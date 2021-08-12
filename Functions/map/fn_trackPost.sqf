params["_post", "_name"];


_mkr = createMarker [format["%1", _post], getPos _post];
_mkr setMarkerColorLocal "colorBLUFOR";
_mkr setMarkerTypeLocal "b_installation";

_post addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
	_unit setDamage 0;
}];

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