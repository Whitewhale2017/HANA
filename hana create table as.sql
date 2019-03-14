create table ZDY_T_MATRINFO_GZJL_T as (select * from "SANGREAD"."V_MATRINFO_GZJL_T")

create table ZDY_T_MATRINFO_GZJL_1100 as (select * from "SANGREAD"."V_MATRINFO_GZJL_T" where gsdm='1100')
create table ZDY_T_MATRINFO_GZJL_1000 as (select * from "SANGREAD"."V_MATRINFO_GZJL_T" where gsdm='1000')
create table ZDY_T_MATRINFO_GZJL_1800 as (select * from "SANGREAD"."V_MATRINFO_GZJL_T" where gsdm='1800')
create table ZDY_T_MATRINFO_GZJL_1900 as (select * from "SANGREAD"."V_MATRINFO_GZJL_T" where gsdm='1900')

select count(*) from ZDY_T_MATRINFO_GZJL_T

select count(*) from V_MATRINFO_GZJL_T

--truncate table "SANGREAD"."ZDY_T_MATRINFO_GZJL_1100"
--select * from ZDY_T_MATRINFO_GZJL_1100
--insert into ZDY_T_MATRINFO_GZJL_1100 (select * from "SANGREAD"."V_MATRINFO_GZJL_T" where gsdm='1100')
create table ZDY_T_MATRINFO_GZJL_T1
(
   gsdm nvarchar(4),
   kcwl nvarchar(50),
   gzrq varchar(5000),
   drjz bigint,
   drcz bigint
)

insert into ZDY_T_MATRINFO_GZJL_T1 (select * from V_MATRINFO_GZJL_T1)