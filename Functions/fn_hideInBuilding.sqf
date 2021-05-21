params ["_pos", "_radius", "_units"];


private _buildings = _pos nearObjects ["Building", _radius];

_buildings = _buildings select {
    private _positions = _x buildingPos -1;

    if (isNil {_x getVariable "CBA_taskDefend_positions"}) then {
        _x setVariable ["CBA_taskDefend_positions", _positions];
    };

	count (_positions) >= 1
};
{
	if(count _buildings == 0) exitWith{};
	private _building = selectRandom _buildings;
	private _array = _building getVariable ["CBA_taskDefend_positions", []];
	private _pos = _array deleteAt (floor (random (count _array)));
	_x setPos _pos;
	doStop _x;
	_building setVariable ["CBA_taskDefend_positions", _array];
} forEach _units;
