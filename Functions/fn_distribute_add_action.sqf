if!(isServer) exitWith{};
[
	_this,											// Object the action is attached to
	"Distribute",										// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Progress icon shown on screen
	"_this distance _target < 3 and speed _target < 5",						// Condition for the action to be shown
	"_caller distance _target < 3",						// Condition for the action to progress
	{},													// Code executed when action starts
	{},													// Code executed on every progress tick
	{  if(typeOf _target == "vn_b_ammobox_supply_03") then {
			//Aid AOE
			[[_target], markers, 3, "ColorGreen",["ColorOpfor", "ColorBlue"]] spawn TR_fnc_generateAOE;
		} else {
			//Food AOE
			[[_target], markers, 3, "ColorGreen",["ColorOpfor","ColorOrange"]] spawn TR_fnc_generateAOE;				// Code executed on completion
		};
	},
	{},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	8,													// Action duration [s]
	1.3,													// Priority
	true,												// Remove on completion
	false												// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0, _this];	// MP compatible implementation
