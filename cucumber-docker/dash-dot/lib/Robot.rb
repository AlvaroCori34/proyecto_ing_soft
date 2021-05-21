require './lib/Square.rb'
class Robot < Square
    def initialize(y, x, card)
        @pos_x = x
        @pos_y = y
        @pos_x_initial = x
        @pos_y_initial = y
        @cardinality = card
        @cardinality_initial = card
    end
    def GetPosition()
        return @pos_y, @pos_x
    end
    def GetCardinality()
        return @cardinality
    end
    def GetInitialPosition()
        return @pos_y_initial, @pos_x_initial
    end
    def GetInitialCardinality()
        return @cardinality_initial
    end
    def SetNewPosition(y, x,card)
        @pos_x = x
        @pos_y = y
        @cardinality = card

    end
    def GetType()
        return "robot"
    end
end



