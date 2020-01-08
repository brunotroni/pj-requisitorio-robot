*** Settings ***
Library  Process
Library  AutoItLibrary
Library  DatabaseLibrary
Library  SikuliLibrary


*** Variables ***
${prcTestador}              F:\\SAJ\\Topo\\prcTestador.exe
${spjCliente}               F:\\SAJ\\Topo\\spjClienteApp.exe
${pathTestador}             F:\\SAJ\\Topo\\
${cdprocessoP}              '0100076ON0001'
${nuprocessoP}              2019056253
${DataAtualizacao}          01012019
${DataAtualizacaoP}         01/01/2019
${telaSistema}              SAJ/PJ - Procuradoria Jurídica
${telaCalculo}              Cálculo de Requisitórios
${CONEXAO_BANCO}            'saj/agesune1@PRJMSP'
${IMAGE_DIR}                ${CURDIR}\\images

*** Keywords ***

Conectar no banco
  Connect To Database Using Custom Params    cx_Oracle   ${CONEXAO_BANCO}

Carrega diretório de imagens
    Add Image Path          ${IMAGE_DIR}

Fechar testador
  Sleep    3
  Terminate Process         ${Process cliente}  kill=True
  Stop Remote Server

Verificar no banco se existe indexador nessa data
  No Operation
#  Check If Exists In Database        select * from ESAJINDEXHIST i left join EPRCPRECATINDEX pi on i.cdindexador = pi.cdindexador where pi.cdprocesso = ${cdprocessoP} and i.dtIndexador = to_date('${DataAtualizacaoP}', 'dd/mm/yyyy')
### ESTUDDAR FORMA DE COLOCAR UMA ANALISE SE JA TEM O CALCULO
#  Check If not Exists In Database    select tpCalculo from eprcPrecatCalculo where cdprocesso = '${cdprocessoP}' and dtbase = to_date ('${DataAtualizacaoP}','dd/mm/yyyy') and tpCalculo = 'P'


  #Verificar no Banco

Abrir o Sistema
### INICIA PRJ
  ${Process cliente}        Start Process  ${spjCliente}  cwd=${pathTestador}
  Set Suite Variable        ${Process cliente}
  Wait For Active Window    fprjLogin  ${EMPTY}   5
  #Sleep   1
  ### FAZ LOGIN AUTOMATICO
  Press Special Key         ENTER
  Wait For Active Window    ${telaSistema}   ${EMPTY}   5

Abrir janela de Atualização
  ## ABRE JANELA DE ATUALIZAR
  Send                      {ALT}
  Send                      r
  Send                      á
  Send                      R

Preecher campos de atualização selecionando processo
  ## PREENCHE DADOS NA TELA
  Wait For Active Window    ${EMPTY}  ${telaCalculo}  5
  Send                      ${DataAtualizacao}
  Send                      {TAB}
  Send                      ${DataAtualizacao}
  Send                      {TAB}
  Send                      ${nuprocessoP}
  ### SELECIONA OPV NA ARVORE
  Wait For Active Window    Seleção de Processos Dependentes  ${EMPTY}   5
  Send                      {DOWN}
  sleep                     1
  Press Special Key         ENTER


Clicar em Calcular
  Wait For Active Window    ${EMPTY}  ${telaCalculo}  3
  Send                      !u
  Wait For Active Window    Confirmação  ${EMPTY}   30
  Press Special Key         ENTER
  Wait For Active Window    ${EMPTY}  &OK   10
  Press Special Key         ENTER

Analisar no banco se foi inserido tpCalculo
###Consulta tpCalculo P no processo ####
  No Operation
  #Check If Exists In Database    select tpCalculo from eprcPrecatCalculo where cdprocesso = ${cdprocessoP} and dtbase = to_date ('${DataAtualizacaoP}','dd/mm/yyyy')
