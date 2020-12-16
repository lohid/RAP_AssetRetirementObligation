@EndUserText.label: 'aro main data'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity zc_r_aro as projection on zi_r_aro {
    key OblGuid,
    OblType,
    CompCode,
    @Search.defaultSearchElement: true
    OblNum,
    OblDesc,
//    cast( OblNum as abap.char( 10 ) ) as OblNum,
//    cast(OblDesc as abap.char( 50) ) as OblDesc,
    OblShortDesc,
    OblStatus,
    Langu,
    OblLock,
    OblMcoDesc,
    AroDateBeg,
    AroDateEnd,
    InfRateKey as InfRate,
    IntRateKey as IntRate,
    @Consumption.valueHelpDefinition: [{ entity : { name : 'I_Currency', element : 'Currency' } } ]
    Currency,
    AroAssetclass,
    AroIntCalMeth as CalMeth,
    CreationUser,
    CreationDate,
    LastchangeUser,
    LastchangeDate,
    /* Associations */
    _aro_ap : redirected to composition child zc_r_aro_ap,
    _aro_hdr,
    _aro_index,
    _assignments :  redirected to composition child zc_r_assignments
}
