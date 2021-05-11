require 'sinatra'
require './config'
require "./lib/MapOfRobot.rb"
require "./lib/Square.rb"
get '/' do
    erb :bienvenida
end

post '/comandos' do
    commandos=(params[:caja_de_comandos]).to_s
    commandos=commandos.split(" ")
    @map = MapOfRobot.new(commandos[0].to_i, commandos[1].to_i)
    erb :comandos
end
get '/comandos' do
    erb :comandos
end

