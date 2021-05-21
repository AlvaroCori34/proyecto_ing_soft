Feature:
    Como niño que usa la aplicacion
    Quiero establecer un area cuadrada
    Para que el robot solo actue dentro de un area segura

Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con '2,2'
    And presiono el boton para correr_comandos
    Then deberia mostrar los limites de la superficie: 'Superficie del terreno: 2,2'

