CLASS lhc_zi_r_aro DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE aro.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE aro.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE aro.

    METHODS read FOR READ
      IMPORTING keys FOR READ aro RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK aro.

    METHODS rba_Aro_ap FOR READ
      IMPORTING keys_rba FOR READ aro\_Aro_ap FULL result_requested RESULT result LINK association_links.

    METHODS rba_Assignments FOR READ
      IMPORTING keys_rba FOR READ aro\_Assignments FULL result_requested RESULT result LINK association_links.

    METHODS cba_Aro_ap FOR MODIFY
      IMPORTING entities_cba FOR CREATE aro\_Aro_ap.

    METHODS cba_Assignments FOR MODIFY
      IMPORTING entities_cba FOR CREATE aro\_Assignments.

*data mv_ap_guid type

ENDCLASS.

CLASS lhc_zi_r_aro IMPLEMENTATION.

  METHOD create.



    DATA lt_messages TYPE bapiret2_t.
    DATA ls_aro_entity_in TYPE zgs_aro_main.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).

      ls_aro_entity_in = CORRESPONDING #( <entity> MAPPING FROM ENTITY ).

      zcl_aro_srv=>get_instance(
        IMPORTING
          eo_aro_srv = DATA(lo_aro_srv)
      ).

      DATA(lv_oblguid) = lo_aro_srv->create_aro( is_aro_main = ls_aro_entity_in ).

*      INSERT VALUE #( oblguid = ls_aro_entity_in-obl_guid "after getting the value
*                      %msg        = new_message(
*                      id          = 'ARO'
*                                                 number      = 1
**                                                 v1          = ls_message_api->message_v1
**                                                 v2          = ls_message_api->message_v2
**                                                 v3          = ls_message_api->message_v3
**                                                 v4          = ls_message_api->message_v4
*                                                 severity    = CONV #( 'S' )
*                                               )
*                    ) INTO TABLE reported-aro.


*        INSERT VALUE #( %cid        = entities[ 1 ]-%cid
*                        oblguid = ls_aro_entity_in-obl_guid
*                      ) INTO TABLE  failed-aro.

      APPEND VALUE #( %cid = <entity>-%cid oblguid = lv_oblguid  ) TO mapped-aro.

    ENDLOOP.

  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Aro_ap.

    LOOP AT keys_rba ASSIGNING FIELD-SYMBOL(<fs_aro_rba>) GROUP BY <fs_aro_rba>-oblguid.

      SELECT  ApGuid  FROM zi_aro_hdr_ap WHERE aroguid = @<fs_aro_rba>-oblguid INTO @DATA(lv_ap_guid).

        INSERT
          VALUE #(
            source-%key = <fs_aro_rba>-%key
            target-%key = lv_ap_guid
          )
          INTO TABLE association_links.
      ENDSELECT.
    ENDLOOP.

  ENDMETHOD.

  METHOD rba_Assignments.

    LOOP AT keys_rba ASSIGNING FIELD-SYMBOL(<fs_aro_rba>) GROUP BY <fs_aro_rba>-oblguid.

      SELECT  validto  FROM zi_aro_assignments WHERE objuuid = @<fs_aro_rba>-oblguid INTO @DATA(lv_validto).

        INSERT
          VALUE #(
            source-%key = <fs_aro_rba>-%key
            target-%key = value #(  objuuid = <fs_aro_rba>-%key
                                    validto =  lv_validto   )
          )
          INTO TABLE association_links.
      ENDSELECT.
    ENDLOOP.

  ENDMETHOD.

  METHOD cba_Aro_ap.

    DATA ls_aro_hdr_ap_in TYPE  aro_hdr_ap.

    LOOP AT entities_cba  ASSIGNING FIELD-SYMBOL(<entity_cba>).

      LOOP AT <entity_cba>-%target ASSIGNING FIELD-SYMBOL(<ls_aro_ap>).
        ls_aro_hdr_ap_in = CORRESPONDING #( <ls_aro_ap> MAPPING FROM ENTITY ).

        ls_aro_hdr_ap_in-aro_guid = <entity_cba>-oblguid.

        zcl_aro_srv=>get_instance(
          IMPORTING
            eo_aro_srv = DATA(lo_aro_srv)
        ).

        DATA(lv_ap_guid) = lo_aro_srv->create_aro_ap( is_aro_ap = ls_aro_hdr_ap_in ).
*
        APPEND VALUE #( %cid = <ls_aro_ap>-%cid
                        apguid = lv_ap_guid ) TO mapped-aro_ap.


      ENDLOOP.



    ENDLOOP.

  ENDMETHOD.

  METHOD cba_Assignments.

    DATA ls_assignments TYPE  aro_assignments.

    LOOP AT entities_cba  ASSIGNING FIELD-SYMBOL(<entity_cba>).

      LOOP AT <entity_cba>-%target ASSIGNING FIELD-SYMBOL(<ls_assignments>).
        ls_assignments = CORRESPONDING #( <ls_assignments> MAPPING FROM ENTITY ).

*        DATA(lv_ap_guid) = zcl_aro_srv=>get_instance( ).
        zcl_aro_srv=>get_instance(
          IMPORTING
            eo_aro_srv = DATA(lo_aro_srv)
        ).

        ls_assignments-obj_uuid = <entity_cba>-oblguid.

        lo_aro_srv->create_assignment( is_assignment = ls_assignments ).

        APPEND VALUE #( %cid = <ls_assignments>-%cid
                        objuuid =  <entity_cba>-oblguid
                         validto  = <ls_assignments>-validto ) TO mapped-assignment.


      ENDLOOP.



    ENDLOOP.

*    DATA(lt_assignments) = CORRESPONDING aro_tt_assignments( entities MAPPING FROM ENTITY ).
*
*    DATA(lv_oblguid) = zcl_aro_srv=>get_instance( )->create_assignment( it_assignment = lt_assignments ).
*
*    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
*
*      APPEND VALUE #( %cid = <entity>-%cid
*                      objuuid = lv_oblguid
*                      validto = <entity>-validto ) TO mapped-assignment.
*
*    ENDLOOP.


  ENDMETHOD.

ENDCLASS.

CLASS lhc_zi_aro_assignments DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE assignment.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE assignment.

    METHODS read FOR READ
      IMPORTING keys FOR READ assignment RESULT result.

ENDCLASS.

CLASS lhc_zi_aro_assignments IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.


ENDCLASS.

CLASS lhc_zi_aro_hdr_ap DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE aro_ap.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE aro_ap.

    METHODS read FOR READ
      IMPORTING keys FOR READ aro_ap RESULT result.

ENDCLASS.

CLASS lhc_zi_aro_hdr_ap IMPLEMENTATION.

  METHOD update.

*    DATA ls_aro_hdr_ap_in TYPE  aro_hdr_ap.
*
*    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
*
*      ls_aro_hdr_ap_in = CORRESPONDING #( <entity> MAPPING FROM ENTITY ).
*
*      DATA(lv_ap_guid) = zcl_aro_srv=>get_instance( )->create_aro_ap( is_aro_ap = ls_aro_hdr_ap_in ).
**
**      APPEND VALUE #( %cid = <entity>-%cid
**                      apguid = lv_ap_guid ) TO mapped-aro_ap.
*
*    ENDLOOP.

  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.



ENDCLASS.

CLASS lsc_ZI_R_ARO DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_R_ARO IMPLEMENTATION.

  METHOD finalize.


*    zcl_aro_srv=>get_instance( )->finalize( ).

  ENDMETHOD.

  METHOD check_before_save.

*    zcl_aro_srv=>get_instance( )->check_before_save( ).

  ENDMETHOD.

  METHOD save.

    zcl_aro_srv=>get_instance(
      IMPORTING
        eo_aro_srv = DATA(lo_aro_srv)
    ).

    lo_aro_srv->save( ).

  ENDMETHOD.

  METHOD cleanup.



  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
