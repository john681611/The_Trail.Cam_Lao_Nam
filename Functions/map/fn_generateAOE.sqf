	params ["_positions","_markers","_potency", "_color", "_ignoredColors"];
	_allEffectedMarkers = [];
	_effecttedMarkers = [];
	{
		_opts = [_x, _markers, _positions + _allEffectedMarkers, 200] call TR_fnc_getAjacentMarkers;
		{
			if!(getMarkerColor _x in _ignoredColors) then {
				_x setMarkerColor _color;
				_effecttedMarkers pushBack _x;
			}
		} forEach _opts;
	} forEach _positions;
	_allEffectedMarkers = _effecttedMarkers;

	for "_i" from 1 to _potency do {
		_neweffecttedMarkers = [];
		{
			_opts = [_x, _markers, _positions + _allEffectedMarkers, 110] call TR_fnc_getAjacentMarkers;
			{
				if!(getMarkerColor _x in _ignoredColors) then {
					_x setMarkerColor _color;
					_neweffecttedMarkers pushBack _x;
				}	
			} forEach _opts;
		} forEach _effecttedMarkers;
		_allEffectedMarkers = _allEffectedMarkers + _neweffecttedMarkers;
		_effecttedMarkers = _neweffecttedMarkers;
	};