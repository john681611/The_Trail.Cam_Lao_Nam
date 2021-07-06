params ["_count", "_color", "_ignoredColors"];
	private _selectedMarkers = [];
	while {count _selectedMarkers < _count} do {
		_opt = (selectRandom markers);
		if!(getMarkerColor _opt in _ignoredColors + _selectedMarkers) then {
			_opt setMarkerColor _color;
			_selectedMarkers pushBackUnique _opt;
		}
	};
	_selectedMarkers