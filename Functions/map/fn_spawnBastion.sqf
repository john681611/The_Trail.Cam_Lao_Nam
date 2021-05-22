trailState = "attacking";
private _faction = selectRandom factions;
private _playerCount = (count allPlayers) min 8;
private _forceConfig = createHashMapFromArray [
		["MBT", ceil _playerCount/5],
		["AAA", ceil _playerCount/5],
		["IFV", ceil _playerCount/4],
		["AAGroup",ceil _playerCount/4],
		["ATGroup", ceil _playerCount/4],
		["reconGroup", ceil _playerCount/5],
		["mainGroup", _playerCount],
		["Car", _playerCount]
		];
private _spawnedUnits = ["CAPITAL_BASE", 750, _forceConfig, _faction, false] call TR_fnc_spawnForce;
sleep 30;

//Only allow spawn at base or City
_triggerCount =  3 max floor ((count _spawnedUnits)/10);
waitUntil {sleep 5; {alive _x} count _spawnedUnits < _triggerCount};
hint "attack over";
trailState = "supplying";
[] spawn TR_fnc_generateTrail;