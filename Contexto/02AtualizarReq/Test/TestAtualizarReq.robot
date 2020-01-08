*** Settings ***
Documentation     Teste Precatorio
Library           Process
Resource          ../Resource/Atualizaresource.robot
#Test Setup        Carrega diretório de imagens
Test Teardown     Fechar testador
Suite Setup       Conectar no banco

*** Test Cases ***

Cenário 01:Atualizar processo
  Dado que seja informado uma data com indexador disponíveis
  Quando atualizar o requisitorio
  Então o saldo será corrigido para a data selecionada

# Cenario 02: Excluir calculo individual
#   Dado que exista calculo de atualização para esse processo
#   Quando preencher a janela e selecionar o calculo disponível
#   Então o sistema irá excluir o calculo P (atualização)

*** Keywords ***

Dado que seja informado uma data com indexador disponíveis
  Verificar no banco se existe indexador nessa data


Quando atualizar o requisitorio
  Abrir o Sistema
  Abrir janela de Atualização
  Preecher campos de atualização selecionando processo
  Clicar em Calcular

Então o saldo será corrigido para a data selecionada
   Analisar no banco se foi inserido tpCalculo
