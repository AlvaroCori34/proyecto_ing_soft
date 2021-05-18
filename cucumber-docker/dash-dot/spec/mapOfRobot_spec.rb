require "./lib/MapOfRobot.rb"
RSpec.describe "Pruebas del mapa donde se maneja el robot." do
    it "deberia devolver cantidad de las filas del mapa (3)" do
        mapa= MapOfRobot.new(4,3)
        columnas, filas = mapa.Shape()
        expect(filas).to eq 3
    end
    it "deberia devolver cantidad de las columnas del mapa (5)" do
        mapa= MapOfRobot.new(5,2)
        columnas, filas = mapa.Shape()
        expect(columnas).to eq 5
    end
    it "deberia devolver cantidad casillas (10)" do
        mapa= MapOfRobot.new(2,5)
        expect(mapa.GetSizeMatrix()).to eq 10
    end
    it "deberia devolver la cardinalidad del auto en la direccion norte (N)" do
        mapa = MapOfRobot.new(6,6)
        auto = Robot.new(3,3,"N")
        mapa.PutRobotInSquares(auto)
        mapa.MoveRobotInSquares(auto,["A","I","D","D","I"])
        expect(auto.GetCardinality()).to eq 'N'
    end
    it "deberia devolver la cardinalidad del auto en la direccion este (E)" do
        mapa = MapOfRobot.new(6,6)
        auto = Robot.new(2,2,"E")
        mapa.PutRobotInSquares(auto)
        mapa.MoveRobotInSquares(auto,["A","I","D","D","I"])
        expect(auto.GetCardinality()).to eq 'E'
    end
    it "deberia devolver la cardinalidad del auto en la direccion sur (S)" do
        mapa= MapOfRobot.new(6,6)
        auto = Robot.new(2,2,"S")
        mapa.PutRobotInSquares(auto)
        mapa.MoveRobotInSquares(auto,["A","I","D","D","I"])
        expect(auto.GetCardinality()).to eq 'S'
    end
    it "deberia devolver la cardinalidad del auto en la direccion oeste (O)" do
        mapa = MapOfRobot.new(6,6)
        auto = Robot.new(3,3,"O")
        mapa.PutRobotInSquares(auto)
        mapa.MoveRobotInSquares(auto,["A","I","D","D","I"])
        expect(auto.GetCardinality()).to eq 'O'
    end
    it "deberia devolver las posicion final del auto y su cardinalidad 3 1 N" do
        mapa = MapOfRobot.new(4,4)
        auto = Robot.new(3,2,"N")
        mapa.PutRobotInSquares(auto)
        mapa.MoveRobotInSquares(auto,["A","A","D","I"])
        y,x = auto.GetPosition()
        expect(x).to eq 2 and expect(y).to eq 1 and expect(auto.GetCardinality()).to eq 'N' 
    end
    it "deberia devolver las posicion final del auto 0 4" do
        mapa = MapOfRobot.new(5,8)
        auto = Robot.new(2,4,"N")
        mapa.PutRobotInSquares(auto)
        mapa.MoveRobotInSquares(auto,["A","A"])
        x,y = auto.GetPosition()
        expect(x).to eq 0 and expect(y).to eq 4
    end
end