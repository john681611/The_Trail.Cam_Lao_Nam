params["_unit", "_range", ["_canKill", false]];

_opts = [_unit, ['ColorBlue', 'ColorGreen'], _range] call TR_fnc_getNearbyMarkers;

if(count _opts == 0 OR (random 10) < 4) exitWith {
	if(alive _unit) then {
		_unit globalChat "I know nothing, leave me alone!";
		if(_canKill && (random 10) < 2) then {
			_unit setDamage 1;
		};
	} else {
		 hint "You find nothing";
	};
};

_choise = selectRandom _opts;
_message = "";

if(_choise in trail) then {
	_message = "Supply Line Observed";
	if(alive _unit) then {
		_unit globalChat "They're building something around there on the map!";
	} else {
		 hint "You find intel on a location of the trail!";
	};
} else {
	if((getMarkerColor _choise) == 'ColorOrange') then {
		if(alive _unit) then {
			_unit globalChat "People need help over there they are sick!";
		} else {
			hint "You find intel on Civies in need of aid";
		};
		_message = "Sick civies";
	} else {
		_message = "Enemy spotted";
		if(alive _unit) then {
			_unit globalChat "I saw men with guns around there on the map!";
		} else {
			hint "You find intel on a enemy location!";
		};
	};
};
_posx = (getMarkerPos _choise select 0) + random [-200, 0, 200];
_posy = (getMarkerPos _choise select 1) + random [-200, 0, 200];
_mkr = createMarker [format["intel%1%2", _posx, _posy],[_posx, _posy]];
_mkr setMarkerColorLocal "ColorGrey";
_mkr setMarkerTypeLocal "hd_unknown";
_mkr setMarkerTextLocal format ["Intel: %1 nearby", _message];
_mkr setMarkerAlpha 1;

if(_canKill && (random 10) < 2) then {
	_unit setDamage 1;
};