*** Settings ***
Documentation     Teste Precatorio
Library           Process
Library           AutoItLibrary
Resource          ../Resource/Cadastroresource.robot
Resource          ../../Resource/ResourceGeral.robot
Test Setup        Carrega diretório de imagens
Test Teardown     Fecha testador

*** Variables ***
## Cadastro de processo AÇÃO ORDINARIA##
${Codigo Tribunal}              1
${Codigo Orgao Judicial}        1
${Num Juizo}                    1
${Codigo Area}                  3
${Codigo Assunto}               69.2.1
${Tipo Acao Ordinaria}          49
${Entidade}                     1
## Partes ##
${Cod parte ativa}             23
${Cod parte passiva}           68176
${cod representante}           1963230

### Geral ###
${Numero judicial do processo}

### Precatorio ###
${Tipo Acao Precatorio}        38
${Natureza}                    2
${Ano}                         2018
${Situacao}                    3
${Valor Requisitado}           1
${Data Oficio}                 01012018
${Data Recebimento}            02012018
${Data base}                   03012018
${Principal Bruto}             50000
${Juros Compensatorio}         10000
${Juros Moratorio}             20000
${Honorario}                   30000
${PE Honorario}                10
 
*** Test Cases ***

# Cenário 01:Cadastrar requisitorios VIA WS
#   Dado que exista requisitórios disponíveis
#   Quando usuario cadastrar o requisitórios
#   Então o requisitórios é cadastrado no PRJ

Cenario 02:Cadastrar acao ordinaria
  Dado a tela de cadastro de processos judiciais
  Quando cadastro o processo de acao ordinaria
  E Cadastrar Precatorio
  E Cadastrar Precatorio
  E Distribui os valores
  Então Confirmar que foi salvo Precatorio

# Cenario 03:Cadastrar Precatorio
#   Dado que tenha os dados necessarios do Precatorio
#   Quando salvar
#   E Distribuir os valores
#   Então o cadastro estará salvo no banco de dados


*** Keywords ***
###### CENÁRIO 1 #########
# Dado que exista requisitórios disponíveis
#   Verificar se ja esta cadastrado na base
# Quando usuario cadastrar o requisitórios
#   Executar testador
#   Abrir menu cadastrar requisitorio digital
#   Informar cdProcessoreqtj
#   Aguardar confirmacao de processamento
# Então o requisitórios é cadastrado no PRJ
#   Verificar requisitorio no Cadastro de Processos

  ###### CENÁRIO 2 #########
Dado a tela de cadastro de processos judiciais
  abrir janela de cadastro de processos judiciais
Quando cadastro o processo de acao ordinaria
  Gerar número randômico de processos
  Cadastrar Processo ordinario  ${Codigo Tribunal}
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
  Confirmar que foi salvo acao
E Cadastrar Precatorio
  Gerar número randômico de processos
  log                    ${Numero judicial do processo}
  Inserir Precatorio     ${Tipo Acao Precatorio}
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
E Distribui os valores
  E Distribuir os valores
Então Confirmar que foi salvo Precatorio
  Confirmar que foi salvo Precatorio
# Então o processo deve ser incluido na base
#
#
# E Distribuir os valores
#   abrir cadastro do processo
#   abrir conta do credor
#   distribuir valor individual
#   salvar informacao
