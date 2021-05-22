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

if(_position select 2 == 0) then {
    _position set [2, getTerrainHeightASL _position];
};

// Clear existing waypoints first
private _waypoints = waypoints _group;
{
    deleteWaypoint [_group, 0];
} forEach _waypoints;

{
    _x enableAI "PATH";
} forEach units _group;

diag_log format ["%1", _position];
[_group, _position, _radius, "SAD", "AWARE", "RED"] call CBAEXT_fnc_addWaypoint;