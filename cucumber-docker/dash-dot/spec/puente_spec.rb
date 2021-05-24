require "./lib/bridge.rb"
require "./lib/Robot.rb"
require "./lib/MapOfRobot.rb"
RSpec.describe "Pruebas para puentes en la superficie" do
    it "deberia devolver el tipo del objeto." do
        entrada_puente = Bridge.new(2,2)
        expect(entrada_puente.GetType()).to eq "puente"
    end
    it "deberia devolver la posicion del puente." do
        entrada_puente = Bridge.new(6,5)
        y, x = entrada_puente.GetPosition()
        expect(y).to eq 6 and expect(x).to eq 5 
    end
    it "deberia devolver la salida del puente en la entrada del otro puente y viceversa." do
        entrada_puente = Bridge.new(0,0)
        salida_puente = Bridge.new(1,1)
        entrada_puente.SetOtherExtremeOfTheBridge(salida_puente)
        salida_puente.SetOtherExtremeOfTheBridge(entrada_puente)
        expect(entrada_puente.GetOtherExtreme()).to eq salida_puente and
        expect(salida_puente.GetOtherExtreme()).to eq entrada_puente
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