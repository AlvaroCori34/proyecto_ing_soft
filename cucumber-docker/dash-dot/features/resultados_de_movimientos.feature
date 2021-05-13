Feature:
    Como	niño que usa la aplicacion		
    Quiero	mostrar las salidas de la posicion del robot		
    Para	verificar los movimientos que realizo el robot y los puntos donde se detiene.	

Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'limite_x' con '8'
    And  yo lleno en 'limite_y' con '6'
    And presiono el boton para asignar
    And yo lleno en 'caja_de_comandos' con "AADI"
    And presiono el boton para correr_comandos
    Then la instruccion de salida es: "Posicion final del auto: 3 1 N"

    