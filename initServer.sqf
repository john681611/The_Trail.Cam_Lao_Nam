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


////////////////////////////////////////////// Noise/Inless /////////////////////////////////////////////////

_setRandomZonesTo = {
	params ["_markers", "_count", "_color", "_ignoredColors"];
	private _selectedMarkers = [];
	while {count _selectedMarkers < _count} do {
		_opt = (selectRandom _markers);
		if(_ignoredColors find getMarkerColor _opt  == -1 AND _selectedMarkers find getMarkerColor _opt  == -1) then {
			_opt setMarkerColor _color;
			_selectedMarkers pushBackUnique _opt;
		}
	};
	_selectedMarkers
};
private _noise = [markers, 50, "ColorOpfor", ["ColorOpfor"]] call _setRandomZonesTo;
private _illness = [markers, 10,  "ColorOrange", []] call _setRandomZonesTo;



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
	 [
      ["start", getMarkerPos _loc],
      ["end", getMarkerPos _newLoc],
      ["color", "ColorRed"],
      ["size", 10]
   ] execVM "drawLine.sqf";  //DEBUG
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

[_trail, markers, 5, "ColorOpfor", []] call generateAOE;
[_noise, markers, 5, "ColorOpfor", ["ColorRed", "ColorOrange"]] call generateAOE;
[_illness, markers, 3, "ColorOrange", ["ColorRed", "ColorOpfor"]] call generateAOE;
[[_tgt], markers, 5, "ColorGreen", []] call generateAOE;

//Food AOE
// [[player], markers, 3, "ColorGreen",["ColorRed", "ColorOpfor","ColorOrange"]] spawn generateAOE;
//Aid AOE
// [[player], markers, 3, "ColorGreen",["ColorRed", "ColorOpfor", "ColorBlue"]] spawn generateAOE;



////////////////////////////////////////////// INTEL /////////////////////////////////////////////////

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

////////////////////////////////////////////// COMBAT /////////////////////////////////////////////////

_combatLoop = {
	_activeZones = createHashMap;
	_trigger_colours = ["ColorRed", "ColorOpfor"];
	while {true} do {
		sleep 3;
		//Is a _activeZones clear?
		{
			if({alive _x} count (units _y) == 0)then {
				_x setMarkerColor "ColorBlue";
				deleteGroup _y;
				_activeZones deleteAt _x;
				break;
			}
		} forEach _activeZones;

		//What needs changing due to player prioximity
		_needActivating = _markers select {getMarkerColor _x in _trigger_colours AND (keys _activeZones) find _x == -1};
		{
			_player = _x;
			_needActivating =  _needActivating select {(getMarkerPos _x) distance _player < 300};
			_needsDeactivating = (keys _activeZones) select {(getMarkerPos _x) distance _player > 400}; 
		} forEach allPlayers select {getPosATL _x select 2 < 50  AND (speed _x) < 100}; //don't care about flying players over 50m or going over 100kmh

		//Activate Zone and spawn units;
		{
			_grp = createGroup [east, false];
			_spawnedUnits = [_grp createUnit [ "C_man_p_beggar_F", getMarkerPos _x, [], 100, "NONE"]];
			_x setMarkerBrush "Cross"; //DEBUG
			_activeZones set [_x, _grp];
			
		} forEach _needActivating;

		//Deactivate Zone and delete units;
		{
			{
				deleteVehicle _x;	
			} forEach units _y;
			deleteGroup _y;
			_x setMarkerBrush "Solid"; //DEBUG
			_activeZones deleteAt _x;
			
		} forEach _needsDeactivating;

	};
};

[] spawn _combatLoop;