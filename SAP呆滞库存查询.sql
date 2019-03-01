create VIEW V_TEMP_DZWLSJ
AS
select matnr,werks,SHKZG
,case when SHKZG='H' then max(BUDAT_MKPF) else min(BUDAT_MKPF) end as gzrq,min(BUDAT_MKPF) AS ZZRQ,max(BUDAT_MKPF) AS ZJRQ
from
(
select matnr,werks,BUDAT_MKPF,SHKZG,min(js) from
(
select mandt,BUDAT_MKPF,matnr,werks,bwart,MBLNR,ZEILE,concat(MBLNR,ZEILE) as js,SHKZG
from sapabap1.NSDM_V_MSEG where bwart not in ('411','412','413','414','415','416','311','321','322','551','552')  and mandt='800'
) t
--where matnr='000000001200000011'
group by matnr,werks,BUDAT_MKPF,SHKZG
) t
group by matnr,werks,SHKZG

create VIEW V_DZKCSJ
AS
select a.matnr,a.maktx,a.zzbismt,a.werks,a.lgort
,a.lgobe,a.charg,a.sobkz,a.tskcbm,
	 a.labst,a.meins,a.insme,a.speme,b.SHKZG,b.gzrq,days_between(b.gzrq,current_date) as zlsc
	 from V_SAPWLSJCX a
left join (
SELECT matnr,werks,SHKZG,gzrq 
FROM V_TEMP_DZWLSJ 
WHERE SHKZG='H'
UNION ALL
SELECT matnr,werks,SHKZG,gzrq 
FROM V_TEMP_DZWLSJ A
WHERE SHKZG='S' AND NOT EXISTS(SELECT * FROM  V_TEMP_DZWLSJ B WHERE A.MATNR=B.MATNR AND A.WERKS=B.WERKS AND SHKZG='H')
) b
on a.matnr=b.matnr and a.werks=b.werks 
where a.werks in (1001,1002,1801,1901)