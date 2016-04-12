#include "script_component.hpp"

["medical_onUnconscious", {_this call FUNC(handleUnconscious)}] call CFUNC(addEventHandler);

if (isServer) then {
    addMissionEventHandler ["HandleDisconnect", {_this call FUNC(handleDisconnect)}];
};

[QGVAR(resetLocal), {
    _this call FUNC(resetLocal);
}] call CFUNC(addEventHandler);
