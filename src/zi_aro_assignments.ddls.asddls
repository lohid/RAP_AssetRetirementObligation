@AbapCatalog.sqlViewName: 'ZIAROASGN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ddl source aro_assignments'
define view zi_aro_assignments as select from aro_assignments 

 association to parent zi_r_aro as _ARO on $projection.ObjUuid = _ARO.OblGuid
 
{

key obj_uuid as ObjUuid,
key validto as Validto,
validfrom as Validfrom,
source_object as SourceObject,
obj_type as ObjType,
comp_code as CompCode,
bus_area as BusArea,
costcenter as Costcenter,
resp_costcenter as RespCostcenter,
orderid as Orderid,
cast( wbs_elem as abap.numc( 8 ) ) as WbsElem,
acttype as Acttype,
plant as Plant,
location as Location,
room as Room,
func_area as FuncArea,
segment as Segment,
profit_ctr as ProfitCtr,
prof_segm as ProfSegm,
cast(rl_est_key as abap.char( 8 ) ) as RlEstKey,
taxjurcode as Taxjurcode,
external_id as ExternalId,
@Semantics.systemDate.createdAt: true
createdtmps as Createdtmps,
@Semantics.user.createdBy: true
createdby as Createdby,
@Semantics.systemDateTime.lastChangedAt: true
lastchgdtmps as Lastchgdtmps,
@Semantics.user.lastChangedBy: true
lastchgdby as Lastchgdby,
_ARO
    
}
