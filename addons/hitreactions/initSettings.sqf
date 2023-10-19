private _category = [LELSTRING(common,categoryUncategorized), QUOTE(COMPONENT_BEAUTIFIED)];

[
    QGVAR(minDamageToTrigger), "SLIDER",
    LSTRING(minDamageToTrigger_displayName),
    _category,
    [-1, 1, 0.1, 1],
    1
] call CBA_fnc_addSetting;

[
    QGVAR(weaponDropChanceGunHit), "SLIDER",
    LSTRING(weaponDropChanceGunHit_displayName),
    _category,
    [0, 1, 0.5, 1],
    1
] call CBA_fnc_addSetting;
