	params ["_veh","_markers","_range"];
	_sleepTime = 10;
	while {alive _veh} do {
		sleep _sleepTime;
		if(speed _veh > 10) then {
			_sleepTime = 1;	
		} else {
			_sleepTime = 10;
		};
		if (_veh == vehicle _veh) then {
			_markersFiltered = _markers select {(getMarkerPos _x) distance2D _veh < _range};
			//TODO: FILTER BY LOS
			{
				_alpha =  (1 - (((getMarkerPos _x) distance2D _veh)/_range));
				_x setMarkerAlpha _alpha;
			} forEach _markersFiltered;
		};
	};