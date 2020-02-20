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
${Cadastro da Conta Requisitada do Credor}    Cadastro da Conta Requisitada do Credor
${Seleção de Partes para Cópia}       Seleção de Partes para Cópia
${Consulta de Juizos}       Consulta de Juizos
${tela Processo Judicial}   Processo Judicial
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
  ControlFocus                 SAJ/PJ - Procuradoria Jurídica  ${EMPTY}  ${EMPTY}
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
  ...
  ####LOG                          ${cod representante}
  Log To Console   ----> Novo Processo    ${EMPTY}     no_newline=True

  Preencher dados novo processo     ${Codigo Tribunal}
  ...                               ${Codigo Orgao Judicial}
  ...                               ${Num Juizo}
####LOG
  Log To Console   ----> Dados Principais    ${EMPTY}     no_newline=True

  Preencher aba dados principais    ${Codigo Area}
  ...                               ${Codigo Assunto}
  ...                               ${Tipo Acao ordinaria}
  ...                               ${Entidade}
####LOG
  Log To Console   ----> Partes    ${EMPTY}     no_newline=True

  Preencher aba partes do processo  ${Cod parte ativa}  ${Cod parte passiva}   ${cod representante}

####LOG
  Log To Console   ----> Salvar Processo    ${EMPTY}     no_newline=True

  Salvar processo

Preencher dados novo processo
  [Arguments]  ${Codigo Tribunal}  ${Codigo Orgao Judicial}  ${Num Juizo}
  ControlFocus            ${EMPTY}   ${EMPTY}    TspCampoMascara9
  Send                    ${Codigo Tribunal}
  Aperta o Tab
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
  ControlFocus            Confirmação   ${EMPTY}    ${EMPTY}
  sleep                   1
  Screen Should Contain     ConfirmaCNJ.png
  Press Special Key       ENTER
  Send                    !c
  sleep                   8


Preencher aba dados principais
   [Arguments]   ${Codigo Area}   ${Codigo Assunto}   ${Tipo Acao ordinaria}   ${Entidade}
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Send                    ${Codigo Area}
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Aperta o Tab            2
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Send                    ${Codigo Assunto}
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Send                    ${Tipo Acao ordinaria}
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  # sleep  1
  Click                   Entidade.png
# ControlFocus            ${EMPTY}   ${EMPTY}   TspCampoMascara15
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Send                    ${Entidade}
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  sleep                   2
  Control Focus           ${EMPTY}   ${Cadastro de Processos Judiciais}   ${EMPTY}
  Screen Should Contain    ConcluiAbaDados.png

#
Preencher aba partes do processo
  [Arguments]   ${Cod parte ativa}  ${Cod parte passiva}   ${cod representante}
  Send                        !p
  Wait Until Screen Contain   AbaPartes.png    10
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Click    CodParte.png
  Send                        ${Cod parte ativa}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Clica em Parte passiva
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Click    CodParte.png
  Send                        ${Cod parte passiva}
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Aperta o Tab
  Clica em representate
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Click    CodParte.png
  Send                        ${cod representante}
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Aperta o Tab

Salvar processo
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Clica em salvar
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  sleep                   4
  Click                       ProCadastramento.png
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10

Confirmar que foi salvo acao
  Check If Exists In Database    select * from espjProcesso where nucnjformatado = '${Numero judicial do processo}'

####LOG
Log To Console   ----> Inserir Precatorio    ${EMPTY}     no_newline=True
Log To Console   ----> Dados Principais    ${EMPTY}     no_newline=True

Inserir Precatorio
  [Arguments]  ${Tipo Acao Precatorio}  ${Natureza}  ${Ano}  ${Situacao}   ${Valor Requisitado}  ${Data Oficio}  ${Data Recebimento}  ${Data base}  ${Principal Bruto}  ${Juros Compensatorio}  ${Juros Moratorio}  ${Honorario}  ${PE Honorario}
  Wait For Active Window      ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  sleep  2
  Clica em Inserir
  Wait For Active Window      ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Sleep    2
  ##### DADOS PRINCIPAIS DO PRECATORIO #####
  Wait For Active Window      ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  ControlFocus                ${EMPTY}   ${EMPTY}   TspCampoMascara2
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
  log                    ${Numero judicial do processo}
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
####LOG
  Log To Console   ----> Conta Requisitada    ${EMPTY}     no_newline=True

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
  Screen Should Contain    ConfirmaContaRequisitada.png

  ####LOG
  Log To Console   ----> Partes Precatorio    ${EMPTY}     no_newline=True

##### PARTES #####
  Click                   Partes.png
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Click                   CopiarPartes.png
  Wait For Active Window    ${Seleção de Partes para Cópia}    ${EMPTY}    5
  # ControlFocus            ${Seleção de Partes para Cópia}   ${EMPTY}  ${EMPTY}
  # Send                    !C
  Wait For Active Window  ${Seleção de Partes para Cópia}   ${EMPTY}  10
  Send                    !T
  Wait For Active Window  Seleção de Partes para Cópia   ${EMPTY}  10
  Send                    !p
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10

  ####LOG
  Log To Console   ----> Conta Individualizada    ${EMPTY}     no_newline=True

##### INDIVIDUALIZAR VALORES NAS CONTAS #####
E Distribuir os valores
  sleep    5
  ControlFocus            ${EMPTY}   ${Cadastro de Processos Judiciais}  ${EMPTY}
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Click                   Precatorio.png
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Sleep                   2
  Click                   Editar.png
  Sleep                   1
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  ControlFocus            ${EMPTY}   ${EMPTY}  TVirtualStringTree1
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
##### Abre árvore até parte ATIVA
  Send                    {+}
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Send                    {DOWN}
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Send                    {+}
  Wait For Active Window  ${EMPTY}   ${Cadastro de Processos Judiciais}  10
  Send                    {DOWN}
##### Abre Conta da Parte Selecionada
  Double Click            ParteSelecionada.png
  Wait For Active Window  ${EMPTY}   ${Cadastro da Conta Requisitada do Credor}  10
  Sleep    1
  Screen Should Contain    ContaCredor.png
#### Envia Valores Individalizados
  log                     ${Principal Bruto}
  Send                    ${Principal Bruto}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro da Conta Requisitada do Credor}  10
  log                     ${Juros Compensatorio}
  Send                    ${Juros Compensatorio}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro da Conta Requisitada do Credor}  10
  log                     ${Juros Moratorio}
  Send                    ${Juros Moratorio}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro da Conta Requisitada do Credor}  10
  log                     ${Honorario}
  Send                    ${Honorario}
  Aperta o Tab
  Wait For Active Window  ${EMPTY}   ${Cadastro da Conta Requisitada do Credor}  10
  Click    Salvar.png
  Wait For Active Window    Confirmação   ${EMPTY}    5
  Press Special Key       ENTER
  Wait For Active Window  ${EMPTY}   ${Cadastro da Conta Requisitada do Credor}  10
  Click    Fechar.png
  Click    Salvar.png

  ####LOG
  Log To Console   ----> Consulta Banco    ${EMPTY}     no_newline=True

Confirmar que foi salvo Precatorio
#### Verifica se existe o processo cadastrado
  Check If Exists In Database    select * from espjProcesso where nuformatado = '${Numero judicial do processo}'

#### Verifica se criou Conta Requisitada na EPRCPRECATCALCULO
  Check If Exists In Database    select * from eprcPrecatCalculo where cdprocesso in (select cdprocesso from espjProcesso where nuformatado = '${Numero judicial do processo}') and tpCalculo = 'C';
