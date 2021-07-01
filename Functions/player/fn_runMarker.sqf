_marker = createMarker [ format["%1",getPlayerUID player], position player ];
_marker setMarkerColorLocal "ColorBLUFOR";
_marker setMarkerTypeLocal  "mil_triangle";
_marker setMarkerTextLocal profileName;
addMissionEventHandler ["HandleDisconnect",{deleteMarker format["%1",(_this select 2)]; deletevehicle (_this select 0)}];
call {while {true} do
        {
          if ((vehicle player) != player) then {
            if ((getMarkerColor (format ["%1_marker",(vehicle player)])) =="") then {
              (vehicle player) remoteExec ["TR_fnc_vehicleMarker", 2, false];
            };
            _marker setMarkerTextLocal "";
            _marker setMarkerAlpha 0;
          } else {
            _marker setMarkerTextLocal profileName;
            _marker setMarkerAlpha 0;
          };
          if((lifeState player) == "INCAPACITATED") then {
            _marker setMarkerColor "ColorRed";
          } else {
            _marker setMarkerColor "ColorBLUFOR";
          };
          _marker setMarkerPos getPos player;
          _marker setMarkerDir getDir player;
        sleep 0.5;
      };
    };