Given("ingresar a la pagina de comandos") do
    visit '/'
    click_button('iniciar')
end
  
When("yo lleno en {string} con {string}") do |string, string2|
    fill_in(string, :with => string2)
end

When("presiono el boton para correr") do
    click_button('correr')
end
When("presione el boton correr") do
    visit '/comandos'
end

Then("deberia mostrar los limites de la superficie: {string}") do |string|
    expect(page.body).to match /#{string}/m
end

When("presiono el boton para correr_comandos") do
    click_button('correr')
end