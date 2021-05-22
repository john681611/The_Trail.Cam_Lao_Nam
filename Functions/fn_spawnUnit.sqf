params ["_AOMarker", "_vehType", "_defend"];
private _AOpos = getMarkerPos _AOMarker;
private _radiusSize = (getMarkerSize _AOMarker) select 0;
private _randomPos = [];
if(_defend) then {
	_randomPos = [_AOpos, 0, _radiusSize, 5, 0, 0.4, 0, [], _AOpos] call BIS_fnc_findSafePos;
} else {
	_randomPos = [_AOpos, _radiusSize + 100, _radiusSize + 300 , 5, 0, 0.4, 0, []] call BIS_fnc_findSafePos;
};
  
private _unit = (createGroup east) createUnit [_vehType, _randomPos, [], 5, "NONE"];

_unit;