["ACE3 Equipment", QGVAR(AzimuthKey), localize LSTRING(AzimuthKey), {
    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if !(currentWeapon ACE_player isKindOf ["ACE_Vector", configFile >> "CfgWeapons"] && {cameraView == "GUNNER"}) exitWith {false};

    // prevent holding down
    if (GETGVAR(isDownStateKey1,false)) exitWith {false};
    GVAR(isDownStateKey1) = true;

    // Statement
    ["azimuth"] call FUNC(onKeyDown);
    false
}, {
    // prevent holding down
    GVAR(isDownStateKey1) = false;

    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};

    // Statement
    ["azimuth"] call FUNC(onKeyUp);
    false
}, [DIK_R, [false, false, false]], false, 0] call CBA_fnc_addKeybind;

["ACE3 Equipment", QGVAR(DistanceKey), localize LSTRING(DistanceKey), {
    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if !(currentWeapon ACE_player isKindOf ["ACE_Vector", configFile >> "CfgWeapons"] && {cameraView == "GUNNER"}) exitWith {false};

    // prevent holding down
    if (GETGVAR(isDownStateKey2,false)) exitWith {false};
    GVAR(isDownStateKey2) = true;

    // Statement
    ["distance"] call FUNC(onKeyDown);
    false
}, {
    // prevent holding down
    GVAR(isDownStateKey2) = false;

    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};

    // Statement
    ["distance"] call FUNC(onKeyUp);
    false
}, [DIK_R, [false, false, false]], false, 0] call CBA_fnc_addKeybind;

["ACE3 Equipment", QGVAR(Distance2Key), localize LSTRING(Distance2Key), {
    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if !(currentWeapon ACE_player isKindOf ["ACE_Vector", configFile >> "CfgWeapons"] && {cameraView == "GUNNER"}) exitWith {false};

    // prevent holding down
    if (GETGVAR(isDownStateKey2,false)) exitWith {false};
    GVAR(isDownStateKey2) = true;

    // Statement
    ["distance2"] call FUNC(onKeyDown);
    false
}, {
    // prevent holding down
    GVAR(isDownStateKey2) = false;

    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};

    // Statement
    ["distance2"] call FUNC(onKeyUp);
    false
}, [DIK_R, [false, false, false]], false, 0] call CBA_fnc_addKeybind;

["time"] call FUNC(onKeyDown);

// ["ACE3 Equipment", QGVAR(GameTimeKey), localize LSTRING(GameTimeKey), {
//     if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};
//     if !(currentWeapon ACE_player isKindOf ["ACE_Vector", configFile >> "CfgWeapons"] && {cameraView == "GUNNER"}) exitWith {false};

//     if (GETGVAR(isDownStateKey3,false)) exitWith {false};
//     GVAR(isDownStateKey3) = true;

//     ["time"] call FUNC(onKeyDown);
//     false
// }, {
//     GVAR(isDownStateKey3) = false;

//     if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};

//     ["time"] call FUNC(onKeyUp);
//     false
// }, [DIK_TAB, [false, false, false]], false, 0] call CBA_fnc_addKeybind;
