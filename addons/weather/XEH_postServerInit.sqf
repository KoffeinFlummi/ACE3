#include "script_component.hpp"

["ace_settingsInitialized", {
    if (!GVAR(enabled)) exitWith {};

    // Temperature and humidity randomization
    GVAR(temperatureShift) = random [-5, 0, 5];
    GVAR(badWeatherShift) = random [10, 0, 10];
    GVAR(humidityShift) = random [-0.1, 0, 0.1];

    // Wind
    call FUNC(initWind);

    [FUNC(updateWind), 1] call CBA_fnc_addPerFrameHandler;

    [FUNC(updateServerWeather), GVAR(updateInterval)] call CBA_fnc_addPerFrameHandler;

}] call CBA_fnc_addEventHandler;
