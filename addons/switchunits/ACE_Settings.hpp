class ACE_Settings {
    class GVAR(EnableSwitchUnits) {
        value = 0;
        typeName = "BOOL";
    };
    class GVAR(SwitchToWest) {
        displayName = CSTRING(SwitchToWest_DisplayName);
        description = CSTRING(SwitchToWest_Description);
        value = 0;
        typeName = "BOOL";
    };
    class GVAR(SwitchToEast) {
        displayName = CSTRING(SwitchToEast_DisplayName);
        description = CSTRING(SwitchToEast_Description);
        value = 0;
        typeName = "BOOL";
    };
    class GVAR(SwitchToIndependent) {
        displayName = CSTRING(SwitchToIndependent_DisplayName);
        description = CSTRING(SwitchToIndependent_Description);
        value = 0;
        typeName = "BOOL";
    };
    class GVAR(SwitchToCivilian) {
        displayName = CSTRING(SwitchToCivilian_DisplayName);
        description = CSTRING(SwitchToCivilian_Description);
        value = 0;
        typeName = "BOOL";
    };
    class GVAR(EnableSafeZone) {
        displayName = CSTRING(EnableSafeZone_DisplayName);
        description = CSTRING(EnableSafeZone_Description);
        value = 1;
        typeName = "BOOL";
    };
    class GVAR(SafeZoneRadius) {
        displayName = CSTRING(SafeZoneRadius_DisplayName);
        description = CSTRING(SafeZoneRadius_Description);
        value = 100;
        typeName = "SCALAR";
    };
};
