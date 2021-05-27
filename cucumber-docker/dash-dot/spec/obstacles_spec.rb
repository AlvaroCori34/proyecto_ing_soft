require "./lib/Obstacle.rb"

RSpec.describe "Pruebas de las casillas y los objetos del mapa" do
    it "deberia devolver el tipo del objeto 'obstaculo'" do
        obstaculo = Obstacle.new()
        expect(obstaculo.GetType()).to eq "obstaculo"
    end

end