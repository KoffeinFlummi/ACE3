#define CREATE_MAGAZINE_GROUP(ammo) class GVAR(ammo) { rhs_##ammo = 1; }
class ace_csw_groups {
    CREATE_MAGAZINE_GROUP(mag_9M131M);
    CREATE_MAGAZINE_GROUP(mag_9M131F);
    CREATE_MAGAZINE_GROUP(mag_9m133);
    CREATE_MAGAZINE_GROUP(mag_9m133f);
    CREATE_MAGAZINE_GROUP(mag_9m1331);
    CREATE_MAGAZINE_GROUP(mag_9m133m2);
    CREATE_MAGAZINE_GROUP(mag_PG9V);
    CREATE_MAGAZINE_GROUP(mag_PG9N);
    CREATE_MAGAZINE_GROUP(mag_PG9VNT);
    CREATE_MAGAZINE_GROUP(mag_OG9VM);
    CREATE_MAGAZINE_GROUP(mag_OG9V);
    CREATE_MAGAZINE_GROUP(mag_VOG30_30);
    CREATE_MAGAZINE_GROUP(mag_GPD30_30);
    CREATE_MAGAZINE_GROUP(mag_VOG17m_30);
    CREATE_MAGAZINE_GROUP(mag_762x54mm_100);

    class GVAR(mag_AZP23_100) {
        RHS_mag_AZP23_100 = 1;
        rhs_mag_AZP23_100_veh = 1;
    };

    class GVAR(mag_AZP23_100_ap) {
        rhs_mag_AZP23_100_ap = 1;
        rhs_mag_AZP23_100_ap_veh = 1;
    };
};

