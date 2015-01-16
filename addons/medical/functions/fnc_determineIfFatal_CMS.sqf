/**
 * fn_determineIfFatal_CMS.sqf
 * @Descr: N/A
 * @Author: Glowbal
 *
 * @Arguments: []
 * @Return:
 * @PublicAPI: false
 */

#include "script_component.hpp"

#define DEFAULT_DAMAGE_THRESHOLD 1

private ["_unit","_part","_damageThreshold"];
_unit = _this select 0;
_part = _this select 1;

if (!alive _unit) exitwith {true};

if ((vehicle _unit != _unit) && {!alive (vehicle _unit)}) exitwith { true };

// Find the correct Damage threshold for unit.
_damageThreshold = [1,1,1];
if (isPlayer _unit) then {
	_damageThreshold =_unit getvariable[QGVAR(unitDamageThreshold), [GVAR(damageThreshold_Players), GVAR(damageThreshold_Players), GVAR(damageThreshold_Players)]];
} else {
	_damageThreshold =_unit getvariable[QGVAR(unitDamageThreshold), [GVAR(damageThreshold_AI), GVAR(damageThreshold_AI), GVAR(damageThreshold_AI)]];
};

_damageBodyPart = ([_unit,QGVAR(bodyPartStatus),[0,0,0,0,0,0]] call EFUNC(common,getDefinedVariable)) select _part;

// Check if damage to body part is higher as damage head
if (_part == 0) exitwith {
	(_damageBodyPart >= (_damageThreshold select 0) && {(random(1) > 0.2)});
};

// Check if damage to body part is higher as damage torso
if (_part == 1) exitwith {
	(_damageBodyPart >= (_damageThreshold select 1) && {(random(1) > 0.2)});
};
// Check if damage to body part is higher as damage limbs
(_damageBodyPart >= (_damageThreshold select 2) && {(random(1) > 0.95)});
