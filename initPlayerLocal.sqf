addMissionEventHandler ["PreloadFinished", {preloadFinished = true;}];
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
[] spawn TR_fnc_runMarker;
[] spawn TR_fnc_initEarplugs;



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

"Welcome to The Trail" hintC [
"If this is your first time check out the Field Manual.",
"Follow the server rules and respect others."];

[[player]] remoteExec ["TR_fnc_addToAllCurators", 2];
waitUntil {!(isNil "listeners")};
listeners pushBackUnique [player,200];
publicVariable "listeners";
while {true} do {
	with uiNamespace do {
		if(!(isNil "trailState")) then {
			if(isNil "stateIcon") then {
				stateIcon = findDisplay 46 ctrlCreate ["RscPicture", 1579];
			} else {
				if(stateIcon isEqualTo controlNull) then {
					stateIcon = findDisplay 46 ctrlCreate ["RscPicture", 1579];
				};
			};
			_ctrlWidth = 0.1; 
			_ctrlHeight = 0.1; 
			_xpos = ( safeZoneX + ( safeZoneWAbs / 2 )) - ( _ctrlWidth / 2 ) ; 
			_y = (safeZoneY)  + 0.01; 
			stateIcon ctrlSetPosition [ _xpos, _y, _ctrlWidth, _ctrlHeight ];
			stateIcon ctrlSetTextColor [1,0,0,1];
			stateIcon ctrlSetText format["Media\TrailState\%1.paa", trailState];
			stateIcon ctrlCommit 0;
		};
	};
	sleep 5;
};

