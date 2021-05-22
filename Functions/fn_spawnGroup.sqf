params["_AOMarker",  "_AORad", "_groupConfig", "_defend"];
private _AOpos = getMarkerPos _AOMarker;
private _randomPos = [];
if(_defend) then {
	_randomPos = [_AOpos, 0, _AORad, 5, 0, 0.4, 0, [], _AOpos] call BIS_fnc_findSafePos;
} else {
	_randomPos = [_AOpos, _AORad + 100, _AORad + 500 , 0, 0, 0.4, 0, []] call BIS_fnc_findSafePos;
};
private _infteamPatrol = [_randomPos, east, _groupConfig] call BIS_fnc_spawnGroup;
_infteamPatrol;