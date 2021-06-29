"VC_base" setMarkerAlpha 1;
trailState = "abandoned";
private _faction = selectRandom factions;
private _playerCount = (count allPlayers) min 15;
private _forceConfig = createHashMapFromArray [
		["MBT", ceil _playerCount/5],
		["reconGroup", ceil _playerCount/5],
		["mainGroup", _playerCount],
		["Car", _playerCount],
		["turret", ceil _playerCount/3]];
private _spawnedUnits = ["VC_base", 200, _forceConfig, _faction, true] call TR_fnc_spawnForce;

sleep 30;
_triggerCount =  3 max floor ((count _spawnedUnits)/10);
waitUntil {sleep 5; {alive _x} count _spawnedUnits < _triggerCount };

"EveryoneWon" call BIS_fnc_endMissionServer;