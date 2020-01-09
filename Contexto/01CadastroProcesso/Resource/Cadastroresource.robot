*** Settings ***
Library           Process
Library           AutoItLibrary
Library           SikuliLibrary
Resource          ../../Resource/ResourceGeral.robot
Resource          ../../Resource/ResourceBD.robot



*** Variables ***
${cdprocessoWS}             DW0013X040000
${nuprocessoWS}             2019.01.056558
${telaConfirmacao}          OK
${IMAGE_DIR}                ${CURDIR}\\images

*** Keywords ***

Carrega diretório de imagens
    Add Image Path          ${IMAGE_DIR}


# A FAZER === Verificar se ja esta cadastrado na base antes de iniciar o cadastro
# #sansTran=False Exists In Database
#   Check If Exists In Database    select cdprocesso from eprcWsreq where cdprocessoreqtj = 'DW0013X040000'    True
# # #

Executar testador
  Abrir Testador


Abrir menu cadastrar requisitorio digital
  Send                      {ALT}
  Send                      w
  Send                      c
  Wait For Active Window    Cadasrar Requisitório - WS  ${EMPTY}  10


Informar cdProcessoreqtj
  Send                      ${cdprocessoWS}
  Press Special Key         ENTER

Aguardar confirmacao de processamento
  Win Wait Active           ${EMPTY}  ${telaConfirmacao}  240

Verificar requisitorio no Cadastro de Processos
  INICIA PRJ
  Abre janela Cadastro de PROCESSO
###### PREENCHE TELA ######
  Send                      ${nuprocessoWS}
  Sleep                     2
  Press Special Key         ENTER
  Sleep                     1
  Screen Should Contain     opv.PNG
