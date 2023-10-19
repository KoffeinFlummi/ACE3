#include "script_component.hpp"

GVAR(armComponents) = [
    "leftshoulder",
    "rightshoulder",
    "lefthand",
    "leftforearm",
    "leftarmroll",
    "rightforearm",
    "rightarmroll",
    "righthand",
    "rightarm"
];

["ace_firedNonPlayer", {
    params ["", "", "", "", "", "", "_projectile"];
    private _willDropGun = (random 1) > GVAR(weaponDropChanceGunHit);
    private _willDropArm = (random 1) > GVAR(weaponDropChanceArmHit);
    if (!(_willDropGun && _willDropArm)) exitWith {};
    _projectile addEventHandler ["HitPart", { 
        params ["_projectile", "_hitEntity", "_projectileOwner", "_pos", "_velocity", "_normal", "_components", "_radius" ,"_surfaceType"];
        [_surfaceType, _components, _pos] call FUNC(checkWeaponDrop);
    }];
}] call CBA_fnc_addEventHandler;

["ace_firedPlayer", {
    params ["", "", "", "", "", "", "_projectile"];
    private _willDropGun = (random 1) > GVAR(weaponDropChanceGunHit);
    private _willDropArm = (random 1) > GVAR(weaponDropChanceArmHit);
    if (!(_willDropGun && _willDropArm)) exitWith {};
    _projectile addEventHandler ["HitPart", { 
        params ["_projectile", "_hitEntity", "_projectileOwner", "_pos", "_velocity", "_normal", "_components", "_radius" ,"_surfaceType"];
        [_surfaceType, _components, _pos] call FUNC(checkWeaponDrop);
    }];
}] call CBA_fnc_addEventHandler;
