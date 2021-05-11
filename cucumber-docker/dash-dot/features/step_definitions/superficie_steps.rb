Given("ingresar a la pagina de comandos") do
    visit '/comandos'
end
  
When("yo lleno en {string} con {string}") do |string, string2|
    fill_in(string, :with => string2)
end

Then("presiono el boton para correr") do
    click_button('correr')
end
