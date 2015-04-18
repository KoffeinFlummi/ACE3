
class CfgWeapons {
    class ACE_ItemCore;
    class InventoryItem_Base_F;

    class ACE_Kestrel4500: ACE_ItemCore {
        author[] = {$STR_ACE_Common_ACETeam, "Ruthberg"};
        scope = 2;
        displayName = "$STR_ACE_Kestrel_Name";
        descriptionShort = "$STR_ACE_Kestrel_Description";
        model = PATHTOF(kestrel4500.p3d);
        picture = PATHTOF(UI\Kestrel4500.paa);
        icon = "iconObject_circle";
        mapSize = 0.034;

        class ItemInfo: InventoryItem_Base_F {
            mass = 2;
        };
    };
};
