Feature:
    como: niño que usa la aplicacion	
    quiero:	ver una simulacion de mi programa en digital
    para: verificar el buen funcionamiento de mi programa
Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con '3,3'
    And presiono el boton para correr_comandos
    Then veo una fila: 'cuadrilla cuadrilla cuadrilla '
    And  veo una fila: 'cuadrilla cuadrilla cuadrilla '
    And  veo una fila: 'cuadrilla cuadrilla cuadrilla '

Scenario:
    Given ingresar a la pagina de comandos
    When yo lleno en 'caja_de_comandos' con '3,3\n1,1 N\n2,2 O\n'
    And presiono el boton para correr_comandos
    Then veo una fila: 'cuadrilla cuadrilla cuadrilla '
    And  veo una fila: 'cuadrilla robot cuadrilla '
    And  veo una fila: 'cuadrilla cuadrilla robot '

