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
        if (pos_y >= @limit_y or pos_x >= @limit_x)
            return "robot esta fuera del mapa"
        end
        if (@squares[pos_y,pos_x].GetType() == "obstaculo" or @squares[pos_y,pos_x].GetType() == "robot")
            return "no se puede crear el robot en un obstaculo" + " " + pos_x.to_s + " " + pos_y.to_s
        end
        @squares[pos_y,pos_x]=robot
        return "robot en el mapa"
    end
    def MoveRobotInSquares(robot, movements)
        pos_y, pos_x = robot.GetPosition()
        card = robot.GetCardinality()
        pos_x,pos_y,card = LoopInstructions(movements,robot,card)
    end

    def PutObstacle(y , x)
        @squares[y,x] = Obstacle.new()
    end
    def PutBridgeWithPositions(puente_inicial_y,puente_inicial_x,puente_salida_y,puente_salida_x)
        PutBridgeWithTwoConnections(Bridge.new(puente_inicial_y,puente_inicial_x),Bridge.new(puente_salida_y,puente_salida_x))
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
    def MoveRobotInSquare(robot,nueva_posicion_y,nueva_posicion_x,cardinalidad, robot_choco)
        objeto = @squares[nueva_posicion_y,nueva_posicion_x].GetType()
        posicion_robot_y,posicion_robot_x =robot.GetPosition()

        objetoRobot = @squares[posicion_robot_y,posicion_robot_x].GetType()
        if (objeto=="cuadrilla")
            MoveRobot(nueva_posicion_y,nueva_posicion_x,cardinalidad,robot)
        end
        if (objeto=="obstaculo" or objeto=="robot")
            robot_choco = true
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
        return nueva_posicion_y,nueva_posicion_x,cardinalidad, robot_choco
    end
    def LoopInstructions(movimientos,robot,cardinalidad)
        pos_y,pos_x = robot.GetPosition()
        lim_y, lim_x = Shape()
        robot_choco = false
        movimientos.each do |movimiento|
            case cardinalidad
                when "N"
                    case movimiento
                        when "A"
                            if (pos_y>0) 
                                pos_y-=1
                            else
                                robot_choco = true
                            end
                        when "D" 
                            cardinalidad = "E"
                        when "I"
                            cardinalidad = "O"
                        end
                when "E"
                    case movimiento
                        when "A"
                            if (pos_x<lim_x-1)
                                pos_x+=1 
                            else
                                robot_choco = true
                            end
                        when "D" 
                            cardinalidad = "S"
                        when "I"
                            cardinalidad = "N"
                        end
                when "S"
                    case movimiento
                        when "A"
                            if (pos_y<lim_y-1)
                                pos_y+=1 
                            else
                                robot_choco = true
                            end
                        when "D" 
                            cardinalidad = "O"
                        when "I"
                            cardinalidad = "E"
                        end
                when "O"
                    case movimiento
                        when "A"
                            if (pos_x>0)
                                pos_x-=1 
                            else
                                robot_choco = true
                            end
                        when "D" 
                             cardinalidad = "N"
                        when "I"
                             cardinalidad = "S"
                        end 
                end
                if (movimiento=="A")
                    pos_y,pos_x,cardinalidad, robot_choco = MoveRobotInSquare(robot,pos_y,pos_x,cardinalidad,robot_choco)
                else
                    robot.SetNewPosition(pos_y,pos_x,cardinalidad)
                end
                break if (robot_choco==true)     
        end
        return pos_x,pos_y,cardinalidad
    end
end
