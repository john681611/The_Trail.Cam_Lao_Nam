params ["_mkr", ["_IsTrail", false]];

if(_mkr in subObjectives) exitWith {};

private _subObjMkr = createMarker [format ["%1-subObj", _mkr], getMarkerPos _mkr];
_subObjMkr setMarkerColorLocal "colorOPFOR";
_subObjMkr setMarkerAlphaLocal 0;


if(_IsTrail && count tunnels < 6) exitWith {
	_subObjMkr setMarkerType "o_installation";
	subObjectives set [_mkr, [([count tunnels, getMarkerPos _mkr] call TR_fnc_createTunnel),_subObjMkr]];
};

if(random 100 < 20) exitWith {
	_subObjMkr setMarkerType "o_antiair";
	_veh = [_mkr, 50,(["VC", "AA"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
	subObjectives set [_mkr, [(crew _veh) + [_veh], _subObjMkr]];
};

if(random 100 < 20) exitWith {
	_subObjMkr setMarkerType "o_antiair";
	_veh = [_mkr, 50,"vn_o_static_rsna75", true] call TR_fnc_spawnVehicle;
	_grp = group ((crew _veh) select 0);
	_vehs = [_veh];
	for "x" from 0 to 3 do {
		private _launcher = [_mkr, 50,"vn_sa2", true] call TR_fnc_spawnVehicle;
		_vehs pushBack _launcher;
		(crew _launcher) joinSilent _grp;
	};
	subObjectives set [_mkr, [_vehs, _subObjMkr]];
};


if(random 100 < 20) exitWith {
	_subObjMkr setMarkerType "o_armor";
	_veh = [_mkr, 50,(["VC", "MBT"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
	subObjectives set [_mkr, [(crew _veh) + [_veh], _subObjMkr]];
};

if(random 100 < 20) exitWith {
	_subObjMkr setMarkerType "o_art";
	_veh = [_mkr, 50,(["VC", "Arty"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
	subObjectives set [_mkr, [(crew _veh) + [_veh], _subObjMkr]];
};

if(random 100 < 20) exitWith {
	_subObjMkr setMarkerType "o_art";
	_veh = [_mkr, 50,(["VC", "Arty"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
	subObjectives set [_mkr, [(crew _veh) + [_veh], _subObjMkr]];
};

if(random 100 < 20) exitWith {
	_subObjMkr setMarkerType "o_Ordnance";
	_veh = [_mkr, 50,(["VC", "Supply"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
	subObjectives set [_mkr, [(crew _veh) + [_veh], _subObjMkr]];
};
