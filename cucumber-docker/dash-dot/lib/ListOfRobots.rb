require './lib/Robot.rb'
class ListOfRobots
    def initialize()
        @robots = []
        @pos_x_inicial = []
        @pos_y_inicial = []
        @movimientos = []
    end
    def AgregateNewRobot(y,x , cardinalidad, instrucciones)
        @robots.push(Robot.new(y,x,cardinalidad))
        @pos_x_inicial.push(robot.GetPosition()[1])
        @pos_y_inicial.push(robot.GetPosition()[0])
        @movimientos.push(intrucciones)
    end
    def ClearList()
        @robots.clear
        @pos_x_inicial.clear
        @pos_y_inicial.clear
        @movimientos.clear
    end
    def CountRobots()
        return @robots.length()
    end
    
end

