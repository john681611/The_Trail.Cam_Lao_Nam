for "_i" from 0 to (count activeAreaMarkers) -1 do {
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