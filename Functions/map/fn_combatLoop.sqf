params ["_markers"];
	_activeZones = createHashMap;
	while {true} do {
		sleep 3;
		if(trailState !="attacking") then {
			//Is a _activeZones clear?
			{
				if({alive _x} count (units _y) == 0)then {
					_x setMarkerColor "ColorBlue";
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
					};
				}
			} forEach _activeZones;

			_triggerPlayers = allPlayers select {getPosATL _x select 2 < 50  AND (speed _x) < 100}; //don't care about flying players over 50m or going over 100kmh
			_needActivating = _markers select { 
				_mrk = _x; 
				(getMarkerColor _x) == "ColorOpfor" AND !(_x in _activeZones) AND (selectMin (allPlayers apply {_x distance2D (getMarkerPos _mrk)})) < 300 
				};
			_needsDeactivatingKeys = (keys _activeZones) select {
				_mrk = _x;
				(selectMin (_triggerPlayers apply {_x distance2D (getMarkerPos _mrk)})) > 400
			}; 


			//Activate Zone and spawn units;
			{
				//REPLACE WITH GET UNITS
				_grp = createGroup [east, false];
				_mkr = _x;
				_playerCount = allPlayers select {(getMarkerPos _mkr) distance _x < 500};
				_unitList = ["vn_o_men_vc_regional_01",
							"vn_o_men_vc_regional_02",
							"vn_o_men_vc_regional_03",
							"vn_o_men_vc_regional_04",
							"vn_o_men_vc_regional_05",
							"vn_o_men_vc_regional_06",
							"vn_o_men_vc_regional_07",
							"vn_o_men_vc_regional_08",
							"vn_o_men_vc_regional_09",
							"vn_o_men_vc_regional_10",
							"vn_o_men_vc_regional_11",
							"vn_o_men_vc_regional_12"];
				{
					_grp createUnit [ selectRandom _unitList, getMarkerPos _mkr, [], 50, "NONE"];
				} forEach _playerCount;
				_wp = _grp addWaypoint [(getMarkerPos _x), 50, 0];
				_wp setWaypointType "SAD";
				_grp setCurrentWaypoint _wp;
				// _x setMarkerBrush "Cross"; //DEBUG
				_activeZones set [_x, _grp];
				
			} forEach _needActivating;

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