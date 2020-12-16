@AbapCatalog.sqlViewName: 'ZIAROOBL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ddl source aro_obligation'
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #C,
     sizeCategory:   #XL
   }
 }
define view zi_aro_obligation as select from aro_obligation 

{
 
 key obl_guid as OblGuid,
 obl_type as OblType,
 comp_code as CompCode,
 obl_num as OblNum,
 obl_desc as OblDesc,
 obl_short_desc as OblShortDesc,
 obl_status as OblStatus,
 langu as Langu,
 obl_lock as OblLock,
 obl_mco_desc as OblMcoDesc
    
}
