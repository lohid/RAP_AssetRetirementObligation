@EndUserText.label: 'aro assignment data'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity zc_r_assignments as projection on zi_aro_assignments {
    key ObjUuid,
    key Validto,
    Validfrom,
    SourceObject,
    ObjType,
    @Search.defaultSearchElement: true
    CompCode,
    BusArea,
    Costcenter,
    RespCostcenter,
    Orderid,
    WbsElem,
    Acttype,
    Plant,
    Location,
    Room,
    FuncArea,
    Segment,
    ProfitCtr,
    ProfSegm,
    RlEstKey,
    Taxjurcode,
    ExternalId,
    Createdtmps,
    Createdby,
    Lastchgdtmps,
    Lastchgdby,
    /* Associations */
    _ARO : redirected to parent  zc_r_aro
}
