private _activeZoneLimit = 15;
private _civLimit = 8; 
activeZones = createHashMap;
if(trailState == "attacking") exitWith {};
{
	if({alive _x} count (units _y) == 0)then {
		if((getMarkerColor _x) in ["ColorBlue", "ColorGreen"]) then {
			_x setMarkerColor "ColorOpfor";
		} else {
			_x setMarkerColor "ColorBlue";
		};
		deleteGroup _y;
		activeZones deleteAt _x;
		if(_x in trail) then {
			_trailIndex = trail find _x;
			if(_trailIndex > 5) then {
				trail = trail select [_trailIndex - 3, count trail];
			} else {
				trail = [trail select 0];
			};
			[excludeTrail, ([_x, activeAreaMarkers, [], 500] call TR_fnc_getAjacentMarkers)] call BIS_fnc_arrayPushStack;
			trailState = "reeling";
		};
	}
} forEach activeZones;

_triggerPlayers = allPlayers select {getPosATL _x select 2 < 50  AND (speed _x) < 100}; //don't care about flying players over 50m or going over 100kmh
_needActivating = [];
_needCiviActivating = [];
if(count activeZones < _activeZoneLimit) then {
	_needActivating = activeAreaMarkers select { 
		_mrk = _x; 
		(getMarkerColor _x) == "ColorOpfor" AND !(_x in activeZones) AND (selectMin (allPlayers apply {_x distance2D (getMarkerPos _mrk)})) < 300 
	};
	if(count activeZones < _civLimit) then {
		_needCiviActivating = activeAreaMarkers select { 
			_mrk = _x; 
			(getMarkerColor _x) in ["ColorBlue", "ColorGreen"] AND !(_x in activeZones) AND (selectMin (allPlayers apply {_x distance2D (getMarkerPos _mrk)})) < 200 and (random 10) < 1
		};
	};
	if(((count activeZones) + (count _needActivating)) > _activeZoneLimit) then {
		_needCiviActivating = [];
		_needActivating = _needActivating select [0, 3];
	};
} else {
	// DEBUG
	// systemChat format["Active Zone limit Reached no more zones will spawn. ActiveZoneCount: %1", count activeZones];
};
_needsDeactivatingKeys = (keys activeZones) select {
	_mrk = _x;
	(selectMin (_triggerPlayers apply {_x distance2D (getMarkerPos _mrk)})) > 400
}; 


//Activate Zone and spawn units;
{
	_grp = createGroup [east, false];
	_mkr = _x;
	_unitSet = "Inf_local";
	_playerCount = 3 max (15 min (count (allPlayers select {(getMarkerPos _mkr) distance _x < 500})));
	if(_x in trail) then {
		_unitSet = "Inf_regional";
		_playerCount = _playerCount * 2;
	};
	for "_i" from 1 to _playerCount do {
		_grp createUnit [(["VC", _unitSet] call TR_fnc_getUnits), getMarkerPos _mkr, [], 50, "NONE"];
	};
	if(random 10 < 1) then {
		_unit = _grp createUnit ["vn_o_men_nva_01", getMarkerPos _mkr, [], 50, "NONE"];
		_unit spawn TR_fnc_addHostileIntelAction;
	};
	if(random 10 < 1 and count ((getMarkerPos _mkr) nearRoads 50) > 0) then {
		_veh = [_mkr, 50,(["VC", "Car"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
		(crew _veh) join _grp;
	};
	if(random 10 < 1) then {
		_veh = [_mkr, 50,(["VC", "turret"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
		(crew _veh) join _grp;
	};
	[units _grp] remoteExec ["TR_fnc_addToAllCurators", 2];
	[_grp, (getMarkerPos _x) , 50, 3, 0.1, 0.1, true] call CBAEXT_fnc_taskDefend;
	// _x setMarkerBrush "Cross"; //DEBUG
	activeZones set [_x, _grp];
	
} forEach _needActivating;

//Activate civie Zone and spawn units;
{

	_grp = createGroup [civilian, false];
	_mkr = _x;
	_unit = _grp createUnit [(["CIV", "Inf"] call TR_fnc_getUnits), getMarkerPos _mkr, [], 50, "NONE"];
	_unit spawn TR_fnc_addCivIntelAction;
	[units _grp] remoteExec ["TR_fnc_addToAllCurators", 2];
	_grp setSpeedMode "LIMITED";
	[_grp, (getMarkerPos _x), 50] call CBAEXT_fnc_taskPatrol;
	// _x setMarkerBrush "Cross"; //DEBUG
	activeZones set [_x, _grp];
	
} forEach _needCiviActivating;

//Deactivate Zone and delete units;
{
	_grp = activeZones get _x;
	{
		deleteVehicle _x;	
	} forEach units _grp;
	deleteGroup _grp;
	// _x setMarkerBrush "Solid"; //DEBUG
	activeZones deleteAt _x;
	
} forEach _needsDeactivatingKeys;