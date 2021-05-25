params["_unit", "_range", ["_canKill", false]];

_opts = [_unit, ['ColorBlue', 'ColorGreen'], _range] call TR_fnc_getNearbyMarkers;

if(alive _unit) then {
	if(_canKill) then {
		systemChat "Player: Tell me what you know about the VC otherwise you may never see tomorrow.";
	} else {
		systemChat "Player: Can you tell me what you know about local VC movements?";
	};
};

if(count _opts == 0 OR (random 10) < 4) exitWith {
	if(alive _unit) then {
		systemChat "Civ: I know nothing, leave me alone!";
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
		systemChat "Civ: They're building something around there on the map!";
	} else {
		 hint "You find intel on a location of the trail!";
	};
} else {
	if((getMarkerColor _choise) == 'ColorOrange') then {
		if(alive _unit) then {
			systemChat "Civ: People need help over there they are sick!";
		} else {
			hint "You find intel on Civies in need of aid";
		};
		_message = "Sick civies";
	} else {
		_message = "Enemy spotted";
		if(alive _unit) then {
			systemChat "Civ: I saw men with guns around there on the map!";
		} else {
			hint "You find intel on a enemy location!";
		};
	};
};
_posx = (getMarkerPos _choise select 0) + random [-200, 0, 200];
_posy = (getMarkerPos _choise select 1) + random [-200, 0, 200];
_now = date;
_mkr = createMarker [format["intel%1%2", _posx, _posy],[_posx, _posy]];
_mkr setMarkerColorLocal "ColorUNKNOWN";
_mkr setMarkerTypeLocal "hd_unknown";
_mkr setMarkerTextLocal format ["Intel: %1 nearby: %2:%3 %4/%5", _message, _now select 3, _now select 4, _now select 2,_now select 1];
_mkr setMarkerSizeLocal [0.7,0.7];
_mkr setMarkerAlpha 1;

if(_canKill && (random 10) < 2) then {
	_unit setDamage 1;
};