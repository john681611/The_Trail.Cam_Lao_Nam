private _loopCount = 1;
listeners = [];
publicVariable "listeners";
while {true} do {
	listeners = listeners select {alive (_x select 0)  && {!(isObjectHidden (_x select 0))}};
	publicVariable "listeners";
	if(_loopCount == 1) then {
		call TR_fnc_activeAreaPass;
	};
	[] spawn TR_fnc_liseningPass;
	[] spawn TR_fnc_combatPass;
	if(!(isNil "trailState")) then {
		publicVariable "trailState";
		publicVariable "trail";
		[uiNamespace,["trailState",trailState]] remoteExec ['setVariable',0];
		"trailStateMarker" setMarkerText format ["Trail state: %1", trailState];
	};
	if(_loopCount == 3) then {
		_loopCount = 0;
	};
	_loopCount = _loopCount + 1;
	sleep 10;
};


