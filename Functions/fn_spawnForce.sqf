params ["_AOMarker", "_AORad","_AOConfig", "_faction", "_defend"];
private _spawnedUnits = [];
private _AOPos = getMarkerPos _AOMarker;


{
	for "_i" from 1 to (_AOConfig getOrDefault [_X, 0]) do {
		private _group = [_AOMarker, _AORad,([_faction, _X] call TR_fnc_getUnits),_defend] call TR_fnc_spawnGroup;
		if(_defend) then {
			[_group, _AOPos , _AORad, 3, 0.1, 0.1, true] call CBAEXT_fnc_taskDefend;
		} else {
			[_group, _AOPos] call CBAEXT_fnc_taskAttack;
		};
		{
			_spawnedUnits pushBack _x;
		} forEach (units _group);
	};
} forEach ["mainGroup","reconGroup"];

{
	for "_i" from 1 to (_AOConfig getOrDefault [_x, 0]) do {
		private _group = [_AOMarker, _AORad,([_faction, _x] call TR_fnc_getUnits),_defend] call TR_fnc_spawnGroup;
		if(_defend) then {
			[_group, _AOPos , _AORad] call CBAEXT_fnc_taskPatrol;
		} else {
			[_group, _AOPos] call CBAEXT_fnc_taskAttack;
		};
		{
			_spawnedUnits pushBack _x;
		} forEach (units _group);
	};
} forEach ["ATGroup","AAGroup"];

{
	for "_i" from 1 to (_AOConfig getOrDefault [_x, 0]) do {
		private _veh = [_AOMarker, _AORad,([_faction, _x] call TR_fnc_getUnits),_defend] call TR_fnc_spawnVehicle;
		if(_defend) then {
			[group _veh,  _AOPos , _AORad, 5, "sad", "safe", "red", "limited"] call CBAEXT_fnc_taskPatrol;
		} else {
			[group _veh, _AOPos] call CBAEXT_fnc_taskAttack;
		};
		_spawnedUnits pushBack _veh;
		{
			_spawnedUnits pushBack _x;
		} forEach (crew _veh);
	};
} forEach ["Car","MBT", "IFV", "AAA"];

if(_defend) then {
	for "_i" from 1 to (_AOConfig getOrDefault ["turret", 0]) do {
		private _veh = [_AOMarker, _AORad,([_faction, "turret"] call TR_fnc_getUnits)] call TR_fnc_spawnVehicle;
			_spawnedUnits pushBack _veh;
		{
			_spawnedUnits pushBack _x;
		} forEach (crew _veh);
	};
};

//Boats

//TODO Helicopters and Jets


[_spawnedUnits] remoteExec ["TR_fnc_addToAllCurators", 2];

_spawnedUnits;