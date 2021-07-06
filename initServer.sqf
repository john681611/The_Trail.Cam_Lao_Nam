[] call TR_fnc_getMarkers;
publicVariable "markers";	
noise = [50, "ColorOpfor", ["ColorOpfor"]] call TR_fnc_setRandomZonesTo;
illness = [10,  "ColorOrange", []] call TR_fnc_setRandomZonesTo;






factions = ["VC"];
trail = ["VC_base"];
excludeTrail = [];
[] spawn TR_fnc_generateTrail;



[noise, markers, 5, "ColorOpfor", ["ColorOrange"]] call TR_fnc_generateAOE;
[illness, markers, 3, "ColorOrange", ["ColorOpfor"]] call TR_fnc_generateAOE;
[["CAPITAL_BASE"], markers, 5, "ColorGreen", []] call TR_fnc_generateAOE;







[] spawn TR_fnc_initMainLoop;
addMissionEventHandler ["HandleDisconnect",{deleteMarker format["%1",(_this select 2)]; deletevehicle (_this select 0)}];
hint "Finished setting up the map";

