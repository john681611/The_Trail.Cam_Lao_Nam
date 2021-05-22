params["_post", "_name"];

_mkr = createMarker [format["%1", _post], getPos _post];
_mkr setMarkerColor "colorBLUFOR";
_mkr setMarkerType "b_installation";


while {true} do {
	_mkr setMarkerPos (getpos _post);
	_radar = (attachedObjects _post) select 0;
	if(isObjectHidden _radar) then {
		_mkr setMarkerText format["%1 (packed)", _name];
	} else {
		_mkr setMarkerText _name;
	};
	sleep 10; 
};