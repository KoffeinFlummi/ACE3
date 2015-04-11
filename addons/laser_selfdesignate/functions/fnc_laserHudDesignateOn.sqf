//#define DEBUG_MODE_FULL
#include "script_component.hpp"

TRACE_1("enter", _this);

#define FCS_UPDATE_DELAY 1

FUNC(laserHudDesignatePFH) = {
    private["_strongestResultPos", "_args", "_laserTarget", "_shooter", "_vehicle", "_weapon", "_gunnerInfo", "_turret", "_pov", "_gunBeg", "_gunEnd", "_povPos", "_povDir", "_result", "_resultPositions", "_firstResult", "_forceUpdateTime"];
    _args = _this select 0;
    _laserTarget = _args select 0;
    _shooter = _args select 1;

    TRACE_1("", _args, (_laserTarget getVariable["ACE_LASER_CODE"]));
    
    if((vehicle ACE_player) != _shooter || !alive _shooter || isNull _vehicle || isNull _laserTarget || !GVAR(active) ) exitWith { 
        [_vehicle, _shooter, _laserTarget] call FUNC(laserHudDesignateOff);
    };
    if(!([_shooter] call FUNC(unitTurretHasDesignator)) ) exitWith {
        [_vehicle, _shooter, _laserTarget] call FUNC(laserHudDesignateOff);
    };
   
    if( (count _args) < 3) then {
        _args set[2, diag_tickTime + FCS_UPDATE_DELAY];
    };
    _forceUpdateTime = _args select 2;
    
    _vehicle = vehicle _shooter;
    _weapon = currentWeapon _vehicle;
    
    // Retrieve the gunner and turret memory point information
    _gunnerInfo = [_vehicle, _weapon] call CBA_fnc_getFirer;
    _turretInfo = [_vehicle, _gunnerInfo select 1] call EFUNC(common,getTurretDirection);
    _povPos = _turretInfo select 0;
    _povDir = _turretInfo select 1;
    
    _targetInfo = _vehicle getVariable[QGVAR(currentTarget), [] ];
    if( (count _targetInfo) > 0) then {
        if(_laserTarget != (_targetInfo select 0) ) then {
            _targetInfo = []
        };
    };
    if( (count _targetInfo) < 1) then {
        _targetInfo = [_laserTarget, 1001]; // TODO: set laser code
        _vehicle setVariable[QGVAR(currentTarget), _targetInfo, true];
        _laserTarget setVariable[QGVAR(owner), _vehicle, true];
    };
    
    
    _result = [_povPos, _povDir] call EFUNC(laser,shootCone);
    if((count _result) > 0) then {
        _resultPositions = _result select 2;

        if((count _resultPositions) > 0) then {
            _strongestResultPos = [_resultPositions, _povPos] call EFUNC(laser,findStrongestRay);
            
            // If the laser has moved less than a half meter, then dont move it.
            // Just regular use of lasers will commonly make them move this much,
            // but not across multiple close frames.
            // This loses accuracy a little, but saves position updates per frame.
            TRACE_5("", diag_tickTime, _forceUpdateTime, getPosASL _laserTarget, _strongestResultPos, ((getPosASL _laserTarget) distance _pos));
    
            if(diag_tickTime > _forceUpdateTime) then {
                TRACE_1("FCS Update", "");
                ["ace_fcs_forceUpdate", []] call ace_common_fnc_localEvent;
            };
            
            //if( (_laserTarget distance _strongestResultPos) > 0.1) then {
                TRACE_1("LaserPos Update", "");
                _laserTarget setPosATL (ASLToATL _strongestResultPos);
            //};
            
            if(diag_tickTime > _forceUpdateTime) then {
                 _args set[2, diag_tickTime + FCS_UPDATE_DELAY];
            };
#ifdef DEBUG_MODE_FULL
            drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", [1,0,0,1], (getPosATL _laserTarget), 0.75, 0.75, 0, "", 0.5, 0.025, "TahomaB"];
            
            {
                private["_position"];
                _position = _x select 0;
                drawLine3d [ASLToATL _povPos, ASLToATL _position, [0,0,1,1] ];
            } forEach _resultPositions;
#endif
        };
    };
    
    _this set[0, _args];
};

private ["_laserTarget", "_handle", "_vehicle"];

if(isNil QGVAR(laser)) then {
    _laserTarget = "LaserTargetW" createVehicle (getpos ACE_player);
    
    GVAR(active) = true;
    
    _handle = [FUNC(laserHudDesignatePFH), 0.1, [_laserTarget, ACE_player]] call cba_fnc_addPerFrameHandler;
    _laserTarget setVariable ["ACE_PFH_HANDLE", _handle, false];
    
    // Clear the vehicle parameters
    _vehicle setVariable[QGVAR(currentTarget), [], true];
    
    GVAR(laser) = _laserTarget;
} else {
    [] call FUNC(laserHudDesignateOff);
    [] call FUNC(laserHudDesignateOn);
};

