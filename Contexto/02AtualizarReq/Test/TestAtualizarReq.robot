*** Settings ***
Documentation     Teste Precatorio
Library           Process
Resource          ../Resource/resource.robot
Test Setup        Carrega diretório de imagens
Test Teardown     Fechar testador


*** Test Cases ***

Cenário 03:Atualizar processo
  Dado que seja informado uma data com indexador disponíveis
  Quando atualizar o requisitorio
#  Então o saldo será corrigido para a data selecionada


*** Keywords ***

Dado que seja informado uma data com indexador disponíveis
  Verificar no banco se existe indexador nessa data


Quando atualizar o requisitorio
  Abrir o Sistema
  Abrir janela de Atualização
  Preecher campos de atualização selecionando processo
  #Clicar em Calcular

# Então o saldo será corrigido para a data selecionada
#   Analisar no banco se foi inserido tpCalculo P
