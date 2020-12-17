CLASS zcl_aro_srv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS get_instance
      EXPORTING eo_aro_srv TYPE REF TO zcl_aro_srv.

    METHODS create_aro IMPORTING is_aro_main        TYPE zgs_aro_main
                       RETURNING VALUE(rv_aro_guid) TYPE aro_obl_guid .
    METHODS create_assignment IMPORTING is_assignment      TYPE aro_assignments
                              RETURNING VALUE(rv_aro_guid) TYPE aro_obl_guid .
    METHODS create_aro_ap IMPORTING is_aro_ap             TYPE aro_hdr_ap
                          RETURNING VALUE(rv_aro_ap_guid) TYPE aro_obl_guid.
    METHODS save.
    METHODS finalize.
    METHODS check_before_save.
  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-DATA go_aro_srv TYPE REF TO zcl_aro_srv.

    DATA : ms_aro_main   TYPE zgs_aro_main,
           mt_assignment TYPE aro_tt_assignments,
           mt_aro_ap     TYPE aro_tt_aro_hdr_ap.

    METHODS get_obligation_tables
      IMPORTING
        is_aro_main          TYPE zgs_aro_main
        it_aro_accounting    TYPE aro_tt_aro_hdr_ap
        it_aro_assignments   TYPE aro_tt_assignments
      EXPORTING
        et_obligation        TYPE aro_tt_obligation
        et_obl_index         TYPE aro_tt_obl_index
        et_aro_hdr           TYPE aro_tt_aro_hdr
        et_aro_hdr_ap        TYPE aro_tt_aro_hdr_ap
        et_assignments       TYPE aro_tt_assignments
        ev_obligation_number TYPE aro_obl_num
        ev_aro_guid          TYPE aro_obl_guid
        ev_ap_ifrs_guid      TYPE aro_ap_guid
        ev_ap_usg_guid       TYPE aro_ap_guid.

    METHODS database_save IMPORTING it_obligation  TYPE aro_tt_obligation OPTIONAL
                                    it_obl_index   TYPE aro_tt_obl_index OPTIONAL
                                    it_aro_hdr     TYPE aro_tt_aro_hdr OPTIONAL
                                    it_aro_hdr_ap  TYPE aro_tt_aro_hdr_ap OPTIONAL
                                    it_assignments TYPE aro_tt_assignments OPTIONAL.

ENDCLASS.



CLASS zcl_aro_srv IMPLEMENTATION.

  METHOD get_instance.

    eo_aro_srv = COND #( WHEN go_aro_srv IS BOUND
                       THEN  go_aro_srv
                       ELSE NEW #( ) ).

  ENDMETHOD.

  METHOD create_aro.

    "validate aro_main

    "get uuid
    TRY.
        rv_aro_guid = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.

**INSERT aro_obligation FROM  ms_aro_main .
***********************************************************************

*    TRY.
    DATA ev_obligation_number TYPE aro_obl_num.

    "get obligation number
    CALL FUNCTION 'ARO_OBJ_NUMBER_DETERMINE'
      EXPORTING
        iv_numkr  = '10'
        iv_bukrs  = is_aro_main-comp_code
      IMPORTING
        e_obj_num = ev_obligation_number.

    DATA(et_obligation)  = VALUE aro_tt_obligation( (  obl_guid = rv_aro_guid
                                                 obl_type = is_aro_main-obl_type
                                                 comp_code =  is_aro_main-comp_code
                                                 obl_num  = ev_obligation_number
                                                 obl_desc = is_aro_main-obl_desc
                                                 obl_short_desc = is_aro_main-obl_short_desc
                                                 obl_status = is_aro_main-obl_status
                                                 langu = is_aro_main-langu
                                                 obl_lock = is_aro_main-obl_lock
                                                 obl_mco_desc = is_aro_main-obl_mco_desc
                                                        ) ).

    DATA(et_obl_index)  = VALUE aro_tt_obl_index( (   obl_guid = rv_aro_guid
                                                 obl_type = is_aro_main-obl_type
                                                 comp_code = is_aro_main-comp_code
                                                 obl_num  = ev_obligation_number
                                                        ) ).

    DATA(et_aro_hdr)  = VALUE aro_tt_aro_hdr( (    aro_guid  =      rv_aro_guid
                                             aro_date_beg  = is_aro_main-aro_date_beg
                                             aro_date_end    = COND #( WHEN is_aro_main-aro_date_end IS NOT INITIAL
                                                                        AND is_aro_main-aro_date_end <> space
                                                                       THEN is_aro_main-aro_date_end
                                                                       ELSE '99991231' )
*                                             aro_date_end_1st  = is_aro_main-aro_date_end
*                                             aro_date_removal  = is_aro_main-aro_date_removal
                                             inf_rate_key   = is_aro_main-inf_rate_key
                                             int_rate_key    = is_aro_main-int_rate_key
*                                             aro_term_years   = is_aro_main-aro_term_years
*                                             aro_term_months   = is_aro_main-aro_term_months
                                             currency   = is_aro_main-currency
*                                                  master_data_guid  "empty in er9
                                             aro_assetclass    = is_aro_main-aro_assetclass
*                                             flag_use_subno    = is_aro_main-flag_use_subno
*                                             aro_close_pdate   = is_aro_main-aro_close_pdate
                                             aro_int_cal_meth  = is_aro_main-aro_int_cal_meth
*                                             last_ta_num_used   = is_aro_main-last_ta_num_used
*                                             last_ta_num_rel  = is_aro_main-last_ta_num_rel
                                             creation_user  = is_aro_main-creation_user
                                             creation_date  = is_aro_main-creation_date
*                                             creation_time   = is_aro_main-creation_time
*                                             creation_orig   = is_aro_main-creation_orig
                                                  lastchange_user = is_aro_main-lastchange_user
                                                  lastchange_date = is_aro_main-lastchange_date
*                                                  lastchange_time
*                                                  lastchange_orig
                                                    ) ).
*

    zcl_r_aro=>get_instance(
      EXPORTING
        iv_aro_guid = rv_aro_guid
      IMPORTING
        eo_aro      = DATA(lo_aro)
    ).

    lo_aro->insert_aro_obligation( it_obligation = et_obligation ).
    lo_aro->insert_aro_index( it_aro_index = et_obl_index ).
    lo_aro->insert_aro_hdr( it_aro_hdr = et_aro_hdr ).

*    INSERT aro_obligation FROM TABLE et_obligation.
*    INSERT aro_obl_index FROM TABLE et_obl_index.
*    INSERT aro_hdr FROM TABLE et_aro_hdr.

*    me->database_save( EXPORTING it_obligation  = et_obligation
*                                 it_obl_index   = et_obl_index
*                                 it_aro_hdr     = et_aro_hdr ).

****
*    rv_aro_guid =  ms_aro_main-obl_guid.


  ENDMETHOD.

  METHOD create_assignment.

    "validate assignments
    APPEND is_assignment TO mt_assignment.
*    mt_assignment = it_assignment.
    rv_aro_guid = ms_aro_main-obl_guid.

    DATA(et_assignments)  = VALUE aro_tt_assignments( (   obj_uuid =  is_assignment-obj_uuid
                                                validto = '99991229'
                                                validfrom = '19000101'
                                                source_object = 'ARO'
*                                                obj_type = is_aro_main-obl_type
                                                comp_code = is_assignment-comp_code
                                                bus_area  = is_assignment-bus_area
                                                costcenter   = is_assignment-costcenter
                                                resp_costcenter = is_assignment-resp_costcenter
                                                orderid    = is_assignment-orderid
                                                wbs_elem  = is_assignment-wbs_elem
                                                acttype   = is_assignment-acttype
                                                plant   = is_assignment-plant
                                                location  = is_assignment-location
                                                room    = is_assignment-room
                                                func_area    = is_assignment-func_area
                                                segment   = is_assignment-segment
                                                profit_ctr  = is_assignment-profit_ctr
                                                prof_segm     = is_assignment-prof_segm
                                                rl_est_key   = is_assignment-rl_est_key
                                                taxjurcode   = is_assignment-taxjurcode
                                                external_id    = is_assignment-external_id
                                                createdtmps = '20201204135901'
                                                createdby = 'C5270360'
                                                lastchgdtmps = '20201204135922'
                                                lastchgdby = 'C5270360' ) ).

    zcl_r_aro=>get_instance(
      EXPORTING
        iv_aro_guid = is_assignment-obj_uuid
      IMPORTING
        eo_aro      = DATA(lo_aro)
    ).

    lo_aro->insert_assignments( it_assignments = et_assignments ).

*    INSERT aro_assignments FROM  TABLE  et_assignments.
  ENDMETHOD.


  METHOD create_aro_ap.
    "validate accounting principle
*    DATA(ls_aro_ap) = is_aro_ap.
    TRY.
        rv_aro_ap_guid = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.

*    APPEND ls_aro_ap TO mt_aro_ap.

*    DATA(lv_ap_guid) = ls_aro_ap-ap_guid.

*    TRY.
*        ev_ap_ifrs_guid = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ).
*
*        ev_ap_usg_guid = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ).

*      CATCH cx_uuid_error.
*    "handle exception
*    ENDTRY.
    DATA(et_aro_hdr_ap)  = VALUE aro_tt_aro_hdr_ap( (  ap_guid = rv_aro_ap_guid
                                                 aro_guid  = is_aro_ap-aro_guid
                                                 acc_pr = is_aro_ap-acc_pr
                                                 inf_rate_key = 'INF'
                                                 int_rate_key = 'INT'
                                                 aro_asset_yrs = is_aro_ap-aro_asset_yrs
                                                 aro_asset_mon = is_aro_ap-aro_asset_mon
                                                 aro_asset_end = is_aro_ap-aro_asset_end
*                                                      aro_calc_met  = it_aro_accounting[ 1 ]-ifrs-aro_calc_met
*                                                      aro_prov_carryf = it_aro_accounting[ 1 ]-ifrs-
                                                 currency = 'EUR'
                                                 ) ).
*                                                 (  ap_guid =  ev_ap_usg_guid
*                                                 aro_guid  = ev_aro_guid "in er9
*                                                 acc_pr = it_aro_accounting[ 1 ]-acc_pr
*                                                 inf_rate_key = 'INF'
*                                                 int_rate_key = 'INT'
*                                                 aro_asset_yrs = it_aro_accounting[ 1 ]-aro_asset_yrs
*                                                 aro_asset_mon = it_aro_accounting[ 1 ]-aro_asset_mon
*                                                 aro_asset_end = it_aro_accounting[ 1 ]-aro_asset_end
*                                                 aro_calc_met  = it_aro_accounting[ 1 ]-aro_calc_met
**                                                      aro_prov_carryf = it_aro_accounting[ 1 ]-usg-
*                                                 currency = 'EUR'
*                                                 )  ).

*
**    me->database_save( EXPORTING it_aro_hdr_ap = et_aro_hdr_ap ).
    zcl_r_aro=>get_instance(
      EXPORTING
        iv_aro_guid = is_aro_ap-aro_guid
      IMPORTING
        eo_aro      = DATA(lo_aro)
    ).

lo_aro->insert_aro_ap( it_aro_ap = et_aro_hdr_ap ).
*
*    INSERT aro_hdr_ap FROM TABLE et_aro_hdr_ap.

*    rv_aro_ap_guid = ls_aro_ap-ap_guid.

  ENDMETHOD.

  METHOD save.

*    IF ms_aro_main IS NOT INITIAL AND mt_aro_ap IS NOT INITIAL AND mt_assignment IS NOT INITIAL.
*      me->get_obligation_tables(  EXPORTING is_aro_main          = ms_aro_main
*                                            it_aro_accounting    = mt_aro_ap
*                                            it_aro_assignments   = mt_assignment
*                                  IMPORTING et_obligation        = DATA(lt_obligation)
*                                            et_obl_index         = DATA(lt_obl_index)
*                                            et_aro_hdr           = DATA(lt_aro_hdr)
*                                            et_aro_hdr_ap        = DATA(lt_aro_hdr_ap)
*                                            et_assignments       = DATA(lt_assignments)
*                                            ev_obligation_number = DATA(lv_obligation_number)
*                                            ev_aro_guid          = DATA(lv_aro_guid)
*                                            ev_ap_ifrs_guid      = DATA(lv_ap_ifrs_guid)
*                                            ev_ap_usg_guid       = DATA(lv_ap_usg_guid)  ).
*
*      me->database_save( EXPORTING it_obligation  = lt_obligation
*                                   it_obl_index   = lt_obl_index
*                                   it_aro_hdr     = lt_aro_hdr
*                                   it_aro_hdr_ap  = lt_aro_hdr_ap
*                                   it_assignments = lt_assignments ).


loop at zcl_r_aro=>mt_aro into data(lo_aro).

lo_aro->save( ).

ENDLOOP.
*    zcl_r_aro=>get_instance(
*      EXPORTING
*        iv_aro_guid = is_aro_ap-aro_guid
*      IMPORTING
*        eo_aro      = DATA(lo_aro)
*    ).
*


*    ENDIF.
  ENDMETHOD.

  METHOD finalize.

  ENDMETHOD.

  METHOD check_before_save.

  ENDMETHOD.

  METHOD get_obligation_tables.

    "get uuid
*    TRY.
    ev_aro_guid =  is_aro_main-obl_guid.
*      CATCH cx_uuid_error.
*        "handle exception
*    ENDTRY.

    "get obligation number
    CALL FUNCTION 'ARO_OBJ_NUMBER_DETERMINE'
      EXPORTING
        iv_numkr  = '10'
        iv_bukrs  = is_aro_main-comp_code
      IMPORTING
        e_obj_num = ev_obligation_number.

    et_obligation  = VALUE aro_tt_obligation( (  obl_guid = ev_aro_guid
                                                 obl_type = is_aro_main-obl_type
                                                 comp_code =  is_aro_main-comp_code
                                                 obl_num  = ev_obligation_number
                                                 obl_desc = is_aro_main-obl_desc
                                                 obl_short_desc = is_aro_main-obl_short_desc
                                                 obl_status = is_aro_main-obl_status
                                                 langu = is_aro_main-langu
                                                 obl_lock = is_aro_main-obl_lock
                                                 obl_mco_desc = is_aro_main-obl_mco_desc
                                                        ) ).

    et_obl_index  = VALUE aro_tt_obl_index( (   obl_guid = ev_aro_guid
                                                 obl_type = is_aro_main-obl_type
                                                 comp_code = is_aro_main-comp_code
                                                 obl_num  = ev_obligation_number
                                                        ) ).

    et_aro_hdr  = VALUE aro_tt_aro_hdr( (    aro_guid  =      ev_aro_guid
                                             aro_date_beg  = is_aro_main-aro_date_beg
                                             aro_date_end    = COND #( WHEN is_aro_main-aro_date_end IS NOT INITIAL
                                                                        AND is_aro_main-aro_date_end <> space
                                                                       THEN is_aro_main-aro_date_end
                                                                       ELSE '99991231' )
*                                             aro_date_end_1st  = is_aro_main-aro_date_end
*                                             aro_date_removal  = is_aro_main-aro_date_removal
                                             inf_rate_key   = is_aro_main-inf_rate_key
                                             int_rate_key    = is_aro_main-int_rate_key
*                                             aro_term_years   = is_aro_main-aro_term_years
*                                             aro_term_months   = is_aro_main-aro_term_months
                                             currency   = is_aro_main-currency
*                                                  master_data_guid  "empty in er9
                                             aro_assetclass    = is_aro_main-aro_assetclass
*                                             flag_use_subno    = is_aro_main-flag_use_subno
*                                             aro_close_pdate   = is_aro_main-aro_close_pdate
                                             aro_int_cal_meth  = is_aro_main-aro_int_cal_meth
*                                             last_ta_num_used   = is_aro_main-last_ta_num_used
*                                             last_ta_num_rel  = is_aro_main-last_ta_num_rel
                                             creation_user  = is_aro_main-creation_user
                                             creation_date  = is_aro_main-creation_date
*                                             creation_time   = is_aro_main-creation_time
*                                             creation_orig   = is_aro_main-creation_orig
                                                  lastchange_user = is_aro_main-lastchange_user
                                                  lastchange_date = is_aro_main-lastchange_date
*                                                  lastchange_time
*                                                  lastchange_orig
                                                    ) ).
    TRY.
        ev_ap_ifrs_guid = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ).

        ev_ap_usg_guid = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ).

      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
    et_aro_hdr_ap  = VALUE aro_tt_aro_hdr_ap( (  ap_guid =  ev_ap_ifrs_guid
                                                 aro_guid  = ev_aro_guid "in er9
                                                 acc_pr = it_aro_accounting[ 1 ]-acc_pr
                                                 inf_rate_key = 'INF'
                                                 int_rate_key = 'INT'
                                                 aro_asset_yrs = it_aro_accounting[ 1 ]-aro_asset_yrs
                                                 aro_asset_mon = it_aro_accounting[ 1 ]-aro_asset_mon
                                                 aro_asset_end = it_aro_accounting[ 1 ]-aro_asset_end
*                                                      aro_calc_met  = it_aro_accounting[ 1 ]-ifrs-aro_calc_met
*                                                      aro_prov_carryf = it_aro_accounting[ 1 ]-ifrs-
                                                 currency = 'EUR'
                                                 )
                                                 (  ap_guid =  ev_ap_usg_guid
                                                 aro_guid  = ev_aro_guid "in er9
                                                 acc_pr = it_aro_accounting[ 1 ]-acc_pr
                                                 inf_rate_key = 'INF'
                                                 int_rate_key = 'INT'
                                                 aro_asset_yrs = it_aro_accounting[ 1 ]-aro_asset_yrs
                                                 aro_asset_mon = it_aro_accounting[ 1 ]-aro_asset_mon
                                                 aro_asset_end = it_aro_accounting[ 1 ]-aro_asset_end
                                                 aro_calc_met  = it_aro_accounting[ 1 ]-aro_calc_met
*                                                      aro_prov_carryf = it_aro_accounting[ 1 ]-usg-
                                                 currency = 'EUR'
                                                 )  ).

    et_assignments  = VALUE aro_tt_assignments( (   obj_uuid =  ev_aro_guid
                                                    validto = '99991231'
                                                    validfrom = '19000101'
                                                    source_object = 'ARO'
                                                    obj_type = is_aro_main-obl_type
                                                    comp_code = is_aro_main-comp_code
                                                    bus_area  = it_aro_assignments[ 1 ]-bus_area
                                                    costcenter   = it_aro_assignments[ 1 ]-costcenter
                                                    resp_costcenter = it_aro_assignments[ 1 ]-resp_costcenter
                                                    orderid    = it_aro_assignments[ 1 ]-orderid
                                                    wbs_elem  = it_aro_assignments[ 1 ]-wbs_elem
                                                    acttype   = it_aro_assignments[ 1 ]-acttype
                                                    plant   = it_aro_assignments[ 1 ]-plant
                                                    location  = it_aro_assignments[ 1 ]-location
                                                    room    = it_aro_assignments[ 1 ]-room
                                                    func_area    = it_aro_assignments[ 1 ]-func_area
                                                    segment   = it_aro_assignments[ 1 ]-segment
                                                    profit_ctr  = it_aro_assignments[ 1 ]-profit_ctr
                                                    prof_segm     = it_aro_assignments[ 1 ]-prof_segm
                                                    rl_est_key   = it_aro_assignments[ 1 ]-rl_est_key
                                                    taxjurcode   = it_aro_assignments[ 1 ]-taxjurcode
                                                    external_id    = it_aro_assignments[ 1 ]-external_id
                                                    createdtmps = '20201204135901'
                                                    createdby = 'C5270360'
                                                    lastchgdtmps = '20201204135922'
                                                    lastchgdby = 'C5270360' ) ).



  ENDMETHOD.

  METHOD database_save.

    TRY.
        cl_aro_data_layer=>write_aro_data(
      EXPORTING
        it_obligation      = it_obligation
*      it_obligation_db   =
        it_obl_index       = it_obl_index
*      it_obl_index_db    =
        it_aro_hdr         = it_aro_hdr
*      it_aro_hdr_db      =
        it_aro_hdr_ap      = it_aro_hdr_ap
*      it_aro_hdr_ap_db   =
        it_assignments     = it_assignments
*      it_assignments_db  =
*      it_aro_ta          = lt_aro_ta
*      it_aro_ta_db       =
*      it_aro_ta_ap       = lt_aro_ta_ap
*      it_aro_ta_ap_db    =
*      it_aro_ta_calc     = lt_aro_ta_calc
*      it_aro_ta_calc_db  =
*      it_aro_ta_plan     = lt_aro_ta_plan
*      it_aro_ta_plan_db  =
*      it_aro_ta_cf       = lt_aro_ta_cf
*      it_aro_ta_cf_db    =
*      it_aro_ta_lay      =
*      it_aro_ta_lay_db   =
*      it_aro_ta_scalc    =
*      it_aro_ta_scalc_db =
*      it_aro_ta_scf      =
*      it_aro_ta_scf_db   =
*      it_aro_ta_slay     =
*      it_aro_ta_slay_db  =
        iv_no_chng_doc_upd = abap_true
*    CHANGING
*      cs_obj_chng_data   =
        ).
      CATCH cx_aro_exception.
        "handle exception
    ENDTRY.
*  CATCH cx_aro_exception.

    CALL FUNCTION 'ARO_WRITE_ASSIGNMENT_TABLES' IN UPDATE TASK
      EXPORTING
        it_assignment_ins = it_assignments.

    COMMIT WORK.

  ENDMETHOD.

ENDCLASS.
