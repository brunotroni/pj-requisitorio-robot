*** Settings ***
Documentation     Teste Precatorio
Library           Process
Resource          ../Resource/resource.robot
Test Setup        Carrega diretório de imagens
Test Teardown     Fechar testador


*** Test Cases ***

 Cenário 01:Cadastrar requisitórios
   # Dado que exista requisitórios disponíveis
   # Quando usuario cadastrar o requisitórios
   Então o requisitórios é cadastrado no PRJ


*** Keywords ***
###### CENÁRIO 1 #########
Dado que exista requisitórios disponíveis
  # Verificar requisitório  na base
  No Operation


Quando usuario cadastrar o requisitórios
  Executar testador
  Abrir tela cadastrar requisitorio digital
  Informar cdProcessoreqtj
  Aguardar confirmacao de processamento


Então o requisitórios é cadastrado no PRJ
  Verificar requisitorio no Cadastro de Processos
