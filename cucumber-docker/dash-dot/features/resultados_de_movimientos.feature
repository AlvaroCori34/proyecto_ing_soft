Feature:
    Como	niño que usa la aplicacion		
    Quiero	mostrar las salidas de la posicion del robot		
    Para	verificar los movimientos que realizo el robot y los puntos donde se detiene.	

Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con '8,6\nDAADII'
    And presiono el boton para correr_comandos
    Then la instruccion de salida es: "Posicion final del auto: 4 0 N"


Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con "8,6\n0,0 N\nDAA"
    And presiono el boton para correr_comandos
    Then la instruccion de salida es: "Posicion final del auto: 3 0 E"