Feature:
    Como:	niño que usa la aplicacion		
    Quiero:	un auto que no choque con los obstaculos		
    Para:	que el auto respete los demas puntos de obstaculos y los demas autos.
Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con "O 1,1\n1,1 N"
    And presiono el boton para correr_comandos
    Then veo mensaje: 'no se puede crear el robot en un obstaculo 1 1'

Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con "5,5\nO 3,0\n0,0 E\nAAAAAADAAA"
    And presiono el boton para correr_comandos
    Then veo mensaje: 'Posicion Final: 2,0 E'

Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con "8,8\n3,3 N\nAAAAAADDAA\n4,4 E\nAAAAAAIIAA\n3,5 S\nAAAAAADDAA\n2,4 O\nAAAAAAIIAA"
    And presiono el boton para correr_comandos
    Then veo mensaje: 'Posicion Final: 3,0 N'
    And veo mensaje: 'Posicion Final: 7,4 E'
    And veo mensaje: 'Posicion Final: 3,7 S'
    And veo mensaje: 'Posicion Final: 0,4 O'
