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
        @@mapa = MapOfRobot.new(sup_y, sup_x)
    end
end

def separarValoresDeUnAuto(comandos)
    comandos = comandos.split('\n')
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
    @superficie_y, @superficie_x = @@mapa.Shape()
    @instrucciones=[""]
    if (params[:caja_de_comandos].to_s!="")
        @pos_x, @pos_y, @card,cadena=separarValoresDeUnAuto(params[:caja_de_comandos].to_s)
        @@auto = Robot.new(@pos_y ,@pos_x ,@card)
        @instrucciones = cadena.upcase.split("")
        ins = @instrucciones
        @@mapa.MoveRobotInSquares(@@auto,ins) 
    end

    @instrucciones = @instrucciones.join("")
    
    @pos_e_y , @pos_e_x = @@auto.GetPosition() 
    @card_e = @@auto.GetCardinality()

    erb :comandos
end
get '/retornar' do
    redirect to('/')
end


@@mapa = MapOfRobot.new(3,3)
@@auto = Robot.new(1,1,'N')
@@mapa.PutRobotInSquares(@@auto)