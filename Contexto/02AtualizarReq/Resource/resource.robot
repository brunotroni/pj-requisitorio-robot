*** Settings ***
Library  Process
Library  AutoItLibrary
Library  SikuliLibrary
#Library  DatabaseLibrary


*** Variables ***
${prcTestador}              F:\\SAJ\\Topo\\prcTestador.exe
${spjCliente}               F:\\SAJ\\Topo\\spjClienteApp.exe
${pathTestador}             F:\\SAJ\\Topo\\
${cdprocessoP}              '0100076ON0001'
${nuprocessoP}              2019.01.056253
${DataAtualizacao}          01012019
${telaSistema}              SAJ/PJ - Procuradoria Jurídica
${telaCalculo}              Cálculo de Requisitórios
#${CONEXAO_BANCO}            'saj/agesune1@PRJMSP'
${IMAGE_DIR}                ${CURDIR}\\images

*** Keywords ***
Carrega diretório de imagens
    Add Image Path          ${IMAGE_DIR}

Fechar testador
  Sleep    3
#  Terminate Process  ${Process testador}  kill=True
  Terminate Process         ${Process cliente}  kill=True
  Stop Remote Server

Verificar no banco se existe indexador nessa data
  No Operation
  #Verificar no Banco

Abrir o Sistema
### INICIA PRJ
  ${Process cliente}        Start Process  ${spjCliente}  cwd=${pathTestador}
  Set Suite Variable        ${Process cliente}
  Wait For Active Window    fprjLogin  ${EMPTY}
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
  Wait For Active Window    Seleção de Processos Dependentes  ${EMPTY}
  Send                      {DOWN}
  Press Special Key         ENTER

#Clicar em Calcular
