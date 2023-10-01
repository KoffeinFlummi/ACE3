class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_MapGpsShow {
                displayName = CSTRING(MapGpsShow);
                condition = QUOTE((!GVAR(mapGpsShow)) && {call FUNC(canUseMapGPS)});
                statement = QUOTE(GVAR(mapGpsShow) = true;);
                exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                showDisabled = 0;
            };
            class ACE_MapGpsHide {
                displayName = CSTRING(MapGpsHide);
                condition = QUOTE((GVAR(mapGpsShow)) && {call FUNC(canUseMapGPS)});
                statement = QUOTE(GVAR(mapGpsShow) = false;);
                exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                showDisabled = 0;
            };
            class ACE_MapTools {
                displayName = CSTRING(MapTools_Menu);
                condition = QUOTE(call FUNC(canUseMapTools));
                statement = "";
                exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                showDisabled = 0;
                class ACE_MapToolsHide {
                    displayName = CSTRING(MapToolsHide);
                    condition = QUOTE(GVAR(mapTool_Shown) != 0);
                    statement = QUOTE(GVAR(mapTool_Shown) = 0;);
                    exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                    showDisabled = 1;
                };
                class ACE_MapToolsShowNormal {
                    displayName = CSTRING(MapToolsShowNormal);
                    condition = QUOTE(GVAR(mapTool_Shown) != 1);
                    statement = QUOTE(if (GVAR(mapTool_Shown) == 0) then {GVAR(mapTool_moveToMouse) = true}; GVAR(mapTool_Shown) = 1;);
                    exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                    showDisabled = 1;
                };
                class ACE_MapToolsShowSmall {
                    displayName = CSTRING(MapToolsShowSmall);
                    condition = QUOTE(GVAR(mapTool_Shown) != 2);
                    statement = QUOTE(if (GVAR(mapTool_Shown) == 0) then {GVAR(mapTool_moveToMouse) = true}; GVAR(mapTool_Shown) = 2;);
                    exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                    showDisabled = 1;
                };
                class ACE_MapToolsAlign {
                    displayName = CSTRING(AlignTo);
                    condition = QUOTE(GVAR(mapTool_Shown) != 0);
                    statement = "";
                    exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                    showDisabled = 0;
                    class ACE_MapToolsAlignToPlottingBoardRuler {
                        displayName = CSTRING(ToPlottingBoardRulerLabel);
                        condition = QUOTE(GVAR(mapTool_Shown != 0) && GVAR(plottingBoard_Shown == 2));
                        statement = QUOTE(GVAR(mapTool_angle) = GVAR(plottingBoard_rulerAngle));
                        exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                        showDisabled = 1;
                    };
                    class ACE_MapToolsAlignToPlottingBoardAcrylic {
                        displayName = CSTRING(ToPlottingBoardAcrylicLabel);
                        condition = QUOTE(GVAR(mapTool_Shown != 0) && GVAR(plottingBoard_Shown != 0));
                        statement = QUOTE(GVAR(mapTool_angle) = GVAR(plottingBoard_acrylicAngle));
                        exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                        showDisabled = 1;
                    };
                    class ACE_MapToolsAlignToPlottingBoard {
                        displayName = CSTRING(ToPlottingBoardLabel);
                        condition = QUOTE(GVAR(mapTool_Shown != 0) && GVAR(plottingBoard_Shown != 0));
                        statement = QUOTE(GVAR(mapTool_angle) = GVAR(plottingBoard_angle));
                        exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                        showDisabled = 1;
                    };
                    class ACE_MapToolsAlignCompass {
                        displayName = CSTRING(ToCompassLabel);
                        condition = QUOTE(GVAR(mapTool_Shown) != 0 && {getUnitLoadout ACE_player param [ARR_2(9, [])] param [ARR_2(3, '')] != ''});
                        statement = QUOTE(GVAR(mapTool_angle) = getDir ACE_player;);
                        exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                        showDisabled = 1;
                    };
                    class ACE_MapToolsAlignNorth {
                        displayName = CSTRING(ToNorthLabel);
                        condition = QUOTE(GVAR(mapTool_Shown) != 0);
                        statement = QUOTE(GVAR(mapTool_angle) = 0;);
                        exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                        showDisabled = 1;
                    };
                };
            };
            class ACE_PlottingBoard {
                displayName = CSTRING(ShowPlottingBoard);
                condition = QUOTE(call FUNC(canUsePlottingBoard) && GVAR(plottingBoard_Shown) < 1);
                statement = QUOTE(GVAR(plottingBoard_Shown) = 1;);
                exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                showDisabled = 0;
            };                
            class ACE_PlottingBoardHide {
                displayName = CSTRING(HidePlottingBoard);
                condition = QUOTE(call FUNC(canUsePlottingBoard) && GVAR(plottingBoard_Shown) != 0);
                statement = QUOTE(GVAR(plottingBoard_Shown) = 0;);
                exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                showDisabled = 0;
                class ACE_PlottingBoardAlign {
                    displayName = CSTRING(AlignTo);
                    condition = QUOTE(GVAR(plottingBoard_Shown) > 0);
                    statement = "";
                    exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                    showDisabled = 0;
                    class ACE_PlottingBoardAlignBoard {
                        displayName = CSTRING(PlottingBoardLabel);
                        condition = QUOTE(GVAR(plottingBoard_Shown) > 0);
                        statement = "";
                        exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        class ACE_PlottingBoardAlignBoardMaptool {
                            displayName = CSTRING(Name);
                            condition = QUOTE(GVAR(plottingBoard_Shown) > 0 && GVAR(mapTool_Shown) > 0 && GVAR(plottingBoard_angle) != GVAR(mapTool_angle));
                            statement = QUOTE(GVAR(plottingBoard_angle) = GVAR(mapTool_angle));
                            exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                            showDisabled = 0;
                        };
                        class ACE_PlottingBoardAlignBoardUp {
                            displayName = CSTRING(ToUpLabel);
                            condition = QUOTE(GVAR(plottingBoard_angle) != 0);
                            statement = QUOTE(GVAR(plottingBoard_angle) = 0);
                            exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                            showDisabled = 0;
                        };
                    };
                    class ACE_PlottingBoardAlignAcrylic {
                        displayName = CSTRING(PlottingBoardAcrylicLabel);
                        condition = QUOTE(GVAR(plottingBoard_Shown) > 0);
                        statement = "";
                        exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        class ACE_PlottingBoardAlignAcrylicMaptool {
                            displayName = CSTRING(Name);
                            condition = QUOTE(GVAR(plottingBoard_Shown) > 0 && GVAR(mapTool_Shown) > 0 && GVAR(plottingBoard_acrylicAngle) != GVAR(mapTool_angle));
                            statement = QUOTE(GVAR(plottingBoard_acrylicAngle) = GVAR(mapTool_angle));
                            exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                            showDisabled = 0;
                        };
                        class ACE_PlottingBoardAlignAcrylicUp {
                            displayName = CSTRING(ToUpLabel);
                            condition = QUOTE(GVAR(plottingBoard_acrylicAngle) != 0);
                            statement = QUOTE(GVAR(plottingBoard_acrylicAngle) = 0);
                            exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                            showDisabled = 0;
                        };
                    };
                    class ACE_PlottingBoardAlignRuler {
                        displayName = CSTRING(PlottingBoardRulerLabel);
                        condition = QUOTE(GVAR(plottingBoard_Shown) == 2);
                        statement = "";
                        exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        class ACE_PlottingBoardAlignRulerMaptool {
                            displayName = CSTRING(Name);
                            condition = QUOTE(GVAR(plottingBoard_Shown) == 2 && GVAR(mapTool_Shown) > 0);
                            statement = QUOTE(GVAR(plottingBoard_rulerAngle) = GVAR(mapTool_angle));
                            exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                            showDisabled = 0;
                        };
                        class ACE_PlottingBoardAlignRulerUp {
                            displayName = CSTRING(ToUpLabel);
                            condition = QUOTE(GVAR(plottingBoard_Shown) == 2 && GVAR(plottingBoard_rulerAngle != 0) && GVAR(plottingBoard_rulerAngle) != GVAR(mapTool_angle));
                            statement = QUOTE(GVAR(plottingBoard_rulerAngle) = 0);
                            exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                            showDisabled = 0;
                        };
                    };
                };
                class ACE_PlottingBoardRulerShow {
                    displayName = CSTRING(TogglePlottingBoardRuler);
                    condition = QUOTE(GVAR(plottingBoard_Shown) == 1);
                    statement = QUOTE(GVAR(plottingBoard_Shown) = 2;);
                    exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                    showDisabled = 1;
                };
                class ACE_PlottingBoardRulerHide {
                    displayName = CSTRING(TogglePlottingBoardRuler);
                    condition = QUOTE(GVAR(plottingBoard_Shown) == 2);
                    statement = QUOTE(GVAR(plottingBoard_Shown) = 1;);
                    exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                    showDisabled = 1;
                };
                class ACE_PlottingBoardWipe {
                    displayName = CSTRING(WipeBoard);
                    condition = QUOTE(count GVAR(plottingBoard_markers) > 0);
                    statement = QUOTE(call FUNC(wipeMarkers));
                    exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                    showDisabled = 1;
                };
            };
        };
    };

    class NATO_Box_Base;
    class EAST_Box_Base;
    class IND_Box_Base;
    class FIA_Box_Base_F;

    class Box_NATO_Support_F: NATO_Box_Base {
        class TransportItems {
            MACRO_ADDITEM(ACE_MapTools,12);
        };
    };

    class Box_East_Support_F: EAST_Box_Base {
        class TransportItems {
            MACRO_ADDITEM(ACE_MapTools,12);
        };
    };

    class Box_IND_Support_F: IND_Box_Base {
        class TransportItems {
            MACRO_ADDITEM(ACE_MapTools,12);
        };
    };

    class Box_FIA_Support_F: FIA_Box_Base_F {
        class TransportItems {
            MACRO_ADDITEM(ACE_MapTools,12);
        };
    };

    class ACE_Box_Misc: Box_NATO_Support_F {
        class TransportItems {
            MACRO_ADDITEM(ACE_MapTools,12);
        };
    };
};
