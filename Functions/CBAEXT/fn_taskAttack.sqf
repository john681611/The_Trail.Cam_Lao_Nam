#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_taskAttack
Description:
    A function for a group to attack a parsed location.
Parameters:
    - Group (Group or Object)
    - Position (XYZ, Object, Location or Group)
Optional:
    - Search Radius (Scalar)
    - Remove Assigned Waypoints (Bool)
Example:
    (begin example)
    [group player, getPos (player findNearestEnemy player), 100] call CBA_fnc_taskAttack
    (end)
Returns:
    Nil
Author:
    Rommel
---------------------------------------------------------------------------- */

params ["_group", "_position", ["_radius", -1], ["_override", false]];

if !(local _group) exitWith {}; // Don't create waypoints on each machine

// Allow TaskAttack to override other set waypoints
if (_override) then {
    // Clear existing waypoints first
	private _waypoints = waypoints _group;
	{
		deleteWaypoint [_group, 0];
	} forEach _waypoints;

    {
        _x enableAI "PATH";
    } forEach units _group;
};

[_group, _position, _radius, "SAD", "COMBAT", "RED"] call CBAEXT_fnc_addWaypoint;