CONFIGURATION IoAddresses
    VAR_GLOBAL

        // Module device_drive_center_s200/drivespd
        device_drive_center_s200_drivespd_Input AT %IB288 : device_drive_center_s200_drivespd_Input_Layout;
        device_drive_center_s200_drivespd_Output AT %QB288 : device_drive_center_s200_drivespd_Output_Layout;

        // Module device_drive_left_s200/drivespd
        device_drive_left_s200_drivespd_Input AT %IB256 : device_drive_left_s200_drivespd_Input_Layout;
        device_drive_left_s200_drivespd_Output AT %QB256 : device_drive_left_s200_drivespd_Output_Layout;

        // Module device_drive_right_s200/drivespd
        device_drive_right_s200_drivespd_Input AT %IB320 : device_drive_right_s200_drivespd_Input_Layout;
        device_drive_right_s200_drivespd_Output AT %QB320 : device_drive_right_s200_drivespd_Output_Layout;

        // Module device_et200sp/ai4_1
        device_et200sp_ai4_1_Input AT %IB0 : device_et200sp_ai4_1_Input_Layout;

        // Module device_et200sp/di8_1
        io_switch_board_lc_s AT %IB9 : device_et200sp_di8_1_Input_Layout;

        // Module device_et200sp/di8_2
        io_switch_board_cr AT %IB8 : device_et200sp_di8_2_Input_Layout;

        // Module device_et200sp/dq8_1
        io_led_board_lc AT %QB1 : device_et200sp_dq8_1_Output_Layout;

        // Module device_et200sp/dq8_2
        io_led_board_cr AT %QB0 : device_et200sp_dq8_2_Output_Layout;
    END_VAR
END_CONFIGURATION

TYPE
    device_drive_center_s200_drivespd_Input_Layout : STRUCT
        Signals_0 AT %B0 : WORD;
        Signals_1 AT %B2 : WORD;
    END_STRUCT;
END_TYPE

TYPE
    device_drive_center_s200_drivespd_Output_Layout : STRUCT
        Signals_2 AT %B0 : WORD;
        Signals_3 AT %B2 : WORD;
    END_STRUCT;
END_TYPE

TYPE
    device_drive_left_s200_drivespd_Input_Layout : STRUCT
        Signals_0 AT %B0 : WORD;
        Signals_1 AT %B2 : WORD;
    END_STRUCT;
END_TYPE

TYPE
    device_drive_left_s200_drivespd_Output_Layout : STRUCT
        Signals_2 AT %B0 : WORD;
        Signals_3 AT %B2 : WORD;
    END_STRUCT;
END_TYPE

TYPE
    device_drive_right_s200_drivespd_Input_Layout : STRUCT
        Signals_0 AT %B0 : WORD;
        Signals_1 AT %B2 : WORD;
    END_STRUCT;
END_TYPE

TYPE
    device_drive_right_s200_drivespd_Output_Layout : STRUCT
        Signals_2 AT %B0 : WORD;
        Signals_3 AT %B2 : WORD;
    END_STRUCT;
END_TYPE

TYPE
    device_et200sp_ai4_1_Input_Layout : STRUCT
        Signals_0 AT %B0 : INT;
        Signals_1 AT %B2 : INT;
        Signals_2 AT %B4 : INT;
        Signals_3 AT %B6 : INT;
    END_STRUCT;
END_TYPE

TYPE
    device_et200sp_di8_1_Input_Layout : STRUCT
        switchleft0 AT %X0.0 : BOOL;
        switchleft1 AT %X0.1 : BOOL;
        switchleft2 AT %X0.2 : BOOL;
        switchleft3 AT %X0.3 : BOOL;
        switchcenter0 AT %X0.4 : BOOL;
        switchcenter1 AT %X0.5 : BOOL;
        estop AT %X0.6 : BOOL;
        Signals_7 AT %X0.7 : BOOL;
    END_STRUCT;
END_TYPE

TYPE
    device_et200sp_di8_2_Input_Layout : STRUCT
        switchcenter2 AT %X0.0 : BOOL;
        switchcenter3 AT %X0.1 : BOOL;
        switchright0 AT %X0.2 : BOOL;
        switchright1 AT %X0.3 : BOOL;
        switchright2 AT %X0.4 : BOOL;
        switchright3 AT %X0.5 : BOOL;
        Signals_6 AT %X0.6 : BOOL;
        Signals_7 AT %X0.7 : BOOL;
    END_STRUCT;
END_TYPE

TYPE
    device_et200sp_dq8_1_Output_Layout : STRUCT
        ledleft0 AT %X0.0 : BOOL;
        ledleft1 AT %X0.1 : BOOL;
        ledleft2 AT %X0.2 : BOOL;
        ledleft3 AT %X0.3 : BOOL;
        ledcenter0 AT %X0.4 : BOOL;
        ledcenter1 AT %X0.5 : BOOL;
        Signals_6 AT %X0.6 : BOOL;
        Signals_7 AT %X0.7 : BOOL;
    END_STRUCT;
END_TYPE

TYPE
    device_et200sp_dq8_2_Output_Layout : STRUCT
        ledcenter2 AT %X0.0 : BOOL;
        ledcenter3 AT %X0.1 : BOOL;
        ledright0 AT %X0.2 : BOOL;
        ledright1 AT %X0.3 : BOOL;
        ledright2 AT %X0.4 : BOOL;
        ledright3 AT %X0.5 : BOOL;
        Signals_6 AT %X0.6 : BOOL;
        Signals_7 AT %X0.7 : BOOL;
    END_STRUCT;
END_TYPE
