  
When("visito la pagina de bienvenida") do
    visit '/'
end
  
Then("deberia ver el mensaje {string}") do |message|
    expect(page.body).to match /#{message}/m
end

When("presiono el boton para dar inicio") do
    click_button('iniciar')# Write code here that turns the phrase above into concrete actions
end