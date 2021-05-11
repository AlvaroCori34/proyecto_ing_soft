require 'sinatra'
require './config'
require "./lib/MapOfRobot.rb"
require "./lib/Square.rb"
get '/' do
    erb :bienvenida
end

post '/comandos' do
    commandos=(params[:limites]).to_s
    commandos=commandos.split(" ")
    @map = MapOfRobot.new(commandos[0].to_i, commandos[1].to_i)
    @superficie_x, @superficie_y = @map.shape()
    erb :comandos
end

get '/comandos' do
    erb :comandos
end

get '/retornar' do
    redirect to('/')
end
