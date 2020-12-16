@EndUserText.label: 'aro ap data'
@AccessControl.authorizationCheck: #NOT_REQUIRED
////@Search.searchable: true
@Metadata.allowExtensions: true
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #C,
     sizeCategory:   #XL
   }
}
define view entity zc_r_aro_ap as projection on zi_aro_hdr_ap {
    key ApGuid,
    AroGuid,
//    @Search.defaultSearchElement: true
    AccPr,
//    @Consumption.defaultValue: 'INF'
    InfRateKey,
//    @Consumption.defaultValue: 'INT'
    IntRateKey,
    AroAssetYrs,
    AroAssetMon,
    AroAssetEnd,
//    @Consumption.defaultValue: '7'
    AroCalcMet,
    AroProvCarryf,
    @Consumption.valueHelpDefinition: [{ entity : { name : 'I_Currency', element : 'Currency' } } ]
    Currency,
    /* Associations */
    _ARO  : redirected to parent  zc_r_aro
}
