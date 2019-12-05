sqlplus saj@SPJXHSP/agesune1 @C:\Saj\Clientes\pge.net\Robot\contextos\Ato\resources\config\preparar_ambiente.sql
sqlplus saj@SPJXHSP/agesune1 @C:\Saj\Clientes\pge.net\Robot\contextos\Ato\resources\config\preparar_mni.sql
sqlplus saj@SPJXHSP/agesune1 @C:\Saj\Clientes\pge.net\Robot\contextos\ExecucaoFiscal\resources\config\preparar_ambiente.sql
sqlplus saj@SPJXHSP/agesune1 @C:\Saj\Clientes\pge.net\Robot\contextos\GestaodeDocumentos\resources\config\config_Peticionamento.sql
sqlplus saj@SPJXHSP/agesune1 @C:\Saj\Clientes\pge.net\Robot\contextos\painel\resources\configurar_painel.sql

Net stop "spjServico"
Net start "spjServico"
