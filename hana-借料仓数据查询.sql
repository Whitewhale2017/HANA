  ------OPEN SQL---------------------------------------------------
  SELECT la~lgnum   "仓库号
       la~lgtyp   "仓储类型
       lq~lgpla   "仓位
       lq~matnr   "物料
  *    lq~maktx   "物料描述
       lq~verme   "可用库存
       lq~werks   "工厂
       lq~lgort   "库存地点
       lq~charg   "批次
       lq~bestq   "库存类别
       lq~sobkz   "特殊库存
       lq~sonum   "特殊库存编号
       lq~edatu   "借料时间
  INTO CORRESPONDING FIELDS OF TABLE o_tab
  FROM apabap1.lagp AS la
  INNER JOIN apabap1.lqua AS lq ON la~lgnum = lq~lgnum
  WHERE la~lgnum IN ('500','200','300')
    AND la~lgtyp IN ('501','201','301')
    AND lq~lgort IN ('8002','8004','2101','2102','5101','5102')
    AND lq~edatu IN s_edatu
    AND la~kzler EQ 'X'.
 ----------标准SQL--------------------------------------------------
    
    SELECT la.lgnum as "仓库号",la.lgtyp as "仓储类型",lq.lgpla as "仓位",lq.matnr as "物料",lq.verme as "可用库存",
           lq.verme as "可用库存",lq.werks as "工厂",lq.lgort as "库存地点",lq.charg as "批次", lq.bestq as "库存类别",
           lq.sobkz as "特殊库存",lq.sonum as "特殊库存编号",lq.edatu as "借料时间",ma.maktx as "物料描述"
    FROM sapabap1.lagp as la
    inner join sapabap1.lqua as lq
    on la.lgnum=lq.lgnum
    left join sapabap1.MAKT as ma
    on lq.matnr=ma.matnr
    where la.lgnum IN ('500','200','300') 
      and la.lgtyp IN ('501','201','301')
      and lq.lgort IN ('8002','8004','2101','2102','5101','5102')
      and lq.edatu>='20181001' and lq.edatu<='20181031'
      and la.kzler='X'
  ------------------------------------------------------------------
select current_date from dummy

select * from "SAPABAP1"."LQUA"

select * from sapabap1.ZERP360_HZB_1001

select * from sapabap1.ZFIN_200_1000_51_01

select  * from "SAPABAP1"."ACDOCA" 





