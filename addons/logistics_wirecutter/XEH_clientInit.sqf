#include "script_component.hpp"

if (!hasInterface) exitWith {};

["interactMenuOpened", {_this call FUNC(interactEH)}] call CFUNC(addEventHandler);
