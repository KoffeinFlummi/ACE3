[
    QGVAR(enableFire),
    "CHECKBOX",
    [LSTRING(enableFire_name), LSTRING(enableFire_tooltip)],
    LSTRING(category_displayName),
    true,
    1,
    {[QGVAR(enableFire), _this] call EFUNC(common,cbaSettings_settingChanged)}
] call CBA_fnc_addSetting;

[
    QGVAR(cookoffDuration),
    "SLIDER",
    [LSTRING(cookoffDuration_name), LSTRING(cookoffDuration_tooltip)],
    LSTRING(category_displayName),
    [0, 5, 1, 1],
    1,
    {[QGVAR(cookoffDuration), _this] call EFUNC(common,cbaSettings_settingChanged)}
] call CBA_fnc_addSetting;

[
    QGVAR(probabilityCoef),
    "SLIDER",
    [LSTRING(probabilityCoef_name), LSTRING(probabilityCoef_tooltip)],
    LSTRING(category_displayName),
    [0, 5, 1, 1],
    1,
    {[QGVAR(probabilityCoef), _this] call EFUNC(common,cbaSettings_settingChanged)}
] call CBA_fnc_addSetting;

[
    QGVAR(destroyVehicleAfterCookoff),
    "CHECKBOX",
    [LSTRING(destroyVehicleAfterCookoff_name), LSTRING(destroyVehicleAfterCookoff_tooltip)],
    LSTRING(category_displayName),
    false,
    1,
    {[QGVAR(destroyVehicleAfterCookoff), _this] call EFUNC(common,cbaSettings_settingChanged)}
] call CBA_fnc_addSetting;

[
    QGVAR(enableAmmoCookoff),
    "CHECKBOX",
    [LSTRING(enableAmmoCookoff_name), LSTRING(enableAmmoCookoff_tooltip)],
    LSTRING(category_displayName),
    true,
    1,
    {[QGVAR(enableAmmoCookoff), _this] call EFUNC(common,cbaSettings_settingChanged)}
] call CBA_fnc_addSetting;

[
    QGVAR(enableAmmobox),
    "CHECKBOX",
    [LSTRING(enableBoxCookoff_name), LSTRING(enableBoxCookoff_tooltip)],
    LSTRING(category_displayName),
    true,
    1,
    {[QGVAR(enableAmmobox), _this] call EFUNC(common,cbaSettings_settingChanged)}
] call CBA_fnc_addSetting;

[
    QGVAR(ammoCookoffDuration),
    "SLIDER",
    [LSTRING(ammoCookoffDuration_name), LSTRING(ammoCookoffDuration_tooltip)],
    LSTRING(category_displayName),
    [0, 5, 1, 1],
    1,
    {[QGVAR(ammoCookoffDuration), _this] call EFUNC(common,cbaSettings_settingChanged)}
] call CBA_fnc_addSetting;

[
    QGVAR(removeAmmoDuringCookoff),
    "CHECKBOX",
    [LSTRING(removeAmmoDuringCookoff_name), LSTRING(removeAmmoDuringCookoff_tooltip)],
    LSTRING(category_displayName),
    true,
    1,
    {[QGVAR(removeAmmoDuringCookoff), _this] call EFUNC(common,cbaSettings_settingChanged)}
] call CBA_fnc_addSetting;
