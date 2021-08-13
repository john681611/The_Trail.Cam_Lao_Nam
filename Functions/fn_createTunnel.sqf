params ["_tunnelNo", "_tpos"];

// These are the tunnel positions on the map
private _pos = [[393.346,16979.3,0],[253.172,18696.2,0],[540.936,20206.0,0],[2730.52,20066.4,0],[4252.47,20084.8,0],[5769.42,20088.9,0]] select _tunnelNo;

// Find the tunnel objects for your location
private _tunnels = nearestObjects [_pos,["Land_vn_tunnel_01_building_01_01","Land_vn_tunnel _01_building_04_01","Land_vn_tunnel_01_building_03 _01","Land_vn_tunnel_01_building_02_01"],200];

// Create the logic and stor logic object into global variable
private _grp = createGroup sideLogic;
_unit = _grp createUnit ["vn_module_tunnel_init", _tpos, [], 0, "NONE"];
_unit setVariable ['BIS_fnc_initModules_disableAutoActivation',true,true];
// Now set the wanted tunnel
_unit setvariable ["tunnel_position",_tunnelNo];

tunnels pushBack _unit;

// Call the init module function
["",[_unit,true]] call vn_fnc_module_tunnel_init;

// And finally spawn the units in your tunnel segments
private _group = [_tunnels,EAST,20,['vn_o_men_vc_regional_01','vn_o_men_vc_regional_04 ']] call vn_fnc_tunnel_spawn_units;
([units _group] + [_unit]) remoteExec ["TR_fnc_addToAllCurators", 2];
_group enableDynamicSimulation true;


units _group