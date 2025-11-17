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
        device_et200sp_di8_1_Input AT %IB9 : device_et200sp_di8_1_Input_Layout;

        // Module device_et200sp/di8_2
        device_et200sp_di8_2_Input AT %IB8 : device_et200sp_di8_2_Input_Layout;

        // Module device_et200sp/dq8_1
        device_et200sp_dq8_1_Output AT %QB1 : device_et200sp_dq8_1_Output_Layout;

        // Module device_et200sp/dq8_2
        device_et200sp_dq8_2_Output AT %QB0 : device_et200sp_dq8_2_Output_Layout;
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
        Signals_0 AT %X0.0 : BOOL;
        Signals_1 AT %X0.1 : BOOL;
        Signals_2 AT %X0.2 : BOOL;
        Signals_3 AT %X0.3 : BOOL;
        Signals_4 AT %X0.4 : BOOL;
        Signals_5 AT %X0.5 : BOOL;
        Signals_6 AT %X0.6 : BOOL;
        Signals_7 AT %X0.7 : BOOL;
    END_STRUCT;
END_TYPE

TYPE
    device_et200sp_di8_2_Input_Layout : STRUCT
        Signals_0 AT %X0.0 : BOOL;
        Signals_1 AT %X0.1 : BOOL;
        Signals_2 AT %X0.2 : BOOL;
        Signals_3 AT %X0.3 : BOOL;
        Signals_4 AT %X0.4 : BOOL;
        Signals_5 AT %X0.5 : BOOL;
        Signals_6 AT %X0.6 : BOOL;
        Signals_7 AT %X0.7 : BOOL;
    END_STRUCT;
END_TYPE

TYPE
    device_et200sp_dq8_1_Output_Layout : STRUCT
        Signals_0 AT %X0.0 : BOOL;
        Signals_1 AT %X0.1 : BOOL;
        Signals_2 AT %X0.2 : BOOL;
        Signals_3 AT %X0.3 : BOOL;
        Signals_4 AT %X0.4 : BOOL;
        Signals_5 AT %X0.5 : BOOL;
        Signals_6 AT %X0.6 : BOOL;
        Signals_7 AT %X0.7 : BOOL;
    END_STRUCT;
END_TYPE

TYPE
    device_et200sp_dq8_2_Output_Layout : STRUCT
        Signals_0 AT %X0.0 : BOOL;
        Signals_1 AT %X0.1 : BOOL;
        Signals_2 AT %X0.2 : BOOL;
        Signals_3 AT %X0.3 : BOOL;
        Signals_4 AT %X0.4 : BOOL;
        Signals_5 AT %X0.5 : BOOL;
        Signals_6 AT %X0.6 : BOOL;
        Signals_7 AT %X0.7 : BOOL;
    END_STRUCT;
END_TYPE
