/*
 * Author: commy2
 * Called by repair action / progress bar. Raise events to set the new hitpoint damage.
 *
 * Arguments:
 * 0: Unit that does the repairing <OBJECT>
 * 1: Vehicle to repair <OBJECT>
 * 2: Selected hitpoint <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [unit, vehicle, "hitpoint"] call ace_repair_fnc_doRepair
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "_vehicle", "_hitPoint"];
TRACE_3("params",_unit,_vehicle,_hitPoint);

// get current hitpoint damage
private "_hitPointDamage";
_hitPointDamage = _vehicle getHitPointDamage _hitPoint;

_hitPointDamage = _hitPointDamage - 0.5;
// don't use negative values for damage
_hitPointDamage = _hitPointDamage max ([_unit] call FUNC(getPostRepairDamage));

// raise event to set the new hitpoint damage
["setVehicleHitPointDamage", _vehicle, [_vehicle, _hitPoint, _hitPointDamage]] call EFUNC(common,targetEvent);

// display text message if enabled
if (GVAR(DisplayTextOnRepair)) then {
    private "_text";
    _text = format ["STR_ACE_Repair_%1", _hitPoint];

    if (isLocalized _text) then {
        _text = format [localize ([LSTRING(RepairedHitPointFully), LSTRING(RepairedHitPointPartially)] select (_hitPointDamage > 0)), localize _text];
    } else {
        _text = localize ([LSTRING(RepairedFully), LSTRING(RepairedPartially)] select (_hitPointDamage > 0));
    };

    [_text] call EFUNC(common,displayTextStructured);
};
