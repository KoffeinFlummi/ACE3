//CfgAmmo.hpp

class CfgAmmo {
    class MissileBase;
    class ace_m47_dragon_base: MissileBase
	{
		model = QUOTE(PATHTOF(models\dragon.p3d));
		irLock = 1;
		manualControl = 1;
		deflecting = 0;
		fuseDistance = 5;
		effectsMissile = "missile2";
		whistleDist = 2;
        
        hit = 360;
		indirectHit = 9;
		indirectHitRange = 1;
		cost = 4000;
		trackOversteer = 0.95;
		trackLead = 0.9;
		timeToLive = 20;
		maneuvrability = 10;
		simulationStep = 0.005;
		sideAirFriction = 0.05;
		maxControlRange = 1500;
		maxSpeed = 200;
		initTime = 0.151;
		thrustTime = 1.45;
		thrust = 300;
	};
    
    class Rocket_03_AP_F;
    class ace_missile_dragon : Rocket_03_AP_F {
		model = QUOTE(PATHTOF(models\dragon.p3d));
		maxSpeed = 120;
		thrust = 0;
		initTime = 0;
		thrustTime = 0;
		sideAirFriction = 0.5;
        effectsMissile = "";
        effectFlare = "";
        airFriction = 0.5;
        irLock = 0;
		manualControl = 0;
		deflecting = 0;
		fuseDistance = 5;
		whistleDist = 2;
        
        hit = 360;
		indirectHit = 9;
		indirectHitRange = 1;
		cost = 4000;
		trackOversteer = 0.95;
		trackLead = 0.9;
		timeToLive = 20;
		maneuvrability = 10;
		simulationStep = 0.005;
		maxControlRange = 1500;
	};
    
    class ShellBase;
	class ace_m47_dragon_serviceCharge : ShellBase {
		hit = 1;
		indirectHit = 2;
		indirectHitRange = 1;
		typicalSpeed = 100;
		explosive = 1;
		cost = 300;
		model = "\A3\Weapons_F\empty.p3d";
		airFriction = 0;
		timeToLive = 1;
		explosionTime = 0.001;
		soundFly[] = {"",1,1};
		soundEngine[] = {"",1,4};
		CraterEffects = "";
		explosionEffects = "ace_m47_serviceExplosion";
		hitarmor[] = {"soundDefault1", 1};
		hitbuilding[] = {"soundDefault1", 1};
		hitconcrete[] = {"soundDefault1", 1};
		hitdefault[] = {"soundDefault1", 1};
		hitfoliage[] = {"soundDefault1", 1};
		hitglass[] = {"soundDefault1", 1};
		hitglassarmored[] = {"soundDefault1", 1};
		hitgroundhard[] = {"soundDefault1", 1};
		hitgroundsoft[] = {"soundDefault1", 1};
		hitiron[] = {"soundDefault1", 1};
		hitman[] = {"soundDefault1", 1};
		hitmetal[] = {"soundDefault1", 1};
		hitmetalplate[] = {"soundDefault1", 1};
		hitplastic[] = {"soundDefault1", 1};
		hitrubber[] = {"soundDefault1", 1};
		hitwood[] = {"soundDefault1", 1};
		sounddefault1[] = {QUOTE(PATHTOF(sounds\service_charge.wss)), 56.2341, 1, 1800};
		soundHit[] = {QUOTE(PATHTOF(sounds\service_charge.wss)),56.23413,1,1800};
        multiSoundHit[] = {"soundDefault1", 1};
	};
};