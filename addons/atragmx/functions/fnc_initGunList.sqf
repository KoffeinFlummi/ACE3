#include "script_component.hpp"
/*
 * Author: Ruthberg
 * Inits the gun list from user profile
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_atragmx_fnc_initGunList
 *
 * Public: No
 */

LOG_2("Trying to load gunlist from profile [Version: %1][Count: %2]", profileNamespace getVariable [ARR_2(QGVAR(profileNamespaceVersion), 'none')], count (profileNamespace getVariable [ARR_2(QGVAR(gunList), [])]));

private _resetGunList = true;
if ((profileNamespace getVariable ["ACE_ATragMX_profileNamespaceVersion", 0]) == ATRAGMX_PROFILE_NAMESPACE_VERSION && {count (profileNamespace getVariable ["ACE_ATragMX_gunList", []]) > 0}) then {
    GVAR(gunList) = profileNamespace getVariable "ACE_ATragMX_gunList";
    _resetGunList = false;
    {
        // Verify each gun has correct param type
        if (!(_x isEqualTypeArray ["", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", [], [], false])) exitWith {
            _resetGunList = true;
        };
    } forEach GVAR(gunList);
};

if (_resetGunList) then {
    WARNING("Reseting Profile Gunlist");
    // Profile Name, Muzzle Velocity, Zero Range, Scope Base Angle, AirFriction, Bore Height, Scope Unit, Scope Click Unit, Scope Click Number, Maximum Elevation, Dialed Elevation, Dialed Windage, Mass, Bullet Diameter, Rifle Twist, BC, Drag Model, Atmosphere Model, Muzzle Velocity vs. Temperature Interpolation, C1 Ballistic Coefficient vs. Distance Interpolation, Persistent
    GVAR(gunList) =  [["12.7x108mm"        ,  812, 100, 0.0958029, -0.00063800, 8.89, 0, 2, 10, 120, 0, 0, 48.28, 12.7, 38.10, 0.630, 1, "ASM" , [[-15,793],[0,800],[10,807],[15,812],[25,826],[30,835],[35,846]]       , [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]], true],

                      ["12.7x99mm AMAX"    ,  852, 100, 0.0907214, -0.00037397, 8.89, 0, 2, 10, 120, 0, 0, 48.60, 12.7, 38.10, 1.050, 1, "ASM" , [[-15,833],[0,840],[10,847],[15,852],[25,866],[30,875],[35,886]]       , [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]], true],
                      ["12.7x99mm"         ,  892, 100, 0.0879633, -0.00058679, 8.89, 0, 2, 10, 120, 0, 0, 41.92, 12.7, 38.10, 0.670, 1, "ASM" , [[-15,873],[0,880],[10,887],[15,892],[25,906],[30,915],[35,926]]       , [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]], true],

                      ["12.7x54mm"         ,  299, 100, 0.3567550, -0.00019568, 6.60, 0, 2, 10, 120, 0, 0, 48.60, 12.7, 24.13, 1.050, 1, "ASM" , [[-15,297],[0,298],[10,299],[15,299],[25,301],[30,302],[35,303]]       , [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]], true],

                      [".50 Beowulf"       ,  562, 100, 0.1425100, -0.00205896, 6.60, 0, 2, 10, 120, 0, 0, 21.71, 12.7, 50.80, 0.210, 1, "ASM" , [[-15,560],[0,561],[10,562],[15,562],[25,564],[30,565],[35,566]]       , [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]], true],

                      [".408 CheyTac 305gr", 1059, 100, 0.0686329, -0.00065414, 7.37, 0, 2, 10, 120, 0, 0, 19.76, 10.4, 33.02, 0.569, 1, "ICAO", [[-15,1040],[0,1047],[10,1054],[15,1059],[25,1073],[30,1082],[35,1093]], [[0, 0.605], [1110, 0.569], [1500, 0.560], [1790, 0.551], [1990, 0.547], [2140, 0.545], [2300, 0.544]], true],
                      [".408 CheyTac 419gr",  859, 100, 0.0816039, -0.00046249, 7.37, 0, 2, 10, 120, 0, 0, 27.15, 10.4, 33.02, 0.866, 1, "ICAO", [[-15,840],[0,847],[10,854],[15,859],[25,873],[30,882],[35,893]]       , [[0, 0.872], [1440, 0.862], [1630, 0.859], [1870, 0.852], [2090, 0.843], [2230, 0.838], [2420, 0.833]], true],

                      ["9.3×64mm"          ,  862, 100, 0.0875873, -0.00110727, 8.13, 0, 2, 10, 120, 0, 0, 14.90, 9.30, 35.56, 0.368, 1, "ASM" , [[-15,843],[0,850],[10,857],[15,862],[25,876],[30,885],[35,896]]       , [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]], true],

                      [".338LM 250gr"      ,  872, 100, 0.0809096, -0.00060841, 7.37, 0, 2, 10, 120, 0, 0, 16.20, 8.58, 25.40, 0.645, 1, "ICAO", [[-15,853],[0,860],[10,867],[15,872],[25,886],[30,895],[35,906]]       , [[0, 0.656], [1300, 0.64], [1460, 0.636], [1770, 0.625], [1920, 0.621], [2030, 0.619], [2190, 0.618]], true],
                      [".338LM 300gr"      ,  792, 100, 0.0890193, -0.00055706, 7.37, 0, 2, 10, 120, 0, 0, 19.44, 8.58, 25.40, 0.759, 1, "ICAO", [[-15,773],[0,780],[10,787],[15,792],[25,806],[30,815],[35,826]]       , [[0, 0.734], [1300, 0.726], [1500, 0.720], [1770, 0.708], [1880, 0.705], [2000, 0.702], [2110, 0.700]], true],
                      [".338LM API526"     ,  872, 100, 0.0810834, -0.00069220, 7.37, 0, 2, 10, 120, 0, 0, 16.39, 8.58, 25.40, 0.580, 1, "ICAO", [[-15,853],[0,860],[10,867],[15,872],[25,886],[30,895],[35,906]]       , [[0, 0.590], [1180, 0.576], [1320, 0.572], [1570, 0.563], [1690, 0.560], [1860, 0.557], [2050, 0.555]], true],

                      [".300WM Mk248 Mod0" ,  857, 100, 0.0825862, -0.00072468, 7.37, 0, 2, 10, 120, 0, 0, 12.31, 7.80, 25.40, 0.537, 1, "ICAO", [[-15,838],[0,845],[10,852],[15,857],[25,871],[30,880],[35,891]]       , [[0, 0.546], [1210, 0.529], [1470, 0.520], [1570, 0.518], [1730, 0.515], [1880, 0.513], [1970, 0.513]], true],
                      [".300WM Mk248 Mod1" ,  839, 100, 0.0841417, -0.00063027, 7.37, 0, 2, 10, 120, 0, 0, 14.26, 7.80, 25.40, 0.619, 1, "ICAO", [[-15,820],[0,827],[10,834],[15,839],[25,853],[30,862],[35,873]]       , [[0, 0.623], [1150, 0.614], [1330, 0.609], [1620, 0.598], [1770, 0.595], [1970, 0.592], [2030, 0.591]], true],
                      [".300WM Berger OTM" ,  792, 100, 0.0891300, -0.00055262, 7.37, 0, 2, 10, 120, 0, 0, 14.90, 7.80, 25.40, 0.715, 1, "ICAO", [[-15,773],[0,780],[10,787],[15,792],[25,806],[30,815],[35,826]]       , [[0, 0.721], [1400, 0.708], [1570, 0.703], [1860, 0.692], [1990, 0.689], [2140, 0.686], [2220, 0.685]], true],

                      ["7.62x54mmR"        ,  828, 100, 0.0853677, -0.00103739, 7.11, 0, 2, 10, 120, 0, 0, 9.849, 7.92, 24.13, 0.400, 1, "ICAO", [[-15,809],[0,816],[10,823],[15,828],[25,842],[30,851],[35,862]]       , [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]], true],

                      ["7.62x51mm M80"     ,  802, 100, 0.0909184, -0.00103711, 7.62, 0, 2, 10, 120, 0, 0, 9.461, 7.82, 25.40, 0.398, 1, "ICAO", [[-15,783],[0,790],[10,797],[15,802],[25,816],[30,825],[35,836]]       , [[0, 0.399], [810, 0.392], [1030, 0.383], [1120, 0.381], [1270, 0.380], [1410, 0.379], [1530, 0.379]], true],
                      ["7.62x51mm M118LR"  ,  757, 100, 0.0958841, -0.00085157, 7.62, 0, 2, 10, 120, 0, 0, 11.34, 7.82, 25.40, 0.482, 1, "ICAO", [[-15,738],[0,745],[10,752],[15,757],[25,771],[30,780],[35,791]]       , [[0, 0.483], [790, 0.479], [920, 0.475], [1130, 0.465], [1230, 0.462], [1420, 0.460], [1630, 0.459]], true],
                      ["7.62x51mm Mk316"   ,  781, 100, 0.0928267, -0.00084311, 7.62, 0, 2, 10, 120, 0, 0, 11.34, 7.82, 25.40, 0.483, 1, "ICAO", [[-15,777],[0,778],[10,779],[15,781],[25,783],[30,785],[35,787]]       , [[0, 0.484], [830, 0.479], [950, 0.475], [1130, 0.467], [1260, 0.463], [1430, 0.461], [1660, 0.459]], true],
                      ["7.62x51mm Mk319"   ,  900, 100, 0.0811838, -0.00104515, 7.62, 0, 2, 10, 120, 0, 0, 8.424, 7.82, 25.40, 0.377, 1, "ICAO", [[-15,898],[0,899],[10,900],[15,900],[25,902],[30,903],[35,904]]       , [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]], true],
                      ["7.62x51mm M993"    ,  912, 100, 0.0803840, -0.00109390, 7.62, 0, 2, 10, 120, 0, 0, 8.230, 7.82, 25.40, 0.359, 1, "ICAO", [[-15,893],[0,900],[10,907],[15,912],[25,926],[30,935],[35,946]]       , [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]], true],
                      ["7.62x51mm Subsonic",  314, 100, 0.3344490, -0.00060194, 6.86, 0, 2, 10, 120, 0, 0, 12.96, 7.82, 25.40, 0.502, 1, "ICAO", [[-15,312],[0,313],[10,314],[15,314],[25,316],[30,317],[35,318]]       , [[0, 0.303], [250, 0.409], [320, 0.427], [420, 0.445], [550, 0.460], [650, 0.467], [730, 0.470]], true],

                      ["7.62x39mm"         ,  715, 100, 0.104782, -0.00154815, 7.62, 0, 2, 10, 120, 0, 0, 7.970, 7.92, 25.40, 0.275, 1, "ICAO", [[-15,696],[0,703],[10,710],[15,715],[25,729],[30,738],[35,749]]       , [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]], true],

                      ["6.5x39mm"          ,  766, 100, 0.0872025, -0.00077363, 6.35, 0, 2, 10, 120, 0, 0, 7.970, 6.71, 22.86, 0.524, 1, "ICAO", [[-15,747],[0,754],[10,761],[15,766],[25,780],[30,789],[35,800]]       , [[0, 0.525], [910, 0.520], [1050, 0.515], [1270, 0.506], [1390, 0.503], [1570, 0.500], [1770, 0.498]], true],
                      ["6.5x47mm Lapua"    ,  767, 100, 0.0868248, -0.00069003, 6.35, 0, 2, 10, 120, 0, 0, 9.007, 6.71, 22.86, 0.577, 1, "ICAO", [[-15,748],[0,755],[10,762],[15,767],[25,781],[30,790],[35,801]]       , [[0, 0.578], [970, 0.574], [1140, 0.569], [1430, 0.557], [1610, 0.553], [1750, 0.551], [1860, 0.550]], true],
                      ["6.5mm Creedmor"    ,  822, 100, 0.0800956, -0.00062437, 6.35, 0, 2, 10, 120, 0, 0, 9.072, 6.71, 22.86, 0.632, 1, "ICAO", [[-15,803],[0,810],[10,817],[15,822],[25,836],[30,845],[35,856]]       , [[0, 0.635], [1150, 0.627], [1350, 0.621], [1630, 0.611], [1760, 0.607], [1860, 0.606], [2020, 0.604]], true],

                      ["5.8x42mm DBP87"    ,  942, 100, 0.0916742, -0.00121087, 9.91, 0, 2, 10, 120, 0, 0, 4.150, 5.99, 24.40, 0.313, 1, "ICAO", [[-15,923],[0,930],[10,937],[15,942],[25,956],[30,965],[35,976]]       , [[0, 0.323], [760, 0.309], [970, 0.303], [1030, 0.302], [1130, 0.301], [1210, 0.300], [1510, 0.299]], true],

                      ["5.56x45mm M855"    ,  862, 100, 0.0825404, -0.00130094, 7.11, 0, 2, 10, 120, 0, 0, 4.018, 5.70, 17.78, 0.302, 1, "ASM" , [[-15,843],[0,849],[10,857],[15,862],[25,876],[30,885],[35,898]]       , [[0, 0.306], [670, 0.298], [880, 0.291], [1000, 0.289], [1150, 0.288], [1340, 0.288], [1410, 0.288]], true],
                      ["5.56x45mm Mk262"   ,  812, 100, 0.0872422, -0.00111805, 7.11, 0, 2, 10, 120, 0, 0, 4.990, 5.70, 17.78, 0.361, 1, "ASM" , [[-15,793],[0,800],[10,807],[15,812],[25,826],[30,835],[35,846]]       , [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]], true],
                      ["5.56x45mm Mk318"   ,  872, 100, 0.0814490, -0.00125880, 7.11, 0, 2, 10, 120, 0, 0, 4.018, 5.70, 17.78, 0.307, 1, "ASM" , [[-15,853],[0,860],[10,867],[15,872],[25,886],[30,895],[35,906]]       , [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]], true],
                      ["5.56x45mm M995"    ,  861, 100, 0.0825279, -0.00126182, 7.11, 0, 2, 10, 120, 0, 0, 4.536, 5.70, 17.78, 0.310, 1, "ASM" , [[-15,842],[0,849],[10,856],[15,861],[25,875],[30,884],[35,895]]       , [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]], true],

                      ["5.45x39mm 7N6M"    ,  735, 100, 0.0784916, -0.00119458, 3.81, 0, 2, 10, 120, 0, 0, 3.43, 5.6, 16.00, 0.336, 1, "ICAO", [[-15,716],[0,723],[10,730],[15,735],[25,749],[30,758],[35,769]], [[0, 0.339], [730, 0.331], [960, 0.323], [1100, 0.321], [1220, 0.320], [1380, 0.320], [1480, 0.320]], true]];

    [] call FUNC(clear_user_data);
    profileNamespace setVariable ["ACE_ATragMX_gunList", GVAR(gunList)];
};
