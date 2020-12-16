@EndUserText.label: 'transaction data'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity zc_rap_transaction as projection on zi_rap_transaction {
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
    /* Associations */
    _ARO : redirected to parent zc_rap_aro
}
