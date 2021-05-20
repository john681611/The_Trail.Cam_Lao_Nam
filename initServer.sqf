//Get all buildings on an Island (also catches editor placed (or spawned via script) buildings).
private ["_toClipboard","_toLogfile","_start","_mapSize","_center","_radius","_buildings"];

_mapSize = getNumber(configFile >> "CfgWorlds" >> worldName >> "MapSize");
_center = [(_mapSize/2), (_mapSize/2), 0];
_radius = [0,0,0] distance2D _center;
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
markers = [];
{
	_mark = createMarker[_x, _y];
	_mark setMarkerColor "ColorBlue";
	_mark setMarkerShape "RECTANGLE";
	_mark setMarkerBrush "Solid";
	_mark setMarkerAlpha 0.5;
	_mark setMarkerSize [50,50];
	markers pushBack _mark;	
} forEach _locations;


////////////////////////////////////////////// GET TRAIL /////////////////////////////////////////////////

_getNearbyMarkers = {
	params ["_marker","_tgt","_markers","_trail", "_distanceLimit"];
	_markersFiltered = [];
	_currentDist = (getMarkerPos _marker) distance2D (getMarkerPos _tgt);
	{
		
		if(_trail find _x == -1 ) then {
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

private _tgt = "CAPITAL_BASE";
private _loc = "VC_base";
private _trail = [_loc];
while {(getMarkerPos _tgt) distance2D (getMarkerPos _loc) > 200} do {
	_opts = [];
	_distanceLimit = 110;
	while {count _opts == 0} do {
		_opts = [_loc, _tgt,  markers, _trail, _distanceLimit] call _getNearbyMarkers;
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
	_newLoc setMarkerColor "ColorRed";
	_loc = _newLoc;
};


////////////////////////////////////////////// APPLY TRAIL AOE /////////////////////////////////////////////////

getAjacentMarkers = {
	params ["_marker","_markers","_excluded", "_distanceLimit"];
	_markersFiltered = [];

	{
		
		if(_excluded find _x == -1 ) then {
			_markersFiltered pushBack _x;
		}
		
	} forEach  _markers;
	if(typeName _marker == "STRING") then {
		_markersFiltered select {(getMarkerPos _x) distance2D (getMarkerPos _marker) < _distanceLimit}
	} else {
		_markersFiltered select {(getMarkerPos _x) distance2D _marker < _distanceLimit}
	};
};

generateAOE = {
	params ["_positions","_markers","_potency", "_color", "_ignoredColors"];
	_allEffectedMarkers = [];
	_effecttedMarkers = [];
	{
		_opts = [_x, _markers, _positions + _allEffectedMarkers, 200] call getAjacentMarkers;
		{
			if(_ignoredColors find getMarkerColor _x  == -1) then {
				_x setMarkerColor _color;
				_effecttedMarkers pushBack _x;
			}
		} forEach _opts;
	} forEach _positions;
	_allEffectedMarkers = _effecttedMarkers;

	for "_i" from 1 to _potency do {
		_neweffecttedMarkers = [];
		{
			_opts = [_x, _markers, _positions + _allEffectedMarkers, 110] call getAjacentMarkers;
			{
				if(_ignoredColors find getMarkerColor _x  == -1) then {
					_x setMarkerColor _color;
					_neweffecttedMarkers pushBack _x;
				}	
			} forEach _opts;
		} forEach _effecttedMarkers;
		_allEffectedMarkers = _allEffectedMarkers + _neweffecttedMarkers;
		_effecttedMarkers = _neweffecttedMarkers;
	};
};

[_trail, markers, 5, "ColorOpfor", []] spawn generateAOE;
//Food AOE
// [[player], markers, 3, "ColorGreen",["ColorRed", "ColorOpfor"]] spawn generateAOE;
//Aid AOE
// [[player], markers, 3, "ColorGreen",["ColorRed", "ColorOpfor", "ColorBlue"]] spawn generateAOE;



////////////////////////////////////////////// INTEL /////////////////////////////////////////////////

//HIDE ALL MARKERS TEMP
//  {
// 	_x setMarkerAlpha 0;
//  } foreach _markers;

_liseningDevice = {
	params ["_veh","_markers","_range"];
	_sleepTime = 10;
	while {alive _veh} do {
		sleep _sleepTime;
		if(speed _veh > 10) then {
			_sleepTime = 1;	
		} else {
			_sleepTime = 10;
		};
		_markersFiltered = _markers select {(getMarkerPos _x) distance2D _veh < _range};
		//TODO: FILTER BY LOS
		{
			_alpha =  (1 - (((getMarkerPos _x) distance2D _veh)/_range));
			_x setMarkerAlpha _alpha;
		} forEach _markersFiltered;
	};
};

[helo, markers, 2000] spawn _liseningDevice;

[player, markers, 200] spawn _liseningDevice;
