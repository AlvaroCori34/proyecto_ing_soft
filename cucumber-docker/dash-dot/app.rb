require 'sinatra'
require './config'
require "./lib/MapOfRobot.rb"
require './lib/ListOfRobots.rb'
require "./lib/Square.rb"
require "./lib/Robot.rb"
get '/' do
    erb :bienvenida
    
end

def Conseguir_Superficie(cadena)
    limites = cadena.split(",")
    sup_x = limites[0].to_i
    sup_y = limites[1].to_i
    return sup_x, sup_y
end
def Conseguir_Posicion_Inicial(cadena)
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
def Mover_Un_Auto(bloque)


    @instrucciones=[""]
    
    @pos_y, @pos_x = @@auto.GetPosition()
    ps_x,ps_y, crd = -1, -1, ""
    if (bloque.to_s!="")
        cadena = bloque.to_s
        cantidad_saltos_de_linea = cadena.count(@@separador_linea)
        if (cantidad_saltos_de_linea==1)
            cadena=cadena.split(@@separador_linea)
            ps_x,ps_y, crd = Conseguir_Posicion_Inicial(cadena[0].to_s)
            @instrucciones = cadena[1].to_s.split("")
        end
        if (cantidad_saltos_de_linea==0)
            cantidad_de_separadores = cadena.count(",") + cadena.count(" ")
            if (cantidad_de_separadores == 2)
                ps_x,ps_y, crd = Conseguir_Posicion_Inicial(cadena.to_s)
            end
            if (cantidad_de_separadores == 0)
                @instrucciones = cadena.to_s.split("")
            end
        end
        if (ps_x>=0 and ps_y>=0 and crd!="")
            @pos_y = ps_y
            @pos_x = ps_x
            @card = crd
            @@auto = Robot.new(@pos_y ,@pos_x ,@card)
            
            ins= @instrucciones
            #@@listaDeRobots.AgregateNewRobot(@pos_y ,@pos_x ,@card, ins)

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
    return true
end

def separar_Bloques(bloque)
    bloques_lista = []
    auto_instruccion = ""
    salto_de_linea = 0
    saltos_de_linea = bloque.count(@@separador_linea)

    while (salto_de_linea< saltos_de_linea) do
        fin_de_linea = bloque.index(@@separador_linea)
        linea = bloque[0..fin_de_linea-1]
        cantidad_de_separadores = linea.count(",") + linea.count(" ")
        if (cantidad_de_separadores == 2)
            if (auto_instruccion!="")
                bloques_lista.push(auto_instruccion)
                auto_instruccion = ""
            end
            auto_instruccion = linea
        else
            if (cantidad_de_separadores == 0)
                auto_instruccion = auto_instruccion+ ((auto_instruccion!="")? @@separador_linea : '') + linea
            end
        end
        bloque = bloque[fin_de_linea+(@@separador_linea.length())..bloque.length()]   
        salto_de_linea = salto_de_linea + 1
    end
    auto_instruccion = auto_instruccion+ ((auto_instruccion!="")? @@separador_linea : '') + bloque
    bloques_lista.push(auto_instruccion)
    return bloques_lista
end
def uniformizarSaltoDeLinea()
    return true
end
post'/comandos' do
    @@auto = Robot.new(0,0,"N")
    bloque=params[:caja_de_comandos].to_s

    bloque = bloque.gsub(@@separador_enter,@@separador_linea)

    primer_salto = bloque.index(@@separador_linea)
    primera_linea = bloque
    if primer_salto != nil    
        primera_linea = bloque[0..primer_salto]
    end
    if (primera_linea.count(",")==1 and primera_linea.count(" ")==0)
        sup_x, sup_y = Conseguir_Superficie(primera_linea)
        @@mapa = MapOfRobot.new(sup_y, sup_x)
        if (primer_salto!=nil)
            bloque=bloque[primer_salto+(@@separador_linea.length())..bloque.length()]
        else
            bloque = ""
        end
    else
        bloque = primera_linea
    end
    bloques_por_auto = separar_Bloques(bloque)
    #8,6\n0,0 N\nDAA\n0,0 N\nDAA
    bloques_por_auto.each do |auto_ins|
        Mover_Un_Auto(auto_ins)
    end
    erb :comandos
end
get '/retornar' do
    redirect to('/')
end

@@mapa = MapOfRobot.new(3,3)

@@listaDeRobots = ListOfRobots.new()
#cucumber
@@separador_linea = '\\n'
#sinatra
#@@separador_linea = "\n"


@@separador_enter = "\n"

#Los obstaculos se colocan despues de la superficie