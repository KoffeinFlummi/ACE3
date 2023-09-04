private _categoryArray = [ELSTRING(medical,Category), "STR_TEAM_SWITCH_AI"];

[
    QGVAR(enabledFor), "LIST",
    [LLSTRING(enableFor_title), LLSTRING(enableFor_desc)],
    _categoryArray,
    [
        [0, 1, 2],
        [LELSTRING(Common,Disabled), LLSTRING(enabledFor_OnlyServerAndHC), LELSTRING(Common,Enabled)],
        2
    ],
    true, // isGlobal
    {[QGVAR(enabledFor), _this] call EFUNC(common,cbaSettings_settingChanged)},
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QGVAR(ignoreItemRequirements), "CHECKBOX",
    [LSTRING(ignoreItemRequirements_title), LSTRING(ignoreItemRequirements_desc)],
    _categoryArray,
    true,
    true, // isGlobal
    {},
    true // Needs mission restart
] call CBA_fnc_addSetting;
