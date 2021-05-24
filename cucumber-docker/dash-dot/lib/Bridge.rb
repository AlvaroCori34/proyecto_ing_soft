require './lib/Square.rb'
class Bridge < Square
    def initialize(y, x)
        super()
        SetObject("P")
        @otro_extremo_puente = nil
        @posicion_x = x
        @posicion_y = y
    end
    def SetObject(obj)
        @object=obj
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
    def KeepRobot(robot_en_puente)
        @robot =robot_en_puente
    end
    def GetType()
        return "puente"
    end
end