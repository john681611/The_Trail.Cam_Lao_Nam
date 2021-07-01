if!(isServer) exitWith{};
[
	_this,											// Object the action is attached to
	"Search",										// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",	// Progress icon shown on screen
	"_this distance _target < 3 and !(alive _target) and _target getVariable ['notSearched', true]",						// Condition for the action to be shown
	"true",						// Condition for the action to progress
	{},													// Code executed when action starts
	{},													// Code executed on every progress tick
	{   
		[_target, 6000] call TR_fnc_tryIntel;
	},
	{},	
	{
	},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	5,													// Action duration [s]
	999,													// Priority
	true,												// Remove on completion
	false												// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0];	// MP compatible implementation