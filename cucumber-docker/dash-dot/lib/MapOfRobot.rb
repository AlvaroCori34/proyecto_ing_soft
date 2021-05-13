require 'matrix'
require './lib/Square.rb'
require './lib/Robot.rb'
class MapOfRobot

    def initialize(lim_y, lim_x)
        @limit_x = lim_x
        @limit_y = lim_y
        @squares = Matrix.build(lim_y, lim_x) { Square.new()}
        #puts(@squares[0, 0].getObject())
    end

    def Shape()
        return @limit_y, @limit_x
    end
    def GetSizeMatrix()
        return @limit_y * @limit_x
    end
    def PutRobotInSquares(robot)
        pos_y, pos_x = robot.GetPosition()
        @squares[pos_y,pos_x]=robot.GetPosition()
    end
    def MoveRobotInSquares(robot, movements)
        pos_y, pos_x = robot.GetPosition()
        card = robot.GetCardinality()
        @squares[pos_y, pos_x]=nil
        movements.each do |mov|
            if card=="N"
                if mov=="A"
                    pos_y-=1
                    next
                end
                if mov=="D"
                    pos_x+=1
                    card = "E"
                    next
                end
                if mov=="I"
                    pos_x-=1
                    card = "O"
                    next
                end
            end
            if card=="E"
                if mov=="A"
                    pos_x+=1
                    next
                end
                if mov=="D"
                    pos_y+=1
                    card = "S"
                    next
                end
                if mov=="I"
                    pos_y-=1
                    card = "N"
                    next
                end
            end
            if card=="S"
                if mov=="A"
                    pos_y+=1
                    next
                end
                if mov=="D"
                    pos_x-=1
                    card = "O"
                    next
                end
                if mov=="I"
                    pos_x+=1
                    card = "E"
                    next
                end
            end
            if card=="O"
                if mov=="A"
                    pos_x-=1
                    next
                end
                if mov=="D"
                    pos_y-=1
                    card = "N"
                    next
                end
                if mov=="I"
                    pos_y+=1
                    card = "S"
                    next
                end
            end
        end
        robot.SetNewPosition(pos_y, pos_x,card)
        @squares[pos_y, pos_x]=robot.GetPosition()
    end
end


