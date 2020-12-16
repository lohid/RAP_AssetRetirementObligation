*"* use this source file for your ABAP unit test classes
CLASS ltcl_integration_test DEFINITION FINAL FOR TESTING
     DURATION SHORT
     RISK LEVEL HARMLESS.

     PRIVATE SECTION.

        CLASS-DATA:
         cds_test_environment TYPE REF TO if_cds_test_environment.

        CLASS-METHODS:
         class_setup,
         class_teardown.
        METHODS:
         setup,
         teardown.
        METHODS:
         create_aro FOR TESTING RAISING cx_static_check.
    ENDCLASS.


    CLASS ltcl_integration_test IMPLEMENTATION.

     METHOD create_aro.

      DATA(today) = cl_abap_context_info=>get_system_date( ).
      DATA aro_in TYPE TABLE FOR CREATE zi_rap_aro\\aro.

aro_in = value #( (
* oblguid   =   cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
 obltype   = 100
 compcode  = 'JVU1'
 oblnum    = '3001'
 obldesc   = 'obl unit test'
 oblshortdesc = 'obltest'
 oblstatus   = '01'
 langu      = 'EN'
* obllock    =
* oblmcodesc

 ) ).

*      travels_in = VALUE #(     ( agencyid      = 070001   "Agency 070001 does exist, Agency 1 does not exist
*                                customerid    = 1
*                                begindate     = today
*                                enddate       = today + 30
*                                bookingfee    = 30
*                                totalprice    = 330
*                                currencycode  = 'EUR'
*                                description   = |Test travel XYZ|
*                               ) ).

      MODIFY ENTITIES OF zi_rap_aro
        ENTITY aro
              CREATE FIELDS ( obltype
                              compcode
                              oblnum
                              obldesc
                              oblshortdesc
                              oblstatus
                              langu )
             WITH aro_in
        MAPPED   DATA(mapped)
        FAILED   DATA(failed)
        REPORTED DATA(reported).

      cl_abap_unit_assert=>assert_initial( failed-aro ).
      cl_abap_unit_assert=>assert_initial( reported-aro ).
      COMMIT ENTITIES.

      DATA(new_aro_guid) = mapped-aro[ 1 ]-oblguid.

      SELECT * FROM zi_rap_aro WHERE  oblguid = @new_aro_guid INTO TABLE @DATA(lt_aro)  .

      cl_abap_unit_assert=>assert_not_initial( lt_aro ).

      cl_abap_unit_assert=>assert_not_initial(
           VALUE #( lt_aro[  oblguid = new_aro_guid ] OPTIONAL )
         ).
*      cl_abap_unit_assert=>assert_equals(
*          exp = 'N'
*          act = lt_travel[ TravelID = new_travel_id ]-Status
*        ).
    ENDMETHOD.

    METHOD class_setup.
*      cds_test_environment = cl_cds_test_environment=>create_for_multiple_cds(
*          i_for_entities = VALUE #( ( i_for_entity = 'zi_rap_aro' )
*                                  ( i_for_entity = 'zi_rap_transaction' ) )
*                                ).
    ENDMETHOD.

    METHOD class_teardown.
*      cds_test_environment->destroy( ).
    ENDMETHOD.

    METHOD setup.
    ENDMETHOD.

    METHOD teardown.
      ROLLBACK ENTITIES.
*      cds_test_environment->clear_doubles( ).
    ENDMETHOD.

ENDCLASS.
