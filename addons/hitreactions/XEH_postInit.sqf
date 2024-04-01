#include "script_component.hpp"

["ace_firedNonPlayer", {
    if (GVAR(weaponDropChanceArmHit) == 0) exitWith {};

    (_this select 6) addEventHandler ["HitPart", {
        params ["", "_entity", "", "", "", "", "_selections"];

        [_entity, _selections] call FUNC(checkWeaponDrop);
    }];
}] call CBA_fnc_addEventHandler;

["ace_firedPlayer", {
    if (GVAR(weaponDropChanceArmHit) == 0) exitWith {};

    (_this select 6) addEventHandler ["HitPart", {
        params ["", "_entity", "", "", "", "", "_selections"];

        [_entity, _selections] call FUNC(checkWeaponDrop);
    }];
}] call CBA_fnc_addEventHandler;

[QGVAR(doMove), {
    params ["_unit", "_pos"];

    _unit setDestination [_pos, "LEADER PLANNED", true];
    _unit doMove _pos;
}] call CBA_fnc_addEventHandler;

[QGVAR(dropWeapon), {
    params ["_unit"];

    if !(_unit getVariable [QGVAR(canDropWeapon), true]) exitWith {};

    // Prevents AI from losing both primary and pistol when being shot with their pistol out
    _unit setVariable [QGVAR(canDropWeapon), false];

    private _weapon = currentWeapon _unit;
    private _thrownWeapon = _unit call EFUNC(common,throwWeapon);

    [{
        params ["_unit"];

        _unit setVariable [QGVAR(canDropWeapon), nil];
    }, _unit, 0.5] call CBA_fnc_waitAndExecute;

    if (isPlayer _unit) exitWith {}; // Don't make the player pick its own weapon up

    // Wait before executing, as otherwise the unit would pick up the weapon immediately
    [{
        [{
            (_this select 0) params ["_unit", "_weapon", "_thrownWeapon", "_timeout"];

            // If the unit has been deleted or dead, if the weapon doesn't exist anymore or if it's been too long, stop
            if (!alive _unit || {isNull _thrownWeapon} || {CBA_missionTime >= _timeout}) exitWith {
                (_this select 1) call CBA_fnc_removePerFrameHandler;
            };

            // Don't pick up weapon when unit is unconscious
            if (lifeState _unit == "INCAPACITATED") exitWith {};

            // If the unit has no essential weapons, force them to get their weapon, otherwise wait until no enemies are present
            if !((primaryWeapon _unit == "" && {handgunWeapon _unit == ""}) || {(_unit distance (_unit findNearestEnemy _unit)) > GVAR(safePickupDistance)}) exitWith {};

            // If the unit is too far away, make them move closer
            if (_unit distance _thrownWeapon >= 4) exitWith {
                [QGVAR(doMove), [_unit, getPosATL _thrownWeapon]] call CBA_fnc_targetEvent;
            };

            (_this select 1) call CBA_fnc_removePerFrameHandler;

            _unit action ["TakeWeapon", _thrownWeapon, _weapon];
        }, 5, _this] call CBA_fnc_addPerFrameHandler;
    }, [_unit, _weapon, _thrownWeapon, CBA_missionTime + 300], random [2, 3, 4]] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;
