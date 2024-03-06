#include "..\script_component.hpp"
/*
 * Author: tcvm
 * Called by "HandleDamage" event handler. Sets up hit array for this frame's damage.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Selection <STRING>
 * 2: Damage taken <NUMBER>
 * 3: Source of damage <OBJECT>
 * 4: Projectile that caused damage <STRING>
 * 5: Hit part index of hit point <NUMBER>
 * 6: Instigator of damage <OBJECT>
 * 7: Hit point config name <STRING>
 *
 * Return Value:
 * Current or maximum damage of part
 *
 * Example:
 * [cursorObject, projectile, 5, 0.663] call ace_vehicle_damage_fnc_handleDamage;
 *
 * Public: No
 */

params ["_vehicle", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
TRACE_6("HandleDamage event inputs",_vehicle,_selection,_damage,_projectile,_hitIndex,_hitPoint);

if (!local _vehicle) exitWith {};

private _returnHit = if (_selection isNotEqualTo "") then {
    _vehicle getHitIndex _hitIndex
} else {
    damage _vehicle
};

if !(_projectile in ["ace_ammoExplosion", "ACE_ammoExplosionLarge"]) then {
    // If an invalid hit, don't process it
    if (_damage <= 0 || {"#light" in _hitPoint}) exitWith {};

    // Set up hit array so we can execute all damage next frame. Always in order of hit done.
    private _hitHash = _vehicle getVariable QGVAR(hitHash);
    private _currentFrameArray = _hitHash getOrDefault [diag_frameNo, [], true];

    if (_currentFrameArray isEqualTo []) then {
        [{
            params ["_vehicle", "_processingFrame"];

            private _hitHash = _vehicle getVariable QGVAR(hitHash);
            private _hitArray = _hitHash deleteAt _processingFrame;

            if (_hitArray isEqualTo []) exitWith {};

            TRACE_3("processing data from old frame",diag_frameNo,_processingFrame,_hitArray);

            // Start from newest damage and work backwards
            {
                _x params ["_vehicle", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];

                private _returnHit = if (_selection != "") then {
                    _vehicle getHitIndex _hitIndex
                } else {
                    damage _vehicle
                };

                private _newDamage = _damage - _returnHit;

                if !([_vehicle, _hitPoint, _hitIndex, _source, _instigator, _returnHit, _newDamage, _projectile, _selection] call FUNC(handleVehicleDamage)) exitWith {
                    TRACE_2("cancelling rest of vehicle damage queue ( [%1] items left out of [%2] )",(count (_hitArray#1)) - _forEachIndex,count (_hitArray#1))
                };
            } forEachReversed _hitArray;
        }, [_vehicle, diag_frameNo]] call CBA_fnc_execNextFrame;
    };

    _currentFrameArray pushBack _this;
};

// Damage is never to be handled in-engine. Always handle out of engine with this event handler
// Don't return 0 or else old parts will be reset in damage
private _criticalDamageIndex = CRITICAL_HITPOINTS findIf {_x == _hitPoint};

if (_criticalDamageIndex != -1) then {
    _returnHit = _returnHit min (CRITICAL_HITPOINTS_THESHOLDS select _criticalDamageIndex);
};

if (_hitPoint == "" && {_hitIndex < 0}) then {
    _returnHit = _returnHit min 0.89;
};

_returnHit
