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
        @squares[pos_y, pos_x]=Square.new()
        pos_x,pos_y,card = LoopInstructions(movements,robot,card)
        robot.SetNewPosition(pos_y, pos_x,card)
        @squares[pos_y, pos_x]=robot
    end

    def PutObstacle(y , x)
        @squares[y,x] = Obstacle.new()
    end
    def PutBridge(y_entrada, x_entrada, y_salida, x_salida)
        @squares[y_entrada, x_entrada] = Bridge.new()
        @squares[y_salida, x_salida] = Bridge.new()
        @squares[y_entrada, x_entrada].SetOtherExtremeOfTheBridge(@squares[y_salida, x_salida])
        @squares[y_salida, x_salida].SetOtherExtremeOfTheBridge(@squares[y_entrada, x_entrada])

    end
    def GetSquareType(y, x)
        return @squares[y,x].GetType()
    end
    def MoveRobot(y,x,robot)
        anterior_y, anterior_x = robot.GetPosition()
        robot.SetNewPosition(y,x)
        @squares[anterior_y, anterior_x]=nil
        @squares[y,x] = robot
    end
    def moveRobotInBridge(robot,cardinalidad)
        pos_y,pos_x = robot.GetPosition()
        if(@squares[pos_y,pos_x].GetType()=="puente")
            @squares[pos_y, pos_x].KeepRobot()
            @squares[pos_y, pos_x].RobotOut()
        end
        return pos_y,pos_x,cardinalidad
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
                #MoveRobot(pos_y,pos_x,Robot)

                #pos_y,pos_x,cardinalidad = moveRobotInBridge(robot,cardinalidad)
        end
        return pos_x,pos_y,cardinalidad
    end
end
