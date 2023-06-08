class ACE_BFT {
    /*
     * To add a device to a vehicle reference the device class name on the vehicle
     * EGVAR(bft,vehicleDevice) = "GroundVehicle_b";
     */
    class Devices {
        // Personal Devices
        class MicroDAGR_b {
            deviceSide = "WEST";
            refreshRate[] = {5,2};
            reportingModes[] = {"GroupOnly"};
            defaultInformation[] = {"Inf", 0, "", 0};
            interface = "MicroDAGR";
        };
        class MicroDAGR_o: MicroDAGR_b {
            deviceSide = "EAST";
        };
        class MicroDAGR_i: MicroDAGR_b {
            deviceSide = "IND";
        };

        // Ground Vehicle
        class GroundVehicle_b {
            deviceSide = "WEST";
            refreshRate[] = {3,2};
            reportingModes[] = {"FBCB2"};
            defaultInformation[] = {"Motorized", 0, "", 0};
            icon = PATHTOF(UI\icon_bft_JV5.paa);
        };
        class GroundVehicle_o: GroundVehicle_b {
            deviceSide = "EAST";
        };
        class GroundVehicle_i: GroundVehicle_b {
            deviceSide = "IND";
        };

        // Naval
        class Naval_b: GroundVehicle_b {
            defaultInformation[] = {"Naval", 0, "", 0};
        };
        class Naval_o: Naval_b {
            deviceSide = "EAST";
        };
        class Naval_i: Naval_b {
            deviceSide = "IND";
        };

        // Aircraft
        class Aircraft_b {
            deviceSide = "WEST";
            reportingModes[] = {"MFD"};
            refreshRate[] = {0.5,0.5};
            defaultInformation[] = {"Helicopter", 0, "", 0};
            icon = PATHTOF(UI\icon_bft_TAD.paa);
        };
        class Aircraft_o: Aircraft_b {
            deviceSide = "EAST";
        };
        class Aircraft_i: Aircraft_b {
            deviceSide = "IND";
        };

        // UAV
        class UAV_b {
            deviceSide = "WEST";
            reportingModes[] = {"UAV"};
            refreshRate[] = {0.5,-1};
            defaultInformation[] = {"UAV", 0, "", 0};
        };
        class UAV_o: UAV_b {
            deviceSide = "EAST";
        };
        class UAV_i: UAV_b {
            deviceSide = "IND";
        };

        // UGV
        class UGV_b: UAV_b {
            refreshRate[] = {5,-1};
        };
        class UGV_o: UGV_b {
            deviceSide = "EAST";
        };
        class UGV_i: UGV_b {
            deviceSide = "IND";
        };
    };

    /*
     * To add an interface to a vehicle reference the interface class name on the vehicle
     * EGVAR(bft,vehicleInterfaces)[] = {"JV5"};
     * A vehicle can have multiple interfaces available, just add them to the list
     *
     * The above will make the interface "JV5" available to all positions within that vehicle.
     * To limit the positions that the interface will be available for, encapsulate the interface
     * config name in an array and add a whereAvailable array as the second array item
     * EGVAR(bft,vehicleInterfaces)[] = {"JV5",{"TAD",{whereAvailable}}}
     * In the exacmple above, "JV5" will be available everywhere, but "TAD" is limited to certain
     * positions on that vehicle defined by whereAvailable.
     *
     * Here is how whereAvailable works
     * To define avialability for driver, all turret positions (excluding cargo-turrets) and
     * cargo positions with cargoIndex 0 and 1:
     * {"Driver","Turret",{"Cargo",{0,1}}}
     *
     * Here are some common settings for whereAvailable
     * To define pilot and co-pilot for most helicopters:
     * {"Driver",{"Turret",{0}}}
     * To define all the crew-members of an APC, but exclude passengers:
     * {"Driver","Turret"}
     * To define the driver and and passenger sitting next to him for a truck:
     * {"Driver",{"Cargo",{0}}}
     */
    class Interfaces {
        class MicroDAGR {
            displayName = QGVAR(GD300_dsp);
            dialogName = QEGVAR(bft_device_gd300,GD300_dlg);
            backgroundDay = "";//QUOTE(PATHTOF(UI\images\MicroDAGR_background_ca.paa));
            backgroundNight = "";//QUOTE(PATHTOF(UI\images\MicroDAGR_background_night_ca.paa));

            class InterfaceSettings {
                dlgIfPosition[] = {};
                dspIfPosition = "false";
                mapWorldPos[] = {};
                showIconText = "true";
                mapScaleDsp = 0.4;
                mapScaleDlg = 0.4;
                class mapTypes {
                    SAT = IDC_SCREEN;
                    TOPO = IDC_SCREEN_TOPO;
                };
                mapType = "SAT";
                drawSizeMultiplier = 1;
                mapTools = "true";
                nightMode = 2;
                brightness = 0.9;
            };
        };

        class JV5 {
            dialogName = QGVAR(JV5_dlg);

            class InterfaceSettings {
                dlgIfPosition[] = {};
                mapWorldPos[] = {};
                showIconText = "true";
                mapScaleDsp = 2;
                mapScaleDlg = 2;
                class mapTypes {
                    SAT = IDC_SCREEN;
                    TOPO = IDC_SCREEN_TOPO;
                };
                mapType = "SAT";
                drawSizeMultiplier = 1;
                mapTools = "true";
            };
        };

        class TAD {
            displayName = QGVAR(TAD_dsp);
            dialogName = QGVAR(TAD_dlg);
            backgroundDay = QUOTE(PATHTOF(UI\images\TAD_background_ca.paa));
            backgroundNight = QUOTE(PATHTOF(UI\images\TAD_background_night_ca.paa));

            class InterfaceSettings {
                dlgIfPosition[] = {};
                dspIfPosition = "false";
                mapWorldPos[] = {};
                showIconText = "true";
                mapScaleDsp = 2;
                mapScaleDlg = 2;
                mapScaleMin = 1;
                class mapTypes {
                    SAT = IDC_SCREEN;
                    TOPO = IDC_SCREEN_TOPO;
                    BLK = IDC_SCREEN_BLACK;
                };
                mapType = "SAT";
                drawSizeMultiplier = 1;
                mapTools = "true";
                nightMode = 0;
                brightness = 0.8;
            };
        };
    };
};
