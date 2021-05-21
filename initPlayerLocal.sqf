addMissionEventHandler ["PreloadFinished", {preloadFinished = true;}];
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
[] spawn TR_fnc_runMarker;
[] spawn TR_fnc_initEarplugs;
// [player, markers, 200] spawn TR_fnc_initLiseningDevice;


//ADD "HOW TO" TO FIELD MANUAL?
player createDiarySubject ["teamspeak", "Teamspeak"];
player createDiaryRecord ["teamspeak", ["TS3", "
<br/> You can download Teamspeak here:<br/>
<br/> http://www.teamspeak.com/?page=downloads
<br/>
"]];
player createDiaryRecord ["teamspeak", ["IRON FISTS", "
<br/> Teamspeak IP-address for the INF server:
<br/> ts3.iron-fists.co.uk
<br/>
<br/> Visitors and guests welcome!
"]];

player createDiarySubject ["Settings & Keybinds", "Settings & Keybinds"];
player createDiaryRecord ["Settings & Keybinds", ["Settings & Keybinds", "
<br/>Click <execute expression = '[] spawn CHVD_fnc_openDialog;'>View Distance Settings.</execute>
<br/>Click <execute expression = '[] call outlw_MR_createDialog;'>Mag Repack</execute> (Ctrl+R)
<br/>Click <execute expression = '[] call toggle_earplugs;'>Toggle Earplugs</execute> (Pause/Break)
"]];
