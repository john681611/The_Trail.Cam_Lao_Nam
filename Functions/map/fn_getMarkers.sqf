//Get all buildings on an Island (also catches editor placed (or spawned via script) buildings).
private ["_toClipboard","_toLogfile","_start","_mapSize","_center","_radius","_buildings"];
_locations = createHashMap;
_cache = profilenamespace getvariable (format["TrailCache%1",worldName]);
if(count (keys _cache) == 0) then { //CLEAR OVERIDE NEEDED
	_mapSize = getNumber(configFile >> "CfgWorlds" >> worldName >> "MapSize");
	_center = [(_mapSize/2), (_mapSize/2), 0];
	_radius = [0,0,0] distance2D _center;
	{
		_pos = getPos _x;
		_rounded_x = (ceil ((_pos select 0) / 100)) * 100 - 50;
		_rounded_y = (ceil ((_pos select 1) / 100)) * 100 - 50;
		_index = format ["%1-%2", _rounded_x, _rounded_y];
		_locations set [_index, [_rounded_x, _rounded_y]];
	}forEach (_center nearObjects ["Building", _radius]);
	profilenamespace setvariable [(format["TrailCache%1",worldName]), _locations];
} else {
	_locations = _cache;
};

markers = [];
{
	if!(_y inArea safezone) then {
		_mark = createMarker[_x, _y];
		_mark setMarkerColor "ColorBlue";
		_mark setMarkerShape "RECTANGLE";
		_mark setMarkerBrush "Solid";
		_mark setMarkerAlpha 0.5; 
		_mark setMarkerSize [50,50];
		markers pushBack _mark;
	}
} forEach _locations;