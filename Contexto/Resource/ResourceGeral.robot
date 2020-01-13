*** Settings ***
Library  Process
Library  AutoItLibrary
Library  SikuliLibrary
Library  FakerLibrary

*** Variables ***
${prcTestador}              F:\\SAJ\\Topo\\prcTestador.exe
${spjCliente}               F:\\SAJ\\Topo\\spjClienteApp.exe
${pathTestador}             F:\\SAJ\\Topo\\

*** Keywords ***

#
#
##### IMPORTANTE CONFIGURAR PARA APONTAR NA BASE PRJTESTESP
#



Fecha testador
      Sleep    3
#      Terminate Process         ${Process testador}  kill=True
      Terminate Process         ${Process cliente}  kill=True
      Stop Remote Server

Abrir Testador
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
          Wait For Active Window      SAJ/PJ - Procuradoria Jurídica  ${EMPTY}   10
Abre janela Cadastro de PROCESSO
  Log                       Passei
  Send                      {ALT}
  Send                      p
  Send                      p
  Wait For Active Window    ${EMPTY}    Cadastro de Processos Judiciais
  Sleep                     1

Gerar número randômico de processos
  ${Numero aleatorio}    Random Int  min=1000000   max=9999999
  ${Numero judicial do processo}=  Catenate  SEPARATOR=  ${Numero aleatorio}  -92.2019.4.11.8916
  Set Global Variable    ${Numero judicial do processo}

Aperta o Tab
  [Arguments]   ${VEZES}=1
  : FOR    ${INDEX}    IN RANGE    0    ${VEZES}
  \    Press Special Key   TAB

Clica em Parte ativa
  send     !a
Clica em Parte passiva
  send     !v
Clica em representate
  send     !r
Clica em salvar
  Send                    !s
Clica em Inserir
  Click                     Inserir.png
