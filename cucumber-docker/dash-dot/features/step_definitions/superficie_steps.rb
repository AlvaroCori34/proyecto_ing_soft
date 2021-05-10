Given("ingresar a la pagina de comandos") do
    visit '/inicio'
end
  
When("presiono el boton para correr") do
    click_button('correr')
end