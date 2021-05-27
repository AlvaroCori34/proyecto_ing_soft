require './lib/Square.rb'
class Bridge < Square
    def initialize(y, x)
        @otro_extremo_puente = nil
        @posicion_x = x
        @posicion_y = y
        @type= "puente"
    end

    def GetPosition()
        return @posicion_y, @posicion_x
    end
    def SetOtherExtremeOfTheBridge(puente)
        @otro_extremo_puente = puente
    end
    def GetOtherExtreme()
        return @otro_extremo_puente
    end
    def GetType()
        return @type
    end
end