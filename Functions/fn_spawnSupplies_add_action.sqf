_act = _this addAction ["Spawn Food",{
_box = "vn_b_ammobox_supply_02" createVehicle getMarkerPos ("supplySpawn");
	call{_box spawn TR_fnc_distribute_add_action; _box spawn TR_fnc_trackVeh;}
}, nil, 1.5, true, true, '', "true", 20];

_act = _this addAction ["Spawn Aid",{
	_box = "vn_b_ammobox_supply_03" createVehicle getMarkerPos ("supplySpawn");
	call{_box spawn TR_fnc_distribute_add_action; _box spawn TR_fnc_trackVeh;}
}, nil, 1.5, true, true, '', "true", 20];