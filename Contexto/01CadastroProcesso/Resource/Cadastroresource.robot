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
${Cadastro de Processos Judiciais}    Cadastro de Processos Judiciais
${Consulta de Juizos}       Consulta de Juizos
${IMAGE_DIR}                ${CURDIR}\\images
${CONEXAO_BANCO}            'saj/agesune1@PRJXSP'

*** Keywords ***


Carrega diretório de imagens
    Add Image Path          ${IMAGE_DIR}
    Conectar no banco


    ###### CENÁRIO 1 #########

# Verificar se ja esta cadastrado na base
# ###### VERIFICA SE JÁ EXISTE O CADASTRO ######
#   Check If Not Exists In Database    select cdprocesso from eprcWsreq where cdprocessoreqtj = '${cdprocessoWS}'
#
# Executar testador
#   Abrir Testador
#
# Abrir menu cadastrar requisitorio digital
#   Send                      {ALT}
#   Send                      w
#   Send                      c
#   Wait For Active Window    Cadasrar Requisitório - WS  ${EMPTY}  10
#
# Informar cdProcessoreqtj
#   Send                      ${cdprocessoWS}
#   Press Special Key         ENTER
#
# Aguardar confirmacao de processamento
#   Win Wait Active           ${EMPTY}  ${telaConfirmacao}  240
#
# Verificar requisitorio no Cadastro de Processos
#   INICIA PRJ
#   Abre janela Cadastro de PROCESSO
# ###### PREENCHE TELA ######
#   Send                      ${nuprocessoWS}
#   Sleep                     2
#   Press Special Key         ENTER
#   Sleep                     1
#   Screen Should Contain     opv.PNG

      ###### CENÁRIO 2 #########
Abrir janela de cadastro de processos judiciais
  #INICIA PRJ
  Abre janela Cadastro de PROCESSO
  Send                      !n


Cadastrar Processo ordinario
  [Arguments]                   ${Codigo Tribunal}
  ...                           ${Codigo Orgao Judicial}
  ...                           ${Num Juizo}
  ...                           ${Numero judicial do processo}
  ...                           ${Codigo Area}
  ...                           ${Codigo Assunto}
  ...                           ${Tipo Acao Ordinaria}
  ...                           ${Entidade}
    ## Partes ##
  ...                           ${Cod parte ativa}
  ...                           ${Cod parte passiva}
  ...                           ${cod representante}

  Preencher dados novo processo     ${Codigo Tribunal}
  ...                               ${Codigo Orgao Judicial}
  ...                               ${Num Juizo}


  Preencher aba dados principais    ${Codigo Area}
  ...                               ${Codigo Assunto}
  ...                               ${Tipo Acao ordinaria}
  ...                               ${Entidade}
  Preencher aba partes do processo  ${Cod parte ativa}  ${Cod parte passiva}   ${cod representante}

  Salvar processo

  Cadastrar Precatorio   ${Tipo Acao Precatorio}
  ...                    ${Natureza}
  ...                    ${Ano}
  ...                    ${Situacao}
  ...                    ${Valor Requisitado}
  ...                    ${Data Oficio}
  ...                    ${Data Recebimento}
  ...                    ${Data base}
  ...                    ${Principal Bruto}
  ...                    ${Juros Compensatorio}
  ...                    ${Juros Moratorio}
  ...                    ${Honorario}
  ...                    ${PE Honorario}


Preencher dados novo processo
  [Arguments]  ${Codigo Tribunal}  ${Codigo Orgao Judicial}  ${Num Juizo}
  Send                    ${Codigo Tribunal}
  Aperta o Tab
  ControlFocus            ${EMPTY}   ${EMPTY}    TspCampoMascara7
  Send                    ${Codigo Orgao Judicial}
  Aperta o Tab
  ControlFocus            ${EMPTY}   ${EMPTY}    TspDBLookupComboBox1
  sleep    1
  Send                    ${Num Juizo}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}  ${Consulta de Juizos}  5
  Press Special Key       ENTER
  ControlFocus            ${EMPTY}   ${EMPTY}   TspCampoMascara1
  Send                    ${Numero judicial do processo}
  Aperta o Tab
  Wait For Active Window    Confirmação        ${EMPTY}    5
  Screen Should Contain     ConfirmaCNJ.png
  Press Special Key       ENTER
  Send                    !c
  sleep                   2
  #Win Wait Active        ${EMPTY}   ${Processo Judicial}    10
  #Win Wait Active          ${EMPTY}    Cadastro de Processos Judiciais   10
  #Win Wait close           ${EMPTY}    Processo Judicial   10

Preencher aba dados principais
   [Arguments]   ${Codigo Area}   ${Codigo Assunto}   ${Tipo Acao ordinaria}   ${Entidade}
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Send                    ${Codigo Area}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  ControlFocus            ${EMPTY}   ${EMPTY}   TspCampoMascara38
  Send                    ${Codigo Assunto}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Send                    ${Tipo Acao ordinaria}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  ControlFocus            ${EMPTY}   ${EMPTY}   TspCampoMascara44
  Send                    ${Entidade}
  Aperta o Tab
  sleep                   1

#
Preencher aba partes do processo
  [Arguments]   ${Cod parte ativa}  ${Cod parte passiva}   ${cod representante}
  Send                        !p
  Wait Until Screen Contain   AbaPartes.png    10
  ControlFocus            ${EMPTY}   ${EMPTY}   TspCampoMascara12
  Send                        ${Cod parte ativa}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Clica em Parte passiva
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  ControlFocus            ${EMPTY}   ${EMPTY}   TspCampoMascara12
  Send                        ${Cod parte passiva}
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Aperta o Tab
  Clica em representate
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  ControlFocus            ${EMPTY}   ${EMPTY}   TspCampoMascara12
  Send                        ${cod representante}
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Aperta o Tab

Salvar processo
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Clica em salvar
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Click                       ProCadastramento.png
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10

Confirmar que foi salvo corretamente
  Check If Exists In Database    select * from espjProcesso where nucnjformatado = '${Numero judicial do processo}'

Cadastrar Precatorio
  [Arguments]  ${Tipo Acao Precatorio}  ${Natureza}  ${Ano}  ${Situacao}   ${Valor Requisitado}  ${Data Oficio}  ${Data Recebimento}  ${Data base}  ${Principal Bruto}  ${Juros Compensatorio}  ${Juros Moratorio}  ${Honorario}  ${PE Honorario}
  Wait For Active Window      ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Clica em Inserir
  Wait For Active Window      ${EMPTY}   ${Cadastro de Processos Judiciais}  10
#  Wait Until Screen Contain   emCadastramento.png    10

  ##### DADOS PRINCIPAIS DO PRECATORIO #####
  log                         ${Tipo Acao Precatorio}
  Send                        ${Tipo Acao Precatorio}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  log                         ${Natureza}
  Send                        ${Natureza}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  log                         ${Numero Judicial do processo}
  Send                        ${Numero Judicial do processo}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  log                         ${Ano}
  Send                        ${Ano}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  log                         ${Situacao}
  Send                        ${Situacao}
  Aperta o Tab             2
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  log                         ${Valor Requisitado}
  Send                        ${Valor Requisitado}
  Aperta o Tab             5
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  log                         ${Data Oficio}
  Send                        ${Data Oficio}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  log                         ${Data Recebimento}
  Send                        ${Data Recebimento}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10

  ##### CONTA REQUISITADA DO PRECATORIO #####
  Send                    !u
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  log                     ${Data base}
  Send                    ${Data base}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  log                     ${Principal Bruto}
  Send                    ${Principal Bruto}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  log                     ${Juros Compensatorio}
  Send                    ${Juros Compensatorio}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  log                     ${Juros Moratorio}
  Send                    ${Juros Moratorio}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  log                     ${Honorario}
  Send                    ${Honorario}
  Aperta o Tab            2
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  log                     ${PE Honorario}
  Send                    ${PE Honorario}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10

##### PARTES #####
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Send                    !P
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Send                    !C
  Wait For Active Window  Seleção de Partes para Cópia   ${EMPTY}  10
  Send                    !T
  Wait For Active Window  Seleção de Partes para Cópia   ${EMPTY}  10
  Send                    !p
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  log                     Terminei
