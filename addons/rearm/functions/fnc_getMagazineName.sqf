#include "..\script_component.hpp"
/*
 * Author: PabstMirror, johnb43
 * Gets a non-ambigious display name for a magazine using displayNameShort (AP/HE).
 *
 * Arguments:
 * 0: Magazine Classname <STRING>
 *
 * Return Value:
 * Display Name <STRING>
 *
 * Example:
 * "60Rnd_20mm_AP_shells" call ace_rearm_fnc_getMagazineName
 *
 * Public: No
 */

params ["_className"];
TRACE_1("getMagazineName",_className);

GVAR(magazineNameCache) getOrDefaultCall [_className, {
    private _cfgMagazines = configFile >> "CfgMagazines";
    private _displayName = getText (_cfgMagazines >> _className >> "displayName");

    if (_displayName == "") then {
        _displayName = _className;
        WARNING_1("Magazine is missing display name [%1]",_className);
    };

    if ((_displayName select [0, 6]) == "[CSW] ") then { _displayName = _displayName select [6]; };

    // If the display name exists already, add displayNameShort to the existing entry
    private _existingClassname = GVAR(usedMagazineNames) get _displayName;

    if (!isNil "_existingClassname") then {
        GVAR(magazineNameCache) set [_existingClassname, format ["%1: %2", _displayName, getText (_cfgMagazines >> _existingClassname >> "displayNameShort")]];

        _displayName = format ["%1: %2", _displayName, getText (_cfgMagazines >> _className >> "displayNameShort")];
    };

    GVAR(usedMagazineNames) set [_displayName, _className];
    TRACE_2("Adding to cache",_className,_displayName);

    _displayName
}, true] // return
