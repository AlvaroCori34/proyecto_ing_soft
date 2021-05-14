require 'sinatra'
require './config'
require "./lib/MapOfRobot.rb"
require "./lib/Square.rb"
require "./lib/Robot.rb"
get '/' do
    erb :bienvenida
    
end

def asignarNuevoTamanioDeSuperficie(cadena)
    cadena_limites=""
    limite_1ra_linea = cadena.index('\n')
     if (limite_1ra_linea==nil)
        cadena_limites=cadena
    else
        cadena_limites=cadena[0..cadena.index('\n')]
        limite_1ra_linea=limite_1ra_linea+2
    end
    cadena_limites=cadena_limites.split(",")

    sup_x = cadena_limites[0].to_i
    sup_y = cadena_limites[1].to_i
    if (sup_x!=0 and sup_y!=0)
        @@mapa = MapOfRobot.new(sup_y, sup_x)
    end
    return cadena,limite_1ra_linea 
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
#<!-- -->
post '/comandos' do
    #8,6\n0,0,N\nDAA
    @instrucciones=[""]
    if (params[:caja_de_comandos].to_s!="")
        limite_1ra_linea = 0
        cadena = params[:caja_de_comandos].to_s
        
        if (cadena[0]!="A" and cadena[0]!="I" and cadena[0]!="D" and (cadena.index("N")==nil and cadena.index("E")==nil and cadena.index("S")==nil and cadena.index("O")==nil) or cadena.count('\n')>1)
            cadena, limite_1ra_linea = asignarNuevoTamanioDeSuperficie(params[:caja_de_comandos].to_s)
        end
        if (limite_1ra_linea!=nil)
            cadena=cadena[limite_1ra_linea..cadena.length()]
            puts("###############################################")
            puts(cadena)
            puts("###############################################")
            @pos_x, @pos_y, @card,cadena=separarValoresDeUnAuto(cadena)
            @@auto = Robot.new(@pos_y ,@pos_x ,@card)
            @instrucciones = cadena.upcase.split("")
            ins = @instrucciones
            @@mapa.MoveRobotInSquares(@@auto,ins) 
        end
    end

    @superficie_y, @superficie_x = @@mapa.Shape()
    @instrucciones = @instrucciones.join("")
    
    @pos_e_y , @pos_e_x = @@auto.GetPosition() 
    @card_e = @@auto.GetCardinality()

    erb :comandos
end
get '/retornar' do
    redirect to('/')
end


@@mapa = MapOfRobot.new(3,3)
@@auto = Robot.new(0,0,'N')
@@mapa.PutRobotInSquares(@@auto)