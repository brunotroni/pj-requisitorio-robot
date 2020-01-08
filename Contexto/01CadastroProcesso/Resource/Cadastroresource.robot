*** Settings ***
Library  Process
Library  AutoItLibrary
Library  SikuliLibrary
Library  DatabaseLibrary



*** Variables ***
${prcTestador}              F:\\SAJ\\Topo\\prcTestador.exe
${spjCliente}               F:\\SAJ\\Topo\\spjClienteApp.exe
${pathTestador}             F:\\SAJ\\Topo\\
${cdprocessoWS}             DW0013X040000
${nuprocessoWS}             2019.01.056558
${telaConfirmacao}          OK
${CONEXAO_BANCO}            'saj/agesune1@PRJXSP'
${IMAGE_DIR}                ${CURDIR}\\images

*** Keywords ***

Conectar no banco
  Connect To Database Using Custom Params    cx_Oracle   ${CONEXAO_BANCO}

Carrega diretório de imagens
    Add Image Path          ${IMAGE_DIR}

Fechar testador
  Sleep    3
  Terminate Process         ${Process testador}  kill=True
  Terminate Process         ${Process cliente}  kill=True
  Stop Remote Server

# Verificar se ja esta cadastrado na base
# #sansTran=False Exists In Database
#   Check If Exists In Database    select cdprocesso from eprcWsreq where cdprocessoreqtj = 'DW0013X040000'    True
# # #

Executar testador
  ${Process testador}       Start Process  ${prcTestador}  cwd=${pathTestador}
  Set Suite Variable        ${Process testador}
  Wait For Active Window    Testador/ Simulador - PRJ  ${EMPTY}  10


Abrir tela cadastrar requisitorio digital
  Send                      {ALT}
  Send                      w
  Send                      c
  Wait For Active Window    Cadasrar Requisitório - WS  ${EMPTY}  10


Informar cdProcessoreqtj
  Send                      ${cdprocessoWS}
  Press Special Key         ENTER

Aguardar confirmacao de processamento
  Win Wait Active           ${EMPTY}  ${telaConfirmacao}  60

Verificar requisitorio no Cadastro de Processos
### INICIA PRJ
  ${Process cliente}        Start Process  ${spjCliente}  cwd=${pathTestador}
  Set Suite Variable        ${Process cliente}
  Wait For Active Window    fprjLogin  ${EMPTY}
  Sleep   1
### FAZ LOGIN AUTOMATICO
  Press Special Key         ENTER
  Wait For Active Window      SAJ/PJ - Procuradoria Jurídica  ${EMPTY}
### ABRE JANELA CADASTRO DE PROCESSO
#  Sleep   1
  Send                      {ALT}
  Send                      p
  Send                      p
  Sleep                     3
#  Wait For Active Window      Cadastro de Processos Judiciais  ${EMPTY}
  Send                      ${nuprocessoWS}
  Sleep                     2
  Press Special Key         ENTER
  Sleep                     1
  Screen Should Contain     opv.PNG
