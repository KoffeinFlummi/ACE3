class CfgWorldsTextures {
    class Default {
        surfaceTextureBasePath = "a3\map_data\";
        filePrefix = "co.paa";
    };

    //Altis
    class Altis: Default {
        camouflageObjects[] = {"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d" /*, "A3\plants_f\Clutter\c_Thistle_Thorn_Green.p3d"*/};
    };

    // Bukovina
    class Bootcamp_ACR {
        surfaceTextureBasePath = "ca\Bootcamp_ACR\data\";
        filePrefix = "detail_co.paa";
        camouflageObjects[] = {"ca\plants2\clutter\c_GrassBunch.p3d"};
    };

    // Bystrica
    class Woodland_ACR {
        surfaceTextureBasePath = "ca\Bohemia\data\";
        filePrefix = "detail_co.paa";
        camouflageObjects[] = {"ca\plants2\clutter\c_weed3.p3d"};
    };

    //Chernarus
    class Chernarus {
        surfaceTextureBasePath = "ca\CHERNARUS\data\";
        filePrefix = "detail_co.paa";
        camouflageObjects[] = {"ca\plants2\clutter\c_weed3.p3d"};
    };

    //Celle
    class mbg_celle2: Chernarus {
        camouflageObjects[] = {};
    };

    //Chernarus Summer
      class Chernarus_Summer: Chernarus {
        camouflageObjects[] = {"ca\plants2\clutter\c_weed3.p3d"};
    };

    //Desert
    class Desert_E {
        surfaceTextureBasePath = "ca\Desert_E\data\";
        filePrefix = "co.paa";
        camouflageObjects[] = {"ca\plants_E\Clutter\c_Brush_Hard_EP1.p3d"};
    };

    //Lythium
    class lythium: Default {
        surfaceTextureBasePath = "GBR\lythium\data\";
        filePrefix = "co.paa";
        camouflageObjects[] = {"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d"};
    };

    //Malden
    class Malden: Altis {
        camouflageObjects[] = {"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d"};
    };

    //Rahmadi
    class Intro: Chernarus {
        camouflageObjects[] = {"ca\plants\clutter_grass_flowers.p3d"};
    };

    //Porto
    class Porto {
        surfaceTextureBasePath = "ca\desert2\data\";
        filePrefix = ".paa";
        camouflageObjects[] = {};
    };

    //Prei Khmaoch Luong
    class prei_khmaoch_luong {
        surfaceTextureBasePath = "\blud_prei_art\data\ground\";
        filePrefix = "co.paa";
        camouflageObjects[] = {"a3\vegetation_f_exp\clutter\grass\c_Grass_Tropic.p3d"};
    };

    //Proving Grounds
    class ProvingGrounds_PMC {
        surfaceTextureBasePath = "ca\provinggrounds_pmc\Data\";
        filePrefix = "co.paa";
        camouflageObjects[] = {};
    };

    //Sahrani
    class Sara {
        surfaceTextureBasePath = "ca\sara\Data\";
        filePrefix = "_detail_co.paa";
        camouflageObjects[] = {"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d"};
        class Surfaces {
            class blato_detail_nohq {
                texturePath = "ca\sara\Data\blato_detail_nohq.paa";
            };
            class blato_mco {
                texturePath = "ca\sara\Data\blato_mco.paa";
            };
            class lesjeh_detail_nohq {
                texturePath = "ca\sara\Data\lesjeh_detail_nohq.paa";
            };
            class lesjeh_mco {
                texturePath = "ca\sara\Data\lesjeh_mco.paa";
            };
            class leslist_detail_nohq {
                texturePath = "ca\sara\Data\leslist_detail_nohq.paa";
            };
            class leslist_mco {
                texturePath = "ca\sara\Data\leslist_mco.paa";
            };
            class mesto_detail_nohq {
                texturePath = "ca\sara\Data\mesto_detail_nohq.paa";
            };
            class mesto_mco {
                texturePath = "ca\sara\Data\mesto_mco.paa";
            };
            class mesto2_detail_nohq {
                texturePath = "ca\sara\Data\mesto2_detail_nohq.paa";
            };
            class mesto2_mco {
                texturePath = "ca\sara\Data\mesto2_mco.paa";
            };
            class pisek_detail_nohq {
                texturePath = "ca\sara\Data\pisek_detail_nohq.paa";
            };
            class pisek_mco {
                texturePath = "ca\sara\Data\pisek_mco.paa";
            };
            class pisekplaz_detail_nohq {
                texturePath = "ca\sara\Data\pisekplaz_detail_nohq.paa";
            };
            class pisekplaz_mco {
                texturePath = "ca\sara\Data\pisekplaz_mco.paa";
            };
            class pisekpoust_detail_nohq {
                texturePath = "ca\sara\Data\pisekpoust_detail_nohq.paa";
            };
            class pisekpoust_mco {
                texturePath = "ca\sara\Data\pisekpoust_mco.paa";
            };
            class pole1_detail_nohq {
                texturePath = "ca\sara\Data\pole1_detail_nohq.paa";
            };
            class pole1_mco {
                texturePath = "ca\sara\Data\pole1_mco.paa";
            };
            class sara_a3_middle_mco {
                texturePath = "ca\sara\Data\sara_a3_middle_mco.paa";
            };
            class skalaj_detail_nohq {
                texturePath = "ca\sara\Data\skalaj_detail_nohq.paa";
            };
            class skalaj_mco {
                texturePath = "ca\sara\Data\skalaj_mco.paa";
            };
            class skalas_detail_nohq{
                texturePath = "ca\sara\Data\skalas_detail_nohq.paa";
            };
            class skalas_mco {
                texturePath = "ca\sara\Data\skalas_mco.paa";
            };
            class trava_detail_nohq {
                texturePath = "ca\sara\Data\trava_detail_nohq.paa";
            };
            class trava_mco {
                texturePath = "ca\sara\Data\trava_mco.paa";
            };
            class travajih_detail_nohq {
                texturePath = "ca\sara\Data\travajih_detail_nohq.paa";
            };
            class travajih_mco {
                texturePath = "ca\sara\Data\travajih_mco.paa";
            };
        };
    };

    //Shapur
    class Shapur_Baf {
        surfaceTextureBasePath = "ca\shapur_baf\Data\";
        filePrefix = "co.paa";
        camouflageObjects[] = {"ca\plants_E\Clutter\c_Brush_Hard_EP1.p3d"};
    };

    //Southern Sahrani
    class SaraLite {
        surfaceTextureBasePath = "ca\saralite\Data\";
        filePrefix = "_detail_co.paa";
        camouflageObjects[] = {"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d"};
        class Surfaces {
             class leslist_detail_nohq {
                 texturePath = "ca\saralite\Data\leslist_detail_nohq.paa";
             };
            class leslist_mco {
                 texturePath = "ca\saralite\Data\leslist_mco.paa";
             };
            class mesto_detail_nohq {
                 texturePath = "ca\saralite\Data\mesto_detail_nohq.paa";
             };
            class mesto_mco {
                texturePath = "ca\saralite\Data\mesto_mco.paa";
            };
            class pisek_detail_nohq {
                texturePath = "ca\saralite\Data\pisek_detail_nohq.paa";
            };
            class pisek_mco {
                texturePath = "ca\saralite\Data\pisek_mco.paa";
            };
            class pisekpoust_detail_nohq {
                texturePath = "ca\saralite\Data\pisekpoust_detail_nohq.paa";
            };
            class pisekpoust_mco {
                texturePath = "ca\saralite\Data\pisekpoust_mco.paa";
            };
            class saralite_a3_middle_mco {
                texturePath = "ca\saralite\Data\saralite_a3_middle_mco.paa";
            };
            class skalaj_detail_nohq {
                texturePath = "ca\saralite\Data\skalaj_detail_nohq.paa";
            };
            class skalaj_mco {
                texturePath = "ca\saralite\Data\skalaj_mco.paa";
            };
            class travajih_detail_nohq {
                texturePath = "ca\saralite\Data\travajih_detail_nohq.paa";
            };
            class travajih_mco {
                texturePath = "ca\saralite\Data\travajih_mco.paa";
            };
        };
    };

    //Stratis
    class Stratis: Altis {
        camouflageObjects[] = {"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d"};
    };

    //Takistan
    class Takistan {
        surfaceTextureBasePath = "ca\takistan\Data\";
        filePrefix = "co.paa";
        camouflageObjects[] = {};
    };

    //Takistan Mountains
    class Mountains_ACR {
        surfaceTextureBasePath = "ca\afghan\Data\";
        filePrefix = "co.paa";
        camouflageObjects[] = {};
    };

    //Tanoa
    class Tanoa : Altis{
        surfaceTextureBasePath = "A3\Map_Data_Exp\";
        camouflageObjects[] = {"A3\Vegetation_F_Exp\Clutter\Grass\c_GrassBunch_HI.p3d"};
    };

    //United Sahrani
    class Sara_dbe1 : Sara {
        camouflageObjects[] = {"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d"};
    };

    //Utes
    class utes {
        surfaceTextureBasePath = "ca\utes\Data\";
        filePrefix = ".paa";
        camouflageObjects[] = {"CUP\Terrains\cup_terrains_worlds\Clutter\c_GrassCrookedForest.p3d"};
        class Surfaces {
            class Default {
                texturePath = "a3\map_data\gdt_beach_co.paa";
            };
        };
    };

    //Zargabad
    class Zargabad {
        surfaceTextureBasePath = "ca\zargabad\Data\";
        filePrefix = "co.paa";
        camouflageObjects[] = {"ca\plants_E\Clutter\c_Brush_Soft_EP1.p3d"};
    };
};
