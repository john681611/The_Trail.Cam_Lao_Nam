_caller = _this select 0;


to_Base =
 {
private ["_Location"];
    _Location = _this select 0;
    _unit = player;
    _unit setVehiclePosition [_Location, [], 0, "NONE"];
    _unit allowDamage false;
    sleep 5;
    _unit allowDamage true;
 };

 _missionsData = [];

  {
     _marker = _x;
     _name = markerText _x;
    _missionsData append [[getMarkerPos  _marker,to_Base,_name,_name,"","",1,[getMarkerPos _marker]]];
 } forEach (([west, false] call BIS_fnc_getRespawnMarkers) + (west call BIS_fnc_getRespawnPositions));


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
