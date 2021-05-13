Feature:
    como:	niño que usa la aplicacion		
    quiero:	mover y direccionar el auto		
    para:	poder mover el robot desde la aplicacion
Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con "AAID"
    And presiono el boton para correr_comandos
    Then veo las instrucciones: 'Comandos de movimientos: AAID'