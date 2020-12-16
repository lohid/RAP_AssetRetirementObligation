@AbapCatalog.sqlViewName: 'ZIRAPTA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #PRIVILEGED_ONLY
@EndUserText.label: 'Asset retirement obligation transactions'
define view zi_rap_transaction
  as select from zi_aro_ta

  association to parent zi_rap_aro as _ARO on $projection.AroGuid = _ARO.OblGuid
  //association [0..*] to zi_aro_ta_plan as _ta_plan on $projection.AroTaNum = _ta_plan.AroTaNum

{

  key AroGuid,
  key AroTaNum,
      TaType,
      TaStatus,
      TaDate,
      TaProcKeydate,
      TaDesc,
      TaRetroCalc,
      TaOrigin,
      AroAssetRetpct,
      CepGuid,
      CepGuidAro,
      Status,
      ReleasedBy,
      ReleaseDate,
      ReleaseTime,
      ReversedBy,
      ReverseDate,
      ReverseTime,
      EnteredBy,
      EntryDate,
      EntryTime,

      _ARO
      //_ta_plan



}
