require './lib/Square.rb'
class Obstacle < Square
    def initialize()
        @type="obstaculo"
    end
    def GetType()
        return @type
    end
end
