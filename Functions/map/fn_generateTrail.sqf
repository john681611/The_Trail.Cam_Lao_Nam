_getNearbyMarkers = {
	params ["_marker","_tgt","_markers","_exclude", "_distanceLimit"];
	_markersFiltered = [];
	_currentDist = (getMarkerPos _marker) distance2D (getMarkerPos _tgt);
	{
		
		if!(_x in _exclude) then {
			if((getMarkerPos _x) distance2D (getMarkerPos _tgt) < _currentDist) then {
				_markersFiltered pushBack _x;
			}
		}
		
	} forEach  _markers;

	_markersFiltered select {(getMarkerPos _x) distance2D (getMarkerPos _marker) < _distanceLimit}
};


_getNextPos = {
	params ["_target","_marker", "_markers"];
	_localPos = [_markers, [getMarkerPos _target], {(getMarkerPos _x) distance2D _input0 }, "ASCEND"] call BIS_fnc_sortBy;

	_localPos select 0
};

private _loc = trail select (count trail -1);
tgt = "CAPITAL_BASE";
_capTime = 0;
_searchTime = 0;
_maxJump = 3000;
trailState = "building";
while {(getMarkerPos tgt) distance2D (getMarkerPos _loc) > 750 and trailState == "building"} do {
	_opts = [];
	_distanceLimit = 110;
	while {count _opts == 0} do {
		if(_distanceLimit > _maxJump) exitWith {
			trailState = "abandoned";
		};
		_opts = [_loc, tgt,  markers, trail + excludeTrail, _distanceLimit] call _getNearbyMarkers;
		_distanceLimit = _distanceLimit + 110;
		sleep _searchTime;

	};
	if(trailState == "abandoned") exitWith {
		[] spawn TR_fnc_spawnAO;
	};
	_newLoc = [tgt, _loc, _opts] call _getNextPos;
	if(getMarkerColor _newLoc == "colorGreen") then {
		sleep _capTime;
		_newLoc setMarkerColor "colorBlue";
	};
	if(getMarkerColor _newLoc == "colorBlue") then {
		sleep _capTime;
	};
	sleep _capTime;
	trail pushBack _newLoc;
	[
		["start", getMarkerPos _loc],
		["end", getMarkerPos _newLoc],
		["color", "ColorYellow"],
		["size", 10]
	] execVM "drawLine.sqf";  //DEBUG
	_newLoc setMarkerColor "ColorOpfor";
	[[_newLoc], markers, 5, "ColorOpfor", ["ColorOpfor"]] spawn TR_fnc_generateAOE;
	_loc = _newLoc;
};

if(trailState == "building") then {
	trailState = "supplying";
	sleep 3;
	if(trailState == "supplying") then {
		[] spawn TR_fnc_spawnBastion;
	};
} else {
	sleep 3;
	[] spawn TR_fnc_generateTrail;
}
