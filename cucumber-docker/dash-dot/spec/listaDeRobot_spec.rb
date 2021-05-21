require "Matrix"
require "./lib/Robot.rb"
require "./lib/ListOfRobots.rb"
RSpec.describe "Pruebas de la lista donde se guardan los robots." do
    it "deberia devolver la cantidad de elementos (4)" do
        listaDeRobots = ListOfRobots.new()
        listaDeRobots.AgregateNewRobot(Robot.new(2,2,"S"),["A","A","I"])
        listaDeRobots.AgregateNewRobot(Robot.new(3,3,"N"),["A","A","I"])
        listaDeRobots.AgregateNewRobot(Robot.new(4,4,"E"),["A","A","I"])
        listaDeRobots.AgregateNewRobot(Robot.new(5,5,"O"),["A","A","I"])
        expect(listaDeRobots.CountRobots()).to eq 4
    end
    it "deberia devolver la cantidad de elementos una vez limpiado la lista (0)" do
        listaDeRobots = ListOfRobots.new()
        listaDeRobots.AgregateNewRobot(Robot.new(2,2,"S"),["A","A","I"])
        listaDeRobots.AgregateNewRobot(Robot.new(3,3,"N"),["A","A","I"])
        listaDeRobots.AgregateNewRobot(Robot.new(4,4,"E"),["A","A","I"])
        listaDeRobots.AgregateNewRobot(Robot.new(5,5,"O"),["A","A","I"])
        listaDeRobots.ClearList()
        expect(listaDeRobots.CountRobots()).to eq 0
    end
    it "deberia devolver los elementos como la posicion inicial, la cardinalidad y los movimientos del robot." do
        listaDeRobots = ListOfRobots.new()
        listaDeRobots.AgregateNewRobot(Robot.new(2,2,"S"),["A","A","I"])
        matriz = listaDeRobots.GetMatrixOfElementsOfCars()
        expect(matriz[0,0][0].to_s+","+matriz[0,1][0].to_s+" "+matriz[0,2][0].to_s).to eq "2,2 S" and expect(matriz[0,3][0].to_s).to eq "AAI"
    end 
    it "deberia devolver los elementos como la posicion inicial, la cardinalidad, los movimientos del robot y la posicion final de 2 autos." do
        listaDeRobots = ListOfRobots.new()
        listaDeRobots.AgregateNewRobot(Robot.new(2,2,"S"),["A","A","I"])
        robot = Robot.new(3,3,"N")
        listaDeRobots.AgregateNewRobot(robot,["A","A","D"])
        robot.SetNewPosition(2, 1,"E")
        matriz = listaDeRobots.GetMatrixOfElementsOfCars()
        expect(matriz[0,0][0].to_s+","+matriz[0,1][0].to_s+" "+matriz[0,2][0].to_s).to eq "2,2 S" and 
        expect(matriz[0,3][0].to_s).to eq "AAI" and
        expect(matriz[0,4][0].to_s+","+matriz[0,5][0].to_s+" "+matriz[0,6][0].to_s).to eq "2,2 S" and
        expect(matriz[1,0][0].to_s+","+matriz[1,1][0].to_s+" "+matriz[1,2][0].to_s).to eq "3,3 N" and 
        expect(matriz[1,3][0].to_s).to eq "AAD" and
        expect(matriz[1,4][0].to_s+","+matriz[1,5][0].to_s+" "+matriz[1,6][0].to_s).to eq "1,2 E"
    end
end