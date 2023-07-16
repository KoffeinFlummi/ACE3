#include "script_component.hpp"

if !GVAR(enabled) exitWith {};

[QGVAR(setVehicleDamage), {_this call FUNC(setDamage)}] call CBA_fnc_addEventHandler;
[QGVAR(setVehicleHitPointDamage), {_this call FUNC(setHitPointDamage)}] call CBA_fnc_addEventHandler;
[QGVAR(setWheelHitPointDamage), {
    params ["_object", "_hitPoint", "_damage"];
    private _damageDisabled = !isDamageAllowed _object;

    if (_damageDisabled) then {
        _object allowDamage true;
    };

    _object setHitPointDamage [_hitPoint, _damage];

    if (_damageDisabled) then {
        _object allowDamage false;
    };
}] call CBA_fnc_addEventHandler;


// placed in editor static objects don't trigger init
{
    if (local _x && {getRepairCargo _x > 0}) then {
        _x setRepairCargo 0;
    };
} forEach allMissionObjects "Static";

["All", "InitPost", {
    params ["_vehicle"];
    if (local _vehicle && {getRepairCargo _vehicle > 0}) then {
        _vehicle setRepairCargo 0;
    };
}, true, ["Man"], true] call CBA_fnc_addClassEventHandler;

["CAManBase", "InitPost", {
    params ["_unit"];
    if (local _unit && {_unit getUnitTrait "engineer"}) then {
        _unit setUnitTrait ["engineer", false];
        if (-1 isEqualTo (_unit getVariable ["ACE_IsEngineer", -1])) then {
            _unit setVariable ["ACE_IsEngineer", true, true];
        };
    };
}, true, [], true] call CBA_fnc_addClassEventHandler;


GVAR(allToolKits) = call (uiNamespace getVariable QGVAR(allToolKits));

["ACE_RepairItem_Base", "killed", {
    params ["_object"];

    [{deleteVehicle _this}, _object, 5] call CBA_fnc_waitAndExecute;
}, true, [], true] call CBA_fnc_addClassEventHandler;

// load tracks and wheels
if (isServer) then {
    private _fnc_addSpareItems = {
        if (!GVAR(addSpareParts)) exitWith {};
        params ["_vehicle"];

        private _spareTracks = _vehicle getVariable QGVAR(editorLoadedTracks);
        if (isNil "_spareTracks") then {
            _spareTracks = [0, 1] select (_vehicle isKindOf "Tank"); // must match eden attribute default
        };
        if (_spareTracks > 0) then {
            [_vehicle, _spareTracks, "ACE_Track"] call FUNC(addSpareParts);
        };

        private _spareWheels = _vehicle getVariable QGVAR(editorLoadedWheels);
        if (isNil "_spareWheels") then {
            _spareWheels = [0, 1] select (_vehicle isKindOf "Car"); // must match eden attribute default
        };
        if (_spareWheels > 0) then {
            [_vehicle, _spareWheels, "ACE_Wheel"] call FUNC(addSpareParts);
        };
    };

    ["Tank", "initPost", _fnc_addSpareItems, true, [], true] call CBA_fnc_addClassEventHandler;
    ["Car", "initPost", _fnc_addSpareItems, true, [], true] call CBA_fnc_addClassEventHandler;
};
