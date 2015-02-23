#include "script_component.hpp"

PARAMS_1(_unit);

if (ACE_player != _unit) exitWith {};

_unit setVariable [QGVAR(sharingMapHost), _unit, true];
GVAR(MapMouseWorldPos) = [];
GVAR(MapLeftMouseButtonIsDown) = false;

systemChat "Debug: Starting Sharing";

[{
    EXPLODE_2_PVT(_this,_params,_pfhId);
    EXPLODE_5_PVT(_params,_unit,_target,_syncedUnits,_syncedMarkers,_nextMarkerSync);

    if ((ACE_player != _unit) || {!([_unit, _target] call FUNC(canShareMap))}) exitWith {
        _unit setVariable [QGVAR(sharingMapHost), objNull, true];
        [_pfhId] call CBA_fnc_removePerFrameHandler;
        systemChat "Debug: Ending Sharing";
    };

    if (time > _nextMarkerSync) then {
        //This is cpu and bandwith intensive, dont' run too often
        _params set [4, (time + 1)];
        
        _nearUnits = if ((vehicle ACE_player) == ACE_player) then {
            ACE_player nearEntities ["CAManBase", 5];
        } else {
            crew (vehicle ACE_player);
        };
        
        _clientUnits = [_nearUnits, {(_this != ACE_player) && {ACE_player == (_this getVariable [QGVAR(sharingMapHost), objNull])}}] call EFUNC(common,filter);
        if ((count _clientUnits) > 0) then {

            //Send our current map's position and zoom
            _mapCenterPos = ((findDisplay 12) displayctrl 51) ctrlMapScreenToWorld [0.5, 0.5];
            _mapScale = ctrlMapScale ((findDisplay 12) displayctrl 51);
            ACE_player setVariable [QGVAR(sharingMapPosition), [_mapScale, _mapCenterPos], true];

            _currentMarkers = [] call FUNC(serializeLocalMarkers);

            //New Clients or Markers have changed
            if ((!(_clientUnits isEqualTo _syncedUnits)) || {!(_currentMarkers isEqualTo _syncedMarkers)}) then {
                systemChat format ["Debug: Sending %2 markers to %1", _clientUnits, (count _currentMarkers)];
                ["ShareMap_RecieveMarkers", _clientUnits, [_unit, _currentMarkers]] call EFUNC(common,targetEvent);

                _params set [2, _clientUnits];
                _params set [3, _currentMarkers];
            };
        } else {
            _params set [2, _clientUnits];
        };
    };

}, 0, [_unit, _target, [], [], -1]] call CBA_fnc_addPerFrameHandler;
