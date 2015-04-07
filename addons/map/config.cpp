#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_common", "ace_interaction"};
        author[] = {"KoffeinFlummi","Rocko","esteldunedain"};
        authorUrl = "https://github.com/KoffeinFlummi/";
        VERSION_CONFIG;
    };
};

class RscControlsGroup;
class RscActiveText;
class RscPicture;
class RscText;
class RscObject;
class RscButton;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscButtonMenu;
class RscEdit;

class ACE_Settings {
    class GVAR(BFT_Interval) {
        value = 1.0;
        typeName = "SCALAR";
    };
    class GVAR(BFT_Enabled) {
        value = 0;
        typeName = "BOOL";
    };
    class GVAR(BFT_HideAiGroups) {
        value = 0;
        typeName = "BOOL";
    };
    class GVAR(mapIllumination) {
        value = 1;
        typeName = "BOOL";
    };
    class GVAR(mapShake) {
        value = 1;
        typeName = "BOOL";
    };
    class GVAR(mapLimitZoom) {
        value = 0;
        typeName = "BOOL";
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgMarkers.hpp"
#include "CfgVehicles.hpp"
#include "CfgWorlds.hpp"

class RscMapControl {
    maxSatelliteAlpha = 0.5;

    // From Arma 2
    colorTracks[] = {1.0,0.0,0.0,1};
    colorTracksFill[] = {1.0,1.0,0.0,1};
    colorRoads[] = {0.0,0.0,0.0,1};
    colorRoadsFill[] = {1,1,0,1};
    colorMainRoads[] = {0.0,0.0,0.0,1};
    colorMainRoadsFill[] = {1,0.6,0.4,1};
    colorRailWay[] = {0.8,0.2,0,1};

    // From ACE2
    colorBackground[] = {0.929412, 0.929412, 0.929412, 1.0};
    colorOutside[] = {0.929412, 0.929412, 0.929412, 1.0};
    colorCountlines[] = {0.647059, 0.533333, 0.286275, 1};
    colorMainCountlines[] = {0.858824, 0, 0,1};
    colorForest[] = {0.6, 0.8, 0.2, 0.25};
    colorLevels[] = {0.0, 0.0, 0.0, 1.0};
    colorRocks[] = {0.50, 0.50, 0.50, 0.50};

    sizeExLevel = 0.03;
    showCountourInterval = 1; // refs #13673

    sizeExGrid = 0.032;
};

// REGULAR MAP
class RscDisplayMainMap {
    // Tweak map styling
    class controlsBackground {
        class CA_Map : RscMapControl {
            #include "MapTweaks.hpp"
        };
    };
    // get rid of the "center to player position" - button (as it works even on elite)
    class controls {
        class TopRight: RscControlsGroup {
            #include "MapControls.hpp"
        };
    };
    // scale up the compass
    class objects {
        class Compass: RscObject {
            scale = 0.7;
            zoomDuration = 0;
        };
    };
};

// DIARY
class RscDisplayDiary {
    // get rid of the "center to player position" - button (as it works even on elite)
    class controls {
        class TopRight: RscControlsGroup {
            class controls {
                class ButtonPlayer: RscActiveText {
                    text = "";
                    w = 0;
                    h = 0;
                    sizeEx = 0;
                    onButtonClick = "";
                };
                class CA_PlayerName: RscText {
                    x = "2 *    ( ((safezoneW / safezoneH) min 1.2) / 40)";
                };
                class ProfilePicture: RscPicture {
                    x = "13.5 * ( ((safezoneW / safezoneH) min 1.2) / 40)";
                };
                class ProfileBackground: RscText {
                    x = "13.3 * ( ((safezoneW / safezoneH) min 1.2) / 40)";
                };
                class Separator1: RscPicture {
                    x = "14.5 * ( ((safezoneW / safezoneH) min 1.2) / 40)";
                };
            };
        };
    };
    // scale up the compass
    class objects {
        class Compass: RscObject {
            scale = 0.7;
            zoomDuration = 0;
        };
    };
};

// BRIEFING SCREEN
class RscDisplayGetReady: RscDisplayMainMap {
    // get rid of the "center to player position" - button (as it works even on elite)
    class controls {
        class TopRight: RscControlsGroup {
            #include "MapControls.hpp"
        };
    };
    // scale up the compass
    class objects {
        class Compass: RscObject {
            scale = 0.7;
            zoomDuration = 0;
        };
    };
};
class RscDisplayClientGetReady: RscDisplayGetReady {
    // get rid of the "center to player position" - button (as it works even on elite)
    class controls {
        class TopRight: RscControlsGroup {
            #include "MapControls.hpp"
        };
    };
    // scale up the compass
    class objects {
        class Compass: RscObject {
            scale = 0.7;
            zoomDuration = 0;
        };
    };
};
class RscDisplayServerGetReady: RscDisplayGetReady {
    // get rid of the "center to player position" - button (as it works even on elite)
    class controls {
        class TopRight: RscControlsGroup {
            #include "MapControls.hpp"
        };
    };
    // scale up the compass
    class objects {
        class Compass: RscObject {
            scale = 0.7;
            zoomDuration = 0;
        };
    };
};
