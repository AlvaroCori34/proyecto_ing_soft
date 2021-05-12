class Robot
    def initialize(x, y, card)
        @pos_x = x
        @pos_y = y
        @cardinality = card
    end
    def GetPosition()
        return @pos_x, @pos_y
    end
    def GetCardinality()
        return @cardinality
    end
end