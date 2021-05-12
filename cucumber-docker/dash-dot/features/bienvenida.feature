Feature:
    Como niño que usa la aplicacion
    Quiero ver la pantalla principal de la app
    Para poder ver una entrada del entorno de la app

Scenario:     
    When al ingresar a la direccion de la pagina    
    Then deberia ver el mensaje 'Bienvenido a dash and dot'      

Scenario:
    Given al ingresar a la direccion de la pagina 
    When presiono el boton para dar inicio
    Then deberia ver el mensaje "Comandos a ejecutar" 
    