params ["_markers"];
	_activeZones = createHashMap;
	while {true} do {
		sleep 3;
		if(trailState !="attacking") then {
			{
				if({alive _x} count (units _y) == 0)then {
					if((getMarkerColor _x) in ["ColorBlue", "ColorGreen"]) then {
						_x setMarkerColor "ColorOpfor";
					} else {
						_x setMarkerColor "ColorBlue";
					};
					deleteGroup _y;
					_activeZones deleteAt _x;
					if(_x in trail) then {
						_trailIndex = trail find _x;
						if(_trailIndex > 5) then {
							trail = trail select [_trailIndex - 3, count trail];
						} else {
							trail = [trail select 0];
						};
						[excludeTrail, ([_x, _markers, [], 500] call TR_fnc_getAjacentMarkers)] call BIS_fnc_arrayPushStack;
						trailState = "reeling";
						
						uiNamespace setVariable ["trailState", trailState];
					};
				}
			} forEach _activeZones;

			_triggerPlayers = allPlayers select {getPosATL _x select 2 < 50  AND (speed _x) < 100}; //don't care about flying players over 50m or going over 100kmh
			_needActivating = _markers select { 
				_mrk = _x; 
				(getMarkerColor _x) == "ColorOpfor" AND !(_x in _activeZones) AND (selectMin (allPlayers apply {_x distance2D (getMarkerPos _mrk)})) < 300 
				};
			_needCiviActivating = _markers select { 
				_mrk = _x; 
				(getMarkerColor _x) in ["ColorBlue", "ColorGreen"] AND !(_x in _activeZones) AND (selectMin (allPlayers apply {_x distance2D (getMarkerPos _mrk)})) < 200 and (random 10) < 1
				};
			_needsDeactivatingKeys = (keys _activeZones) select {
				_mrk = _x;
				(selectMin (_triggerPlayers apply {_x distance2D (getMarkerPos _mrk)})) > 400
			}; 


			//Activate Zone and spawn units;
			{
				_grp = createGroup [east, false];
				_mkr = _x;
				_unitSet = "Inf_local";
				_playerCount = 3 max (15 min (count (allPlayers select {(getMarkerPos _mkr) distance _x < 500})));
				if(_x in trail) then {
					_unitSet = "Inf_regional";
					_playerCount = _playerCount * 2;
				};
				for "_i" from 1 to _playerCount do {
					_grp createUnit [(["VC", _unitSet] call TR_fnc_getUnits), getMarkerPos _mkr, [], 50, "NONE"];
				};
				if(random 10 < 1) then {
					_unit = _grp createUnit ["vn_o_men_nva_01", getMarkerPos _mkr, [], 50, "NONE"];
					_unit spawn TR_fnc_addHostileIntelAction;
				};
				[units _grp] remoteExec ["TR_fnc_addToAllCurators", 2];
				[_grp, (getMarkerPos _x) , 50, 3, 0.1, 0.1, true] call CBAEXT_fnc_taskDefend;
				// _x setMarkerBrush "Cross"; //DEBUG
				_activeZones set [_x, _grp];
				
			} forEach _needActivating;

			//Activate civie Zone and spawn units;
			{

				_grp = createGroup [civilian, false];
				_mkr = _x;
				_unit = _grp createUnit [(["CIV", "Inf"] call TR_fnc_getUnits), getMarkerPos _mkr, [], 50, "NONE"];
				_unit spawn TR_fnc_addCivIntelAction;
				[units _grp] remoteExec ["TR_fnc_addToAllCurators", 2];
				_grp setSpeedMode "LIMITED";
				[_grp, (getMarkerPos _x), 50] call CBAEXT_fnc_taskPatrol;
				// _x setMarkerBrush "Cross"; //DEBUG
				_activeZones set [_x, _grp];
				
			} forEach _needCiviActivating;

			//Deactivate Zone and delete units;
			{
				_grp = _activeZones get _x;
				{
					deleteVehicle _x;	
				} forEach units _grp;
				deleteGroup _grp;
				_x setMarkerBrush "Solid"; //DEBUG
				_activeZones deleteAt _x;
				
			} forEach _needsDeactivatingKeys;
		};

	};