require "./lib/bridge.rb"
require "./lib/Robot.rb"
require "./lib/MapOfRobot.rb"
RSpec.describe "Pruebas para puentes en la superficie" do
    it "deberia devolver el tipo del objeto." do
        entrada_puente = Bridge.new()
        expect(entrada_puente.GetType()).to eq "puente"
    end
    it "deberia devolver la salida del puente en la entrada del otro puente y viceversa." do
        entrada_puente = Bridge.new()
        salida_puente = Bridge.new()
        entrada_puente.SetOtherExtremeOfTheBridge(salida_puente)
        salida_puente.SetOtherExtremeOfTheBridge(entrada_puente)
        expect(entrada_puente.getOtherExtreme()).to eq salida_puente and
        expect(salida_puente.getOtherExtreme()).to eq entrada_puente
    end 
    it "deberia devolver el tipo de la entrada y salida de un puente dentro del mapa" do
        mapa = MapOfRobot.new(9,9)
        mapa.PutBridge(8, 3, 2, 3) 
        expect(mapa.GetSquareType(8,3)).to eq "puente" and
        expect(mapa.GetSquareType(2,3)).to eq "puente"
    end
    it "Deberia mover un auto desde la entrada de un puente a su salida" do
        mapa = MapOfRobot.new(9,9)
        mapa.PutBridge(2, 3, 7, 3) 
        robot = Robot.new(0,3,"S")
        mapa.PutRobotInSquares(robot)
        mapa.MoveRobotInSquares(robot, ["A","A"])
        y, x = robot.GetPosition()
        expect(y).to eq 2 and expect(x).to eq 3 
    end
end