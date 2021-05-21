params["_AOMarker", "_groupConfig"];
private _AOpos = getMarkerPos _AOMarker;
private _radiusSize = (getMarkerSize _AOMarker) select 0;
private _randomPos = [_AOpos, 0, _radiusSize, 5, 0, 0.4, 0, [], _AOpos] call BIS_fnc_findSafePos;
private _infteamPatrol = [_randomPos, east, _groupConfig] call BIS_fnc_spawnGroup;
_infteamPatrol;