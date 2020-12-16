CLASS lhc_Transaction DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Transaction.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Transaction.

    METHODS read FOR READ
      IMPORTING keys FOR READ Transaction RESULT result.

    METHODS rba_Aro FOR READ
      IMPORTING keys_rba FOR READ Transaction\_Aro FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_Transaction IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Aro.
  ENDMETHOD.

ENDCLASS.
