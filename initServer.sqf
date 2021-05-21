[] call TR_fnc_getMarkers;

noise = [markers, 50, "ColorOpfor", ["ColorOpfor"]] call TR_fnc_setRandomZonesTo;
illness = [markers, 10,  "ColorOrange", []] call TR_fnc_setRandomZonesTo;




trail = ["VC_base"];
excludeTrail = [];
[] spawn TR_fnc_generateTrail;



[noise, markers, 5, "ColorOpfor", ["ColorOrange"]] call TR_fnc_generateAOE;
[illness, markers, 3, "ColorOrange", ["ColorOpfor"]] call TR_fnc_generateAOE;
[["CAPITAL_BASE"], markers, 5, "ColorGreen", []] call TR_fnc_generateAOE;







[markers] spawn TR_fnc_combatLoop;
hint "Finished setting up the map";