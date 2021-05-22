require 'matrix'
require './lib/Square.rb'
require './lib/Robot.rb'
require './lib/Obstacle.rb'
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
        pos_x,pos_y,card = LoopIstructions(movements,pos_x,pos_y,card)
        robot.SetNewPosition(pos_y, pos_x,card)
        @squares[pos_y, pos_x]=robot
    end

    def PutObstacle(y , x)
        @squares[y,x] = Obstacle.new()
    end
    def GetSquareType(y, x)
        return @squares[y,x].GetType()
    end
    def LoopIstructions(movements,pos_x,pos_y,card)
        lim_y, lim_x = Shape()
        movements.each do |mov|
            if card=="N"
                if mov=="A" and pos_y>0
                    pos_y-=1
                    next
                end
                if mov=="D"
                    card = "E"
                    next
                end
                if mov=="I"
                    card = "O"
                    next
                end
            end
            if card=="E"
                if mov=="A"  and pos_x < lim_x-1
                    pos_x+=1
                    next
                end
                if mov=="D"
                    card = "S"
                    next
                end
                if mov=="I"
                    card = "N"
                    next
                end
            end
            if card=="S" 
                if mov=="A"  and pos_y < lim_y-1
                    pos_y+=1
                    next
                end
                if mov=="D"
                    card = "O"
                    next
                end
                if mov=="I"
                    card = "E"
                    next
                end
            end
            if card=="O"
                if mov=="A"  and pos_x>0
                    pos_x-=1
                    next
                end
                if mov=="D" 
                    card = "N"
                    next
                end
                if mov=="I"
                    card = "S"
                    next
                end
            end
        end
     return pos_x,pos_y,card
    end
end

dic = {"NA"=>"-y",
       "ND"=>"E",
       "NI"=>"O",
       "EA"=>"+x",
       "ED"=>"E",
       "EI"=>"N",
       "SA"=>"+y",
       "SD"=>"O",
       "SI"=>"E",
       "OA"=>"-x",
       "OD"=>"N",
       "OS"=>"S"
      }
puts(dic["NA"])
