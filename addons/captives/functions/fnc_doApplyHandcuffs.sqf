#include "..\script_component.hpp"
/*
 * Author: PabstMirror
 * Checks the conditions for being able to apply handcuffs
 *
 * Arguments:
 * 0: caller (player) <OBJECT>
 * 1: target <OBJECT>
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * [player, bob] call ACE_captives_fnc_doApplyHandcuffs;
 *
 * Public: No
 */


params ["_unit", "_target"];

playSound3D [QUOTE(PATHTO_R(sounds\cable_tie_zipping.ogg)), objNull, false, (getPosASL _target), 1, 1, 10];

private _cuffs = (_unit call EFUNC(common,uniqueItems)) arrayIntersect GVAR(restraints);
private _selectedCuffs = _cuffs#0;

[QGVAR(setHandcuffed), [_target, true, _unit, _selectedCuffs], [_target]] call CBA_fnc_targetEvent;

_unit removeItem _selectedCuffs;
