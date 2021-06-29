while {true} do {
	sleep 5;
	{
		listeners = listeners select {alive (_x select 0)  && !(isObjectHidden (_x select 0))};
		publicVariable "listeners";
		_mkrPos = (getMarkerPos _x);
		_alpha = selectMax (listeners apply {
			if(_mkrPos distance2D (_x select 0) > _x select 1) then {
				0
			};
			parseNumber (1 - ((_mkrPos distance2D (_x select 0))/(_x select 1)) toFixed 1)
		});
		_x setMarkerAlpha _alpha;
	} forEach markers;
	if(!(isNil "trailState")) then {
		uiNamespace setVariable ["trailState", trailState];
		"trailStateMarker" setMarkerText format ["Trail state: %1", trailState];
	};
};


