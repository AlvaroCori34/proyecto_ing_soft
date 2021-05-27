require "./lib/Square.rb"

RSpec.describe "Pruebas de las casillas" do
    it "deberia devolver el tipo de objeto" do
        casilla = Square.new()
        expect(casilla.GetType()).to eq "cuadrilla"
    end
end