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
        lim_y, lim_x = Shape()
        card = robot.GetCardinality()
        @squares[pos_y, pos_x]=nil
        pos_x,pos_y,card = LoopIstructions(movements,pos_x,pos_y,lim_x,lim_y,card)
        robot.SetNewPosition(pos_y, pos_x,card)
        @squares[pos_y, pos_x]=robot.GetPosition()
    end
end

def LoopIstructions(movements,pos_x,pos_y,lim_x,lim_y,card)
    movements.each do |mov|
        if card=="N"
            if mov=="A" and pos_y>0
                pos_y-=1
                next
            end
            if mov=="D" and pos_x < lim_x
                pos_x+=1
                card = "E"
                next
            end
            if mov=="I" and pos_x>0
                pos_x-=1
                card = "O"
                next
            end
        end
        if card=="E"
            if mov=="A"  and pos_x < lim_x
                pos_x+=1
                next
            end
            if mov=="D"  and pos_y < lim_y
                pos_y+=1
                card = "S"
                next
            end
            if mov=="I" and pos_y>0
                pos_y-=1
                card = "N"
                next
            end
        end
        if card=="S" 
            if mov=="A"  and pos_y < lim_y
                pos_y+=1
                next
            end
            if mov=="D" and pos_x>0
                pos_x-=1
                card = "O"
                next
            end
            if mov=="I"  and pos_x < lim_x
                pos_x+=1
                card = "E"
                next
            end
        end
        if card=="O"
            if mov=="A"  and pos_x>0
                pos_x-=1
                next
            end
            if mov=="D"  and pos_y>0
                pos_y-=1
                card = "N"
                next
            end
            if mov=="I" and pos_y < lim_y
                pos_y+=1
                card = "S"
                next
            end
        end
    end
    return pos_x,pos_y,card
end

