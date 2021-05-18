require './lib/Square.rb'
class Obstacle < Square

    def initialize()
        super()
        SetObject("O")
    end
    def SetObject(obj)
        @object=obj
    end
    def GetType()
        return "obstaculo"
    end
end
