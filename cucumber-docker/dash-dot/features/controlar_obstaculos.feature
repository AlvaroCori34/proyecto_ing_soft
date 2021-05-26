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

Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con "4,4\n0,0 E\nAA\n0,0 E"
    And presiono el boton para correr_comandos
    Then veo mensaje: 'Posicion Final: 2,0 E'
    And veo mensaje: 'Posicion Final: 0,0 E'

Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con "4,4\n0,0 E\n0,0 E"
    And presiono el boton para correr_comandos
    Then veo mensaje: 'Posicion Final: 0,0 E'
    And veo mensaje: 'no se puede crear el robot en un obstaculo 0 0'

Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con "9,9\n4,4 N\n4,0 S\nAAAAAAAA\n8,4 O\nAAAAAAA\n0,4 E\nAAAAAAA\n4,8 N\nAAAAAAA"
    And presiono el boton para correr_comandos
    Then veo mensaje: 'Posicion Inicial: 4,4 N'
    And veo mensaje: 'Posicion Final: 4,4 N'
    And veo mensaje: 'Posicion Inicial: 4,0 S'
    And veo mensaje: 'Posicion Final: 4,3 S'
    And veo mensaje: 'Posicion Inicial: 8,4 O'
    And veo mensaje: 'Posicion Final: 5,4 O'
    And veo mensaje: 'Posicion Inicial: 0,4 E'
    And veo mensaje: 'Posicion Final: 3,4 E'
    And veo mensaje: 'Posicion Inicial: 4,8 N'
    And veo mensaje: 'Posicion Final: 4,5 N'