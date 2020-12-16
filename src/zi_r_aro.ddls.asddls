@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'aro root'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #C,
     sizeCategory:   #XL
   }
 }
define root view entity zi_r_aro
  as select from zi_aro_obligation

  composition [1..*] of zi_aro_assignments as _assignments

  composition [1..*] of zi_aro_hdr_ap      as _aro_ap

  association [1..1] to zi_aro_obl_index   as _aro_index on  $projection.OblGuid  = _aro_index.OblGuid
                                                         and $projection.OblType  = _aro_index.OblType
                                                         and $projection.OblNum   = _aro_index.OblNum
                                                         and $projection.CompCode = _aro_index.CompCode

  association [1..1] to zi_aro_hdr         as _aro_hdr   on  $projection.OblGuid = _aro_hdr.AroGuid


{

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
      _aro_hdr.AroDateBeg,
      _aro_hdr.AroDateEnd,
      //      _aro_hdr.AroDateEnd1st,
      //      _aro_hdr.AroDateRemoval,
      cast(_aro_hdr.InfRateKey as abap.char( 6 ) ) as InfRateKey,
      cast(_aro_hdr.IntRateKey as abap.char( 6 ) ) as IntRateKey,
      //      _aro_hdr.AroTermYears,
      //      _aro_hdr.AroTermMonths,
      _aro_hdr.Currency,
      //      _aro_hdr.MasterDataGuid,
      _aro_hdr.AroAssetclass,
      //      _aro_hdr.FlagUseSubno,
      //      _aro_hdr.AroClosePdate,
      cast(_aro_hdr.AroIntCalMeth as abap.char( 1 ) ) as AroIntCalMeth,
      //      _aro_hdr.LastTaNumUsed,
      //      _aro_hdr.LastTaNumRel,
      @Semantics.user.createdBy: true
      _aro_hdr.CreationUser,
      @Semantics.systemDateTime.createdAt: true
      _aro_hdr.CreationDate,
      //      _aro_hdr.CreationTime,
      //      _aro_hdr.CreationOrig,
      @Semantics.user.lastChangedBy: true
      _aro_hdr.LastchangeUser,
      @Semantics.systemDateTime.lastChangedAt: true
      _aro_hdr.LastchangeDate,
      //      _aro_hdr.LastchangeTime,
      //      _aro_hdr.LastchangeOrig,
      _aro_hdr,
      _aro_index,
      _assignments,
      _aro_ap

}
