create view "SANGREAD"."V_SAPWLSJCX"
as
 select a.matnr,b.maktx,c.zzbismt,a.werks,a.lgort,d.lgobe,e.charg,' ' as sobkz,'                          ' as tskcbm,
	 a.labst as labst,c.meins,a.insme,a.speme 
from sapabap1.nsdm_v_mard a 
left outer join sapabap1.makt b on a.matnr = b.matnr and b.mandt = '800' 
left outer join sapabap1.mara c on a.matnr = c.matnr and c.mandt = '800' 
left outer join sapabap1.t001l d on a.lgort = d.lgort and a.werks = d.werks and d.mandt = '800' 
left outer join sapabap1.NSDM_V_MCHB e on a.matnr = e.matnr and e.mandt = '800' and a.werks = e.werks and a.lgort = e.lgort 
where a.mandt = '800' and a.labst != 0 and not exists(select matnr from sapabap1.mchb t where t.matnr=a.matnr and t.mandt='800') 
union all
select a.matnr,b.maktx,c.zzbismt,a.werks,a.lgort,d.lgobe,a.charg,' ' as sobkz,'                          ' as tskcbm,
	 a.clabs as labst,c.meins,0.0 as insme,0.0 as speme 
from sapabap1.NSDM_V_MCHB a 
left outer join sapabap1.makt b on a.matnr = b.matnr and b.mandt = '800' 
left outer join sapabap1.mara c on a.matnr = c.matnr and c.mandt = '800' 
left outer join sapabap1.t001l d on a.lgort = d.lgort and a.werks = d.werks and d.mandt = '800' 
where a.mandt = '800' and a.clabs != 0
union all
select a.matnr,b.maktx,c.zzbismt,a.werks,a.lgort,d.lgobe,a.charg,a.sobkz,concat(concat(a.vbeln,'/'),a.posnr) as tskcbm,
    a.kalab,c.meins,0.0 as insme,0.0 as speme 
 from sapabap1.nsdm_v_mska a
left outer join sapabap1.makt b on a.matnr = b.matnr  and b.mandt = '800' 
left outer join sapabap1.mara c on a.matnr = c.matnr  and c.mandt = '800' 
left outer join sapabap1.t001l d on a.lgort = d.lgort and a.werks = d.werks and d.mandt = '800' 
where a.mandt = '800' and a.kalab !=0 and a.sobkz = 'E'
union all 
select  a.matnr,b.maktx,c.zzbismt,a.werks,a.lgort,d.lgobe,a.charg,a.sobkz,e.posid as tskcbm,
    a.prlab,c.meins,0.0 as insme,0.0 as speme 
from sapabap1.nsdm_v_mspr a 
left outer join sapabap1.makt b on a.matnr = b.matnr  and b.mandt = '800' 
left outer join sapabap1.mara c on a.matnr = c.matnr  and c.mandt = '800' 
left outer join sapabap1.t001l d on d.mandt = '800' and a.lgort = d.lgort and a.werks = d.werks
left outer join sapabap1.prps e on e.mandt = '800' and a.pspnr = e.pspnr 
where a.mandt = '800' and a.prlab != 0
union all
select   a.matnr,b. maktx,c.zzbismt,a.werks,'' as lgort,'' as lgobe,a.charg,a.sobkz,a.lifnr as tskcbm,
    a.lblab,c.meins,0.0 as insme,0.0 as speme 
from sapabap1.nsdm_v_mslb a
left outer join sapabap1.makt b on a.matnr = b.matnr  and b.mandt = '800' 
left outer join sapabap1.mara c on a.matnr = c.matnr  and c.mandt = '800' 
where a.mandt = '800' and a.lblab !=0 
