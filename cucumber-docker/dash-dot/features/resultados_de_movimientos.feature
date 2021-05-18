Feature:
    Como	niño que usa la aplicacion		
    Quiero	mostrar las salidas de la posicion del robot		
    Para	verificar los movimientos que realizo el robot y los puntos donde se detiene.	

Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con '8,6\nDAADII'
    And presiono el boton para correr_comandos
    Then la instruccion de salida es: "Posicion final del auto: 2 0 N"


Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con "8,6\n0,0 N\nDAA"
    And presiono el boton para correr_comandos
    Then la instruccion de salida es: "Posicion final del auto: 2 0 E"

Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con "5,5\n1,2 N\nIAIAIAIAA"
    And presiono el boton para correr_comandos
    Then la instruccion de salida es: "Posicion final del auto: 1 1 N"

Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con "6,6\n3,3 E\nAADAADADDA"
    And presiono el boton para correr_comandos
    Then la instruccion de salida es: "Posicion final del auto: 5 5 E"

