
create view v_cgscsh
select * 
from (
select t.EBELN as cgdd,t.EBELP as hh,t.jhrq,a.BEDAT as CGDDRQ,b.PLIFZ as jhhhhs
,days_between(a.BEDAT,t.jhrq) as sjjhhs
,(b.PLIFZ-days_between(a.BEDAT,t.jhrq)) as dhsc
,c.bsart as cglx
,b.matnr as wlbm,b.matkl as wlz
,d.wgbez as wlzms
from
(
select EBELN,EBELP,max(BUDAT_MKPF) as jhrq from sapabap1.NSDM_V_MSEG 
where BWLVS='101' and mandt='800'
group by EBELN,EBELP
) t
left join sapabap1.EKET a
on t.ebeln=a.ebeln and t.ebelp=a.ebelp and a.mandt='800'
left join sapabap1.ekpo b
on t.ebeln=b.ebeln and t.ebelp=b.ebelp and b.mandt='800'
left join sapabap1.ekko c
on t.EBELN=c.ebeln and c.mandt='800' 
left join sapabap1.t023t d
on b.matkl=d.matkl and d.mandt='800'
) t
where t.cglx not in ('GS','ZGS')



select * 
from (
select t.EBELN as cgdd,t.EBELP as hh,t.jhrq,a.BEDAT as CGDDRQ,b.PLIFZ as jhhhhs
,days_between(a.BEDAT,t.jhrq) as sjjhhs
,(b.PLIFZ-days_between(a.BEDAT,t.jhrq)) as dhsc
,c.bsart as cglx
,b.matnr as wlbm,b.matkl as wlz
,d.wgbez as wlzms
from
(
select EBELN,EBELP,max(BUDAT_MKPF) as jhrq from sapabap1.NSDM_V_MSEG 
where BWLVS='101' and mandt='800'
group by EBELN,EBELP
) t
left join sapabap1.EKET a
on t.ebeln=a.ebeln and t.ebelp=a.ebelp and a.mandt='800'
left join sapabap1.ekpo b
on t.ebeln=b.ebeln and t.ebelp=b.ebelp and b.mandt='800'
left join sapabap1.ekko c
on t.EBELN=c.ebeln and c.mandt='800' 
left join sapabap1.t023t d
on b.matkl=d.matkl and d.mandt='800'
) t
where t.cglx not in ('GS','ZGS')