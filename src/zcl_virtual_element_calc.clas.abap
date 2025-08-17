CLASS zcl_virtual_element_calc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_VIRTUAL_ELEMENT_CALC IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    CHECK NOT it_original_data IS INITIAL.

    DATA: lt_calculated_data TYPE STANDARD TABLE OF ZCDS_Virtual_element WITH DEFAULT KEY.

    MOVE-CORRESPONDING it_original_data TO lt_calculated_data.

    LOOP AT lt_calculated_data ASSIGNING FIELD-SYMBOL(<flight>).
        <flight>-SeatsAvailable = <flight>-SeatsMax - <flight>-SeatsOccupied.
    ENDLOOP.

    MOVE-CORRESPONDING lt_calculated_data to ct_calculated_data.


  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.
ENDCLASS.
