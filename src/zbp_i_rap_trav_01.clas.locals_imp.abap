CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Travel RESULT result.

*    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
*      IMPORTING REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE Travel.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Travel.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Travel.

    METHODS read FOR READ
      IMPORTING keys FOR READ Travel RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Travel.

    METHODS rba_Booking FOR READ
      IMPORTING keys_rba FOR READ Travel\_Booking FULL result_requested RESULT result LINK association_links.

    METHODS cba_Booking FOR MODIFY
      IMPORTING entities_cba FOR CREATE Travel\_Booking.

    METHODS set_status_booked FOR MODIFY
      IMPORTING keys FOR ACTION Travel~set_status_booked RESULT result.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF zi_rap_trav_01 IN LOCAL MODE
        ENTITY Travel
        FIELDS ( TravelId Status )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_travel_result)
        FAILED failed.

    result = VALUE #( FOR ls_travel IN lt_travel_result (
        %key = ls_travel-%key
        %features-%action-set_status_booked = COND #( WHEN ls_travel-Status = 'B'
                                                        THEN if_abap_behv=>fc-o-disabled
                                                        ELSE if_abap_behv=>fc-o-enabled )
     ) ).
  ENDMETHOD.

*  METHOD get_global_authorizations.
*  ENDMETHOD.

  METHOD create.
    DATA: ls_travel TYPE /dmo/travel,
          lt_msg    TYPE /dmo/t_message.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<lfs_travel_entity>).
      ls_travel = CORRESPONDING #( <lfs_travel_entity> MAPPING FROM ENTITY USING CONTROL ).


      CALL FUNCTION '/DMO/FLIGHT_TRAVEL_CREATE'
        EXPORTING
          is_travel   = CORRESPONDING /dmo/s_travel_in( ls_travel )
        IMPORTING
          es_travel   = ls_travel
          et_messages = lt_msg.


      IF lt_msg IS INITIAL.
        mapped-travel = VALUE #( BASE mapped-travel
                                ( %cid = <lfs_travel_entity>-%cid
                                  TravelId = <lfs_travel_entity>-TravelId )
         ).

      ELSE.
        LOOP AT lt_msg INTO DATA(ls_msg).
          APPEND VALUE #( %cid = <lfs_travel_entity>-%cid
                          TravelId = <lfs_travel_entity>-TravelId ) TO failed-travel.

          APPEND VALUE #( %msg = new_message( id = ls_msg-msgid
                                              number = ls_msg-msgno
                                              v1 = ls_msg-msgv1
                                              v2 = ls_msg-msgv2
                                              v3 = ls_msg-msgv3
                                              v4 = ls_msg-msgv4
                                              severity = if_abap_behv_message=>severity-error )

                          %key-TravelID = <lfs_travel_entity>-TravelId
                          %cid = <lfs_travel_entity>-%cid
                          %create = 'X'
                          TravelId = <lfs_travel_entity>-TravelId
                                               ) TO reported-travel.
        ENDLOOP.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
    SELECT * FROM zi_rap_trav_01
     FOR ALL ENTRIES IN @keys
     WHERE TravelId = @keys-TravelId
     INTO   CORRESPONDING FIELDS OF TABLE @result.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Booking.
  ENDMETHOD.

  METHOD cba_Booking.
    DATA: lt_booking TYPE /dmo/t_booking,
          lt_msg     TYPE /dmo/t_message,
          lt_msg_b   TYPE /dmo/t_message.

    LOOP AT entities_cba ASSIGNING FIELD-SYMBOL(<lfs_travel_booking>).
      DATA(lv_travel_id) = <lfs_travel_booking>-TravelId.

*Get Travel and booking data
      CALL FUNCTION '/DMO/FLIGHT_TRAVEL_READ'
        EXPORTING
          iv_travel_id = lv_travel_id
        IMPORTING
          et_booking   = lt_booking
          et_messages  = lt_msg.

      IF lt_msg IS INITIAL.
        IF lt_booking IS NOT INITIAL.
          DATA(lv_last_booking_id) = lt_booking[ lines( lt_booking ) ]-booking_id.
        ELSE.
          CLEAR lv_last_booking_id.
        ENDIF.

        LOOP AT <lfs_travel_booking>-%target ASSIGNING FIELD-SYMBOL(<lfs_booking>).
          DATA(ls_booking) = CORRESPONDING /dmo/booking( <lfs_booking> MAPPING FROM ENTITY USING CONTROL ).
          lv_last_booking_id += 1.
          ls_booking-booking_id = lv_last_booking_id.

          CALL FUNCTION '/DMO/FLIGHT_TRAVEL_UPDATE'
            EXPORTING
              is_travel   = VALUE /dmo/s_travel_in( travel_id = lv_travel_id )
              is_travelx  = VALUE /dmo/s_travel_inx( travel_id = lv_travel_id )
              it_booking  = VALUE /dmo/t_booking_in( ( CORRESPONDING #( ls_booking ) ) )
              it_bookingx = VALUE /dmo/t_booking_inx( ( booking_id = ls_booking-booking_id
                                                   action_code = /dmo/if_flight_legacy=>action_code-create
                                                                            ) )
            IMPORTING
              et_messages = lt_msg_b.

          "pass the data back to UI
          INSERT VALUE #( %cid = <lfs_booking>-%cid
                          travelid = lv_travel_id
                          bookingid = ls_booking-booking_id ) INTO TABLE mapped-booking.

          LOOP AT lt_msg_b INTO DATA(ls_msg) WHERE msgty CA 'EA'.
            APPEND VALUE #( %cid = <lfs_booking>-%cid
                            travelid = lv_travel_id
                          bookingid = ls_booking-booking_id ) TO failed-booking.

            APPEND VALUE #( %msg = new_message( id = ls_msg-msgid
                                                number = ls_msg-msgno
                                                v1 = ls_msg-msgv1
                                                v2 = ls_msg-msgv2
                                                v3 = ls_msg-msgv3
                                                v4 = ls_msg-msgv4
                                                severity = if_abap_behv_message=>severity-error
                                                 )

                                %key-TravelID = lv_travel_id
                                %key-bookingid = ls_booking-booking_id
                                %cid = <lfs_booking>-%cid
                                travelid = lv_travel_id
                          bookingid = ls_booking-booking_id ) TO reported-booking.
          ENDLOOP.
        ENDLOOP.
      ELSE.
        LOOP AT lt_msg INTO ls_msg WHERE msgty CA 'EA'.
          APPEND VALUE #( %cid = <lfs_travel_booking>-%cid_ref
                              travelid = lv_travel_id ) TO failed-travel.

          APPEND VALUE #( %msg = new_message( id = ls_msg-msgid
                                              number = ls_msg-msgno
                                              v1 = ls_msg-msgv1
                                              v2 = ls_msg-msgv2
                                              v3 = ls_msg-msgv3
                                              v4 = ls_msg-msgv4
                                              severity = if_abap_behv_message=>severity-error
                                               )

                              %key-TravelID = lv_travel_id
                              %cid = <lfs_travel_booking>-%cid_ref
                              travelid = lv_travel_id ) TO reported-travel.
        ENDLOOP.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD set_status_booked.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_RAP_TRAV_01 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_RAP_TRAV_01 IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    CALL FUNCTION '/DMO/FLIGHT_TRAVEL_SAVE'.
    CALL FUNCTION '/DMO/FLIGHT_TRAVEL_INITIALIZE'.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
