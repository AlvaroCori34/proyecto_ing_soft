require "./lib/MapOfRobot.rb"
require "./lib/Obstacle.rb"
require "./lib/Bridge.rb"
require "./lib/Robot.rb"
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
    it "deberia agregar un obstaculo a la pista en la coordenada 3,3" do
        x = 3
        y = 3
        mapa = MapOfRobot.new(8,8)
        mapa.PutObstacle(y,x)
        expect(mapa.GetSquareType(y, x)).to eq  "obstaculo" 
    end
    it "deberia responder con un mensaje si el auto esta fuera de la superficie" do
        mapa = MapOfRobot.new(8,8)
        auto1 = Robot.new(9,9,"N")
        resultado = mapa.PutRobotInSquares(auto1)
        expect(resultado).to eq  "robot esta fuera del mapa"
    end 
    it "deberia responder con un mensaje si el auto se creo sobre un obstaculo mas su posicion" do
        mapa = MapOfRobot.new(8,8)
        auto1 = Robot.new(0,0,"N")
        auto2 = Robot.new(0,0,"N")
        resultado1 = mapa.PutRobotInSquares(auto1)
        resultado2 = mapa.PutRobotInSquares(auto2)
        expect(resultado1).to eq  "robot en el mapa" and
        expect(resultado2).to eq  "no se puede crear el robot en un obstaculo 0 0"
    end 
    it "los autos no deberian salirse del mapa." do
        mapa = MapOfRobot.new(8,8)
        auto1 = Robot.new(0,3,"N")
        mapa.PutRobotInSquares(auto1)
        mapa.MoveRobotInSquares(auto1,["A","A","D","A"])
        auto2 = Robot.new(7,3,"S")
        mapa.PutRobotInSquares(auto2)
        mapa.MoveRobotInSquares(auto2,["A","A","D","A"])
        auto3 = Robot.new(0,0,"O")
        mapa.PutRobotInSquares(auto3)
        mapa.MoveRobotInSquares(auto3,["A","A","D","A"])
        auto4 = Robot.new(7,7,"E")
        mapa.PutRobotInSquares(auto4)
        mapa.MoveRobotInSquares(auto4,["A","A","D","A"])
        expect(mapa.GetSquareType(0, 3)).to eq  "robot" and
        expect(mapa.GetSquareType(7, 3)).to eq  "robot" and
        expect(mapa.GetSquareType(0, 0)).to eq  "robot" and
        expect(mapa.GetSquareType(7, 7)).to eq  "robot"
    end
    it "Con 2 puentes deberia devolver el tipo de la entrada y salida de un puente dentro del mapa" do
        mapa = MapOfRobot.new(9,9)
        entrada_puente = Bridge.new(8,3)
        salida_puente = Bridge.new(2,3)
        mapa.PutBridgeWithTwoConnections(entrada_puente, salida_puente) 
        expect(mapa.GetSquareType(8,3)).to eq "puente" and
        expect(mapa.GetSquareType(2,3)).to eq "puente"
    end
    it "Con 4 posiciones deberia devolver el tipo de la entrada y salida de un puente dentro del mapa" do
        mapa = MapOfRobot.new(9,9)
        entrada_puente = Bridge.new(8,3)
        salida_puente = Bridge.new(2,3)
        mapa.PutBridgeWithPositions(8,3, 2,3) 
        expect(mapa.GetSquareType(8,3)).to eq "puente" and
        expect(mapa.GetSquareType(2,3)).to eq "puente"
    end

    it "Deberia devolver la posicion del auto al otro lado del puente y su tipo en el mapa." do
        mapa = MapOfRobot.new(9,9)
        entrada_puente = Bridge.new(2,3)
        salida_puente = Bridge.new(7,3)
        mapa.PutBridgeWithTwoConnections(entrada_puente, salida_puente) 
        robot = Robot.new(0,3,"S")
        mapa.PutRobotInSquares(robot)
        mapa.MoveRobotInSquares(robot, ["A","A"])
        y, x = robot.GetPosition()
        expect(y).to eq 8 and expect(x).to eq 3  and expect(mapa.GetSquareType(8,3)).to eq "robot"
    end
    it "Deberia devolver la posicion del auto al otro lado del puente y su tipo en el mapa." do
        mapa = MapOfRobot.new(9,9)
        entrada_puente = Bridge.new(2,3)
        salida_puente = Bridge.new(7,3)
        mapa.PutBridgeWithTwoConnections(entrada_puente, salida_puente) 
        robot = Robot.new(8,3,"N")
        mapa.PutRobotInSquares(robot)
        mapa.MoveRobotInSquares(robot, ["A"])
        y, x = robot.GetPosition()
        expect(y).to eq 1 and expect(x).to eq 3  and expect(mapa.GetSquareType(1,3)).to eq "robot"
    end
    it "Deberia devolver la posicion del auto al otro lado del puente y su tipo en el mapa." do
        mapa = MapOfRobot.new(9,9)
        entrada_puente = Bridge.new(2,3)
        salida_puente = Bridge.new(7,3)
        mapa.PutBridgeWithTwoConnections(entrada_puente, salida_puente) 
        robot = Robot.new(2,2,"E")
        mapa.PutRobotInSquares(robot)
        mapa.MoveRobotInSquares(robot, ["A","A"])
        y, x = robot.GetPosition()
        expect(y).to eq 7 and expect(x).to eq 5  and expect(mapa.GetSquareType(7,5)).to eq "robot"
    end
    it "Deberia devolver la posicion del auto al otro lado del puente y su tipo en el mapa." do
        mapa = MapOfRobot.new(9,9)
        entrada_puente = Bridge.new(2,3)
        salida_puente = Bridge.new(7,3)
        mapa.PutBridgeWithTwoConnections(entrada_puente, salida_puente) 
        robot = Robot.new(2,5,"O")
        mapa.PutRobotInSquares(robot)
        mapa.MoveRobotInSquares(robot, ["A","A"])
        y, x = robot.GetPosition()
        expect(y).to eq 7 and expect(x).to eq 2  and expect(mapa.GetSquareType(7,2)).to eq "robot"
    end
    it "Deberia devolver la posicion del auto y su cardinalidad." do
        mapa = MapOfRobot.new(10,10)
        entrada_puente = Bridge.new(2,3)
        salida_puente = Bridge.new(7,3)
        mapa.PutBridgeWithTwoConnections(entrada_puente, salida_puente) 
        robot = Robot.new(0,3,"S")
        mapa.PutRobotInSquares(robot)
        mapa.MoveRobotInSquares(robot, ["A","A","A","D","A","A","D"])
        y, x = robot.GetPosition()
        expect(y).to eq 9 and expect(x).to eq 1 and expect(robot.GetCardinality()).to eq "N"
    end
end