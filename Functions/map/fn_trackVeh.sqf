params["_veh"];
_veh allowDamage false;
_vehName = _veh getVariable ["respawnVehicle", _veh];
_name = getText (configFile >> "CfgVehicles" >> typeOf _vehName >> "displayName");
_mkr = createMarker [format["%1", _veh], getPos _veh];
_mkr setMarkerColorLocal "colorBLUFOR";
_mkr setMarkerTypeLocal "loc_LetterV";

if(_veh isKindOf "ReammoBox_F") then {
	_mkr setMarkerTypeLocal "loc_Box";	
};

sleep 3;
_veh allowDamage true;


while {alive _veh} do {
	private _players = "";
	{
		if (_x in _veh) then {
			if(_players == "") then {
				_players = (name _x);
			} else {
				_players = _players + ", " + (name _x);
			};
		};
	} foreach allplayers;
	if(_veh inArea safezone and _players == "") then {
		_mkr setMarkerAlphaLocal 0.2;
	} else {
		_mkr setMarkerAlphaLocal 1;
	};
	if(damage _veh > .8) then {
		_mkr setMarkerTextLocal format["- %1 (Damaged) %2", _name, _players];
		_mkr setMarkerColorLocal "colorRed";
	} else {
		_mkr setMarkerTextLocal format["- %1 %2", _name, _players];
		_mkr setMarkerColorLocal "colorBLUFOR";
	};
	_mkr setMarkerPosLocal (getpos _veh);
	_mkr setMarkerDir ((getDir _veh) + 180);
	sleep 1; 
};
deleteMarker _mkr;


//Spawn Wreck Container
_act = _veh addAction ["Pack wreck",{
	params ["_target", "_caller", "_actionId", "_arguments"];
	_name = getText (configFile >> "CfgVehicles" >> typeOf _target >> "displayName");
	_box = "vn_us_komex_medium_02" createVehicle (getPos _target);
	_target setPos [0,0,0];
	_box setVariable ["respawnVehicle", _target];
	call{_box spawn TR_fnc_trackVeh;};
}, nil, 1.5, true, true, '', "true", 20];