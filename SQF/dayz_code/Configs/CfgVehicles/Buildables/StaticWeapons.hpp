class USMC_WarfareBMGNest_M240;
class M240Nest_DZ: USMC_WarfareBMGNest_M240
{
	destrType = "DestructBuilding";
	armor = 450;
	scope = 2;
	offset[] = {0,4,1.6};
	displayName = $STR_EPOCH_M240NEST;	
	transportMaxMagazines = 25;
	transportMaxWeapons = 4;
	transportMaxBackpacks = 1;
	constructioncount = 10;
	vehicleClass = "DayZ Epoch Static Weapons";
	GhostPreview = "M240Nest_DZ";
	removeoutput[] = {{"m240_nest_kit",1}};
};

class M2StaticMG;
class M2_MG_Static_DZ: M2StaticMG {
	side = 1;
	faction = "USMC";	
	offset[] = {0,3,1};
	GhostPreview = "M2_MG_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"M2_MG_Static_kit",1}};
};

class M2HD_mini_TriPod;
class M2_TriPod_MG_Static_DZ: M2HD_mini_TriPod {
	side = 1;
	faction = "USMC";
	offset[] = {0,3,1};
	GhostPreview = "M2_TriPod_MG_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"M2_TriPod_MG_Static_kit",1}};
};

class DSHKM_Ins;
class DSHKM_MG_Static_DZ: DSHKM_Ins {
	side = 1;
	faction = "USMC";	
	offset[] = {0,3,2};
	GhostPreview = "DSHKM_MG_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"DSHKM_MG_Static_kit",1}};	
};

class DSHkM_Mini_TriPod;
class DSHKM_TriPod_MG_Static_DZ: DSHkM_Mini_TriPod {
	side = 1;
	faction = "USMC";	
	offset[] = {0,3,1};
	GhostPreview = "DSHKM_TriPod_MG_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"DSHKM_TriPod_MG_Static_kit",1}};
};

class KORD;
class KORD_Tripod_MG_Static_DZ: KORD {
	side = 1;
	faction = "USMC";	
	offset[] = {0,3,1};
	GhostPreview = "KORD_Tripod_MG_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"KORD_TriPod_MG_Static_kit",1}};
};

class KORD_high;
class KORD_MG_Static_DZ: KORD_high {
	side = 1;
	faction = "USMC";	
	offset[] = {0,3,2};
	GhostPreview = "KORD_MG_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"KORD_MG_Static_kit",1}};
};

class BAF_L2A1_ACOG_base;
class BAF_L2A1_Tripod_D: BAF_L2A1_ACOG_base {
	class assembleInfo;
};

class L2A1_MG_Static_DZ: BAF_L2A1_Tripod_D {
	side = 1;
	faction = "USMC";	
	class assembleInfo: assembleInfo {
		dissasembleTo[] = {};
	};
	offset[] = {0,3,1};
	GhostPreview = "L2A1_MG_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"L2A1_MG_Static_kit",1}};
};

class BAF_L2A1_Minitripod_D: BAF_L2A1_ACOG_base {
	class assembleInfo;
};

class L2A1_Tripod_MG_Static_DZ: BAF_L2A1_Minitripod_D {
	side = 1;
	faction = "USMC";	
	class assembleInfo: assembleInfo {
		dissasembleTo[] = {};
	};
	offset[] = {0,3,1};
	GhostPreview = "L2A1_Tripod_MG_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"L2A1_Tripod_MG_Static_kit",1}};
};

class GMG_TriPod;
class BAF_GMG_Tripod_D: GMG_TriPod {
	class assembleInfo;
};

class GMG_Tripod_MG_Static_DZ: BAF_GMG_Tripod_D {
	side = 1;
	faction = "USMC";	
	class assembleInfo: assembleInfo {
		dissasembleTo[] = {};
	};
	offset[] = {0,3,0};
	GhostPreview = "GMG_Tripod_MG_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"GMG_Tripod_MG_Static_kit",1}};
};

class AGS_Ins;
class AGS30_GrenadeLauncher_Static_DZ: AGS_Ins {
	side = 1;
	faction = "USMC";	
	offset[] = {0,3,1};
	GhostPreview = "AGS30_GrenadeLauncher_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"AGS30_GrenadeLauncher_Static_kit",1}};
};

class MK19_TriPod;
class MK19_TriPod_GrenadeLauncher_Static_DZ: MK19_TriPod {
	side = 1;
	faction = "USMC";	
	offset[] = {0,3,1};
	GhostPreview = "MK19_TriPod_GrenadeLauncher_Static_DZ";	
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"MK19_TriPod_GrenadeLauncher_Static_kit",1}};
};

class BAF_GPMG_Minitripod_D: BAF_L2A1_ACOG_base {
	class assembleInfo;
};

class GPMG_TriPod_GrenadeLauncher_Static_DZ: BAF_GPMG_Minitripod_D {
	side = 1;
	faction = "USMC";	
	class assembleInfo: assembleInfo {
		dissasembleTo[] = {};
	};
	offset[] = {0,3,1};
	GhostPreview = "GPMG_TriPod_GrenadeLauncher_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"GPMG_TriPod_GrenadeLauncher_Static_kit",1}};
};

class M119;
class M119_Artillery_Static_DZ: M119 {
	side = 1;
	faction = "USMC";
	offset[] = {0,5,0.5};	
	GhostPreview = "M119_Artillery_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"M119_Artillery_Static_kit",1}};
};

class D30_Ins;
class D30_Artillery_Static_DZ: D30_Ins {
	side = 1;
	faction = "USMC";	
	offset[] = {0,5,1};
	GhostPreview = "D30_Artillery_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"D30_Artillery_Static_kit",1}};	
};

class SearchLight_INS;
class SearchLight_Static_DZ: SearchLight_INS {
	side = 1;
	faction = "USMC";	
	offset[] = {0,3,0};
	GhostPreview = "SearchLight_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"SearchLight_Static_kit",1}};	
};

class M252;
class M252_Mortar_Static_DZ: M252 {
	side = 1;
	faction = "USMC";	
	offset[] = {0,3,1};
	GhostPreview = "M252_Mortar_Static_DZ";	
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"M252_Mortar_Static_kit",1}};
};

class 2b14_82mm;
class 2b14_82mm_Mortar_Static_DZ: 2b14_82mm {
	side = 1;
	faction = "USMC";	
	offset[] = {0,3,1};
	GhostPreview = "2b14_82mm_Mortar_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"2b14_82mm_Mortar_Static_kit",1}};	
};

class Metis;
class Metis_Launcher_Static_DZ: Metis {
	side = 1;
	faction = "USMC";	
	offset[] = {0,3,1};
	GhostPreview = "Metis_Launcher_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"Metis_Launcher_Static_kit",1}};	
};

class SPG9_Gue;
class SPG9_Launcher_Static_DZ: SPG9_Gue {
	side = 1;
	faction = "USMC";	
	offset[] = {0,3,0};
	GhostPreview = "SPG9_Launcher_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"SPG9_Launcher_Static_kit",1}};	
};

class Stinger_Pod;
class Stinger_Tripod_Launcher_Static_DZ: Stinger_Pod {
	side = 1;
	faction = "USMC";
	offset[] = {0,3,0};
	GhostPreview = "Stinger_Tripod_Launcher_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"Stinger_Tripod_Launcher_Static_kit",1}};	
};

class TOW_TriPod;
class TOW_Tripod_Launcher_Static_DZ: TOW_TriPod {
	side = 1;
	faction = "USMC";	
	offset[] = {0,3,2};
	GhostPreview = "TOW_Tripod_Launcher_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"TOW_Tripod_Launcher_Static_kit",1}};
};

class Stinger_Pod_base;
class Rbs70_ACR: Stinger_Pod_base {
	class AssembleInfo;
};

class Rbs70_Launcher_Static_DZ: Rbs70_ACR {
	side = 1;
	faction = "USMC";	
	class AssembleInfo : AssembleInfo {
		dissasembleTo[] = {};
	};	
	offset[] = {0,3,4};
	GhostPreview = "Rbs70_Launcher_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"Rbs70_Launcher_Static_kit",1}};
};

class Igla_AA_pod_East;
class Igla_AntiAir_Launcher_Static_DZ: Igla_AA_pod_East {
	side = 1;
	faction = "USMC";	
	offset[] = {0,3,2};
	GhostPreview = "Igla_AntiAir_Launcher_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"Igla_AntiAir_Launcher_Static_kit",1}};
};

class ZU23_Ins;
class ZU23_AntiAir_Static_DZ: ZU23_Ins {
	side = 1;
	faction = "USMC";
	offset[] = {0,3,2};
	GhostPreview = "ZU23_AntiAir_Static_DZ";
	vehicleClass = "DayZ Epoch Static Weapons";
	removeoutput[] = {{"ZU23_AntiAir_Static_kit",1}};
};