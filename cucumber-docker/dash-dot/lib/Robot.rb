
class Robot
    def initialize(y, x, card)
        @pos_x = x
        @pos_y = y
        @cardinality = card
    end
    def GetPosition()
        return @pos_y, @pos_x
    end
    def GetCardinality()
        return @cardinality
    end
    def SetNewPosition(y, x,card)
        @pos_x = x
        @pos_y = y
        @cardinality = card
    end
end



