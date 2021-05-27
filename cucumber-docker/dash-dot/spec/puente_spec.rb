require "./lib/Bridge.rb"

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
        extremo1 = entrada_puente.GetOtherExtreme()
        extremo2 = salida_puente.GetOtherExtreme()
        expect(extremo1).to eq salida_puente and
        expect(extremo2).to eq entrada_puente
    end 

end