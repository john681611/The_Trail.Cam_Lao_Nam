//Get all buildings on an Island (also catches editor placed (or spawned via script) buildings).
private ["_toClipboard","_toLogfile","_start","_mapSize","_center","_radius","_buildings"];

_mapSize = getNumber(configFile >> "CfgWorlds" >> worldName >> "MapSize");
_center = [(_mapSize/2), (_mapSize/2), 0];
_radius = [0,0,0] distance _center;
_buildings = [];
_locations = createHashMap;
{
	_pos = getPos _x;
	_rounded_x = (ceil ((_pos select 0) / 100)) * 100 - 50;
	_rounded_y = (ceil ((_pos select 1) / 100)) * 100 - 50;
	_index = format ["%1-%2", _rounded_x, _rounded_y];
	_locations set [_index, [_rounded_x, _rounded_y]];
	_buildings pushBack [typeOf _x, getPos _x];
}forEach (_center nearObjects ["Building", _radius]);
_markers = [];
{
	_mark = createMarker[_x, _y];
	_mark setMarkerColor "ColorRed";
	_mark setMarkerShape "RECTANGLE";
	_mark setMarkerBrush "Solid";
	_mark setMarkerAlpha 0.5;
	_mark setMarkerSize [50,50];
	_markers pushBack _mark;	
} forEach _locations;


////////////////////////////////////////////// GET TRAIL /////////////////////////////////////////////////

_getNearbyMarkers = {
	params ["_marker","_tgt","_markers","_trail", "_distanceLimit"];
	_markersFiltered = [];
	_currentDist = (getMarkerPos _marker) distance (getMarkerPos _tgt);
	{
		
		if(_x in _trail) then {
				
		} else {
			if((getMarkerPos _x) distance (getMarkerPos _tgt) < _currentDist) then {
				_markersFiltered pushBack _x;
			}
		}
		
	} forEach  _markers;

	_markersFiltered select {(getMarkerPos _x) distance (getMarkerPos _marker) < _distanceLimit}
};


_getNextPos = {
	params ["_target","_marker", "_markers"];
	_localPos = [_markers, [getMarkerPos _target], {(getMarkerPos _x) distance _input0 }, "ASCEND"] call BIS_fnc_sortBy;

	_localPos select 0
};

private _tgt = "CAPITAL_BASE";
private _loc = "VC_base";
private _trail = [_loc];
while {(getMarkerPos _tgt) distance (getMarkerPos _loc) > 200} do {
	_opts = [];
	_distanceLimit = 110;
	while {count _opts == 0} do {
		_opts = [_loc, _tgt,  _markers, _trail, _distanceLimit] call _getNearbyMarkers;
		_distanceLimit = _distanceLimit + 110;
	};
	_newLoc = [_tgt, _loc, _opts] call _getNextPos;	
	_trail pushBack _newLoc;
	_marker = [
      ["start", getMarkerPos _loc],
      ["end", getMarkerPos _newLoc],
      ["color", "ColorRed"],
      ["size", 10]
   ] execVM "drawLine.sqf"; 
	_newLoc setMarkerColor "ColorYellow";
	_loc = _newLoc;
};


////////////////////////////////////////////// APPLY TRAIL AOE /////////////////////////////////////////////////

_getAjacentMarkers = {
	params ["_marker","_markers","_excluded", "_distanceLimit"];
	_markersFiltered = [];

	{
		
		if(_x in _excluded) then {
				
		} else {
			_markersFiltered pushBack _x;
		}
		
	} forEach  _markers;

	_markersFiltered select {(getMarkerPos _x) distance (getMarkerPos _marker) < _distanceLimit}
};

_allAoeMarkers = [];
_aoeMarkers = [];
{
	// Current result is saved in variable _x
	_opts = [_x, _markers, _trail + _allAoeMarkers, 200] call _getAjacentMarkers;
	{
		_x setMarkerColor "ColorGreen";
		_aoeMarkers pushBack _x;
	} forEach _opts;
} forEach _trail;
_allAoeMarkers = _aoeMarkers;

for "_i" from 1 to 5 do {
	_newAoeMarkers = [];
	{
		// Current result is saved in variable _x
		_opts = [_x, _markers, _trail + _allAoeMarkers, 110] call _getAjacentMarkers;
		{
			_x setMarkerColor "ColorGreen";
			_newAoeMarkers pushBack _x;
		} forEach _opts;
	} forEach _aoeMarkers;
	_allAoeMarkers = _allAoeMarkers + _newAoeMarkers;
	_aoeMarkers = _newAoeMarkers;
 };