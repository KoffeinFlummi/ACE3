#include "script_component.hpp"
/*
 * Author: Gundy
 *
 * Description:
 *   Toggle night mode
 *
 * Arguments:
 *   0: Interface ID <STRING>
 *
 * Return Value:
 *   TRUE <BOOL>
 *
 * Example:
 *   ["interfaceID"] call ace_bft_devices_fnc_toggleNightMode;
 *
 * Public: No
 */


params ["_interfaceID"];

private _nightMode = [_interfaceID, "nightMode"] call FUNC(getSettings);

if (_nightMode != 2) then {
    if (_nightMode == 0) then {
        _nightMode = 1;
    } else {
        _nightMode = 0;
    };
    [_interfaceID, [["nightMode", _nightMode]]] call FUNC(setSettings);
};

true
