/**
 * fn_loadPersonLocal_f.sqf
 * @Descr: Load a person, local
 * @Author: Glowbal
 *
 * @Arguments: [unit OBJECT, vehicle OBJECT, caller OBJECT]
 * @Return: void
 * @PublicAPI: false
 */

#include "script_component.hpp"

private ["_unit","_vehicle","_caller","_handle","_loaded","_slotsOpen"];
_unit = [_this, 0, ObjNull,[ObjNull]] call BIS_fnc_Param;
_vehicle = [_this, 1, ObjNull,[ObjNull]] call BIS_fnc_Param;
_caller = [_this, 2, ObjNull,[ObjNull]] call BIS_fnc_Param;
_slotsOpen = false;

if (!alive _unit) then {
    _unit = [_unit,_caller] call FUNC(makeCopyOfBody);
};


if (_vehicle emptyPositions "cargo" > 0) then {
    _unit moveInCargo _vehicle;
    _slotsOpen = true;
} else {
    if (_vehicle emptyPositions "gunner" > 0) then {
        _unit moveInGunner _vehicle;
        _slotsOpen = true;
    };
};

if (_slotsOpen) then {
    _loaded = _vehicle getvariable [QGVAR(loaded_persons),[]];
    _loaded pushback _unit;
    _vehicle setvariable [QGVAR(loaded_persons),_loaded,true];
    if (!([_unit] call FUNC(isAwake))) then {
        _handle = [_unit,_vehicle] spawn {
            private ["_unit","_vehicle"];
            _unit = _this select 0;
            _vehicle = _this select 1;
            waituntil {vehicle _unit == _vehicle};
            sleep 0.5;

            //Save the "awake" animation before applying the death animation
            if (vehicle _unit == _vehicle) then {
                _unit setVariable [QEGVAR(medical,vehicleAwakeAnim), [_vehicle, (animationState _unit)]];
            };
            [_unit,([_unit] call FUNC(getDeathAnim)), 1, true] call FUNC(doAnimation);
        };
    } else {
        if ([_unit] call FUNC(isArrested)) then {

        };
    };
};