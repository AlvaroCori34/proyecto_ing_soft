require './lib/Robot.rb'
class ListOfRobots
    def initialize()
        @robots = []
    end
    def AgregateNewRobot(robot)
        @robots.push(robot)
    end
    def ClearList()
        @robots.clear
    end
    def CountRobots()
        return @robots.length()
    end
end

