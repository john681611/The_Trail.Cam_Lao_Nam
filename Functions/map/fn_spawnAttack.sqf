"VC_base" setMarkerAlpha 1;
trailState = "abandoned";
private _faction = selectRandom factions;
private _playerCount = (count allPlayers) min 15;
private _forceConfig = createHashMapFromArray [
		["MBT", ceil _playerCount/5],
		["AAA", ceil _playerCount/5],
		["IFV", ceil _playerCount/4],
		["AAGroup",ceil _playerCount/4],
		["ATGroup", ceil _playerCount/4],
		["reconGroup", ceil _playerCount/5],
		["mainGroup", _playerCount],
		["Car", _playerCount],
		["turret", ceil _playerCount/3]];
private _spawnedUnits = ["VC_base", 750, _forceConfig, _faction, true] call TR_fnc_spawnForce;

waitUntil {sleep 5; {alive _x} count _spawnedUnits < 10 };

"EveryoneWon" call BIS_fnc_endMissionServer;