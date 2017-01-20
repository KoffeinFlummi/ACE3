/*
 * Author: 654wak654
 * Shows a zeus message through the BIS function, handles localization
 *
 * Arguments:
 * 0: The message <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * ["something"] call ace_zeus_fnc_showMessage
 *
 * Public: Yes
 */

#include "script_component.hpp"

params ["_message"];

if (_message isEqualType "" && {isLocalized _message}) then {
    _message = localize _message;
} else {
    if (_message isEqualType []) then {
        MAP(_message,if (isLocalized _x) then {localize _x} else {_x});
        _message = format _message;
    };
};

[objNull, _message] call BIS_fnc_showCuratorFeedbackMessage;
