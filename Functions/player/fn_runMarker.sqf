_marker = getPlayerUID player;

if !((getPlayerUID player) in allMapMarkers) then {
  _marker = createMarker [ format["%1",getPlayerUID player], position player ];
};

_marker setMarkerColorLocal "ColorBLUFOR";
_marker setMarkerTypeLocal  "mil_triangle";
_marker setMarkerTextLocal profileName;
call {while {true} do
        {
          if ((vehicle player) != player) then {
            _marker setMarkerAlphaLocal 0;
          } else {
            _marker setMarkerAlphaLocal 1;
          };
          if((lifeState player) == "INCAPACITATED") then {
            _marker setMarkerColorLocal "ColorRed";
          } else {
            _marker setMarkerColorLocal "ColorBLUFOR";
          };
          _marker setMarkerPosLocal getPos player;
          _marker setMarkerDir getDir player;
        sleep 0.5;
      };
    };