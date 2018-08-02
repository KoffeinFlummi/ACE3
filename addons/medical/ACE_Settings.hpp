class ACE_Settings {
    /* @todo
    class GVAR(enableFor) {
        category = CSTRING(Category_Medical);
        displayName = CSTRING(MedicalSettings_enableFor_DisplayName);
        description = CSTRING(MedicalSettings_enableFor_Description);
        value = 1;
        typeName = "SCALAR";
        values[] = {"Players only", "Players and AI"};
    };
    */
    /* @todo
    class GVAR(enableVehicleCrashes) {
        category = CSTRING(Category_Medical);
        displayName = CSTRING(MedicalSettings_enableVehicleCrashes_DisplayName);
        description = CSTRING(MedicalSettings_enableVehicleCrashes_Description);
        typeName = "BOOL";
        value = 1;
    };
    */
    class GVAR(allowUnconsciousAnimationOnTreatment) {
        category = CSTRING(Category_Medical);
        displayName = CSTRING(MedicalSettings_allowUnconsciousAnimationOnTreatment_DisplayName);
        typeName = "BOOL";
        value = 0;
    };
    class GVAR(menuTypeStyle) {
        category = CSTRING(Category_Medical);
        displayName = CSTRING(menuTypeDisplay);
        description = CSTRING(menuTypeDescription);
        typeName = "SCALAR";
        value = 0;
        values[] = {CSTRING(useSelection), CSTRING(useRadial), "Disabled"};
        isClientSettable = 1;
    };
    class GVAR(ivFlowRate) {
        category = CSTRING(Category_Medical);
        displayName = CSTRING(MedicalSettings_ivFlowRate_DisplayName);
        description = CSTRING(MedicalSettings_ivFlowRate_Description);
        typeName = "SCALAR";
        value = 1;
    };
    class GVAR(allowSelfIV) {
        category = CSTRING(Category_Medical);
        displayName = CSTRING(MedicalSettings_allowSelfIV_DisplayName);
        description = CSTRING(MedicalSettings_allowSelfIV_Description);
        typeName = "SCALAR";
        value = 0;
        values[] = {"No", "Yes"};
    };
    class GVAR(spontaneousWakeUpChance) {
        category = CSTRING(Category_Medical);
        displayName = CSTRING(MedicalSettings_spontaneousWakeUpChance_DisplayName);
        description = CSTRING(MedicalSettings_spontaneousWakeUpChance_Description);
        typeName = "SCALAR";
        value = 0.05;
        sliderSettings[] = {0, 1, 0.05, 2};
    };
};
