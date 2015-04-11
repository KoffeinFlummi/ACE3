class CfgWeapons {
    class InventoryItem_Base_F;
    class ACE_ItemCore;

    class ACE_UAVBattery: ACE_ItemCore {
        scope = 2;
        displayName = "$STR_ACE_logistics_uavbattery_Battery_Name";
        descriptionShort = "$STR_ACE_logistics_uavbattery_Battery_Description";
        model = QUOTE(PATHTOF(models\ace_battery.p3d));
        picture = QUOTE(PATHTOF(ui\UAV_battery_ca.paa));
        class ItemInfo: InventoryItem_Base_F {
            mass = 20;
        };
    };
};
