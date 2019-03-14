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
--select count(*) from "SANGREAD"."V_MATRINFO_GZJL_T"

create view V_MATRINFO_GZJL_T1
as
select  gsdm,kcwl,gzrq
,sum(case when kcsl>=0 then kcsl else 0 end) as drjz
,sum(case when kcsl<0 then kcsl else 0 end) as drcz 
from V_MATRINFO_GZJL_T
group by gsdm,kcwl,gzrq

--drop table ZDY_T_MATRINFO_GZJL_T1

create table ZDY_T_MATRINFO_GZJL_T1
(
   gsdm nvarchar(4),
   kcwl nvarchar(50),
   gzrq varchar(5000),
   drjz bigint,
   drcz bigint
)

insert into ZDY_T_MATRINFO_GZJL_T1 (select * from V_MATRINFO_GZJL_T1)

create table ZDY_RES_MATINFO_01
as
(
select gsdm,kcwl,gzrq,drjz,drcz,jz as ljjz,cz as ljcz,
case when drjz>=0 and jz+cz<=0 then 0 
when drjz>=0 and jz+cz>0 and jz+cz<drjz then jz+cz 
when drjz>=0 and jz+cz>=drjz then drjz 
else 0 
end as jg, 
days_between(gzrq,current_date) as sc 
 from (
select gsdm,kcwl,gzrq,drjz,drcz
,(select sum(case when drjz>=0 then drjz else 0 end) from ZDY_T_MATRINFO_GZJL_T1 B where A.gsdm=B.gsdm and A.kcwl=B.kcwl and B.gzrq<=A.gzrq) as jz
,(select sum(case when drcz<0 then drcz else 0 end) from ZDY_T_MATRINFO_GZJL_T1 B where A.gsdm=B.gsdm and A.kcwl=B.kcwl) as cz
from ZDY_T_MATRINFO_GZJL_T1 A
) T
)

--select count(*) from ZDY_RES_MATINFO_01 where gsdm='1000' and kcwl='000000001300009198' order by gzrq

select gsdm,kcwl 
,sum(case when sc<=30 then jg else 0 end) as a
,sum(case when sc>30 and sc<=60 then jg else 0 end) as b
,sum(case when sc>60 and sc<=90 then jg else 0 end) as b
,sum(case when sc>90 and sc<=180 then jg else 0 end) as b
,sum(case when sc>180 then jg else 0 end) as c
from  
ZDY_RES_MATINFO_01
--where kcwl='000000001200007047' and gsdm='1800'
group by gsdm,kcwl


