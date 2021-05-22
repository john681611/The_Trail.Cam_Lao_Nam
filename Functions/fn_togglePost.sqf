params["_box"];
_box setVectorUp [0, 0, 1];
_radar = (attachedObjects _box) select 0;
if(isObjectHidden  _radar) then {
	_radar hideObjectGlobal false;
	listeners pushBackUnique [_radar,3000];
	publicVariable "listeners";
} else {
	_radar hideObjectGlobal true;
};
