_caller = _this select 0;


to_Base =
 {
private ["_Location"];
    _Location = _this select 0;
    _unit = vehicle player;
    _unit setVehiclePosition [_Location, [], 50, "NONE"];
    _unit allowDamage false;
    sleep 5;
    _unit allowDamage true;
 };

 _missionsData = [];


 {
     _unit = _y;
    if!(isObjectHidden _unit) then {
      _name = _x;
      _missionsData append [[getPos  _unit,to_Base,_name,_name,"","",1,[getPos _unit]]];
    };
 } forEach createHashMapFromArray [
    ["HQ", hq_tele],
    ["Camp Siagon", capital_tele],
    ["Outpost Able", rad1],
    ["Outpost Baker", rad2],
    ["Outpost Charlie", rad3],
    ["Outpost Dog", rad4]
 ];

 if((count allPlayers) < 5 && leader player != player) then {
    _unit= leader player;
    _name = format ["SL: %1", name _unit];
   _missionsData append [[getPos  _unit,to_Base,_name,_name,"","",1,[getPos _unit]]];
 };


 disableserialization;

 _parentDisplay = [] call bis_fnc_displayMission;
 _mapCenter     = getpos player;
 _ORBAT         = [];
 _markers   = [];
 _images    = [];
 _overcast  = overcast;
 _isNight   = !((dayTime > 6) && (dayTime < 20));
 _scale     = 0;
 _simul     = true;

      [
    findDisplay 46,
    _mapCenter,
    _missionsData,
    _ORBAT,
    _markers,
    _images,
    _overcast,
    _isNight,
    _scale,
    _simul
 ] call Bis_fnc_strategicMapOpen;
