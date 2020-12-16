@AbapCatalog.sqlViewName: 'ZIAROHDRAPIAS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'aro_hdr_ap with ap ias'
define view zi_aro_hdr_ap_ias as select from aro_hdr_ap 
{
key ap_guid as ApGuid,
aro_guid as AroGuid,
acc_pr as AccPr,
inf_rate_key as InfRateKey,
int_rate_key as IntRateKey,
aro_asset_yrs as AroAssetYrs,
aro_asset_mon as AroAssetMon,
aro_asset_end as AroAssetEnd,
aro_calc_met as AroCalcMet,
aro_prov_carryf as AroProvCarryf,
currency as Currency    
}
where acc_pr = 'IFRS'
