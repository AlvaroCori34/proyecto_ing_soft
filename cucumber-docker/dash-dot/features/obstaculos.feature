Feature:
    Como:	niño que maneja el robot		
    Quiero:	crear obstaculos en la superficie		
    Para:	que la superficie sea mas compleja y interactiva
Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con '3,3\nO 1,1'
    And presiono el boton para correr_comandos
    Then veo una fila: 'cuadrilla obstaculo cuadrilla '
    
Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con '4,4\nO 0,0\nO 1,1\nO 2,2\nO 3,3'
    And presiono el boton para correr_comandos
    Then veo una fila: 'obstaculo cuadrilla cuadrilla cuadrilla '
    And  veo una fila: 'cuadrilla obstaculo cuadrilla cuadrilla '
    And  veo una fila: 'cuadrilla cuadrilla obstaculo cuadrilla '
    And  veo una fila: 'cuadrilla cuadrilla cuadrilla obstaculo '