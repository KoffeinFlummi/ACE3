// by commy2
#include "script_component.hpp"

terminate (missionNamespace getVariable [QGVAR(waitForAnimationHandle), scriptNull]);

GVAR(waitForAnimationHandle) = _this spawn {
	waitUntil {!([_this select 0] call FUNC(inTransitionAnim))};

	_this call FUNC(doAnimation);
};
