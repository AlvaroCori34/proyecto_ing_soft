require "./lib/MapOfRobot.rb"
require "./lib/Square.rb"
require "./lib/Robot.rb"
require "./lib/Obstacle.rb"

RSpec.describe "Pruebas de las casillas y los objetos del mapa" do
    it "deberia devolver para una casilla recien creada nil" do
        casilla = Square.new()
        expect(casilla.GetObject()).to eq nil
    end

    
    it "deberia devolver las posiciones de los autos y su cardinalidad 3 1" do
        auto = Robot.new(1 , 3, "O")
        y, x = auto.GetPosition()
        expect(x).to eq 3 and expect(y).to eq 1
    end
    it "deberia devolver las posiciones de los autos y su cardinalidad 3 1 O" do
        auto = Robot.new(1 , 3, "O")
        y, x = auto.GetPosition()
        cardinalidad = auto.GetCardinality()
        expect(x).to eq 3 and expect(y).to eq 1 and expect(cardinalidad).to eq "O"  
    end


    it "deberia devolver el tipo del objeto 'obstaculo'" do
        obstaculo = Obstacle.new()
        expect(obstaculo.GetType()).to eq "obstaculo"
    end
    it "deberia devolver el objeto representado por la letra 'O'" do
        obstaculo = Obstacle.new()
        expect(obstaculo.GetObject()).to eq "O"
    end

end