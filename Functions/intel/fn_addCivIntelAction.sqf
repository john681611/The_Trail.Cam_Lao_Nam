if!(isServer) exitWith{};
[
	_this,											// Object the action is attached to
	"Question",										// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Progress icon shown on screen
	"_this distance _target < 3 and (alive _target) and _target getVariable ['notSearched', true]",						// Condition for the action to be shown
	"true",						// Condition for the action to progress
	{
		doStop _target;
	},													// Code executed when action starts
	{},													// Code executed on every progress tick
	{   
		[_target, 4000, (count ([_target, ['ColorBlue'], 100] call TR_fnc_getNearbyMarkers)) > 0] call TR_fnc_tryIntel;
		_target doFollow _target;
	},
	{
		_target doFollow _target;
	},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	5,													// Action duration [s]
	1.4,													// Priority
	true,												// Remove on completion
	false												// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0];	// MP compatible implementation