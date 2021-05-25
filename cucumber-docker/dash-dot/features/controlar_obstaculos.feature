Feature:
    Como:	niño que usa la aplicacion		
    Quiero:	un auto que no choque con los obstaculos		
    Para:	que el auto respete los demas puntos de obstaculos y los demas autos.
Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con "O 1,1\n1,1 N"
    And presiono el boton para correr_comandos
    Then veo mensaje: 'no se puede crear el robot en un obstaculo 1 1'