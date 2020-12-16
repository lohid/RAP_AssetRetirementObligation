@AbapCatalog.sqlViewName: 'ZIAROINDX'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ddl source aro_obl_index'
define view zi_aro_obl_index as select from aro_obl_index {

key obl_guid as OblGuid,
obl_type as OblType,
comp_code as CompCode,
obl_num as OblNum
    
}
