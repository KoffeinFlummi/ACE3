class CfgSoundShaders {
    class ACE_GAU8_30mm_closeExp_SoundShader {
        samples[] = {
            {PATHTOF(sounds\ammo\GAU8_Hit1),1},
            {PATHTOF(sounds\ammo\GAU8_Hit1),1},
            {PATHTOF(sounds\ammo\GAU8_Hit1),1}
        };
        volume = 1;
        range = 2000;
        rangeCurve[] = {
            {0,1},
            {800,0.75},
            {2000,0}
        };
    };
};
