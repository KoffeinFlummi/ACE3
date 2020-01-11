#include "script_component.hpp"
/*
 * Author: Pterolatypus
 * Checks a unit's equipment to calculate the total armor on a hitpoint
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Hitpoint <STRING>
 *
 * Return Value:
 * Total armor for the given hitpoint <ARRAY>
 * 0: Armor <NUMBER>
 * 1: ExplosionShielding <NUMBER>
 *
 * Example:
 * [player, "HitChest"] call ace_medical_engine_fnc_getHitpointArmor
 *
 * Public: No
 */
params ["_unit", "_hitpoint"];

// Helper function to check cache and/or read config
private _fnc_getItemArmor = {
    params ["_item", "_hitpoint", ["_isUniform", false]];
    if (_item isEqualTo "") exitWith {[0,0]};
    private _key = format ["%1$%2", _item, _hitpoint];
    private _armorValues = GVAR(armorCache) getVariable _key;
    if (isNil "_armorValues") then {
        TRACE_2("Cache miss", _item, _hitpoint);
        if (_isUniform) then {
            private _uniformClass = getText (configFile >> "CfgWeapons" >> _uniform >> "ItemInfo" >> "uniformClass");
            private _unitCfg = configFile >> "CfgVehicles" >> _uniformClass;
            private _baseValues = GVAR(armorCache) getVariable (_item + "$armor");
            if (isNil "_baseValues") then {
                _baseValues = [getNumber (_unitCfg >> "armor"), getNumber (_unitCfg >> "explosionShielding")];
                GVAR(armorCache) setVariable [(_item + "$armor"), _baseValues];
            };
            private _entry = _unitCfg >> "HitPoints" >> _hitpoint;
            _armorValues = [(_baseValues select 0) * getNumber (_entry >> "armor"), (_baseValues select 1) * getNumber (_entry >> "explosionShielding")];
        } else {
            private _cfg = configFile >> "CfgWeapons" >> _item >> "ItemInfo" >> "HitpointsProtectionInfo";
            private _condition = format ["getText (_x >> 'hitpointName') == '%1'",_hitpoint];
            private _entry = configProperties [_cfg, _condition] param [0, configNull];
            _armorValues = [getNumber (_entry >> "armor"), getNumber (_entry >> "explosionShielding")];
        };
        GVAR(armorCache) setVariable [_key, _armorValues];
    };
    _armorValues // return
};

private _uniform = uniform _unit;
// If unit is naked, use its underwear class instead
if (_uniform isEqualTo "") then {
    _uniform =  getText (configFile >> "CfgVehicles" >> typeOf _unit >> "nakedUniform");
};

// Initialise with values from uniform
[_uniform, _hitpoint, true] call _fnc_getItemArmor params ["_armor", "_explosion"];

// Add values from relevant gear
{
    [_x, _hitpoint] call _fnc_getItemArmor params ["_armorX", "_explosionX"];
    _armor = _armor + _armorX;
    _explosion = _explosion + _explosionX;
} forEach [vest _unit, headgear _unit];

[_armor, _explosion] // return
