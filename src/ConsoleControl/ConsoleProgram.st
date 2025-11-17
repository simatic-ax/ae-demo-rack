USING System.EdgeDetection;

PROGRAM ConsoleProgram
    VAR_EXTERNAL

        // IO-Tag Structs
        io_switch_board_lc_s : device_et200sp_di8_1_Input_Layout;
        io_switch_board_cr : device_et200sp_di8_2_Input_Layout;
        io_led_board_lc : device_et200sp_dq8_1_Output_Layout;
        io_led_board_cr : device_et200sp_dq8_2_Output_Layout;

        // other global tags (HMI related)
        estopActive : BOOL;
        driveLeftActive : BOOL;
        driveLeftTargetSpeed : LREAL;
        driveLeftSpeedIncrease : INT;
        driveCenterActive : BOOL;
        driveCenterTargetSpeed : LREAL;
        driveCenterSpeedIncrease : INT;
        driveRightActive : BOOL;
        driveRightTargetSpeed : LREAL;
        driveRightSpeedIncrease : INT;
    END_VAR

    VAR_EXTERNAL CONSTANT
    {::ifdef MACHINE_SPEEDDRV_CONFIG}
        // HWC SystemConstant SPD-DRV
        device_drive_left_s200_telegram1_HwID, device_drive_center_s200_telegram1_HwID, device_drive_right_s200_telegram1_HwID : UINT;
    {::elseif MACHINE_SPEEDPOS_CONFIG}
        // HWC SystemConstant POS-DRV
        device_drive_left_s200_telegram111_HwID, device_drive_center_s200_telegram111_HwID, device_drive_right_s200_telegram111_HwID : UINT;
    {::endif}
    END_VAR

    VAR
        // block-instances
        instDriveCtrlLeft : DriveCtrl;
        instDriveCtrlCenter : DriveCtrl;
        instDriveCtrlRight : DriveCtrl;
        // others
        driveTelHwIdLeft, driveTelHwIdCenter, driveTelHwIdRight : UINT;
        driveAck : BOOL;
        detectActivationLeft, detectActivationCenter, detectActivationRight : RisingEdge;
        detectDeactivationLeft, detectDeactivationCenter, detectDeactivationRight : FallingEdge;
        detectChangeDirectionLeft, detectChangeDirectionCenter, detectChangeDirectionRight : RisingEdge;
        detectSpeedIncreaseLeft, detectSpeedIncreaseCenter, detectSpeedIncreaseRight : RisingEdge;
        directionLeft, directionCenter, directionRight : INT := 1;
        changeDirectionLeft, changeDirectionCenter, changeDirectionRight : BOOL := FALSE;
        changeSpeedLeft, changeSpeedCenter, changeSpeedRight : BOOL := FALSE;
    END_VAR
    VAR_TEMP
        detection_rising : BOOL;
        detection_falling : BOOL;
    END_VAR
    VAR CONSTANT
        SPEED_MAX : INT := 250;
        SPEED_INITIAL : LREAL := LREAL#1.0;
    END_VAR

    // light LED lights
    io_led_board_lc.ledleft0 := io_switch_board_lc_s.switchleft0;
    io_led_board_lc.ledleft1 := io_switch_board_lc_s.switchleft1;
    io_led_board_lc.ledleft2 := io_switch_board_lc_s.switchleft2;
    io_led_board_lc.ledleft3 := io_switch_board_lc_s.switchleft3;
    io_led_board_lc.ledcenter0 := io_switch_board_lc_s.switchcenter0;
    io_led_board_lc.ledcenter1 := io_switch_board_lc_s.switchcenter1;
    io_led_board_cr.ledcenter2 := io_switch_board_cr.switchcenter2;
    io_led_board_cr.ledcenter3 := io_switch_board_cr.switchcenter3;
    io_led_board_cr.ledright0 := io_switch_board_cr.switchright0;
    io_led_board_cr.ledright1 := io_switch_board_cr.switchright1;
    io_led_board_cr.ledright2 := io_switch_board_cr.switchright2;
    io_led_board_cr.ledright3 := io_switch_board_cr.switchright3;

    // estop active ?
    estopActive := NOT io_switch_board_lc_s.estop;

    // control logic
    IF estopActive THEN
        driveLeftActive := FALSE;
        driveLeftTargetSpeed := 0.0;
        driveCenterActive := FALSE;
        driveCenterTargetSpeed := 0.0;
        driveRightActive := FALSE;
        driveRightTargetSpeed := 0.0;
    ELSE
        // detect drives user-switch activation
        detectActivationLeft(signal := io_switch_board_lc_s.switchleft0, detected => detection_rising);
        detectDeactivationLeft(signal := io_switch_board_lc_s.switchleft0, detected => detection_falling);
        IF detection_rising THEN
            driveLeftActive := TRUE;
            driveLeftTargetSpeed := SPEED_INITIAL;
            detection_rising := FALSE;
        ELSIF detection_falling THEN
            driveLeftActive := FALSE;
            driveLeftTargetSpeed := 0.0;
            detection_falling := FALSE;
        END_IF;

        detectActivationCenter(signal := io_switch_board_lc_s.switchcenter0, detected => detection_rising);
        detectDeactivationCenter(signal := io_switch_board_lc_s.switchcenter0, detected => detection_falling);
        IF detection_rising THEN
            driveCenterActive := TRUE;
            driveCenterTargetSpeed := SPEED_INITIAL;
            detection_rising := FALSE;
        ELSIF detection_falling THEN
            driveCenterActive := FALSE;
            driveCenterTargetSpeed := 0.0;
            detection_falling := FALSE;
        END_IF;

        detectActivationRight(signal := io_switch_board_cr.switchright0, detected => detection_rising);
        detectDeactivationRight(signal := io_switch_board_cr.switchright0, detected => detection_falling);
        IF detection_rising THEN
            driveRightActive := TRUE;
            driveRightTargetSpeed := SPEED_INITIAL;
            detection_rising := FALSE;
        ELSIF detection_falling THEN
            driveRightActive := FALSE;
            driveRightTargetSpeed := 0.0;
            detection_falling := FALSE;
        END_IF;

        // detect change in direction
        detectChangeDirectionLeft(signal := io_switch_board_lc_s.switchleft1, detected => changeDirectionLeft);
        detectChangeDirectionCenter(signal := io_switch_board_lc_s.switchCenter1, detected => changeDirectionCenter);
        detectChangeDirectionRight(signal := io_switch_board_cr.switchRight1, detected => changeDirectionRight);
        
        // detect change in speed
        detectSpeedIncreaseLeft(signal := io_switch_board_lc_s.switchleft2, detected => changeSpeedLeft);
        detectSpeedIncreaseCenter(signal := io_switch_board_cr.switchcenter2, detected => changeSpeedCenter);
        detectSpeedIncreaseRight(signal := io_switch_board_cr.switchright2, detected => changeSpeedRight);
        IF driveLeftActive THEN
            driveLeftTargetSpeed := SPEED_INITIAL;
            directionLeft := 1;
        END_IF;
        IF driveCenterActive THEN
            driveCenterTargetSpeed := SPEED_INITIAL;
            directionCenter := 1;
        END_IF;
        IF driveRightActive  THEN
            driveRightTargetSpeed := SPEED_INITIAL;
            directionRight := 1;
        END_IF;
        IF changeDirectionLeft THEN
            directionLeft := directionLeft * -1;
        END_IF;
        IF changeDirectionCenter THEN
            directionCenter := directionCenter * -1;
        END_IF;
        IF changeDirectionRight THEN
            directionRight := directionRight * -1;
        END_IF;
        IF changeSpeedLeft AND ((driveLeftTargetSpeed + driveLeftSpeedIncrease) < SPEED_MAX) THEN
            driveLeftTargetSpeed := driveLeftTargetSpeed + driveLeftSpeedIncrease;
        END_IF;
        IF changeSpeedCenter AND ((driveCenterTargetSpeed + driveCenterSpeedIncrease) < SPEED_MAX) THEN
            driveCenterTargetSpeed := driveCenterTargetSpeed + driveCenterSpeedIncrease;
        END_IF;
        IF changeSpeedRight AND ((driveRightTargetSpeed + driveRightSpeedIncrease) < SPEED_MAX) THEN
            driveRightTargetSpeed := driveRightTargetSpeed + driveRightSpeedIncrease;
        END_IF;
    END_IF;

    {::ifdef MACHINE_SPEEDDRV_CONFIG}
        driveTelHwIdLeft := device_drive_left_s200_telegram1_HwID;
        driveTelHwIdCenter := device_drive_center_s200_telegram1_HwID;
        driveTelHwIdRight := device_drive_right_s200_telegram1_HwID;
    {::elseif MACHINE_POSDRV_CONFIG}
        driveTelHwIdLeft := device_drive_left_s200_telegram111_HwID;
        driveTelHwIdCenter := device_drive_center_s200_telegram111_HwID;
        driveTelHwIdRight := device_drive_right_s200_telegram111_HwID;
    {::endif}

    // cyclic call of control modules
    instDriveCtrlLeft   (   enableAxis := driveLeftActive, 
                            acknowledgeError := (io_switch_board_lc_s.switchleft3 OR driveack), 
                            speed_moveForward := (directionLeft = INT#1),
                            speed_moveBackward := (directionLeft = INT#-1),
                            speed_speedSetpoint := TO_REAL(driveLeftTargetSpeed),
                            pos_velocity := 500,
                            pos_position := 10000,
                            hwidSTW := driveTelHwIdLeft, 
                            hwidZSW := driveTelHwIdLeft);
    instDriveCtrlCenter (   enableAxis := driveCenterActive, 
                            acknowledgeError := (io_switch_board_cr.switchCenter3 OR driveack), 
                            speed_moveForward := (directionCenter = INT#1),
                            speed_moveBackward := (directionCenter = INT#-1),
                            speed_speedSetpoint := TO_REAL(driveCenterTargetSpeed),
                            pos_velocity := 500,
                            pos_position := 10000,
                            hwidSTW := driveTelHwIdCenter, 
                            hwidZSW := driveTelHwIdCenter);
    instDriveCtrlRight  (   enableAxis := driveRightActive, 
                            acknowledgeError := (io_switch_board_cr.switchRight3 OR driveack), 
                            speed_moveForward := (directionRight = INT#1),
                            speed_moveBackward := (directionRight = INT#-1),
                            speed_speedSetpoint := TO_REAL(driveRightTargetSpeed),
                            pos_velocity := 500,
                            pos_position := 10000,
                            hwidSTW := driveTelHwIdRight, 
                            hwidZSW := driveTelHwIdRight);

END_PROGRAM