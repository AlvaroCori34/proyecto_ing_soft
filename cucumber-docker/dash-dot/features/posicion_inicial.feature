Feature:
    Como niño que usa la aplicacion
    Quiero establecer un area cuadrada
    Para que el robot solo actue dentro de un area segura
Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con '0 1 N'
    And yo lleno en 'caja_de_comandos' con 'll'
    And  presiono el boton para correr_comandos
    
