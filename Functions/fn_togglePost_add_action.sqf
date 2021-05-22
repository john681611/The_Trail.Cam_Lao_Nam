[
	_this,											// Object the action is attached to
	"Deploy/UnDeploy",										// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Progress icon shown on screen
	"_this distance _target < 3 and speed _target < 5",						// Condition for the action to be shown
	"_caller distance _target < 3 and (count ([_target, ['ColorGreen'], 300] call TR_fnc_getNearbyMarkers)) == 0",						// Condition for the action to progress
	{},													// Code executed when action starts
	{},													// Code executed on every progress tick
	{   
		_target setVectorUp [0, 0, 1];
		_radar = (attachedObjects _target) select 0;
		if(isObjectHidden  _radar) then {
			_radar hideObjectGlobal false;
			listeners pushBackUnique [_radar,3000];
			publicVariable "listeners";
		} else {
			_radar hideObjectGlobal true;
		};
	},
	{
		if((count ([_target, ['ColorGreen'], 300] call TR_fnc_getNearbyMarkers)) > 0) then {
			hint "Area isn't secure!";
		};
	},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	8,													// Action duration [s]
	1.4,													// Priority
	false,												// Remove on completion
	false												// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0, _this];	// MP compatible implementation