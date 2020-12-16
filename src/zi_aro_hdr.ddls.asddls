@AbapCatalog.sqlViewName: 'ZIAROHDR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ddl source aro_hdr'
define view zi_aro_hdr as select from aro_hdr  {
    key aro_guid as AroGuid,
    aro_date_beg as AroDateBeg,
    aro_date_end as AroDateEnd,
    aro_date_end_1st as AroDateEnd1st,
    aro_date_removal as AroDateRemoval,
    inf_rate_key as InfRateKey,
    int_rate_key as IntRateKey,
    aro_term_years as AroTermYears,
    aro_term_months as AroTermMonths,
    currency as Currency,
    master_data_guid as MasterDataGuid,
    aro_assetclass as AroAssetclass,
    flag_use_subno as FlagUseSubno,
    aro_close_pdate as AroClosePdate,
    aro_int_cal_meth as AroIntCalMeth,
    last_ta_num_used as LastTaNumUsed,
    last_ta_num_rel as LastTaNumRel,
    creation_user as CreationUser,
    creation_date as CreationDate,
    creation_time as CreationTime,
    creation_orig as CreationOrig,
    lastchange_user as LastchangeUser,
    lastchange_date as LastchangeDate,
    lastchange_time as LastchangeTime,
    lastchange_orig as LastchangeOrig
}
