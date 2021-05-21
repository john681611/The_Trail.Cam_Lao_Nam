params ["_AOMarker", "_vehType"];

private _AOpos = getMarkerPos _AOMarker;
private _radiusSize = (getMarkerSize _AOMarker) select 0;
private _randomPos = [_AOpos, 0, _radiusSize, 5, 0, 0.4, 0, [], _AOpos] call BIS_fnc_findSafePos;
private _veh = createVehicle [_vehType, _randomPos, [], 5, "NONE"];
private _grp = createGroup east;
createVehicleCrew _veh;
(crew _veh) join _grp;
_veh allowCrewInImmobile true;

_veh;