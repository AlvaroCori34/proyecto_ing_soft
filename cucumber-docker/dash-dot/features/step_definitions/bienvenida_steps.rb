  
When("al ingresar a la direccion de la pagina") do
    visit '/'
end
  
Then("deberia ver el mensaje {string}") do |message|
    expect(page.body).to match /#{message}/m
end


When("presiono el boton para dar inicio") do
    click_button('iniciar')# Write code here that turns the phrase above into concrete actions
end


#When ("Yo lleno {string} con {string}") do |field, value|
#    fill_in(field, :with => value)
#  end
#Then("deberia mostrar una caja de comandos {string}") do |message|
#    expect(page.body).to match /#{message}/m
#end

