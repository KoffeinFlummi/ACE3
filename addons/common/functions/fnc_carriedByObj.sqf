/**
 * fn_carriedByObj.sqf
 * @Descr: Check if object A is being carried by object B.
 * @Author: Glowbal
 *
 * @Arguments: [object OBJECT, unit OBJECT]
 * @Return: BOOL True if B is carrying A.
 * @PublicAPI: true
 */

#include "script_component.hpp"

private ["_unit","_to"];
_to = _this select 0;
_unit = _this select 1;

([_to] call FUNC(getCarriedBy) == [_unit] call FUNC(getCarriedBy));