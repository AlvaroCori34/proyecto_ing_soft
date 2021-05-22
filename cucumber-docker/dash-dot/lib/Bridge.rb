require './lib/Square.rb'
class Bridge < Square
    def initialize()
        super()
        SetObject("P")
        @otro_extremo_puente = nil
        @robot = nil
    end
    def SetObject(obj)
        @object=obj
    end
    def SetOtherExtremeOfTheBridge(puente)
        @otro_extremo_puente = puente
    end
    def getOtherExtreme()
        return @otro_extremo_puente
    end
    def KeepRobot(robot_en_puente)
        @robot =robot_en_puente
    end
    def GetType()
        if (@robot==nil)
            return "puente"
        end
        return "[robot]"
    end
    def RobotOut()
        @robot = nil
    end
end