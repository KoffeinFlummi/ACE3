// #define ENABLE_PERFORMANCE_COUNTERS
#include "script_component.hpp"
// BEGIN_COUNTER(blueForceTrackingUpdate);

private ["_groupsToDrawMarkers", "_playersToDrawMarkers", "_playerSide", "_anyPlayers", "_colour", "_marker"];

// Delete last set of markers (always)
{
    deleteMarkerLocal _x;
} forEach GVAR(BFT_markers);

GVAR(BFT_markers) = [];

if (GVAR(BFT_Enabled) and {(!isNil "ACE_player") and {alive ACE_player}}) then {

    _groupsToDrawMarkers = [];
    _playerSide = call CFUNC(playerSide);

    _groupsToDrawMarkers = allGroups select {side _x == _playerSide};

    if (GVAR(BFT_HideAiGroups)) then {
        _groupsToDrawMarkers = _groupsToDrawMarkers select {
            {
                _x call CFUNC(isPlayer);
            } count units _x > 0;
        };
    };

    if (GVAR(BFT_ShowPlayerNames)) then {
        _playersToDrawMarkers = allPlayers select {side _x == _playerSide};

        {
            private _markerType = [_x] call CFUNC(getMarkerType);
            private _colour = format ["Color%1", side _x];

            private _marker = createMarkerLocal [format ["ACE_BFT_%1", _forEachIndex], [(getPos _x) select 0, (getPos _x) select 1]];
            _marker setMarkerTypeLocal _markerType;
            _marker setMarkerColorLocal _colour;
            _marker setMarkerTextLocal (name _x);

            GVAR(BFT_markers) pushBack _marker;
        } forEach _playersToDrawMarkers;

        _groupsToDrawMarkers = _groupsToDrawMarkers select {
            {
                !(_x call CFUNC(isPlayer));
            } count units _x > 0;
        };
    };

    {
        private _markerType = [_x] call CFUNC(getMarkerType);
        private _colour = format ["Color%1", side _x];

        private _marker = createMarkerLocal [format ["ACE_BFT_%1", _forEachIndex], [(getPos leader _x) select 0, (getPos leader _x) select 1]];
        _marker setMarkerTypeLocal _markerType;
        _marker setMarkerColorLocal _colour;
        _marker setMarkerTextLocal (groupId _x);

        GVAR(BFT_markers) pushBack _marker;
    } forEach _groupsToDrawMarkers;
};

// END_COUNTER(blueForceTrackingUpdate);
