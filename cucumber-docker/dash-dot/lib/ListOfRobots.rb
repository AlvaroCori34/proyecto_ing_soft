require 'matrix'
require './lib/Robot.rb'
class ListOfRobots
    def initialize()
        @robots = []
        @movimientos = []
    end
    def AgregateNewRobot(robot, instrucciones)
        @robots.push(robot)
        @movimientos.push(instrucciones.join(""))
    end
    def ClearList()
        @robots.clear
        @movimientos.clear
    end
    def GetMatrixOfElementsOfCars()
        matriz = Matrix.build(CountRobots(), 7) {0}
        numero_de_auto=0
        @robots.each do |robot|
           y,x = robot.GetPosition()
           cardinalidad = robot.GetCardinality()
           y_i,x_i = robot.GetInitialPosition()
           cardinalidad_i = robot.GetInitialCardinality()
           matriz[numero_de_auto,0]=[x_i]
           matriz[numero_de_auto,1]=[y_i]
           matriz[numero_de_auto,2]=[cardinalidad_i]
           matriz[numero_de_auto,3]=[@movimientos[numero_de_auto]]
           matriz[numero_de_auto,4]=[x]
           matriz[numero_de_auto,5]=[y]
           matriz[numero_de_auto,6]=[cardinalidad]
           numero_de_auto = numero_de_auto +1
        end
        return matriz
    end
    def CountRobots()
        return @robots.length()
    end
    
end

