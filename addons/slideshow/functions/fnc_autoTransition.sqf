#include "script_component.hpp"
/*
 * Author: Jonpas
 * Handles automatic slide transitions using waitAndExecute in a PFH-like manner resulting in no performance loss.
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: Image Paths <ARRAY>
 * 2: State Variable Name <ARRAY>
 * 3: Current Slideshow <NUMBER>
 * 4: Duration <NUMBER> (0 disables automatic transitions)
 *
 * Return Value:
 * None
 *
 * Example:
 * [objects, images, "ace_slideshow_slideshow1", duration] call ace_slideshow_fnc_autoTransition
 *
 * Public: No
 */

params ["_objects", "_images", "_varString", "_currentSlideshow", "_duration"];

// Get current slide number of this slideshow
private _currentSlide = missionNamespace getVariable [_varString, 0];

// Increment slide or return to first slide if reached end
_currentSlide = (_currentSlide + 1) mod (count _images);

// Save slide back into global variable (PFH's local variables do not persist through PFH run)
missionNamespace setVariable [_varString, _currentSlide];

// Set slide
{
    _x setObjectTextureGlobal [0, _images select _currentSlide];
} count _objects;

//Raise event upon slide change
[QGVAR(slideChanged), [_images select _currentSlide, _currentSlideshow]] call CBA_fnc_localEvent;

// Log current slide and execute Next slide
TRACE_4("Auto-transition",_images select _currentSlide,_currentSlide,count _images,_duration);
[FUNC(autoTransition), [_objects, _images, _varString, _currentSlideshow, _duration], _duration] call CBA_fnc_waitAndExecute;
