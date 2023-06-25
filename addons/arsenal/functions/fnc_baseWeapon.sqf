#include "script_component.hpp"
/*
 * Author: Karel Moricky, johnb43
 * Returns base weapon (weapon without any attachments), but it returns it in config sensitive case.
 * Same as BIS_fnc_baseWeapon, except config case and uses cache.
 *
 * Arguments:
 * 0: Weapon <STRING>
 *
 * Return Value:
 * Base weapon <STRING>
 *
 * Example:
 * ["arifle_AK12_GL_lush_arco_pointer_F"] call ace_arsenal_fnc_baseWeapon
 *
 * Public: Yes
 */

params [["_weapon", "", [""]]];

private _cacheKey = toLower _weapon;

// Check if item is cached
private _className = (uiNamespace getVariable QGVAR(baseWeaponNameCache)) get _cacheKey;

if (!isNil "_className") exitWith {
    _className
};

private _config = configfile >> "CfgWeapons" >> _weapon;

// If class doesn't exist, exit
if (!isClass _config) exitWith {
    (uiNamespace getVariable QGVAR(baseWeaponNameCache)) set [_cacheKey, _weapon];
    _weapon
};

// Get manual base weapon
private _configBase = configfile >> "CfgWeapons" >> getText (_config >> "baseWeapon");

if (isClass _configBase) exitWith {
    _className = configName _configBase;
    (uiNamespace getVariable QGVAR(baseWeaponNameCache)) set [_cacheKey, _className];
    _className
};

// Get first parent without any attachments
scopeName "main";

// Only take weapons available to the arsenal
// https://community.bistudio.com/wiki/Arma_3:_Characters_And_Gear_Encoding_Guide#Character_configuration
// https://github.com/acemod/ACE3/pull/9040#issuecomment-1597748331
while {isClass _config && {if (isNumber (_config >> "scopeArsenal")) then {getNumber (_config >> "scopeArsenal") == 2} else {getNumber (_config >> "scope") > 0}} && {getNumber (_config >> QGVAR(hide)) != 1}} do {
    if (count (_config >> "LinkedItems") == 0) exitWith {
        _className = configName _config;
        (uiNamespace getVariable QGVAR(baseWeaponNameCache)) set [_cacheKey, _className];
        _className breakOut "main"
    };

    _config = inheritsFrom _config;
};

_cache set [_cacheKey, _weapon];
_weapon
