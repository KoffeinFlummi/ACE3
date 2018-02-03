class CfgACEArsenalStats {
    class statBase {
        scope = 1;
        priority = 0;
        stats[]= {};
        displayName= "";
        showBar= 0;
        showText= 0;
        barStatement = "";
        textStatement = "";
        condition = "true";
        tabs[]= {{}, {}};
    };
    class bananaPotassium: statBase {
        scope = 2;
        priority = 0;
        displayName= CSTRING(statPotassium);
        showBar= 1;
        showText= 0;
        barStatement = "1";
        condition = "((configName (_this select 1)) == 'ACE_Banana')";
        tabs[]= {{}, {7}};
    };
    class mass: statBase {
        scope = 2;
        priority = 1;
        displayName= "$STR_a3_rscdisplayarsenal_stat_weight";
        showBar= 0;
        showText= 1;
        textStatement = QUOTE([ARR_2(_this select 0, _this select 1)] call FUNC(statTextStatement_mass));
        tabs[]= {{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14}, {0,1,2,3,4,5,6,7}};
    };
    class rateOfFire: statBase {
        scope = 2;
        priority = 5;
        stats[]= {"reloadTime"};
        displayName= "$STR_a3_rscdisplayarsenal_stat_rof";
        showBar= 1;
        showText= 1;
        barStatement = QUOTE([ARR_3((_this select 0) select 0, _this select 1, [ARR_3([ARR_2(-1.4, 0.31)], [ARR_2(1, 0.01)], true)])] call FUNC(statBarStatement_default));
        textStatement = QUOTE([ARR_3((_this select 0) select 0, _this select 1, [ARR_2([ARR_2(-1.4, 0.31)], false)])] call FUNC(statTextStatement_rateOfFire));
        tabs[]= {{0,1}, {}};
    };
    class accuracy: statBase {
        scope = 2;
        priority = 4;
        stats[]= {"dispersion"};
        displayName= "$STR_a3_rscdisplayarsenal_stat_dispersion";
        showBar= 1;
        showText= 1;
        barStatement = QUOTE([ARR_3((_this select 0) select 0, _this select 1, [ARR_3([ARR_2(-4, -1.7)], [ARR_2(1, 0.01)], true)])] call FUNC(statBarStatement_default));
        textStatement = QUOTE([ARR_3((_this select 0) select 0, _this select 1, [ARR_2([ARR_2(-4, -1.7)], false)])] call FUNC(statTextStatement_accuracy));
        tabs[]= {{0,1}, {}};
    };
    class maxZeroing: statBase {
        scope = 2;
        priority = 3;
        stats[]= {"maxZeroing"};
        displayName= "$STR_a3_rscdisplayarsenal_stat_range";
        showBar= 1;
        showText= 0;
        barStatement = QUOTE([ARR_3((_this select 0) select 0, _this select 1, [ARR_3([ARR_2(0, 2500)], [ARR_2(0.01, 1)], false)])] call FUNC(statBarStatement_default));
        tabs[]= {{0,1,2}, {}};
    };
    class impact: statBase {
        scope = 2;
        priority = 3;
        stats[]= {"hit", "initSpeed"};
        displayName= "$STR_a3_rscdisplayarsenal_stat_impact";
        showBar= 1;
        showText= 0;
        barStatement = QUOTE([ARR_3(_this select 0, _this select 1, [ARR_3([ARR_2(0, 3.2)], [ARR_2(-1, 1100)], 2006)])] call FUNC(statBarStatement_impact));
        tabs[]= {{0,1,2}, {}};
    };
};
