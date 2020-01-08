*** Settings ***
Library           Process
Library           AutoItLibrary
Library           DatabaseLibrary


*** Variables ***
${CONEXAO_BANCO}            'saj/agesune1@PRJXSP'
*** Keywords ***

#
#
##### IMPORTANTE CONFIGURAR PARA APONTAR NA BASE PRJTESTESP
#

Conectar no banco
            Connect To Database Using Custom Params    cx_Oracle   ${CONEXAO_BANCO}
