
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
		["Inf_local",[
				"vn_o_men_vc_local_32", .5,
				"vn_o_men_vc_local_24", .5,
				"vn_o_men_vc_local_08", .5,
				"vn_o_men_vc_local_01", .5,
				"vn_o_men_vc_local_16", .5,
				"vn_o_men_vc_local_02", .5,
				"vn_o_men_vc_local_20", .5,
				"vn_o_men_vc_local_06", .5,
				"vn_o_men_vc_local_04", .5,
				"vn_o_men_vc_local_03", .5,
				"vn_o_men_vc_local_05", .5,
				"vn_o_men_vc_local_27", .5,
				"vn_o_men_vc_local_13", .5,
				"vn_o_men_vc_local_09", .5,
				"vn_o_men_vc_local_23", .5,
				"vn_o_men_vc_local_12", .5,
				"vn_o_men_vc_local_14", .5,
				"vn_o_men_vc_local_28", .5,
				"vn_o_men_vc_local_07", .5,
				"vn_o_men_vc_local_21", .5
			]
		],
		["Inf_regional",[
			"vn_o_men_vc_regional_14", .5,
			"vn_o_men_vc_regional_01", .5,
			"vn_o_men_vc_regional_04", .5,
			"vn_o_men_vc_regional_03", .5,
			"vn_o_men_vc_regional_06", .5,
			"vn_o_men_vc_regional_05", .5,
			"vn_o_men_vc_regional_13", .5,
			"vn_o_men_vc_regional_09", .5,
			"vn_o_men_vc_regional_12", .5,
			"vn_o_men_vc_regional_07", .5,
			"vn_o_men_vc_regional_11", .5,
			"vn_o_men_vc_regional_10", .5,
			"vn_o_men_vc_regional_08", .5,
			"vn_o_men_vc_regional_02", .5
			]
		],
		["mainGroup",[
				(missionConfigFile >> "unitList" >> "VC" >> "squad1"),.1,
				(missionConfigFile >> "unitList" >> "VC" >> "squad2"),.1,
				(missionConfigFile >> "unitList" >> "VC" >> "squad3"),.1
			]
		],
		["reconGroup",[
				(missionConfigFile >> "unitList" >> "VC" >> "squad3"),.1
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
		]],
		["AA",[
				"vn_o_nva_65_static_zpu4", .5,
				"vn_o_wheeled_btr40_mg_03_nva65", .5,
				"vn_o_wheeled_z157_mg_02", .5
		]],
		["Arty",[
				"vn_o_vc_static_mortar_type53", .5,
				"vn_o_vc_static_mortar_type63", .5,
				"vn_o_vc_static_d44_01", .5
		]],
		["Supply",[
			"vn_b_ammobox_full_11", .5,
			"vn_o_ammobox_kit_nva", .5,
			"vn_o_ammobox_full_07", .5,
			"vn_b_ammobox_full_12", .5
		]]
		]
	],
	["CIV", createHashMapFromArray [
		["Inf",[
				"vn_c_men_01",.5,
				"vn_c_men_02",.5,
				"vn_c_men_05",.5,
				"vn_c_men_06",.5,
				"vn_c_men_09",.5,
				"vn_c_men_10",.5,
				"vn_c_men_13",.5,
				"vn_c_men_14",.5,
				"vn_c_men_17",.5,
				"vn_c_men_18",.5,
				"vn_c_men_21",.5,
				"vn_c_men_22",.5,
				"vn_c_men_25",.5,
				"vn_c_men_26",.5,
				"vn_c_men_29",.5,
				"vn_c_men_30",.5
				]
			]
		]	
	]
]);


((_unitMap get _faction) get _type) call BIS_fnc_selectRandomWeighted;
