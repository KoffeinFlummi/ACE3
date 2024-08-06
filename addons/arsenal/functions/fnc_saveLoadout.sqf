#include "..\script_component.hpp"
/*
 * Author: DartRuffian
 * Saves a given loadout to the client's profile.
 *
 * Arguments:
 * 0: Name of loadout <STRING>
 * 1: CBA extended loadout or getUnitLoadout array <ARRAY>
 * 2: Replace existing loadout <BOOL> (default: false)
 *
 * Return Value:
 * True if loadout was saved, otherwise false <BOOL>
 *
 * Example:
 * ["Current Loadout", getUnitLoadout ACE_player] call ace_arsenal_fnc_saveLoadout
 *
 * Public: Yes
 */

params [["_name", "", [""]], ["_loadout", [], [[]]], ["_replaceExisting", false, [false]]];

if (_name == "" || {_loadout isEqualTo []}) exitWith { false };

private _loadouts = profileNamespace getVariable [QGVAR(saved_loadouts), []];
private _loadoutNames = _loadouts apply {toLower (_x#0)};

private _loadoutIndex = _loadoutNames find toLower _name;

if (_loadoutIndex == -1) then {
    _loadouts pushBack [_name, _loadout];
} else {
    if (!_replaceExisting) exitWith { false };
    _loadouts set [_loadoutIndex, [_name, _loadout]];
};

true
