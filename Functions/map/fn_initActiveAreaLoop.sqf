activeAreaMarkers = [];
publicVariable "activeAreaMarkers";
private _markerCount = count markers;
while {true} do {
	//TODO filter listeners see if quicker
	activeAreaMarkers = [];
	for "_i" from 0 to _markerCount -1 do {
		private _mrker = markers select _i;
		private _mkrPos = (getMarkerPos _mrker);
		if (listeners findif {(_x select 0) distance2D _mkrPos < (_x select 1) + 200}  != -1) then {
			activeAreaMarkers pushBackUnique _mrker;
		};
	};
	publicVariable "activeAreaMarkers";
	sleep 30;
};