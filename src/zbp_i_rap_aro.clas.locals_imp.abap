CLASS lhc_ARO DEFINITION INHERITING FROM cl_abap_behavior_handler.
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

    METHODS rba_Transaction FOR READ
      IMPORTING keys_rba FOR READ aro\_Transaction FULL result_requested RESULT result LINK association_links.

    METHODS cba_Transaction FOR MODIFY
      IMPORTING entities_cba FOR CREATE aro\_Transaction.

ENDCLASS.

CLASS lhc_ARO IMPLEMENTATION.

  METHOD create.

    DATA lt_messages TYPE bapiret2_t.
    DATA ls_aro_entity_in TYPE aro_obligation.
    DATA ls_aro_entity_out TYPE aro_obligation.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).

      ls_aro_entity_in = CORRESPONDING #( <entity> MAPPING FROM ENTITY ).

      DATA(lo_aro) = NEW zcl_aro_wrapper( ).

     data(lv_oblguid) =  lo_aro->create_aro( is_aro_obligation = ls_aro_entity_in ).

*      DATA lv_oblguid TYPE aro_obl_guid.

      APPEND VALUE #( %cid = <entity>-%cid oblguid = lv_oblguid ) TO mapped-aro.

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

  METHOD rba_Transaction.
  ENDMETHOD.

  METHOD cba_Transaction.
  ENDMETHOD.

ENDCLASS.

CLASS   lsc_ZI_RAP_ARO definition INHERITING FROM cl_abap_behavior_saver.
PROTECTED SECTION.

  METHODS finalize REDEFINITION.

  METHODS check_before_save REDEFINITION.

  METHODS save REDEFINITION.

  METHODS cleanup REDEFINITION.

  METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_RAP_ARO IMPLEMENTATION.

METHOD finalize.
ENDMETHOD.

METHOD check_before_save.
ENDMETHOD.

METHOD save.

"code to save the data saved in the buffer ...

ENDMETHOD.

METHOD cleanup.
ENDMETHOD.

METHOD cleanup_finalize.
ENDMETHOD.

ENDCLASS.
