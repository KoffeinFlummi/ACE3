/*
 * Author: commy2 PabstMirror
 * Fix, because captiveNum doesn't reset properly on respawn
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Corpse <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [alive, body] call ACE_captives_fnc_handleRespawn;
 *
 * Public: No
 */
#include "script_component.hpp"

systemChat str(_this);

params ["_unit","_dead"];

if (!local _unit) exitWith {};

// Group and side respawn can potentially respawn you as a captive unit
// Base and instant respawn cannot, so captive should be entirely reset
// So we explicity account for the respawn type
private ["_respawn"];
_respawn = [0] call BIS_fnc_missionRespawnType;

if (_respawn > 3) then {
    if (_unit getVariable [QGVAR(isHandcuffed), false]) then {
        _unit setVariable [QGVAR(isHandcuffed), false];
        [_unit, true] call FUNC(setHandcuffed);
    };

    if (_unit getVariable [QGVAR(isSurrendering), false]) then {
        _unit setVariable [QGVAR(isSurrendering), false];
        [_unit, true] call FUNC(setSurrendered);
    };
} else {
    if (_unit getVariable [QGVAR(isHandcuffed), false]) then {
        [_unit, false] call FUNC(setHandcuffed);
    };
    [_unit, QGVAR(Handcuffed), false] call EFUNC(common,setCaptivityStatus);

    if (_unit getVariable [QGVAR(isSurrendering), false]) then {
        [_unit, false] call FUNC(setSurrendered);
    };
    [_unit, QGVAR(Surrendered), false] call EFUNC(common,setCaptivityStatus);

    if (_oldUnit getVariable [QGVAR(isEscorting), false]) then {
        _oldUnit setVariable [QGVAR(isEscorting), false, true];
    };
};
