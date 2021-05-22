Feature:
    Como	niño que maneja el robot		
    Quiero	crear obstaculos en la superficie		
    Para	que la superficie sea mas compleja y interactiva
Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con 'O 2,2'
    And  presiono el boton para correr_comandos
    Then veo la posicion como: ''
    
    