CLASS zcl_r_aro DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.

    CLASS-METHODS get_instance IMPORTING iv_aro_guid TYPE aro_obl_guid
                               EXPORTING eo_aro      TYPE REF TO zcl_r_aro.
    CLASS-DATA : mo_aro TYPE REF TO zcl_r_aro,
                 mt_aro LIKE TABLE OF mo_aro.

    DATA mv_aro_guid TYPE aro_obl_guid.
    METHODS insert_aro_obligation
      IMPORTING
        it_obligation TYPE aro_tt_obligation.
    METHODS insert_aro_index
      IMPORTING
        it_aro_index TYPE aro_tt_obl_index.
    METHODS insert_aro_hdr
      IMPORTING
        it_aro_hdr TYPE aro_tt_aro_hdr.
    METHODS insert_assignments
      IMPORTING
        it_assignments TYPE aro_tt_assignments.
    METHODS insert_aro_ap
      IMPORTING
        it_aro_ap TYPE aro_tt_aro_hdr_ap.
    METHODS save.
    TYPES gty_tt_ap_guid TYPE STANDARD TABLE OF aro_ap_guid WITH DEFAULT KEY.
    METHODS get_ap_guid
      RETURNING
        VALUE(r_result) TYPE gty_tt_ap_guid.
    TYPES gty_tt_validto TYPE STANDARD TABLE OF datbi  WITH DEFAULT KEY.
    METHODS get_assignment_validto
      RETURNING
        VALUE(r_result) TYPE gty_tt_validto.
    METHODS get_assignments
      RETURNING
        VALUE(r_result) TYPE aro_tt_assignments.
    METHODS get_aro_ap  RETURNING
                          VALUE(r_result) TYPE aro_tt_aro_hdr_ap.


  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA : mt_obligation  TYPE aro_tt_obligation,
           mt_aro_index   TYPE aro_tt_obl_index,
           mt_aro_hdr     TYPE aro_tt_aro_hdr,
           mt_assignments TYPE aro_tt_assignments,
           mt_aro_ap      TYPE aro_tt_aro_hdr_ap.

ENDCLASS.



CLASS zcl_r_aro IMPLEMENTATION.

  METHOD get_instance.

    READ TABLE zcl_r_aro=>mt_aro INTO mo_aro
                                 WITH KEY table_line->mv_aro_guid = iv_aro_guid.
    IF sy-subrc = 0.
      eo_aro  = mo_aro.
    ELSE.
      mo_aro = NEW zcl_r_aro( ).
      mo_aro->mv_aro_guid = iv_aro_guid.
      APPEND mo_aro TO mt_aro.
      eo_aro = mo_aro.
    ENDIF.

  ENDMETHOD.


  METHOD insert_aro_obligation.

    mt_obligation = it_obligation.

  ENDMETHOD.


  METHOD insert_aro_index.

    mt_aro_index = it_aro_index.

  ENDMETHOD.


  METHOD insert_aro_hdr.

    mt_aro_hdr = it_aro_hdr.

  ENDMETHOD.


  METHOD insert_assignments.

    mt_assignments = it_assignments.

  ENDMETHOD.


  METHOD insert_aro_ap.

    mt_aro_ap = it_aro_ap.

  ENDMETHOD.


  METHOD save.

*    IF mt_obligation IS NOT INITIAL AND mt_aro_index IS NOT INITIAL AND mt_aro_hdr IS NOT INITIAL AND mt_assignments IS NOT INITIAL AND mt_aro_ap IS NOT INITIAL.

     if mt_obligation is not INITIAL.
      INSERT aro_obligation FROM TABLE mt_obligation.
      INSERT aro_obl_index FROM TABLE mt_aro_index.
      INSERT aro_hdr FROM TABLE mt_aro_hdr.
      clear mt_obligation.
      ENDIF.
      if mt_assignments is not INITIAL.
      INSERT  aro_assignments FROM TABLE mt_assignments.
      clear mt_assignments.
      ENDIF.
      if mt_aro_ap is not INITIAL.
      INSERT aro_hdr_ap FROM TABLE mt_aro_ap.
     clear  mt_aro_ap.
    ENDIF.
  ENDMETHOD.


  METHOD get_ap_guid.

    LOOP AT me->mt_aro_ap INTO DATA(ls_aro_ap) WHERE aro_guid =  me->mt_obligation[ 1 ]-obl_guid.

      APPEND ls_aro_ap-ap_guid TO r_result.

    ENDLOOP.

*    READ TABLE me->mt_aro_ap INTO table r_result WITH KEY aro_guid =  me->mt_obligation[ 1 ]-obl_guid.

*SELECT obl_guid from table me->mt_aro_ap into r_result.

*INSERT  OF me->mt_aro_ap into r_result.
*
*
*DELETE r_result where not aro_guid =  me->mt_obligation[ 1 ]-obl_guid.

*r_result =
*
*    r_result = me->mt_aro_ap[ aro_guid = me->mt_obligation[ 1 ]-obl_guid ]-ap_guid.

  ENDMETHOD.


  METHOD get_assignment_validto.

    LOOP AT me->mt_assignments INTO DATA(ls_assignments) WHERE obj_uuid =  me->mt_obligation[ 1 ]-obl_guid.

      APPEND ls_assignments-obj_uuid TO r_result.

    ENDLOOP.

  ENDMETHOD.


  METHOD get_assignments.

    r_result = mt_assignments.

  ENDMETHOD.

  METHOD get_aro_ap.

    r_result = mt_aro_ap.

  ENDMETHOD.

ENDCLASS.
