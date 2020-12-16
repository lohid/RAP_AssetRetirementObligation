@EndUserText.label: 'aro data'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity zc_rap_aro
  as projection on zi_rap_aro
{
      @Search.defaultSearchElement: true
  key OblGuid,
      OblType,
      CompCode,
      OblNum,
      OblDesc,
      OblShortDesc,
      OblStatus,
      Langu,
      OblLock,
      OblMcoDesc,
      LastchangeDate,
      /* Associations */
      _Transaction : redirected to composition child zc_rap_transaction,
      _ap_hdr_ias,
      _ap_hdr_usg,
      _aro_hdr,
      _aro_index,
      _assignments

}
