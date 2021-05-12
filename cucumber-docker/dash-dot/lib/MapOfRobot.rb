require 'matrix'
require './lib/Square.rb'
class MapOfRobot

    def initialize(lim_x, lim_y)
        @limit_x = lim_x
        @limit_y = lim_y
        @squares = Matrix.build(lim_x, lim_y) { Square.new()}
        #puts(@squares[0, 0].getObject())
    end
    def GetSquare(row, col)
        return @squares[row,col]
    end
    def Shape()
        return @limit_x, @limit_y
    end
    def GetSizeMatrix()
        return @limit_x * @limit_y
    end
end

#map= MapOfRobot.new(2,2)
