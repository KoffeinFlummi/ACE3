#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Calculates the blood volume change and decreases the IVs given to the unit.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Time since last update <NUMBER>
 * 2: Global Sync Values (bloodbags) <BOOL>
 *
 * Return Value:
 * Blood volume change (liters per second) <NUMBER>
 *
 * Example:
 * [player, 1, true] call ace_medical_status_fnc_getBloodVolumeChange
 *
 * Public: No
 */

params ["_unit", "_deltaT", "_syncValues"];

private _bloodVolumeChange = -_deltaT * GET_BLOOD_LOSS(_unit);

if (!isNil {_unit getVariable QEGVAR(medical,ivBags)}) then {
    private _bloodBags = _unit getVariable [QEGVAR(medical,ivBags), []];
    private _tourniquets = GET_TOURNIQUETS(_unit);

    _bloodBags = _bloodBags apply {
<<<<<<< HEAD
        _x params ["_bagVolumeRemaining", "_type", "_bodyPart", "_classname", "_rateCoef"];
=======
        _x params ["_bagVolumeRemaining", "_type", "_bodyPart", "_treatment", "_rateCoef", "_item"];
>>>>>>> 5285ec4585ab6754993bc5c5f10c5a71e15c9673

        if (_tourniquets select _bodyPart == 0) then {
            private _bagChange = (_deltaT * EGVAR(medical,ivFlowRate) * IV_CHANGE_PER_SECOND * _rateCoef) min _bagVolumeRemaining; // absolute value of the change in miliLiters
            _bagVolumeRemaining = _bagVolumeRemaining - _bagChange;
            _bloodVolumeChange = _bloodVolumeChange + (_bagChange / 1000);
        };

        if (_bagVolumeRemaining < 0.01) then {
            []
        } else {
<<<<<<< HEAD
            [_bagVolumeRemaining, _type, _bodyPart, _classname, _rateCoef]
=======
            [_bagVolumeRemaining, _type, _bodyPart, _treatment, _rateCoef, _item]
>>>>>>> 5285ec4585ab6754993bc5c5f10c5a71e15c9673
        };
    };

    _bloodBags = _bloodBags - [[]]; // remove empty bags

    if (_bloodBags isEqualTo []) then {
        _unit setVariable [QEGVAR(medical,ivBags), nil, true]; // no bags left - clear variable (always globaly sync this)
    } else {
        _unit setVariable [QEGVAR(medical,ivBags), _bloodBags, _syncValues];
    };
};

_bloodVolumeChange
