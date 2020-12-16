@AbapCatalog.sqlViewName: 'ZIAROHDRAP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ddl source aro_hdr_ap'
define view zi_aro_hdr_ap
  as select from aro_hdr_ap

  association to parent zi_r_aro as _ARO on $projection.AroGuid = _ARO.OblGuid

{

  key ap_guid         as ApGuid,
      aro_guid        as AroGuid,
      acc_pr          as AccPr,
      inf_rate_key    as InfRateKey,
      int_rate_key    as IntRateKey,
      @Semantics.calendar.year: true
      aro_asset_yrs   as AroAssetYrs,
      @Semantics.calendar.month: true
      aro_asset_mon   as AroAssetMon,
      aro_asset_end   as AroAssetEnd,
      aro_calc_met    as AroCalcMet,
      aro_prov_carryf as AroProvCarryf,
      currency        as Currency,
      _ARO

}
