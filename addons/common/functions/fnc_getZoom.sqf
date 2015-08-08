/*
 * Author: commy2
 *
 * Returns a value depending on current zoom level.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Zoom (Number)
 */
#include "script_component.hpp"

(0.5 - ((worldToScreen positionCameraToWorld [0,1,1]) select 1)) * (getResolution select 5)
