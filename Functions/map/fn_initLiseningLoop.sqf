
while {true} do {
	listeners = listeners select {alive (_x select 0)  && {!(isObjectHidden (_x select 0))}};
	publicVariable "listeners";
	private _markerCount = count activeAreaMarkers;
	for "_i" from 0 to _markerCount -1 do {
		if(count activeAreaMarkers < _i) exitWith {};
		private _mrker = activeAreaMarkers select _i;
		private _mkrPos = (getMarkerPos _mrker);
		private _alpha = selectMax (listeners apply {
			private _pos =  _x select 0;
			private _range = _x select 1;
			private _distance = _mkrPos distance2D _pos;
			if(_distance > _range) then {
				0
			};
			parseNumber (1 - ((_distance)/(_range)) toFixed 1)
		});
		if(markerAlpha _mrker  != _alpha) then {
			_mrker setMarkerAlpha _alpha;
		};
	};
	if(!(isNil "trailState")) then {
		publicVariable "trailState";
		publicVariable "trail";
		[uiNamespace,["trailState",trailState]] remoteExec ['setVariable',0];
		"trailStateMarker" setMarkerText format ["Trail state: %1", trailState];
	};
	sleep 10;
};


