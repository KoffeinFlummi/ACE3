#include "..\script_component.hpp"
/*
 * Author: Lambda.Tiger, based on fnc_dev_debugAmmo by "ACE-Team"
 * Dumps all ammo types to see if there's any reason to spawn fragments given hit power and distance.
 * Good for grasping the values used in shouldFrag to cull non-fragmenting rounds.
 *
 * Arguments:
 * 0: Display rounds that will never frag <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * false call ace_frag_fnc_dev_fragCalcDump
 *
 * Public: No
 */

params [["_logAll", false, [false]]];

private _allAmmoConfigs = configProperties [configFile >> "CfgAmmo", "isClass _x && !('ace_frag' in configName _x)", true];
private _processedCfgAmmos = [];

private _numberPrinted = 0;

diag_log text "//****************** fragCalcDump Beg ******************//";
{ // Begin _allAmmoConfigs forEach
    private _ammo = configName _x;

    if (_ammo isEqualTo "" || {_ammo in _processedCfgAmmos}) then {
        continue;
    };

    _ammo call FUNC(shouldFrag) params ["_shouldFrag"];
    if (_shouldFrag || _logAll) then {
        private _fragInfo = _ammo call FUNC(getFragInfo);
        _fragInfo params ["_fragRange", "_fragMaxVelocity", "", "_modifiedFragCount"];
        private _fragCount = 4 * pi * _modifiedFragCount;
        private _ammoConfig = configFile >> "CfgAmmo" >> _ammo;
        private _indirectHitRange = getNumber (_ammoConfig >> "indirectHitRange");
        private _indirectHit = getNumber (_ammoConfig >> "indirectHit");
        private _fragPowerSpeedRange = [0.5, 1] vectorMultiply _fragMaxVelocity;

        diag_log text format ["Ammo type: %1 | Should frag: %2", _ammo, _shouldFrag];
        diag_log text format ["    Indirect hit range: %1", _indirectHitRange];
        diag_log text format ["    Indirect hit:       %1", _indirectHit];
        diag_log text format ["    Frag sqrtPower:     %1", _fragPowerSqrt];
        diag_log text format ["    Frag range:         %1", _fragRange];
        diag_log text format ["    Frag speed range:   %1", _fragPowerSpeedRange];
        diag_log text format ["    Number frags:       %1", _fragCount];
        INC(_numberPrinted);
    };

    _processedCfgAmmos pushBack _ammo;
} forEach _allAmmoConfigs;

diag_log text "//****************** fragCalcDump End ******************//";
diag_log text format ["//********************** printed %1 *********************//", _numberPrinted];
