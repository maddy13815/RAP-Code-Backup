CLASS lhc_Carrier DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Carrier RESULT result.

ENDCLASS.

CLASS lhc_Carrier IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZRAP_I_CARRIER DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZRAP_I_CARRIER IMPLEMENTATION.

  METHOD save_modified.
    DATA: carriers    TYPE STANDARD TABLE OF zrap_carrier,
          carriers_u  TYPE STANDARD TABLE OF zrap_carrier,
          lr_carriers TYPE RANGE OF zrap_carrier-carrier_id.

    IF create IS NOT INITIAL.
      carriers = CORRESPONDING #( create-carrier MAPPING FROM ENTITY ).
      INSERT zrap_carrier FROM TABLE @carriers. " BAPI
    ENDIF.

    if delete is not INITIAL.
        lr_carriers = value #( for ls_carrier_id in delete-carrier
                               ( sign = 'I' option = 'EQ' low = ls_carrier_id-CarrierId  ) ).

        delete from zrap_carrier where carrier_id in @lr_carriers.
    endif.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
