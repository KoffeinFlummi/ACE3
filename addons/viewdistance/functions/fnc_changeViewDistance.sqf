#include "script_component.hpp"
/*
 * Author: Winter
 * Sets the player's current view distance according to allowed values.
 *
 * Arguments:
 * 0: View Distance setting INDEX <NUMBER>
 * 1: Show Prompt <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_viewdistance_fnc_changeViewDistance
 *
 * Public: No
 */

params ["_indexRequested", "_showPrompt"];

private _newViewDistance = [_indexRequested] call FUNC(returnValue); // changes the setting index into an actual view distance value
private _objectViewDistanceCoeff = [GVAR(objectViewDistanceCoeff)] call FUNC(returnObjectCoeff); // changes the setting index into a coefficient.
private _viewDistanceLimit = GVAR(limitViewDistance); // Grab the limit

if (_newViewDistance == -1) then { // Reset to default
    setViewDistance -1;
    _newViewDistance = viewDistance;
};

TRACE_3("Limit",_newViewDistance,_viewDistanceLimit,_showPrompt);
setViewDistance (_newViewDistance min _viewDistanceLimit);

if (_objectViewDistanceCoeff isEqualType 0) then {
    if (_objectViewDistanceCoeff > 0) then {
        setObjectViewDistance (_objectViewDistanceCoeff * viewDistance);
    } else {
        if (!isNil QGVAR(fovBasedPFHminimalViewDistance)) then {
            // Restore correct view distance when changing from FoV Based to Off
            // Restoring directly inside PFH's self-exit resulted in the need of selecting another option to take effect
            setObjectViewDistance GVAR(fovBasedPFHminimalViewDistance);
        };
    };
} else {
    if (isNil QGVAR(fovBasedPFHminimalViewDistance)) then {
        GVAR(fovBasedPFHminimalViewDistance) = getObjectViewDistance select 0; // Minimal view distance holder and PFH isRunning variable
        [FUNC(setFovBasedOvdPFH), 0, []] call CBA_fnc_addPerFrameHandler;
    };
};

if (_showPrompt) then {
    if (GVAR(objectViewDistanceCoeff) > 0) then {
        private _text = "";
        // FoV Based or %
        if (GVAR(objectViewDistanceCoeff) == 6) then {
            _text = format ["<t align='center'>%1 %2<br/>Min. %3<br/>Max. %4</t>", localize LSTRING(objectinfotext), localize LSTRING(object_fovBased), GVAR(fovBasedPFHminimalViewDistance), viewDistance];
        } else {
            _text = [
                format ["<t align='center'>%1 %2m", localize LSTRING(invalid), viewDistance],
                format ["<t align='center'>%1 %2m", localize LSTRING(infotext), viewDistance]
            ] select (_newViewDistance <= _viewDistanceLimit);
            _text = _text + format ["<br/><t align='center'>%1 %2%3</t>", localize LSTRING(objectinfotext), _objectViewDistanceCoeff * 100, "%"];
        };
        [parseText _text, 2] call EFUNC(common,displayTextStructured);
    };
};
