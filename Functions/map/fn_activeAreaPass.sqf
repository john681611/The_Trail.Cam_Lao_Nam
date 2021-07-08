//TODO filter listeners see if quicker
activeAreaMarkers = [];
private _overDistance = 1000;
for "_i" from 0 to (count markers)-1 do {
	private _mrker = markers select _i;
	private _mkrPos = (getMarkerPos _mrker);
	if (listeners findif {(_x select 0) distance2D _mkrPos < (_x select 1) + _overDistance}  != -1) then {
		activeAreaMarkers pushBackUnique _mrker;
	};
};
publicVariable "activeAreaMarkers";