
drop table ZDY_T_MATRINFO_GZJL_1800

create table ZDY_T_MATRINFO_GZJL_1800 as (select *,ROW_NUMBER() over(order by gzrq) as id from "SANGREAD"."V_MATRINFO_GZJL_T" where gsdm='1800')

--select *,ROW_NUMBER() over(partition by gsdm,kcwl,gzrq order by kcsl) as id 
--from V_MATRINFO_GZJL_T

drop table ZDY_R_MATRINFO_GZJL_1800

create table ZDY_R_MATRINFO_GZJL_1800 as (
select id,keyinfo,gsdm,kcwl,kcsl,gzrq
,(select sum(case when kcsl>=0 then kcsl else 0 end) from ZDY_T_MATRINFO_GZJL_1800 B where A.gsdm=B.gsdm and A.kcwl=B.kcwl and B.gzrq<=A.gzrq and B.id<=A.id) as jz
,(select sum(case when kcsl<0 then kcsl else 0 end) from ZDY_T_MATRINFO_GZJL_1800 B where A.gsdm=B.gsdm and A.kcwl=B.kcwl) as cz
from ZDY_T_MATRINFO_GZJL_1800 A
)

drop table ZDY_RR_MATRINFO_GZJL_1800

create table ZDY_RR_MATRINFO_GZJL_1800 as (
select id,keyinfo,gsdm,kcwl,kcsl,gzrq,jz,cz
,case when kcsl>=0 and jz+cz<=0 then 0 
when kcsl>=0 and jz+cz>0 and jz+cz<kcsl then jz+cz 
when kcsl>=0 and jz+cz>=kcsl then kcsl 
else 0 
end as jg, 
days_between(gzrq,current_date) as sc 
from  ZDY_R_MATRINFO_GZJL_1800
)


select * from ZDY_T_MATRINFO_GZJL_1800 where kcwl='000000001200007047' and gsdm='1800' order by gzrq

select * from ZDY_R_MATRINFO_GZJL_1800 where kcwl='000000001200007047' and gsdm='1800' order by gzrq

select * from ZDY_RR_MATRINFO_GZJL_1800 where kcwl='000000001200007047' and gsdm='1800' order by gzrq

select sum(kcsl) from ZDY_T_MATRINFO_GZJL_1800 where kcwl='000000001200007047' and gsdm='1800' 

select gsdm,kcwl 
,sum(case when sc<=30 then jg else 0 end) as a
,sum(case when sc>30 and sc<=60 then jg else 0 end) as b
,sum(case when sc>60  then jg else 0 end) as c
from  
ZDY_RR_MATRINFO_GZJL_1800
where kcwl='000000001200007047' and gsdm='1800'
group by gsdm,kcwl