@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Asset Retirement Obligation data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zi_rap_aro
  as select from zi_aro_obligation

  composition [0..*] of zi_rap_transaction as _Transaction

  association [1..1] to zi_aro_obl_index   as _aro_index   on $projection.OblGuid = _aro_index.OblGuid

  association [1..1] to zi_aro_hdr         as _aro_hdr     on $projection.OblGuid = _aro_hdr.AroGuid

  association [1..*] to zi_aro_assignments as _assignments on $projection.OblGuid = _assignments.ObjUuid

  association [0..*] to zi_aro_hdr_ap_ias  as _ap_hdr_ias  on $projection.OblGuid = _ap_hdr_ias.AroGuid

  association [0..*] to zi_aro_hdr_ap_usg  as _ap_hdr_usg  on $projection.OblGuid = _ap_hdr_usg.AroGuid

  //  association [1..*] to zi_aro_hdr_ap      as _ap_hdr      on $projection.OblGuid = _ap_hdr.AroGuid

{

  key OblGuid,
      OblType,
      CompCode,
      OblNum,
      OblDesc,
      OblShortDesc,
      OblStatus,
      Langu,
      OblLock,
      OblMcoDesc,
      _aro_hdr.LastchangeDate,
      
      _Transaction,

      _aro_index,
      _aro_hdr,
      _assignments,
      //      _ap_hdr,
      _ap_hdr_ias,
      _ap_hdr_usg


}

where
  OblNum > '0000002000'
