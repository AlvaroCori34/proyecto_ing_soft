Feature:
    Como	niño que maneja el robot		
    Quiero	crear puentes transitables 		
    Para	que el robot se traslade por encima de obstaculos de un punto a otro punto	
Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con '7,7\n(P 1,2 - 3,5)'
    And presiono el boton para correr_comandos
    Then veo una fila: 'cuadrilla puente cuadrilla cuadrilla cuadrilla cuadrilla cuadrilla '
    And veo una fila: 'cuadrilla cuadrilla cuadrilla puente cuadrilla cuadrilla cuadrilla '

Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con '7,7\n(P 1,2 - 3,5)\n(P 0,1 - 0,4)\n(P 6,1 - 2,1)'
    And presiono el boton para correr_comandos
    Then veo una fila: 'cuadrilla cuadrilla cuadrilla cuadrilla cuadrilla cuadrilla cuadrilla '
    And veo una fila: 'puente cuadrilla puente cuadrilla cuadrilla cuadrilla puente '
    And veo una fila: 'cuadrilla puente cuadrilla cuadrilla cuadrilla cuadrilla cuadrilla '
    And veo una fila: 'cuadrilla cuadrilla cuadrilla cuadrilla cuadrilla cuadrilla cuadrilla '
    And veo una fila: 'puente cuadrilla cuadrilla cuadrilla cuadrilla cuadrilla cuadrilla '
    And veo una fila: 'cuadrilla cuadrilla cuadrilla puente cuadrilla cuadrilla cuadrilla '
    And veo una fila: 'cuadrilla cuadrilla cuadrilla cuadrilla cuadrilla cuadrilla cuadrilla '

Scenario:
    Given ingresar a la pagina de comandos
     When yo lleno en 'caja_de_comandos' con '7,7\n(P 1,2 - 3,5)\n0,2 E\nA'
    And presiono el boton para correr_comandos 
    Then veo la posicion como: 'Posicion Final: 4,5 E'