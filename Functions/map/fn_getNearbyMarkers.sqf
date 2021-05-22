
params ["_unit","_ignoreColor", "_distanceLimit"];

 markers select { 
 ((getMarkerPos _x) distance2D _unit < _distanceLimit) 
  && !((getMarkerColor _x) in _ignoreColor) 
 }
