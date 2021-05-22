
params ["_faction", "_type"];

// Call ([_faction, _type] call AW_fnc_getUnits)
// Format Faction Hash => Type Hash => Unit/Group Array
private _unitMap = createHashMapFromArray ([
	["VC", createHashMapFromArray [
		["MBT",[
			"vn_o_armor_m41_02_vcmf",.2
			]
		],
		["Car",[
			"vn_o_wheeled_btr40_mg_02_vcmf", .5,
			"vn_o_wheeled_btr40_mg_01_vcmf", .5,
			"vn_o_wheeled_btr40_mg_03_vcmf", .5,
			"vn_o_wheeled_btr40_02_vcmf", .5,
			"vn_o_wheeled_btr40_01_vcmf", .5,
			"vn_o_wheeled_z157_ammo_vcmf", .5,
			"vn_o_wheeled_z157_mg_01_vcmf", .5,
			"vn_o_wheeled_z157_fuel_vcmf", .5,
			"vn_o_wheeled_z157_repair_vcmf", .5,
			"vn_o_wheeled_z157_mg_02_vcmf", .5,
			"vn_o_wheeled_z157_01_vcmf", .5,
			"vn_o_wheeled_z157_02_vcmf", .5
			]
		],
		["mainGroup",[
			(configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_local" >> "vn_o_group_men_vc_local_01"),.1,
			(configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_local" >> "vn_o_group_men_vc_local_02"),.1,
			(configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_local" >> "vn_o_group_men_vc_local_03"),.1,
			(configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_regional" >> "vn_o_group_men_vc_regional_01"),.1,
			(configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_regional" >> "vn_o_group_men_vc_regional_02"),.1,
			(configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_regional" >> "vn_o_group_men_vc_regional_03"),.1
			]
		],
		["reconGroup",[
			(configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_regional" >> "vn_o_group_men_vc_regional_04"),.1,
			(configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_local" >> "vn_o_group_men_vc_local_04"),.1
			]
		],
		["turret",[
				"vn_o_vc_static_dshkm_high_02", .5,
				"vn_o_vc_static_d44_01", .5,
				"vn_o_vc_static_mortar_type53", .5,
				"vn_o_vc_static_mortar_type63", .5,
				"vn_o_vc_static_dshkm_low_01", .5,
				"vn_o_vc_spiderhole_02", .5,
				"vn_o_vc_spiderhole_01", .5,
				"vn_o_vc_spiderhole_03", .5,
				"vn_o_vc_static_d44", .5,
				"vn_o_vc_static_dp28_high", .5,
				"vn_o_vc_static_dshkm_high_01", .5,
				"vn_o_vc_static_dshkm_low_02", .5,
				"vn_o_vc_static_pk_high", .5,
				"vn_o_vc_static_rpd_high", .5
		]]
		]
	]
]);


((_unitMap get _faction) get _type) call BIS_fnc_selectRandomWeighted;
