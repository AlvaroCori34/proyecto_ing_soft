require "./lib/MapOfRobot.rb"
require "./lib/Square.rb"
require "./lib/Robot.rb"
require "./lib/Obstacle.rb"

RSpec.describe "Pruebas del robot y su mapa" do
    it "deberia devolver para una casilla recien creada nil" do
        ebs = Square.new()
        expect(ebs.GetObject()).to eq nil
    end
    it "deberia devolver cantidad de las filas del mapa (3)" do
        map= MapOfRobot.new(4,3)
        col, row = map.Shape()
        expect(row).to eq 3
    end
    it "deberia devolver cantidad de las columnas del mapa (5)" do
        map= MapOfRobot.new(5,2)
        col, row = map.Shape()
        expect(col).to eq 5
    end
    it "deberia devolver cantidad casillas (10)" do
        map= MapOfRobot.new(2,5)
        expect(map.GetSizeMatrix()).to eq 10
    end
    
    it "deberia devolver las posiciones de los autos y su cardinalidad 3 1" do
        car = Robot.new(1 , 3, "O")
        y, x = car.GetPosition()
        expect(x).to eq 3 and expect(y).to eq 1
    end
    it "deberia devolver las posiciones de los autos y su cardinalidad 3 1 O" do
        car = Robot.new(1 , 3, "O")
        y, x = car.GetPosition()
        card = car.GetCardinality()
        expect(x).to eq 3 and expect(y).to eq 1 and expect(card).to eq "O"  
    end
    it "deberia devolver las posicion final del auto 0 4" do
        map= MapOfRobot.new(5,8)
        r = Robot.new(2,4,"N")
        map.PutRobotInSquares(r)
        map.MoveRobotInSquares(r,["A","A"])
        x,y = r.GetPosition()
        expect(x).to eq 0 and expect(y).to eq 4
    end

    it "deberia devolver la cardinalidad del auto en la direccion norte (N)" do
        map= MapOfRobot.new(6,6)
        r = Robot.new(3,3,"N")
        map.PutRobotInSquares(r)
        map.MoveRobotInSquares(r,["A","D","I","I","D"])
        expect(r.GetCardinality()).to eq 'N'
    end
    it "deberia devolver la cardinalidad del auto en la direccion este (E)" do
        map= MapOfRobot.new(6,6)
        r = Robot.new(2,2,"E")
        map.PutRobotInSquares(r)
        map.MoveRobotInSquares(r,["A","D","I","I","D"])
        expect(r.GetCardinality()).to eq 'E'
    end
    it "deberia devolver la cardinalidad del auto en la direccion sur (S)" do
        map= MapOfRobot.new(6,6)
        r = Robot.new(2,2,"S")
        map.PutRobotInSquares(r)
        map.MoveRobotInSquares(r,["A","D","I","I","D"])
        expect(r.GetCardinality()).to eq 'S'
    end
    it "deberia devolver la cardinalidad del auto en la direccion oeste (O)" do
        map= MapOfRobot.new(6,6)
        r = Robot.new(3,3,"O")
        map.PutRobotInSquares(r)
        map.MoveRobotInSquares(r,["A","D","I","I","D"])
        expect(r.GetCardinality()).to eq 'O'
    end
    it "deberia devolver las posicion final del auto y su cardinalidad 3 1 N" do
        map= MapOfRobot.new(4,4)
        r = Robot.new(3,2,"N")
        map.PutRobotInSquares(r)
        map.MoveRobotInSquares(r,["A","A","D","I"])
        y,x = r.GetPosition()
        expect(x).to eq 3 and expect(y).to eq 0 and expect(r.GetCardinality()).to eq 'N' 
    end

    it "deberia devolver el tipo del objeto ""obstaculo." do
        obstaculo = Obstacle.new()
        expect(obstaculo.GetType()).to eq "obstaculo"
    end

end