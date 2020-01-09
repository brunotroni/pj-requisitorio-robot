*** Settings ***
Documentation     Teste Precatorio
Library           Process
Library           AutoItLibrary
Resource          ../Resource/Cadastroresource.robot
Test Setup        Carrega diretório de imagens
Test Teardown     Fecha testador


*** Test Cases ***

Cenário 01:Cadastrar requisitorios VIA WS
  Dado que exista requisitórios disponíveis
  Quando usuario cadastrar o requisitórios
  Então o requisitórios é cadastrado no PRJ

# Cenario 02:Cadastrar requisitorio via Janela
#   Dado que tenha os dados principais do processo
#   Quando salvar
#   Então será necessário preencher os dados principais
*** Keywords ***
###### CENÁRIO 1 #########
Dado que exista requisitórios disponíveis
#  Verificar se ja esta cadastrado na base
  No Operation

Quando usuario cadastrar o requisitórios
  Executar testador
  Abrir menu cadastrar requisitorio digital
  Informar cdProcessoreqtj
  Aguardar confirmacao de processamento

Então o requisitórios é cadastrado no PRJ
  Verificar requisitorio no Cadastro de Processos
