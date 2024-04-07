#include "..\script_component.hpp"
/*
 * Author: tcvm, johnb43
 * Process hit by projectile against vehicle and apply appropiate damage to part.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Projectile <OBJECT>
 * 2: Hit index of potentially damaged part <NUMBER>
 * 3: New damage done to part <NUMBER>
 * 4: Hitpoint <STRING>
 * 5: Source of damage <OBJECT>
 * 6: Person who caused damage <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, projectile, 5, 0.663] call ace_vehicle_damage_fnc_processHit;
 *
 * Public: No
 */

params ["_vehicle", "_projectile", "_hitIndex", "_newDamage", "_hitPoint", "_source", "_instigator"];

_newDamage = abs _newDamage;

private _currentPartDamage = _vehicle getHitIndex _hitIndex;
private _nextPartDamage = _currentPartDamage + _newDamage;

// Damage is high enough for immediate destruction
if (_newDamage >= 15) exitWith {
    TRACE_2("immediate destruction - high damage",_newDamage,_currentPartDamage);

    _vehicle call FUNC(knockOut);
    [_vehicle, 1, true, _source, _instigator] call FUNC(handleDetonation);

    // Kill everyone inside for very insane damage
    {
        [QGVAR(medicalDamage), [_x, _source, _instigator, true], _x] call CBA_fnc_targetEvent;
    } forEach (crew _vehicle);

    _vehicle setDamage 1;

    false
};

private _projectileConfig = _projectile call CBA_fnc_getObjectConfig;

private _warheadTypeStr = toLowerANSI getText (_projectileConfig >> "warheadName");
private _warheadType = ["he", "ap", "heat", "tandemheat"] find _warheadTypeStr; // numerical index for warhead type for quicker checks. Numbers defined in script_macros.hpp

private _incendiary = [_projectileConfig >> QGVAR(incendiary), "NUMBER", [0.3, 0.1, 1, 1, 0] select _warheadType] call CBA_fnc_getConfigEntry;

private _hitPointHash = GVAR(vehicleClassesHitPointHash) getOrDefault [typeOf _vehicle, createHashMap];
(_hitPointHash getOrDefault [_hitPoint, []]) params ["_hitArea", "_minDamage"];

private _projectileExplosive = [_projectileConfig >> "explosive", "NUMBER", 0] call CBA_fnc_getConfigEntry;
private _indirectHit = [_projectileConfig >> "indirectHit", "NUMBER", 0] call CBA_fnc_getConfigEntry;

if (_warheadType == WARHEAD_TYPE_AP) then {
    // Change damage based on projectile speed (doesn't do this in vanilla Arma believe it or not)
    if (!isNull _source) then {
        private _airFriction = [_projectileConfig >> "airFriction", "NUMBER", 0] call CBA_fnc_getConfigEntry;
        private _distance = _source distance _vehicle;
        _newDamage = (1 - _projectileExplosive) * _newDamage * exp (_airFriction * _distance);
    };
};

private _penChance = 1;

// newDamage can't be 0, so don't need to worry about 0 division here
if (_newDamage < _minDamage) then {
    _penChance = _newDamage / _minDamage;

    TRACE_5("minimum damage modifying hit",_newDamage,_penChance,_minDamage,_warheadTypeStr,_hitArea);
};

if (_penChance < random 1) exitWith {
    TRACE_1("didn't penetrate",_penChance);

    true
};

if (_minDamage == 0) then {
    _minDamage = 1;
};

if (_warheadType == WARHEAD_TYPE_HE) then {
    private _modifiedIndirectHit = _indirectHit / 100;

    if (_newDamage > _modifiedIndirectHit) then {
        _newDamage = _newDamage / 2;
    };

    _newDamage = (_newDamage * (_newDamage / _modifiedIndirectHit)) min _newDamage;
};

private _ammoEffectiveness = if (_warheadType == WARHEAD_TYPE_AP) then {
    0.15 max _newDamage
} else {
    if (_warheadType == WARHEAD_TYPE_HE) then {
        (_newDamage / (_minDamage + (_indirectHit / 100)) * 0.2)
    } else {
        ((_newDamage / _minDamage) * 0.4) min 1
    };
};

TRACE_4("ammo effectiveness",_ammoEffectiveness,_newDamage,_minDamage,_warheadTypeStr);

_incendiary = _incendiary * _ammoEffectiveness;

private _isCar = _vehicle isKindOf "Car" && {!(_vehicle isKindOf "Wheeled_APC_F")};

if (_isCar) then {
    _ammoEffectiveness = (_ammoEffectiveness * 1.5) min 1;
};

private _currentVehicleAmmo = _vehicle call EFUNC(cookoff,getVehicleAmmo);
private _chanceOfDetonation = 0;
private _explosiveAmmoCount = 0;
private _nonExplosiveAmmoCount = 0;

if ((_currentVehicleAmmo select 0) isNotEqualTo []) then {
    private _magConfig = configFile >> "CfgMagazines";
    private _ammoConfig = configFile >> "CfgAmmo";
    private _countOfExplodableAmmo = 0;

    {
        _x params ["_magazineClassname", "_currentAmmoCount"];

        private _initialAmmoCount = getNumber (_magConfig >> _magazineClassname >> "count");
        _chanceOfDetonation = _chanceOfDetonation + (_currentAmmoCount / _initialAmmoCount);
        _countOfExplodableAmmo = _countOfExplodableAmmo + 1;

        private _ammoClassname = getText (_magConfig >> _magazineClassname >> "ammo");
        private _explosive = getNumber (_ammoConfig >> _ammoClassname >> "explosive");
        private _hit = getNumber (_ammoConfig >> _ammoClassname >> "hit");

        if (_explosive > 0.5 || _hit > 50) then {
            _explosiveAmmoCount = _explosiveAmmoCount + 1;
        } else {
            _nonExplosiveAmmoCount = _nonExplosiveAmmoCount + 1;
        };
    } forEach (_currentVehicleAmmo select 0);

    if (_countOfExplodableAmmo != 0) then {
        _chanceOfDetonation = _chanceOfDetonation / _countOfExplodableAmmo;
    };
};

private _return = true;

switch (_hitArea) do {
    case "engine": {
        private _vehicleConfig = configOf _vehicle;
        private _currentFuel = fuel _vehicle;
        private _chanceToDetonate = ([_vehicleConfig >> QGVAR(engineDetonationProb), "NUMBER", 0] call CBA_fnc_getConfigEntry) * _incendiary * _currentFuel * _penChance;

        TRACE_4("hit engine",_chanceToDetonate,_incendiary,_chanceOfDetonation,_currentFuel);

        if ([_vehicle, _chanceToDetonate, _explosiveAmmoCount > 0, _source, _instigator] call FUNC(handleDetonation)) exitWith {
            _vehicle call FUNC(knockOut)
        };

        // Cap damage at 0.9 to avoid hard coded blow up
        _nextPartDamage = 0.9 min _nextPartDamage;

        // Fatal engine/drive system damage
        if (_nextPartDamage == 0.9 || {0.8 * _ammoEffectiveness > random 1}) then {
            [_vehicle, _hitIndex, _hitPoint, 0.9 * _penChance] call FUNC(addDamage);

            _vehicle setVariable [QGVAR(canMove), false];
        } else {
            [_vehicle, _hitIndex, _hitPoint, _nextPartDamage * _penChance] call FUNC(addDamage);
        };

        // No cookoff for cars
        if (_isCar) exitWith {};

        private _chanceOfFire = ([_vehicleConfig >> QGVAR(engineFireProb), "NUMBER", 0] call CBA_fnc_getConfigEntry) * _incendiary * _currentFuel * _penChance;
        private _cookoffIntensity = 4 * _currentFuel;

        [_vehicle, _chanceOfFire, _cookoffIntensity, _source, _instigator, "engine", false, false] call FUNC(handleCookoff);
    };
    case "hull": {
        private _vehicleConfig = configOf _vehicle;
        private _currentFuel = fuel _vehicle;
        private _chanceToDetonate = ([_vehicleConfig >> QGVAR(hullDetonationProb), "NUMBER", 0] call CBA_fnc_getConfigEntry) * _incendiary * ((_chanceOfDetonation + _currentFuel) / 2) * _penChance;

        TRACE_4("hit hull",_chanceToDetonate,_incendiary,_chanceOfDetonation,_currentFuel);

        if ([_vehicle, _chanceToDetonate, _explosiveAmmoCount > 0, _source, _instigator] call FUNC(handleDetonation)) exitWith {
            [_vehicle, _hitIndex, _hitPoint, 0.89 * _penChance] call FUNC(addDamage);

            _vehicle call FUNC(knockOut)
        };

        // 25% chance of jamming turret - 25% of mobility kill - 25% of both - 75% chance of critical hull damage
        private _rand = random 1;

        TRACE_2("rolling hull damage",_ammoEffectiveness,_rand);

        private _partKill = [];

        if (_ammoEffectiveness > _rand) then {
            _rand = random 1;

            TRACE_2("damaged hull part",_ammoEffectiveness,_rand);

            switch (true) do {
                case (_rand < 0.25): {
                    [_vehicle, _hitIndex, _hitPoint, 0.89 * _penChance] call FUNC(addDamage);

                    // Iterate through all keys and find appropriate turret
                    {
                        if ((_y select 0) == "turret") then {
                            _partKill pushBack _x;
                        };
                    } forEach _hitPointHash;

                    _vehicle setVariable [QGVAR(canShoot), false];
                };
                case (_rand < 0.5): {
                    [_vehicle, _hitIndex, _hitPoint, 0.89 * _penChance] call FUNC(addDamage);

                    _partKill pushBack (ENGINE_HITPOINTS select 0);

                    if !(_vehicle isKindOf "Wheeled_APC_F") then {
                        _partKill pushBack (TRACK_HITPOINTS select 0);
                    };

                    _vehicle setVariable [QGVAR(canMove), false];
                };
                case (_rand < 0.75): {
                    [_vehicle, _hitIndex, _hitPoint, 0.89 * _penChance] call FUNC(addDamage);

                    _partKill pushBack (ENGINE_HITPOINTS select 0);

                    if !(_vehicle isKindOf "Wheeled_APC_F") then {
                        _partKill pushBack (TRACK_HITPOINTS select 0);
                    };

                    // Iterate through all keys and find appropriate turret
                    {
                        if ((_y select 0) == "turret") then {
                            _partKill pushBack _x;
                        };
                    } forEach _hitPointHash;

                    _vehicle setVariable [QGVAR(canMove), false];
                    _vehicle setVariable [QGVAR(canShoot), false];
                };
            };
        };

        {
            [_vehicle, -1, _x, _penChance] call FUNC(addDamage);

            TRACE_1("doing damage to hitpoint",_x);
        } forEach _partKill;

        // No cookoff for cars
        if (_isCar) exitWith {};

        private _chanceOfFire = ([_vehicleConfig >> QGVAR(hullFireProb), "NUMBER", 0] call CBA_fnc_getConfigEntry) * _incendiary * ((_chanceOfDetonation + _currentFuel) / 2) * _penChance;
        private _cookoffIntensity = 1.5 + (_explosiveAmmoCount * _chanceOfFire);

        [_vehicle, _chanceOfFire, _cookoffIntensity, _source, _instigator] call FUNC(handleCookoff);
    };
    case "turret": {
        private _vehicleConfig = configOf _vehicle;
        private _chanceToDetonate = ([_vehicleConfig >> QGVAR(turretDetonationProb), "NUMBER", 0] call CBA_fnc_getConfigEntry) * _incendiary * _chanceOfDetonation * _penChance;

        TRACE_3("hit turret",_chanceToDetonate,_incendiary,_chanceOfDetonation);

        if ([_vehicle, _chanceToDetonate, _explosiveAmmoCount > 0, _source, _instigator] call FUNC(handleDetonation)) exitWith {
            _vehicle call FUNC(knockOut)
        };

        if (0.8 * _ammoEffectiveness > random 1) then {
            TRACE_1("damaged turret",_ammoEffectiveness * 0.8);

            [_vehicle, _hitIndex, _hitPoint, 1 * _penChance] call FUNC(addDamage);

            _vehicle setVariable [QGVAR(canShoot), false];
        };

        // No cookoff for cars
        if (_isCar) exitWith {};

        private _chanceOfFire = ([_vehicleConfig >> QGVAR(turretFireProb), "NUMBER", 0] call CBA_fnc_getConfigEntry) * _incendiary * _chanceOfDetonation * _penChance;
        private _cookoffIntensity = _explosiveAmmoCount * _chanceOfFire;

        [_vehicle, _chanceOfFire, _cookoffIntensity, _source, _instigator] call FUNC(handleCookoff);
    };
    case "gun": {
        TRACE_3("hit gun",_chanceToDetonate,_incendiary,_chanceOfDetonation);

        if (0.8 * _ammoEffectiveness > random 1) then {
            TRACE_1("damaged gun",_ammoEffectiveness * 0.8);

            [_vehicle, _hitIndex, _hitPoint, 1 * _penChance] call FUNC(addDamage);

            _vehicle setVariable [QGVAR(canShoot), false];
        };
    };
    case "track": {
        private _damage = (0.1 max (0.1 * _newDamage / _minDamage)) min 1;

        [_vehicle, _hitIndex, _hitPoint, (_currentPartDamage + _damage) * _penChance] call FUNC(addDamage);

        TRACE_3("damaged track",_damage,_newDamage,_minDamage);

        if ((_vehicle getHitIndex _hitIndex) >= 1) then {
            _vehicle setVariable [QGVAR(canMove), false];
        };
    };
    case "wheel": {
        [_vehicle, _hitIndex, _hitPoint, (_currentPartDamage + _newDamage) * _penChance] call FUNC(addDamage);

        TRACE_1("damaged wheel",_newDamage);
    };
    case "fuel": {
        private _damage = (0.1 max (0.1 * _newDamage / _minDamage)) min 1;
        [_vehicle, _hitIndex, _hitPoint, (_currentPartDamage + _damage) * _penChance] call FUNC(addDamage);

        // No cookoff for cars
        if (_isCar) exitWith {};

        private _currentFuel = fuel _vehicle;
        private _chanceOfFire = (_incendiary * _currentFuel * _penChance) / 2;
        private _cookoffIntensity = _currentFuel * 5;

        TRACE_4("damaged fuel",_chanceOfFire,_incendiary,_cookoffIntensity,_currentFuel);

        [_vehicle, _chanceOfFire, _cookoffIntensity, _source, _instigator, "", false, false] call FUNC(handleCookoff);
    };
    case "slat": {
        TRACE_2("hit slat",_warheadType,_warheadTypeStr);

        // Incredibly small chance of AP destroying SLAT
        if (_warheadType == WARHEAD_TYPE_HEAT || {_warheadType == WARHEAD_TYPE_TANDEM} || {_warheadType == WARHEAD_TYPE_HE} || {0.01 > random 1}) then {
            private _currentDamage = _vehicle getHitIndex _hitIndex;

            TRACE_3("damaged slat",_warheadType,_warheadTypeStr,_currentDamage);

            if (_warheadType == WARHEAD_TYPE_HEAT || {_warheadType == WARHEAD_TYPE_TANDEM}) then {
                [_vehicle, _hitIndex, _hitPoint, 1] call FUNC(addDamage);
            } else {
                [_vehicle, _hitIndex, _hitPoint, _currentDamage + (0.5 max random 1)] call FUNC(addDamage);
            };

            if (_currentDamage < 1 && _warheadType isEqualTo WARHEAD_TYPE_HEAT) then {
                _return = false;
            };
        };
    };
    case "era": {
        TRACE_2("hit era",_warheadType,_warheadTypeStr);

        if (_warheadType == WARHEAD_TYPE_HEAT || {_warheadType == WARHEAD_TYPE_TANDEM} || {0.05 > random 1}) then {
            private _currentDamage = _vehicle getHitIndex _hitIndex;

            TRACE_3("damaged era",_warheadType,_warheadTypeStr,_currentDamage);

            [_vehicle, _hitIndex, _hitPoint, 1] call FUNC(addDamage);

            // Don't process anymore damage if this is HEAT - shouldn't happen anyway but Arma says it does so you know
            if (_currentDamage < 1 && _warheadType == WARHEAD_TYPE_HEAT) then {
                _return = false;
            };
        };
    };
    default {
        TRACE_1("hit unknown hitpoint??",_hitArea);
    };
};

_return
