for "_i" from 0 to (count activeAreaMarkers) -1 do {
	if(count activeAreaMarkers < _i) exitWith {};
	private _mrker = activeAreaMarkers select _i;
	private _mkrPos = (getMarkerPos _mrker);
	private _alpha = selectMax (listeners apply {
		private _pos =  _x select 0;
		private _range = _x select 1;
		private _distance = _mkrPos distance2D _pos;
		if(_distance > _range) then {
			0
		};
		parseNumber (1 - ((_distance)/(_range)) toFixed 1)
	});
	if(markerAlpha _mrker  != _alpha) then {
		_mrker setMarkerAlpha _alpha;
	};
};

// Check for wrecks needing respawn
_list = (getPos wreckLoc) nearObjects ["vn_us_komex_medium_02", 10];
{
	[(_x getVariable "respawnVehicle"), { call{(_this select 1) spawn TR_fnc_trackVeh;} }] call VN_ms_module_fnc_vehicleRespawn_respawn;
	deleteVehicle _x;
} forEach _list;