// by commy2

["ACE3 Weapons", QGVAR(switchLaserLightMode), localize LSTRING(switchLaserLight),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside", "isNotSitting"]] call CFUNC(canInteractWith)) exitWith {false};
    // Conditions: specific
    if !([ACE_player] call CBA_fnc_canUseWeapon) exitWith {false};

    [ACE_player, currentWeapon ACE_player] call FUNC(switchLaserLightMode);
    true
},
{false}, [38, [false, true, false]], false] call CBA_fnc_addKeybind;
