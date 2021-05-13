require 'matrix'
require './lib/Square.rb'
require './lib/Robot.rb'
class MapOfRobot

    def initialize(lim_x, lim_y)
        @limit_x = lim_x
        @limit_y = lim_y
        @squares = Matrix.build(lim_x, lim_y) { Square.new()}
        #puts(@squares[0, 0].getObject())
    end

    def Shape()
        return @limit_x, @limit_y
    end
    def GetSizeMatrix()
        return @limit_x * @limit_y
    end
    def PutRobotInSquares(robot)
        pos_x, pos_y = robot.GetPosition()
        @squares[pos_x,pos_y]=robot.GetPosition()
    end
    def MoveRobotInSquares(robot, movements)
        pos_x, pos_y = robot.GetPosition()
        @squares[pos_x, pos_y]=nil
        card = robot.GetCardinality()
        movements.each do |mov|
            if (card=='N')
                if (mov=='A')
                    pos_x = pos_x + 1
                    next
                end
                if (mov=='D')
                    pos_y = pos_y + 1
                    card = 'E'
                    next
                end
                if (mov=='I')
                    pos_y = pos_y - 1
                    card = 'O'
                    next
                end
            end
            if (card=='E')
                if (mov=='A')
                    pos_y = pos_y + 1
                    next
                end
                if (mov=='D')
                    pos_x = pos_x - 1
                    card = 'S'
                    next
                end
                if (mov=='I')
                    pos_x = pos_x + 1
                    card = 'N'
                    next
                end
            end
            if (card=='S')
                if (mov=='A')
                    pos_x = pos_x - 1
                    next
                end
                if (mov=='D')
                    pos_y = pos_y - 1
                    card = 'O'
                    next
                end
                if (mov=='I')
                    pos_y = pos_y + 1
                    card = 'E'
                    next
                end
            end
            if (card=='O')
                if (mov=='A')
                    pos_y = pos_y - 1
                    next
                end
                if (mov=='D')
                    pos_x = pos_x + 1
                    card = 'N'
                    next
                end
                if (mov=='I')
                    pos_x = pos_x - 1
                    card = 'S'
                    next
                end
            end
        end
        robot.SetNewPosition(pos_x, pos_y)
        @squares[pos_x, pos_y]=robot
    end
end




