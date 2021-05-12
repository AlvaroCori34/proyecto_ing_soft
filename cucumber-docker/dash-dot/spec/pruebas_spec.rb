require "./lib/MapOfRobot.rb"
require "./lib/Square.rb"
require "./lib/Robot.rb"

RSpec.describe "Pruebas del robot y su mapa" do
    it "deberia devolver para una casilla recien creada nil" do
        ebs = Square.new()
        expect(ebs.GetObject()).to eq nil
    end
    it "deberia devolver cantidad de las filas del mapa (3)" do
        map= MapOfRobot.new(3,4)
        row, col = map.Shape()
        expect(row).to eq 3
    end
    it "deberia devolver cantidad de las columnas del mapa (5)" do
        map= MapOfRobot.new(2,5)
        row, col = map.Shape()
        expect(col).to eq 5
    end
    it "deberia devolver cantidad casillas (10)" do
        map= MapOfRobot.new(2,5)
        expect(map.GetSizeMatrix()).to eq 10
    end
    it "deveria devolver las posiciones de los autos y su cardinalidad 3 1 O" do
        car = Robot.new(3 , 1, "O")
        x, y = car.GetPosition()
        card = car.GetCardinality()
        expect(x).to eq 3 and expect(y).to eq 1 and expect(card).to eq "O"  
    end
end