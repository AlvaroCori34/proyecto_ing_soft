require 'sinatra'
require './config'
require "./lib/MapOfRobot.rb"
require "./lib/Square.rb"
require "./lib/Robot.rb"
get '/' do
    erb :bienvenida
end

@@mapa = MapOfRobot.new(1,1)
@@auto = Robot.new(0,0,'N')
post '/comandos' do
    sup_x = params[:limite_x].to_i
    sup_y = params[:limite_y].to_i
    if (sup_x!=0 and sup_y!=0)
        @@mapa = MapOfRobot.new(sup_x, sup_y)
    end
    @superficie_x, @superficie_y = @@mapa.Shape()
    comandos = params[:caja_de_comandos].to_s
    comandos = comandos.split("\n")
    posiciones_auto = comandos[0].to_s.split(" ")
    @pos_x = posiciones_auto[0].to_i
    @pos_y = posiciones_auto[1].to_i
    @card = posiciones_auto[2]
    @@auto = Robot.new(@pos_x ,@pos_y ,@card)
    erb :comandos
end
get '/retornar' do
    redirect to('/')
end
