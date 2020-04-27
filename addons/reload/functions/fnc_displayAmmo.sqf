#include "script_component.hpp"
/*
 * Author: commy2 and esteldunedain
 * Display the ammo of the currently loaded magazine of the target or count rifle grenades.
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call ace_reload_fnc_displayAmmo
 *
 * Public: No
 */

#define COUNT_BARS 12

params ["_target"];

private _weapon = currentWeapon _target;
private _muzzle = currentMuzzle _target;
private _magazine = currentMagazine _target;

// currentWeapon returns "" for static weapons before they are shot once
if (_target isKindOf "StaticWeapon") then {
    if (_weapon == "") then {
        if (count (weapons _target) == 1) then {
            _weapon = (weapons _target) select 0;
            _muzzle = _weapon;
        };
    };

    if (_magazine == "") then {
        // Try to get magazine using magazinesAmmoFull
        private _magazines = magazinesAmmoFull _target;

        {
            if (_x select 2) exitWith {
                _magazine = _x select 0;
            };
        } forEach _magazines;
    };

    // For static weapons the muzzle seemingly never returns anything for static weapons with/without people inside
    if (_muzzle == "") then {
        _muzzle = _weapon;
    };
};

if (_magazine == "") exitWith {};
if (_weapon == "") exitWith {};
if (!( _muzzle isEqualType "")) then {_muzzle = _weapon};

private _ammo = 0;
private _maxRounds = getNumber (configFile >> "CfgMagazines" >> _magazine >> "count") max 1;
private _count = -1; // Show a count instead of ammo bars (ignore if -1)

// not grenade launcher
if (_muzzle == _weapon) then {
    _ammo = _target ammo _weapon;
} else {
    // grenade launcher (or some kind of seconday muzzle)
    _ammo = _target ammo _muzzle;
    if (_ammo > 0) then {
        if (_maxRounds == 1) then { // singleShot so show count of identical mags available instead of ammo bars
            _count = {_x == _magazine} count (magazines _target + [_magazine]) // add the loaded mag
        };
    } else {
        if (_maxRounds <= 3) then { // empty GL/3GL - don't have a real magazine so just show count of any compatible mag
            _magazine = "";
            private _compatibleMagazines =  [configFile >> "CfgWeapons" >> _weapon >> _muzzle] call CBA_fnc_compatibleMagazines;
            _count = {_x in _compatibleMagazines} count (magazines _target); // safe because everything is config case
         };
    };
};

private _ammoBarsStructuredText = if (_count >= 0) then {
    parseText format ["<t align='center' >%1x</t>", _count]
} else {
    if (_maxRounds >= COUNT_BARS) then {
        _count = round (COUNT_BARS * _ammo / _maxRounds);

        if (_ammo > 0) then {_count = _count max 1};
        if (_ammo < _maxRounds) then {_count = _count min (COUNT_BARS - 1)};
    } else {
        _count = _ammo;
    };

    private _color = [((2 * (1 - _ammo / _maxRounds)) min 1), ((2 * _ammo / _maxRounds) min 1), 0];

    private _string = "";
    for "_a" from 1 to _count do {
        _string = _string + "|";
    };
    private _text = [_string, _color] call EFUNC(common,stringToColoredText);

    _string = "";
    for "_a" from (_count + 1) to (_maxRounds min COUNT_BARS) do {
        _string = _string + "|";
    };

    composeText [_text, [_string, "#808080"] call EFUNC(common,stringToColoredText)];
};


if (_target isKindOf "StaticWeapon") then {
    //Vehicle mags (usualy) don't have pictures, so just show the text above ammo count
    private _loadedName = getText (configFile >> "CfgMagazines" >> _magazine >> "displaynameshort");
    _loadedName = parseText format ["<t align='center' >%1</t>", _loadedName];
    private _text = composeText [_loadedName, linebreak, _ammoBarsStructuredText];
    [_text] call EFUNC(common,displayTextStructured);
} else {
    if (_magazine != "") then {
        private _picture = getText (configFile >> "CfgMagazines" >> _magazine >> "picture");
        [_ammoBarsStructuredText, _picture] call EFUNC(common,displayTextPicture);
    } else {
        [_ammoBarsStructuredText, 1] call EFUNC(common,displayTextStructured);
    };
};
