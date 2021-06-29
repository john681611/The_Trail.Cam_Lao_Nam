params["_box"];
_radar = (attachedObjects _box) select 0;
if(isObjectHidden  _radar) then {
	_radar hideObjectGlobal false;
	listeners pushBackUnique [_radar,2500];
	publicVariable "listeners";
	_box setVectorUp [0, 0, 1];
} else {
	_radar hideObjectGlobal true;
};
