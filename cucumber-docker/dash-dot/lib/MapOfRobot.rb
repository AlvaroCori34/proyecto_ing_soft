require 'matrix'
require './lib/Square.rb'
require './lib/Robot.rb'
require './lib/Obstacle.rb'
require './lib/Bridge.rb'
class MapOfRobot

    def initialize(lim_y, lim_x)
        @limit_x = lim_x
        @limit_y = lim_y
        @squares = Matrix.build(lim_y, lim_x) { Square.new()}
    end

    def Shape()
        return @limit_y, @limit_x
    end
    def GetSizeMatrix()
        return @limit_y * @limit_x
    end
    def PutRobotInSquares(robot)
        pos_y, pos_x = robot.GetPosition()
        if (pos_y < @limit_y and pos_x < @limit_x)
            @squares[pos_y,pos_x]=robot
            return true
        end
        return false
    end
    def MoveRobotInSquares(robot, movements)
        pos_y, pos_x = robot.GetPosition()
        card = robot.GetCardinality()
        pos_x,pos_y,card = LoopInstructions(movements,robot,card)
    end

    def PutObstacle(y , x)
        @squares[y,x] = Obstacle.new()
    end
    def PutBridgeWithTwoConnections(entrada_puente, salida_puente)
        y_entrada, x_entrada = entrada_puente.GetPosition()
        y_salida, x_salida = salida_puente.GetPosition()
        @squares[y_entrada, x_entrada] = entrada_puente
        @squares[y_salida, x_salida] = salida_puente
        @squares[y_entrada, x_entrada].SetOtherExtremeOfTheBridge(@squares[y_salida, x_salida])
        @squares[y_salida, x_salida].SetOtherExtremeOfTheBridge(@squares[y_entrada, x_entrada])
    end
    def GetSquareType(y, x)
        return @squares[y,x].GetType()
    end
    def swap(y_inicial, x_inicial, y_salida,x_salida)
        auxiliar = @squares[y_inicial, x_inicial]
        @squares[y_inicial, x_inicial]=@squares[y_salida, x_salida]
        @squares[y_salida, x_salida]=auxiliar
    end
    def MoveRobot(y,x,cardinalidad,robot)
        anterior_y, anterior_x = robot.GetPosition()
        robot.SetNewPosition(y,x, cardinalidad)
        swap(anterior_y,anterior_x,y,x)
    end
    def MoveRobotInSquare(robot,nueva_posicion_y,nueva_posicion_x,cardinalidad)
        objeto = @squares[nueva_posicion_y,nueva_posicion_x].GetType()
        posicion_robot_y,posicion_robot_x =robot.GetPosition()

        objetoRobot = @squares[posicion_robot_y,posicion_robot_x].GetType()
        if (objeto=="cuadrilla")
            MoveRobot(nueva_posicion_y,nueva_posicion_x,cardinalidad,robot)
        end
        if (objeto=="puente")
            nueva_posicion_del_puente_y, nueva_posicion_del_puente_x= @squares[nueva_posicion_y,nueva_posicion_x].GetOtherExtreme().GetPosition()
            case cardinalidad
                when "N"
                    nueva_posicion_del_puente_y-=1
                when "E"
                    nueva_posicion_del_puente_x+=1
                when "S"
                    nueva_posicion_del_puente_y+=1
                when "O"
                    nueva_posicion_del_puente_x-=1  
            end
            nueva_posicion_y = nueva_posicion_del_puente_y
            nueva_posicion_x = nueva_posicion_del_puente_x
            robot.SetNewPosition(nueva_posicion_y,nueva_posicion_x,cardinalidad)
            swap(posicion_robot_y,posicion_robot_x,nueva_posicion_y, nueva_posicion_x)
        end
        return nueva_posicion_y,nueva_posicion_x,cardinalidad
    end
    def LoopInstructions(movimientos,robot,cardinalidad)
        pos_y,pos_x = robot.GetPosition()
        lim_y, lim_x = Shape()
        movimientos.each do |movimiento|
            case cardinalidad
                when "N"
                    case movimiento
                        when "A"
                            pos_y-=1 if (pos_y>0)
                        when "D" 
                            cardinalidad = "E"
                        when "I"
                            cardinalidad = "O"
                        end
                when "E"
                    case movimiento
                        when "A"
                            pos_x+=1 if (pos_x<lim_x-1)
                        when "D" 
                            cardinalidad = "S"
                        when "I"
                            cardinalidad = "N"
                        end
                when "S"
                    case movimiento
                        when "A"
                            pos_y+=1 if (pos_y<lim_y-1)
                        when "D" 
                            cardinalidad = "O"
                        when "I"
                            cardinalidad = "E"
                        end
                when "O"
                    case movimiento
                        when "A"
                             pos_x-=1 if (pos_x>0)
                        when "D" 
                             cardinalidad = "N"
                        when "I"
                             cardinalidad = "S"
                        end 
                end
                if (movimiento=="A")
                    pos_y,pos_x,cardinalidad = MoveRobotInSquare(robot,pos_y,pos_x,cardinalidad)
                else
                    robot.SetNewPosition(pos_y,pos_x,cardinalidad)
                end
                
        end
        return pos_x,pos_y,cardinalidad
    end
end
