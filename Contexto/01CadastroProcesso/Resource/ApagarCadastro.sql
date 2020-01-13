update eprcWsReq R
   set R.Flcadastrado   = 'N',
       R.Cdprocesso = null where R.cdProcesso='010005K3M0001';

----------- DELETE         

Update espjProcesso
   set nuUltSeqProcessoMv =
       (Select Max(p.nuSeqProcessoMv) as nuSeqProcessoMv
          from espjProcessoMv P
         where p.cdProcesso = '0100065PF0001'
           and p.nuSeqProcessoMv <> 1)

 where cdProcesso in
       (Select cdProcesso
          from espjProcesso P
         where P.cdprocesso = '010005K3M0001');

delete from espjprocessomv
 where cdProcesso in
       (Select cdProcesso
          from espjProcesso P
         where P.cdprocesso = '010005K3M0001');

delete from Espjdistprocesso
 where cdProcesso in
       (Select cdProcesso
          from espjProcesso P
         where P.cdprocesso = '010005K3M0001');

delete from espjProcAssunto
 where cdProcesso in
       (Select cdProcesso
          from espjProcesso P
         where P.cdprocesso = '010005K3M0001');   

delete from espjProcPessoa
 where cdProcesso in
       (Select cdProcesso
          from espjProcesso P
         where P.cdprocesso = '010005K3M0001');   

delete from Eprcprecatjuro
 where cdProcesso in
       (Select cdProcesso
          from espjProcesso P
         where P.cdprocesso = '010005K3M0001');   

delete from EprcprecatIndex
 where cdProcesso in
       (Select cdProcesso
          from espjProcesso P
        where P.cdprocesso = '010005K3M0001');     

delete from EPRCPRECATPESSOA
 where cdProcesso in
       (Select cdProcesso
          from espjProcesso P
         where P.cdprocesso = '010005K3M0001'); 

delete from eprcPrecatorio
 where cdProcesso in
       (Select cdProcesso
          from espjProcesso P
         where P.cdprocesso = '010005K3M0001');            
         
delete from EPRCPRECATCALCULO
 where cdProcesso in
       (Select cdProcesso
          from espjProcesso P
         where P.cdprocesso = '010005K3M0001');                                                   
         
delete from eprcprecatcontrib
 where cdProcesso in
       (Select cdProcesso
          from espjProcesso P
         where P.cdprocesso = '010005K3M0001');         
         
delete from Eprcservpublico
 where cdProcesso in
       (Select cdProcesso
          from espjProcesso P
         where P.cdprocesso = '010005K3M0001');  
       
delete from Espjprocoutrosnum
 where cdProcesso in
       (Select cdProcesso
          from espjProcesso P
         where P.cdprocesso = '010005K3M0001');
         
delete from eprcpendenciapagto 
 where cdProcesso in
       (Select cdProcesso
          from espjProcesso P
         where P.cdprocesso = '010005K3M0001');

delete from eprcpendenciarev 
 where cdProcesso in
       (Select cdProcesso
          from espjProcesso P
         where P.cdprocesso = '010005K3M0001');

UPDATE espjProcesso SET CDPROCESSOAGRUP = NULL  where CDPROCESSOAGRUP IN (SELECT cdprocesso from espjProcesso P where P.cdprocesso = '010005K3M0001');

UPDATE espjProcesso SET CDPROCESSOSUP = NULL  where cdprocesso = '010005K3M0001';

--COMMIT;

DELETE from espjProcesso P where P.cdprocesso = '010005K3M0001';

--commit;


 
