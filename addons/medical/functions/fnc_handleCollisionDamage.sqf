/*
 * Author: commy2
 *
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: New Damage <SCALAR>
 *
 * ReturnValue:
 * None
 *
 * Public: No
 */

#include "script_component.hpp"

params ["_unit", "_newDamage"];

private ["_selection", "_totalDamage"];

_selection = "body";

_totalDamage = (_unit getHit _selection) + _newDamage;

_unit setHit [_selection, _totalDamage];

systemChat format ["collision: %1", _this];
