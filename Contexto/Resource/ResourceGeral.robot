*** Settings ***
Library  Process
Library  AutoItLibrary
Library  SikuliLibrary

*** Variables ***
${prcTestador}              F:\\SAJ\\Topo\\prcTestador.exe
${spjCliente}               F:\\SAJ\\Topo\\spjClienteApp.exe
${pathTestador}             F:\\SAJ\\Topo\\

*** Keywords ***

#
#
##### IMPORTANTE CONFIGURAR PARA APONTAR NA BASE PRJTESTESP
#



Fechar testador
      Sleep    3
      Terminate Process  ${Process testador}  kill=True
      Terminate Process         ${Process cliente}  kill=True
      Stop Remote Server

Executar testador
        ${Process testador}       Start Process  ${prcTestador}  cwd=${pathTestador}
        Set Suite Variable        ${Process testador}
        Wait For Active Window    Testador/ Simulador - PRJ  ${EMPTY}  10

INICIA PRJ
          ${Process cliente}        Start Process  ${spjCliente}  cwd=${pathTestador}
          Set Suite Variable        ${Process cliente}
          Wait For Active Window    fprjLogin  ${EMPTY}
          Sleep   1
        ### FAZ LOGIN AUTOMATICO
          Press Special Key         ENTER
          Wait For Active Window      SAJ/PJ - Procuradoria Jurídica  ${EMPTY}