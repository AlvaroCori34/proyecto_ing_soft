require 'sinatra'
require './config'
require "./lib/MapOfRobot.rb"
require "./lib/Square.rb"
require "./lib/Robot.rb"
get '/' do
    erb :bienvenida
    
end

def asignarNuevoTamanioDeSuperficie()
    sup_x = params[:limite_x].to_i
    sup_y = params[:limite_y].to_i
    if (sup_x!=0 and sup_y!=0)
        @@mapa = MapOfRobot.new(sup_x, sup_y)
    end
end

def separarValoresDeCajaDeComando()
    comandos = params[:caja_de_comandos].to_s
    comandos = comandos.split("\n")

    posiciones_auto = comandos[0].to_s.split(",")

    cadena = comandos[0].to_s
    if (posiciones_auto.length()==3) 
        pos_x = posiciones_auto[0].to_i
        pos_y = posiciones_auto[1].to_i
        card = posiciones_auto[2].to_s
        cadena = comandos[1].to_s
    else
        pos_x = 0
        pos_y = 0
        card = "N"
        cadena = comandos[0].to_s
    end
    return pos_x,pos_y,card,cadena
end 

post '/comandos' do
    if (params[:limite_x]!="" and params[:limite_y]!="")
        asignarNuevoTamanioDeSuperficie()
    end
    @superficie_x, @superficie_y = @@mapa.Shape()

    @pos_x, @pos_y, @card,cadena=separarValoresDeCajaDeComando()

    @@auto = Robot.new(@pos_x ,@pos_y ,@card)

    @instrucciones = cadena.upcase.split("")


    if (@superficie_x>2 and @superficie_y>2)
        ins = @instrucciones
        @@mapa.PutRobotInSquares(@@auto)
        @@mapa.MoveRobotInSquares(@@auto,ins) 

    end

    @instrucciones = @instrucciones.join("")
    
    @pos_e_x , @pos_e_y = @@auto.GetPosition() 
    @card_e = @@auto.GetCardinality()

    erb :comandos
end
get '/retornar' do
    redirect to('/')
end


@@mapa = MapOfRobot.new(1,1)
@@auto = Robot.new(0,0,'N')