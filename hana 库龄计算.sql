-----------------------------------------------------------
CREATE VIEW "SANGREAD"."V_MATRINFO_GZJL" ( "KEYINFO",
	 "KCWL",
	 "GSDM",
	 "KCSL",
	 "GZRQ" ) AS select
	 concat(concat(concat(concat(concat(key1,
	key2),
	key3),
	key4),
	key5),
	key6) as keyinfo ,
	MATBF AS kcwl,
	BUKRS as gsdm,
	to_int(STOCK_QTY) as kcsl,
	to_char(BUDAT,
	'YYYY-MM-DD') as gzrq 
from SAPABAP1.MATDOC 
where mandt='800' 
and MATBF<>''
------------------------------------------------------------
CREATE VIEW "SANGREAD"."V_MATRINFO_GZJL_T" ( "KEYINFO",
	 "KCWL",
	 "GSDM",
	 "KCSL",
	 "GZRQ" ) AS SELECT
	 "A"."KEYINFO" ,
	 "A"."KCWL" ,
	 "A"."GSDM" ,
	 "A"."KCSL" ,
	 "A"."GZRQ" 
from v_matrinfo_gzjl A 
where exists ( select
	 1 
	from ( select
	 gsdm,
	kcwl,
	sum(kcsl) as js 
		from v_matrinfo_gzjl 
		group by gsdm,
	kcwl ) t 
	where t.js<>0 
	and A.gsdm=t.gsdm 
	and A.kcwl=t.kcwl)
--------------------------------------------------------------
--select * from "SANGREAD"."V_MATRINFO_GZJL"
select count(*) from "SANGREAD"."V_MATRINFO_GZJL_T"

select count(*) from (
select  gsdm,kcwl,gzrq,sum(case when kcsl>=0 then kcsl else 0 end) as drjz,sum(case when kcsl<0 then kcsl else 0 end) as drcz 
from V_MATRINFO_GZJL_T
group by gsdm,kcwl,gzrq
) t

create table ZDY_T_MATRINFO_GZJL_1100 as (select * from "SANGREAD"."V_MATRINFO_GZJL_T" where gsdm='1100')
create table ZDY_T_MATRINFO_GZJL_1000 as (select * from "SANGREAD"."V_MATRINFO_GZJL_T" where gsdm='1000')--1000表需增加bigint字段kcsll
create table ZDY_T_MATRINFO_GZJL_1800 as (select * from "SANGREAD"."V_MATRINFO_GZJL_T" where gsdm='1800')
create table ZDY_T_MATRINFO_GZJL_1900 as (select * from "SANGREAD"."V_MATRINFO_GZJL_T" where gsdm='1900')

select count(*) from "SANGREAD"."V_MATRINFO_GZJL" where gsdm='1100'


select count(*) from ZDY_T_MATRINFO_GZJL_1100
--truncate table "SANGREAD"."ZDY_T_MATRINFO_GZJL_1100"
--select * from ZDY_T_MATRINFO_GZJL_1100
--insert into ZDY_T_MATRINFO_GZJL_1100 (select * from "SANGREAD"."V_MATRINFO_GZJL_T" where gsdm='1100')

create table ZDY_R_MATRINFO_GZJL_1000 as (
select keyinfo,gsdm,kcwl,kcsl,gzrq
,(select sum(case when kcsll>=0 then kcsll else 0 end) from ZDY_T_MATRINFO_GZJL_1000 B where A.gsdm=B.gsdm and A.kcwl=B.kcwl and B.gzrq<=A.gzrq and B.keyinfo<A.keyinfo) as jz
,(select sum(case when kcsll<0 then kcsll else 0 end) from ZDY_T_MATRINFO_GZJL_1000 B where A.gsdm=B.gsdm and A.kcwl=B.kcwl) as cz
from ZDY_T_MATRINFO_GZJL_1000 A
)

create table ZDY_R_MATRINFO_GZJL_1100 as (
select keyinfo,gsdm,kcwl,kcsl,gzrq
,(select sum(case when kcsl>=0 then kcsl else 0 end) from ZDY_T_MATRINFO_GZJL_1100 B where A.gsdm=B.gsdm and A.kcwl=B.kcwl and B.gzrq<=A.gzrq and B.keyinfo<A.keyinfo) as jz
,(select sum(case when kcsl<0 then kcsl else 0 end) from ZDY_T_MATRINFO_GZJL_1100 B where A.gsdm=B.gsdm and A.kcwl=B.kcwl) as cz
from ZDY_T_MATRINFO_GZJL_1100 A
)

create table ZDY_R_MATRINFO_GZJL_1800 as (
select keyinfo,gsdm,kcwl,kcsl,gzrq
,(select sum(case when kcsl>=0 then kcsl else 0 end) from ZDY_T_MATRINFO_GZJL_1800 B where A.gsdm=B.gsdm and A.kcwl=B.kcwl and B.gzrq<=A.gzrq and B.keyinfo<A.keyinfo) as jz
,(select sum(case when kcsl<0 then kcsl else 0 end) from ZDY_T_MATRINFO_GZJL_1800 B where A.gsdm=B.gsdm and A.kcwl=B.kcwl) as cz
from ZDY_T_MATRINFO_GZJL_1800 A
)

create table ZDY_R_MATRINFO_GZJL_1900 as (
select keyinfo,gsdm,kcwl,kcsl,gzrq
,(select sum(case when kcsl>=0 then kcsl else 0 end) from ZDY_T_MATRINFO_GZJL_1900 B where A.gsdm=B.gsdm and A.kcwl=B.kcwl and B.gzrq<=A.gzrq and B.keyinfo<A.keyinfo) as jz
,(select sum(case when kcsl<0 then kcsl else 0 end) from ZDY_T_MATRINFO_GZJL_1900 B where A.gsdm=B.gsdm and A.kcwl=B.kcwl) as cz
from ZDY_T_MATRINFO_GZJL_1900 A
)
-------------------------------------------------------------------
create table ZDY_RR_MATRINFO_GZJL_1100 as (
select keyinfo,gsdm,kcwl,kcsl,gzrq,jz,cz
,case when kcsl>=0 and jz+cz<=0 then 0 
when kcsl>=0 and jz+cz>0 and jz+cz<kcsl then jz+cz 
when kcsl>=0 and jz+cz>=kcsl then kcsl 
else 0 
end as jg, 
days_between(gzrq,current_date) as sc 
from  ZDY_R_MATRINFO_GZJL_1100
)

create table ZDY_RR_MATRINFO_GZJL_1000 as (
select keyinfo,gsdm,kcwl,kcsl,gzrq,jz,cz
,case when kcsl>=0 and jz+cz<=0 then 0 
when kcsl>=0 and jz+cz>0 and jz+cz<kcsl then jz+cz 
when kcsl>=0 and jz+cz>=kcsl then kcsl 
else 0 
end as jg, 
days_between(gzrq,current_date) as sc 
from  ZDY_R_MATRINFO_GZJL_1000
)

create table ZDY_RR_MATRINFO_GZJL_1800 as (
select keyinfo,gsdm,kcwl,kcsl,gzrq,jz,cz
,case when kcsl>=0 and jz+cz<=0 then 0 
when kcsl>=0 and jz+cz>0 and jz+cz<kcsl then jz+cz 
when kcsl>=0 and jz+cz>=kcsl then kcsl 
else 0 
end as jg, 
days_between(gzrq,current_date) as sc 
from  ZDY_R_MATRINFO_GZJL_1800
)

create table ZDY_RR_MATRINFO_GZJL_1900 as (
select keyinfo,gsdm,kcwl,kcsl,gzrq,jz,cz
,case when kcsl>=0 and jz+cz<=0 then 0 
when kcsl>=0 and jz+cz>0 and jz+cz<kcsl then jz+cz 
when kcsl>=0 and jz+cz>=kcsl then kcsl 
else 0 
end as jg, 
days_between(gzrq,current_date) as sc 
from  ZDY_R_MATRINFO_GZJL_1900
)
----------------------------------------------------------------------


create table  ZDY_RES_MATRINFO
as
(
select *
from (
select gsdm,kcwl 
,sum(case when sc<=30 then jg else 0 end) as a
,sum(case when sc>30 and sc<=60 then jg else 0 end) as b
,sum(case when sc>60  then jg else 0 end) as c
from  
ZDY_RR_MATRINFO_GZJL_1900
group by gsdm,kcwl
union all
select gsdm,kcwl 
,sum(case when sc<=30 then jg else 0 end) as a
,sum(case when sc>30 and sc<=60 then jg else 0 end) as b
,sum(case when sc>60  then jg else 0 end) as c
from  
ZDY_RR_MATRINFO_GZJL_1000
group by gsdm,kcwl
union all
select gsdm,kcwl 
,sum(case when sc<=30 then jg else 0 end) as a
,sum(case when sc>30 and sc<=60 then jg else 0 end) as b
,sum(case when sc>60  then jg else 0 end) as c
from  
ZDY_RR_MATRINFO_GZJL_1100
group by gsdm,kcwl
union all
select gsdm,kcwl 
,sum(case when sc<=30 then jg else 0 end) as a
,sum(case when sc>30 and sc<=60 then jg else 0 end) as b
,sum(case when sc>60  then jg else 0 end) as c
from  
ZDY_RR_MATRINFO_GZJL_1800
group by gsdm,kcwl
) t
)


