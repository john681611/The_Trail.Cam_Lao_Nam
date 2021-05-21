params ["_marker","_markers","_excluded", "_distanceLimit"];
_markersFiltered = [];

{
	
	if!(_x in _excluded) then {
		_markersFiltered pushBack _x;
	}
	
} forEach  _markers;
if(typeName _marker == "STRING") then {
	_markersFiltered select {(getMarkerPos _x) distance2D (getMarkerPos _marker) < _distanceLimit}
} else {
	_markersFiltered select {(getMarkerPos _x) distance2D _marker < _distanceLimit}
};