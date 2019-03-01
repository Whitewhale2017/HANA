create view v_mtrinfo
as
select *,ROW_NUMBER() over(partition by gsdm,kcwl,gzrq order by kcsl) as id 
from [dbo].[mtrinfo]

--where kcwl like '%100105178'

select * from v_mtrinfo where kcwl like '%100105178'

update [mtrinfo] set gzrq=left(guozrq,10)

---------------------------------------------------
create function f_gzqhz(@gsdm varchar(20),@kcwl varchar(50),@gzrq date,@id int) 
returns int 
as 
begin 
declare @res int 
set @res=(select sum(case when kcsl>=0 then kcsl else 0 end) from mtrinfo where gsdm=@gsdm and kcwl=@kcwl and gzrq<=@gzrq and id<=@id) 
return @res 
end 

---------------------------------------
create function f_gzqhz1(@gsdm varchar(20),@kcwl varchar(50),@gzrq date,@id int) 
returns int 
as 
begin 
declare @res int 
set @res=(select sum(case when kcsl>=0 then kcsl else 0 end) from v_mtrinfo where gsdm=@gsdm and kcwl=@kcwl and gzrq<=@gzrq and id<=@id) 
return @res 
end 

------------------------
create function f_gzqhf(@gsdm varchar(20),@kcwl varchar(50)) 
returns int 
as 
begin 
declare @res int 
set @res=(select sum(case when kcsl<0 then kcsl else 0 end) from mtrinfo where gsdm=@gsdm and kcwl=@kcwl) 
return @res 
end 
-----------------------------------------------------------------------------------------------
select gsdm,kcwl 
,sum(case when sc<=30 then jg else 0 end) as '30Ìì' 
,sum(case when sc>30 and sc<=60 then jg else 0 end) as '60Ìì' 
,sum(case when sc>60  then jg else 0 end) as '³¬60Ìì' 
from 
( 
select * 
,case when kcsl>=0 and jz+cz<=0 then 0 
when kcsl>=0 and jz+cz>0 and jz+cz<kcsl then jz+cz 
when kcsl>=0 and jz+cz>=kcsl then kcsl 
else 0 
end as jg, 
DATEDIFF(day,guozrq,CONVERT(varchar(100), GETDATE(), 23)) as sc 
from 
( 
select *,dbo.f_gzqhz1(gsdm,kcwl,gzrq,id) as jz,dbo.f_gzqhf(gsdm,kcwl) as cz 
from [dbo].[v_mtrinfo] 
) t 
--where kcwl='1100105178' 
) t 
--where kcwl='1100105178' 
group by gsdm,kcwl