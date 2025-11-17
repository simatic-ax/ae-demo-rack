CONFIGURATION ConfigurationRack

    TASK Main(Priority := 1);
    PROGRAM P1 WITH Main : ConsoleProgram;

    // >>> Global Variables
    {S7.Extern = ReadWrite}
    {OpcUa.AccessLevel = ReadWrite}
    VAR_GLOBAL
        driveLeftSpeedIncrease : INT := SPEED_INCREASE_DEFAULT;
        driveCenterSpeedIncrease : INT  := SPEED_INCREASE_DEFAULT;
        driveRightSpeedIncrease : INT  := SPEED_INCREASE_DEFAULT;
    END_VAR
    
    {S7.Extern = ReadOnly}
    {OpcUa.AccessLevel = ReadOnly}
    VAR_GLOBAL
        estopActive : BOOL;
        driveLeftActive : BOOL;
        driveLeftTargetSpeed : LREAL; // := SPEED_INITIAL;
        driveCenterActive : BOOL;
        driveCenterTargetSpeed : LREAL; // := SPEED_INITIAL;
        driveRightActive : BOOL;
        driveRightTargetSpeed : LREAL; // := SPEED_INITIAL;
    END_VAR

    // >>> Global IO-Tags
    VAR_GLOBAL
        // see : vplc-427e_IoAddresses.st      
    END_VAR
    
    // >>> Global Constants  
    VAR_GLOBAL CONSTANT
        SPEED_INCREASE_DEFAULT : INT := 10;
        SPEED_INITIAL : LREAL := LREAL#100.0;
    END_VAR

END_CONFIGURATION