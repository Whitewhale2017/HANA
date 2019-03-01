
-------无BOM自制件数量按日统计---------------
CREATE VIEW ZDY_V_NOBOMZZJ
as
SELECT  sum(case when SAPABAP1.MARC.matnr not like '00000000__000_____' then 1 else 0 end) as SXH
,sum(case when SAPABAP1.MARC.matnr like '00000000__000_____' then 1 else 0 end) as QC,sapabap1.mara.ersda
--SAPABAP1.MARC.matnr,SAPABAP1.MARC.WERKS,sapabap1.mara.ersda
FROM SAPABAP1.MARC 
LEFT join sapabap1.mara
on SAPABAP1.MARC.matnr=sapabap1.mara.matnr and sapabap1.mara.MANDT=800
where SAPABAP1.MARC.MANDT=800               
and (SAPABAP1.MARC.BESKZ='E' or SAPABAP1.MARC.BESKZ='X') 
and not exists(
select STLNR FROM SAPABAP1.MAST 
where SAPABAP1.MAST.WERKS=SAPABAP1.MARC.WERKS AND SAPABAP1.MAST.MATNR=SAPABAP1.MARC.MATNR and SAPABAP1.MAST.MANDT=800
)
group by sapabap1.mara.ersda

select * from ZDY_V_NOBOMZZJ


--------------------维护BOM的平均时间---------------------------------------------
create view ZDY_V_WHBOMAVRTIME
as
select a.matnr,a.werks,a.andat,b.ersda,days_between(b.ersda,a.andat) as da
from sapabap1.mast a
left join sapabap1.mara b
on a.matnr=b.matnr and b.mandt=800
where a.MANDT=800
