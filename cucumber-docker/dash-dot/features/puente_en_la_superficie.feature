Feature:
    Como	niño que maneja el robot		
    Quiero	crear puentes transitables 		
    Para	que el robot se traslade por encima de obstaculos de un punto a otro punto	
Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con "AAID"
    And presiono el boton para correr_comandos
    Then veo las instrucciones: 'Comandos ejecutados: AAID'