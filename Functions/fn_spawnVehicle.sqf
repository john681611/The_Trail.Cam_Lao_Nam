params ["_AOMarker", "_AORad", "_vehType", "_defend"];

private _AOpos = getMarkerPos _AOMarker;
private _randomPos = [];
if(_defend) then {
	_randomPos = [_AOpos, 0, _AORad, 5, 0, 0.4, 0, [], _AOpos] call BIS_fnc_findSafePos;
} else {
	_randomPos = [_AOpos, _AORad + 100, _AORad + 300 , 0, 0, 0.4, 0, []] call BIS_fnc_findSafePos;
};
private _veh = createVehicle [_vehType, _randomPos, [], 5, "NONE"];
private _grp = createGroup east;
createVehicleCrew _veh;
(crew _veh) join _grp;
_veh allowCrewInImmobile true;

_veh;