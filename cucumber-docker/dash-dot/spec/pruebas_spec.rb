require "./lib/MapOfRobot.rb"
require "./lib/Square.rb"
RSpec.describe "Pruebas del robot y su mapa" do
    it "deberia devolver para una casilla recien creada nil" do
        #ebs= MapOfRobot.new(2,2)
        ebs = Square.new()
        expect(ebs.getObject()).to eq nil
    end
    it "deberia devolver cantidad de las filas del mapa" do
        map= MapOfRobot.new(3,4)
        row, col = map.shape()
        expect(row).to eq 3
    end
    it "deberia devolver cantidad de las columnas del mapa" do
        map= MapOfRobot.new(2,5)
        row, col = map.shape()
        expect(col).to eq 5
    end
    it "deberia devolver cantidad casillas" do
        map= MapOfRobot.new(2,5)
        expect(map.getSizeMatrix()).to eq 10
    end
    #column_size
    #column_count
end