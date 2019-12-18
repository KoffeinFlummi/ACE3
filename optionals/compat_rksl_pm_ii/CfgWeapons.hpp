
class CfgWeapons {
    class ItemCore;
    class InventoryOpticsItem_Base_F;

    class RKSL_optic_PMII_312: ItemCore { // https://www.schmidtundbender.de/en/products/police-military-forces/3-12x50-pm-ii.html
        ACE_ScopeHeightAboveRail = 4.2235;
        ACE_ScopeAdjust_Vertical[] = {0, 13}; // Single Turn
        ACE_ScopeAdjust_Horizontal[] = {-6, 6};
        ACE_ScopeAdjust_VerticalIncrement = 0.1;
        ACE_ScopeAdjust_HorizontalIncrement = 0.1;
        class ItemInfo: InventoryOpticsItem_Base_F {
            class OpticsModes {
                class Snip {
                    discreteDistance[] = {100}; // default RKSL {100,...,1500}
                    discreteDistanceInitIndex = 0;
                    distanceZoomMax = 1500; // default RKSL 100
                    distanceZoomMin = 100; // default RKSL
                };
            };
        };
    };

    class RKSL_optic_PMII_312_sunshade: RKSL_optic_PMII_312 {
        class ItemInfo: ItemInfo { // default RKSL InventoryOpticsItem_Base_F
            class OpticsModes {
                class Snip {
                    cameraDir = "";
                    discreteDistance[] = {100};
                    discreteDistanceInitIndex = 0;
                    distanceZoomMax = 1500;
                    distanceZoomMin = 100;
                    memoryPointCamera = "opticView";
                    opticsDisablePeripherialVision = 1;
                    opticsDisplayName = "WFOV";
                    opticsFlare = 1;
                    opticsID = 1;
                    opticsPPEffects[] = {"OpticsCHAbera1","OpticsBlur1"};
                    opticsZoomInit = "(0.25/3)";
                    opticsZoomMax = "(0.25/3)";
                    opticsZoomMin = "(0.25/12)";
                    useModelOptics = 1;
                    visionMode[] = {"Normal"};
                };
                class RMR {
                    cameraDir = "";
                    distanceZoomMax = 100;
                    distanceZoomMin = 100;
                    memoryPointCamera = "eye";
                    opticsDisablePeripherialVision = 0;
                    opticsFlare = 0;
                    opticsID = 2;
                    opticsPPEffects[] = {};
                    opticsZoomInit = 0.75;
                    opticsZoomMax = 1.25;
                    opticsZoomMin = 0.25;
                    useModelOptics = 0;
                    visionMode[] = {};
                };
            };
        };
    };

    class RKSL_optic_PMII_525: ItemCore { // https://www.schmidtundbender.de/en/products/police-military-forces/5-25x56-pm-iilp.html
        ACE_ScopeHeightAboveRail = 4.2235;
        ACE_ScopeAdjust_Vertical[] = {0, 26};
        ACE_ScopeAdjust_Horizontal[] = {-6, 6};
        ACE_ScopeAdjust_VerticalIncrement = 0.1;
        ACE_ScopeAdjust_HorizontalIncrement = 0.1;
        class ItemInfo: InventoryOpticsItem_Base_F {
            class OpticsModes {
                class Snip {
                    discreteDistance[] = {100}; // default RKSL {300,...,2500}
                    discreteDistanceInitIndex = 0;
                    distanceZoomMax = 2500; // default RKSL 300
                    distanceZoomMin = 300; // default RKSL
                };
            };
        };
    };
};
