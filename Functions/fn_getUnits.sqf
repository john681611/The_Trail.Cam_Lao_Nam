
params ["_faction", "_type"];

// Call ([_faction, _type] call AW_fnc_getUnits)
// Format Faction Hash => Type Hash => Unit/Group Array
private _unitMap = createHashMapFromArray ([
	["OPF_F", createHashMapFromArray [
		["MBT",[
			"O_MBT_02_cannon_F",.2,
			"O_MBT_04_cannon_F",.1,
			"O_MBT_04_command_F",.1
			]
		],
		["AAA",["O_APC_Tracked_02_AA_F",1]],
		["Arty",["O_MBT_02_arty_F",1]],
		["IFV",[
			"O_APC_Wheeled_02_rcws_F",.5,
			"O_APC_Tracked_02_cannon_F",.5
			]
		],
		["Car",[
			"O_MRAP_02_gmg_F",.2,
			"O_MRAP_02_hmg_F",.3,
			"O_LSV_02_armed_F",.1,
			"O_G_Offroad_01_armed_F",.1,
			"O_Truck_03_transport_F",.1
			]
		],
		["mainGroup",[
			(configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfAssault"),.1,
			(configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad"),.1,
			(configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad_Weapons"),.1,
			(configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam"),.1,
			(configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardSquad"),.1,
			(configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"),.1
			]
		],
		["AAGroup",[(configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA"),.1]],
		["ATGroup",[
			(configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "O_T_InfTeam_AT"),.1,
			(configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "O_T_InfTeam_AT_Heavy"),.1
			]
		],
		["reconGroup",[
			(configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconPatrol"),.1,
			(configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconTeam"),.1,
			(configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_ReconSquad"),.1,
			(configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "SpecOps" >> "OI_ViperTeam"),.2
			]
		],
		["officer", [
			"O_officer_F",.1,
			"O_Officer_Parade_F",.1,
			"O_Officer_Parade_Veteran_F",.1
			]
		],
		["helis",[
			"O_Heli_Attack_02_dynamicLoadout_F",.1,
			"O_T_VTOL_02_infantry_dynamicLoadout_F",.3,
			"O_Heli_Light_02_dynamicLoadout_F",.3
			]
		],
		["helisTransport",[
			"O_Heli_Attack_02_dynamicLoadout_F", .25,
			"O_T_VTOL_02_infantry_dynamicLoadout_F", .25,
			"O_Heli_Light_02_dynamicLoadout_F", .25,
			"I_Heli_light_03_dynamicLoadout_F", .25,
			"I_Heli_Transport_02_F", 1,
			"O_Heli_Light_02_unarmed_F", 1,
			"I_Heli_light_03_unarmed_F", 1,
			"I_Heli_Transport_02_F", 1,
			"O_Heli_Transport_04_bench_F", 1,
			"O_Heli_Transport_04_covered_F", 1
			]
		],
		["jet",[
			"O_Plane_CAS_02_dynamicLoadout_F",.1,
			"O_Plane_CAS_02_Cluster_F",.1,
    		"O_Plane_Fighter_02_F",.1,
			"O_Plane_Fighter_02_Cluster_F",.1,
			"O_Plane_Fighter_02_Stealth_F",.1
			]
		],
		["turret",[
			"O_HMG_01_high_F",.2,
			"O_Mortar_01_F",.1,
			"O_static_AA_F",.1,
			"O_static_AT_F",.1
		]]
		]
	]
] + customUnitConfig);


((_unitMap get _faction) get _type) call BIS_fnc_selectRandomWeighted;
