Feature:
    Como niño que usa la aplicacion
    Quiero establecer un area cuadrada
    Para que el robot solo actue dentro de un area segura

Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'limites' con '2 2'
    Then presiono el boton para correr

Scenario:
    When presione el boton correr