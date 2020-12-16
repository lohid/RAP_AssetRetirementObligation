@AbapCatalog.sqlViewName: 'ZIARO_TA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ddl source aro_ta'
define view zi_aro_ta as select from aro_ta {

key aro_guid as AroGuid,
key aro_ta_num as AroTaNum,
ta_type as TaType,
ta_status as TaStatus,
ta_date as TaDate,
ta_proc_keydate as TaProcKeydate,
ta_desc as TaDesc,
ta_retro_calc as TaRetroCalc,
ta_origin as TaOrigin,
aro_asset_retpct as AroAssetRetpct,
cep_guid as CepGuid,
cep_guid_aro as CepGuidAro,
status as Status,
released_by as ReleasedBy,
release_date as ReleaseDate,
release_time as ReleaseTime,
reversed_by as ReversedBy,
reverse_date as ReverseDate,
reverse_time as ReverseTime,
entered_by as EnteredBy,
entry_date as EntryDate,
entry_time as EntryTime
    
}
