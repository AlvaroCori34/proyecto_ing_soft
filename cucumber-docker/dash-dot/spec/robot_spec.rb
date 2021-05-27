require "./lib/Robot.rb"

RSpec.describe "Pruebas de las casillas y los objetos del mapa" do

    
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


end