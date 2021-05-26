require 'sinatra'
require './config'
require 'matrix'
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
    pos_x = 0
    pos_y = 0
    card = "N" 
    if (sep_coma!=nil and sep_espacio!=nil) 
        pos_x = cadena[0..sep_coma].to_i
        pos_y = cadena[sep_coma+1..sep_espacio].to_i
        card = cadena[sep_espacio+1,1]
    end
    return pos_x,pos_y, card
end
def separarLimites(bloque)

    primer_salto = bloque.index(@@separador_linea)
    primera_linea = bloque
    
    if primer_salto != nil    
        primera_linea = bloque[0..primer_salto]
    end
    if (primera_linea.count(",")==1 and primera_linea.count(" ")==0)
        if (primer_salto!=nil)
            bloque=bloque[primer_salto+(@@separador_linea.length())..bloque.length()]
        else
            bloque = ""
        end
    end
    return bloque, primera_linea
end
def cargarLimites(limites)
    if (limites.count(",")==1 and limites.count(" ")==0)
        sup_x, sup_y = Conseguir_Superficie(limites)
        @@mapa = MapOfRobot.new(sup_y, sup_x)
    end
end
=begin
1,1 N
AA
2,2 O
AA
3,3 E
AA
AAAD
=end
def separar_Bloques(bloque)
    bloques_lista = []
    auto_instruccion = ""
    salto_de_linea = 0
    saltos_de_linea = bloque.count(@@separador_linea)
    while (bloque!="")
        fin_de_linea = bloque.index(@@separador_linea)
        if (fin_de_linea==nil)
            if (auto_instruccion!="")
                cantidad_de_separadores = bloque.count(",") + bloque.count(" ")
                if (cantidad_de_separadores == 2)
                    bloques_lista.push(auto_instruccion)
                    auto_instruccion = ""
                    bloques_lista.push(bloque)
                end
                if (cantidad_de_separadores == 0)
                    bloques_lista.push(auto_instruccion+@@separador_linea+bloque)
                    auto_instruccion = ""
                end
            else
                bloques_lista.push(bloque) 
            end
            bloque=""
            next
        end
        linea = bloque[0..fin_de_linea-1]
        cantidad_de_separadores = linea.count(",") + linea.count(" ")
        if (cantidad_de_separadores == 2)
            if (auto_instruccion!="")
                bloques_lista.push(auto_instruccion)
                auto_instruccion = ""
            end
            auto_instruccion = linea
        end
        if (cantidad_de_separadores == 0)
            auto_instruccion = auto_instruccion+ ((auto_instruccion!="")? @@separador_linea : '') + linea
            bloques_lista.push(auto_instruccion)
            auto_instruccion = ""
        end
        bloque = bloque[fin_de_linea+(@@separador_linea.length())..bloque.length()]   
    end

    auto_instruccion = auto_instruccion+ ((auto_instruccion!="")? @@separador_linea : '') + bloque
    bloques_lista.push(auto_instruccion)
    return bloques_lista
end

def cargarObstaculo(linea)
    linea = linea.gsub("O ","")
    linea = linea.split(",")
    @@mapa.PutObstacle(linea[1].to_i, linea[0].to_i)
end

def separarObstaculos(bloque)
    separador_salto_de_linea = bloque.index(@@separador_linea)
    linea = bloque[0..separador_salto_de_linea]
    obstaculos = []
    while (separador_salto_de_linea!=nil and linea[0]=="O") do
        bloque = bloque[separador_salto_de_linea + @@separador_linea.length()..bloque.length()]
        obstaculos.push(linea)
        separador_salto_de_linea = bloque.index(@@separador_linea)
        linea = bloque[0..separador_salto_de_linea] 
    end
    if (separador_salto_de_linea==nil and bloque[0]=="O")
        linea=bloque
        obstaculos.push(linea)
        bloque=""
    end
    return bloque, obstaculos
end
def cargarObstaculos(obstaculos)
    obstaculos.each do |obstaculo|
        cargarObstaculo(obstaculo)
    end
end

def cargarPuente(linea)
    linea = linea.gsub("(P","")
    linea = linea.gsub(")","")
    linea = linea.gsub(" ","")
    linea = linea.split("-")
    puente_inicio = linea[0].split(",")
    puente_salida = linea[1].split(",")
    @@mapa.PutBridgeWithPositions(puente_inicio[1].to_i, puente_inicio[0].to_i, puente_salida[1].to_i,puente_salida[0].to_i)
end
def separarPuentes(bloque)
    separador_salto_de_linea = bloque.index(@@separador_linea)
    linea = bloque[0..separador_salto_de_linea]
    puentes=[]
    while (separador_salto_de_linea!=nil and linea[0,2]=="(P") do
        bloque = bloque[separador_salto_de_linea + @@separador_linea.length()..bloque.length()]
        puentes.push(linea)
        separador_salto_de_linea = bloque.index(@@separador_linea)
        linea = bloque[0..separador_salto_de_linea] 
    end
    if (separador_salto_de_linea==nil and bloque[0,2]=="(P")
        linea=bloque
        puentes.push(linea)
        bloque=""
    end
    return bloque, puentes
end
def cargarPuentes(puentes)
    puentes.each do |puente|
        cargarPuente(puente)
    end
end
def moverUnAutoYGuardar(bloque)
    mensaje = ""
    instrucciones=[""]
    
    pos_y, pos_x = @@auto.GetPosition()
    ps_x,ps_y, crd = -1, -1, ""
    if (bloque.to_s!="")

        cadena = bloque.to_s
        cantidad_saltos_de_linea = cadena.count(@@separador_linea)

        if (cantidad_saltos_de_linea==1)
            cadena=cadena.split(@@separador_linea)
            ps_x,ps_y, crd = Conseguir_Posicion_Inicial(cadena[0].to_s)
            instrucciones = cadena[1].to_s.split("")
        end
        if (cantidad_saltos_de_linea==0)
            cantidad_de_separadores = cadena.count(",") + cadena.count(" ")
            if (cantidad_de_separadores == 2)
                ps_x,ps_y, crd = Conseguir_Posicion_Inicial(cadena.to_s)
            end
            if (cantidad_de_separadores == 0)
                instrucciones = cadena.to_s.split("")
                ps_x = 0
                ps_y = 0
                crd = "N"
            end
        end
        if (ps_x>=0 and ps_y>=0 and crd!="")
            pos_y = ps_y
            pos_x = ps_x
            card = crd
            @@auto = Robot.new(pos_y ,pos_x ,card)

        end
        
        mensaje = @@mapa.PutRobotInSquares(@@auto)
        if (mensaje=="robot en el mapa")
            @@listaDeRobots.AgregateNewRobot(@@auto, instrucciones)
            @@mapa.MoveRobotInSquares(@@auto,instrucciones)
        end
    end
    
    
    return mensaje
end



def cargarAutos(bloques_por_auto)
    mensaje=""
    bloques_por_auto.each do |auto_ins|
        mensaje=mensaje+moverUnAutoYGuardar(auto_ins)+"<br>"
    end
    return mensaje
end



post'/comandos' do
    @@listaDeRobots.ClearList()
    @@auto = Robot.new(0,0,"N")
    @matrizDeDatosDeAutos=Matrix.build(0,0)
    bloque=params[:caja_de_comandos].to_s
    bloque = bloque.gsub(@@separador_enter,@@separador_linea)
    if (bloque!="")
        bloque, limites = separarLimites(bloque)
        cargarLimites(limites)
        bloque, puentes = separarPuentes(bloque)
        cargarPuentes(puentes)
        bloque, obstaculos = separarObstaculos(bloque)
        cargarObstaculos(obstaculos)
    end
    bloques_por_auto = separar_Bloques(bloque)
    @mensajeDeRobots = cargarAutos(bloques_por_auto)
    if (bloque!="")
        @matrizDeDatosDeAutos= @@listaDeRobots.GetMatrixOfElementsOfCars()
    end
    @superficie_y, @superficie_x = @@mapa.Shape()
    @numeros_de_autos = Array.new(@@listaDeRobots.CountRobots()) { |a| a + 1 } 
    @cadena_de_resultados=""
    @numeros_de_autos.each do |auto|
        @cadena_de_resultados+="<h3>Auto #{auto}:</h3>"
        @cadena_de_resultados+="<div>Posicion Inicial: #{@matrizDeDatosDeAutos[auto-1,0][0].to_s},#{@matrizDeDatosDeAutos[auto-1,1][0].to_s} #{@matrizDeDatosDeAutos[auto-1,2][0].to_s}</div>"
        @cadena_de_resultados+="<div>Comandos ejecutados: #{@matrizDeDatosDeAutos[auto-1,3][0].to_s}</div>"
        @cadena_de_resultados+="<div>Posicion Final: #{@matrizDeDatosDeAutos[auto-1,4][0].to_s },#{@matrizDeDatosDeAutos[auto-1,5][0].to_s} #{@matrizDeDatosDeAutos[auto-1,6][0].to_s}</div>"
    end
    @grilla=""

    for @i in 0..@superficie_y-1
        @grilla+="<div>"
        for @j in 0..@superficie_x-1
            @grilla+=@@mapa.GetSquareType(@i,@j)+" "
        end
        @grilla+="</div>"
    end
    erb :comandos
end
=begin
8,8
1,1 N
2,2 N
3,3 N
4,4 N
5,5 N
6,6 N
7,7 N
<%for @i in 0..@superficie_y-1%>
        <div><%for @j in 0..@superficie_x-1;%><%=@@mapa.GetSquareType(@i,@j);%> <% end%></div>
    <% end%>
=end
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