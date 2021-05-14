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
    sep_coma = cadena.index(",")
    sep_espacio = cadena.index(" ")
    if (sep_coma!=nil and sep_espacio!=nil) 
        pos_x = cadena[0..sep_coma].to_i
        pos_y = cadena[sep_coma+1..sep_espacio].to_i
        card = cadena[sep_espacio+1,1]
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
            @pos_x, @pos_y, @card,cadena=separarValoresDeUnAuto(cadena)
            @@auto = Robot.new(@pos_y ,@pos_x ,@card)
            
            autoEstaEnPosicion = @@mapa.PutRobotInSquares(@@auto)

            if (!autoEstaEnPosicion)
                return false
            end
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
def superficie(cadena)
    limites = cadena.split(",")
    sup_x = limites[0].to_i
    sup_y = limites[1].to_i
    return sup_x, sup_y
end
def posicionInicial(cadena)
    sep_coma = cadena.index(",")
    sep_espacio = cadena.index(" ")
    if (sep_coma!=nil and sep_espacio!=nil) 
        pos_x = cadena[0..sep_coma].to_i
        pos_y = cadena[sep_coma+1..sep_espacio].to_i
        card = cadena[sep_espacio+1,1]
    else
        pos_x = 0
        pos_y = 0
        card = "N"
    end
    return pos_x,pos_y, card
end
post'/comandosE' do
    @instrucciones=[""]
    bloque=params[:caja_de_comandos].to_s
    @pos_y, @pos_x = @@auto.GetPosition()
    ps_x,ps_y, crd = -1, -1, ""
    sup_x, sup_y = -1, -1

    if (bloque.to_s!="")
        cadena = bloque.to_s
        cantidad_saltos_de_linea = cadena.count('\n')

        if (cantidad_saltos_de_linea>=2)
            cadena=cadena.split('\n')
            sup_x, sup_y = superficie(cadena[0].to_s)
            ps_x,ps_y, crd = posicionInicial(cadena[1].to_s)
            @instrucciones = cadena[2].to_s.split("")
        end
        #8,6\nDAADII
        if (cantidad_saltos_de_linea==1)
            cadena=cadena.split('\n')
            cantidad_de_separadores = cadena.count(",") + cadena.count(" ")
            if (cantidad_de_separadores == 2)
                ps_x,ps_y, crd = posicionInicial(cadena[0].to_s)
            end
            if (cantidad_de_separadores == 1)
                sup_x, sup_y = superficie(cadena[0].to_s)
            end
            @instrucciones = cadena[1].to_s.split("")
        end

        if (cantidad_saltos_de_linea==0)
            cantidad_de_separadores = cadena.count(",") + cadena.count(" ")
            if (cantidad_de_separadores == 2)
                ps_x,ps_y, crd = posicionInicial(cadena.to_s)
            end
            if (cantidad_de_separadores == 1)
                sup_x, sup_y = superficie(cadena.to_s)
            end
            if (cantidad_de_separadores == 0)
                @instrucciones = cadena.to_s.split("")
                
            end
        end
        if (sup_x>0 and sup_y>0)
            @@mapa = MapOfRobot.new(sup_y, sup_x)
        end
        if (ps_x>=0 and ps_y>=0 and crd!="")
            @pos_y = ps_y
            @pos_x = ps_x
            @card = crd
            @@auto = Robot.new(@pos_y ,@pos_x ,@card)
        end
        autoEstaEnPosicion = @@mapa.PutRobotInSquares(@@auto)
        if (!autoEstaEnPosicion)
            return false
        end
        @@mapa.MoveRobotInSquares(@@auto,@instrucciones) 
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
