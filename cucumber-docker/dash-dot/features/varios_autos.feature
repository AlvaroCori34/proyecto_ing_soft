Feature:
    Como	niño que usa la aplicacion		
    Quiero	programar movimientos para varios autos		
    Para	la aplicacion maneje varios autos con varios comandos al mismo tiempo	
Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con "8,8\n2,2 N\nAAA\n7,7 O\nAAADA"
    And presiono el boton para correr_comandos
    Then la instruccion de salida es: "Superficie del terreno: 8,8"
    And la instruccion de salida es: "Auto 1:"
    And la instruccion de salida es: "Posicion Inicial: 2,2 N"
    And la instruccion de salida es: "Comandos ejecutados: AAA"
    And la instruccion de salida es: "Posicion Final: 2,0 N"
    And la instruccion de salida es: "Auto 2:"
    And la instruccion de salida es: "Posicion Inicial: 7,7 O"
    And la instruccion de salida es: "Comandos ejecutados: AAADA"
    And la instruccion de salida es: "Posicion Final: 4,6 N"
    
    
