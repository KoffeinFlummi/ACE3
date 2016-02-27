/*
 * Author: BaerMitUmlaut
 * Handles ropes breaking when deployed.
 *
 * Arguments:
 * 0: RopeBreak EH arguments <ARRAY>
 * 1: Part of rope ("top" or "bottom") <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "script_component.hpp"
params ["_ehArgs", "_part"];
_ehArgs params ["_rope", "_helper1", "_helper2"];
private ["_vehicle", "_deployedRopes", "_brokenRope", "_unit"];

if (_part == "bottom") then {
    _helper2 = (ropeAttachedObjects _helper1) select 0;
};

_vehicle = attachedTo _helper2;
if (isNil "_vehicle") exitWith {}; //Exit when vehicle got destroyed
if (_vehicle isKindOf "ACE_friesBase") then {
    _vehicle = attachedTo _vehicle;
};

_deployedRopes = _vehicle getVariable [QGVAR(deployedRopes), []];
_brokenRope = [];
{
    if ((_x select 1 == _rope) || {(_x select 2 == _rope)}) exitWith {
        _brokenRope = _x;
    };
} forEach _deployedRopes;
_brokenRope set [5, true];
_vehicle setVariable [QGVAR(deployedRopes), _deployedRopes, true];

_unit = {
    if (_x isKindOf "CAManBase") exitWith {_x};
} forEach (attachedObjects (_brokenRope select 3));

if !(isNil "_unit") then {
    if (_part == "top") then {
        detach _unit;
    } else {
        //TODO: ???
        //Rope might break at the very bottom
        //-> letting the unit fall is not always ideal
    };
};
