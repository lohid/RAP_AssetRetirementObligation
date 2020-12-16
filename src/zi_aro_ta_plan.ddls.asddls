@AbapCatalog.sqlViewName: 'ZIAROTAPLAN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ddl source aro_ta_plan'
define view zi_aro_ta_plan as select from aro_ta_plan  
{

key ap_guid as ApGuid,
key aro_ta_num as AroTaNum,
key settlement_item as SettlementItem,
settlement_date as SettlementDate,
ce_current as CeCurrent,
ce_current_date as CeCurrentDate,
removal_percent as RemovalPercent,
removal_amount as RemovalAmount,
prov_cons_eom as ProvConsEom,
prov_cons_eopfy as ProvConsEopfy,
prov_disol_eom as ProvDisolEom,
prov_disol_eopfy as ProvDisolEopfy,
currency as Currency
    
}
