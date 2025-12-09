"--------------------------------------------------------------
"  ABAP_Code_Sales_Order_Report.abap
"  Main Program + Include Content
"--------------------------------------------------------------


REPORT zprg_sales_report.


*&---------------------------------------------------------------------*
INCLUDE zdata_salesord.
*&---------------------------------------------------------------------*

DATA : lv_erdat TYPE erdat.
DATA : lv_ernam TYPE ernam.
DATA : lt_final TYPE  ztt_so_output.
DATA : lwa_final TYPE  zstr_so_output.
DATA : lo_object TYPE REF TO zcl_salesord.
DATA : lt_fieldcat TYPE slis_t_fieldcat_alv.
DATA : lwa_fieldcat TYPE slis_fieldcat_alv.

*&---------------------------------------------------------------------*
INCLUDE zsel_salesord.
*&---------------------------------------------------------------------*
SELECTION-SCREEN : BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.
  SELECT-OPTIONS : s_erdat FOR lv_erdat OBLIGATORY NO-EXTENSION.
  SELECT-OPTIONS : s_ernam FOR lv_ernam NO INTERVALS  .
SELECTION-SCREEN : END OF BLOCK b1 .

*&---------------------------------------------------------------------*
*& Report ZPRG_SALES_REPORT
*&---------------------------------------------------------------------*


CREATE OBJECT lo_object.

CALL METHOD lo_object->get_sales_orders
  EXPORTING
    serdat      = s_erdat[]
    sernam      = s_ernam[]
  IMPORTING
    lt_output   = lt_final
  EXCEPTIONS
    wrong_input = 1
    OTHERS      = 2.
IF sy-subrc <> 0.
  MESSAGE i000(zmsg_sales).
ELSE.

  PERFORM prepare_fieldcat USING '1' 'VBELN' TEXT-001 CHANGING lt_fieldcat.
  PERFORM prepare_fieldcat USING '2' 'POSNR' TEXT-002 CHANGING lt_fieldcat.
  PERFORM prepare_fieldcat USING '3' 'MATNR' TEXT-003 CHANGING lt_fieldcat.
  PERFORM prepare_fieldcat USING '4' 'MAKTX' TEXT-004 CHANGING lt_fieldcat.
  PERFORM prepare_fieldcat USING '5' 'KWMENG' TEXT-005 CHANGING lt_fieldcat.
  PERFORM prepare_fieldcat USING '6' 'VRKME' TEXT-006 CHANGING lt_fieldcat.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK        = ' '
*     I_BYPASSING_BUFFER       = ' '
*     I_BUFFER_ACTIVE          = ' '
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'PF_STATUS'
      i_callback_user_command  = 'USER_CMD'
      i_callback_top_of_page   = 'TOP_OF_PAGE'
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME         =
*     I_BACKGROUND_ID          = ' '
*     I_GRID_TITLE             =
*     I_GRID_SETTINGS          =
*     IS_LAYOUT                =
      it_fieldcat              = lt_fieldcat
*     IT_EXCLUDING             =
*     IT_SPECIAL_GROUPS        =
*     IT_SORT                  =
*     IT_FILTER                =
*     IS_SEL_HIDE              =
*     I_DEFAULT                = 'X'
*     I_SAVE                   = ' '
*     IS_VARIANT               =
*     IT_EVENTS                =
*     IT_EVENT_EXIT            =
*     IS_PRINT                 =
*     IS_REPREP_ID             =
*     I_SCREEN_START_COLUMN    = 0
*     I_SCREEN_START_LINE      = 0
*     I_SCREEN_END_COLUMN      = 0
*     I_SCREEN_END_LINE        = 0
*     I_HTML_HEIGHT_TOP        = 0
*     I_HTML_HEIGHT_END        = 0
*     IT_ALV_GRAPHICS          =
*     IT_HYPERLINK             =
*     IT_ADD_FIELDCAT          =
*     IT_EXCEPT_QINFO          =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*     O_PREVIOUS_SRAL_HANDLER  =
* IMPORTING
*     E_EXIT_CAUSED_BY_CALLER  =
*     ES_EXIT_CAUSED_BY_USER   =
    TABLES
      t_outtab                 = lt_final
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
ENDIF.


FORM pf_status USING rt_extab TYPE slis_t_extab.
  SET PF-STATUS 'SALES'.

ENDFORM.

FORM user_cmd  USING r_ucomm LIKE sy-ucomm
                                  rs_selfield TYPE slis_selfield.

  IF r_ucomm = 'SMARTFORMS'.
    DATA : lv_fname TYPE rs38l_fnam.
    DATA : lwa_control_parameters TYPE ssfctrlop.
    DATA : lwa_output_options TYPE ssfcompop.

    CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
      EXPORTING
        formname           = 'ZSF_SALESORD'
*       VARIANT            = ' '
*       DIRECT_CALL        = ' '
      IMPORTING
        fm_name            = lv_fname
      EXCEPTIONS
        no_form            = 1
        no_function_module = 2
        OTHERS             = 3.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    lwa_control_parameters-no_dialog = 'X'.
    lwa_control_parameters-preview = 'X'.
    lwa_output_options-tddest = 'LP01'.

    CALL FUNCTION lv_fname
      EXPORTING
*       ARCHIVE_INDEX      =
*       ARCHIVE_INDEX_TAB  =
*       ARCHIVE_PARAMETERS =
        control_parameters = lwa_control_parameters
*       MAIL_APPL_OBJ      =
*       MAIL_RECIPIENT     =
*       MAIL_SENDER        =
        output_options     = lwa_output_options
        user_settings      = ' '
        perdat_low         = s_erdat-low
        perdat_high        = s_erdat-high
        pernam             = s_ernam-low
        lt_output          = lt_final
*   IMPORTING
*       DOCUMENT_OUTPUT_INFO       =
*       JOB_OUTPUT_INFO    =
*       JOB_OUTPUT_OPTIONS =
      EXCEPTIONS
        formatting_error   = 1
        internal_error     = 2
        send_error         = 3
        user_canceled      = 4
        OTHERS             = 5.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.
  ENDIF.
ENDFORM.

FORM prepare_fieldcat USING pv_col_pos
                                           pv_fieldname
                                           pv_text
                                CHANGING pt_fieldcat TYPE slis_t_fieldcat_alv.
  lwa_fieldcat-col_pos = pv_col_pos.
  lwa_fieldcat-fieldname = pv_fieldname.
  lwa_fieldcat-seltext_l = pv_text.
  APPEND lwa_fieldcat TO pt_fieldcat.
  CLEAR : lwa_fieldcat.
ENDFORM.

FORM top_of_page.
  DATA : lt_list TYPE slis_t_listheader.
  DATA : lwa_list TYPE slis_listheader.
  DATA : lv_date(25) TYPE c.
  DATA : lv_low(12) TYPE c.
  DATA : lv_high(12) TYPE c.

  lwa_list-typ = 'H'.
  lwa_list-info = TEXT-007.
  APPEND lwa_list TO lt_list.
  CLEAR : lwa_list.

  IF s_erdat-low IS NOT INITIAL AND s_erdat-high IS INITIAL.
    CONCATENATE s_erdat-low+6(2) '.' s_erdat-low+4(2) '.' s_erdat-low+0(4) INTO lv_low.
    lwa_list-typ = 'S'.
    lwa_list-key = TEXT-008.
    lwa_list-info = lv_low.
    APPEND lwa_list TO lt_list.
    CLEAR : lwa_list.
  ENDIF.

  IF s_erdat-low IS NOT INITIAL AND s_erdat-high IS NOT INITIAL.
    CONCATENATE s_erdat-low+6(2) '.' s_erdat-low+4(2) '.' s_erdat-low+0(4) INTO lv_low.
    CONCATENATE s_erdat-high+6(2) '.' s_erdat-high+4(2) '.' s_erdat-high+0(4) INTO lv_high.
    CONCATENATE lv_low TEXT-009 lv_high INTO lv_date SEPARATED BY space.
    lwa_list-typ = 'S'.
    lwa_list-key = TEXT-008.
    lwa_list-info = lv_date.
    APPEND lwa_list TO lt_list.
    CLEAR : lwa_list.
  ENDIF.

  IF s_ernam-low IS NOT INITIAL.
    lwa_list-typ = 'S'.
    lwa_list-key = TEXT-010.
    lwa_list-info = s_ernam-low.
    APPEND lwa_list TO lt_list.
    CLEAR : lwa_list.
  ENDIF.


  lwa_list-typ = 'A'.
  lwa_list-info = TEXT-011.
  APPEND lwa_list TO lt_list.
  CLEAR : lwa_list.


  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_list.

ENDFORM.
