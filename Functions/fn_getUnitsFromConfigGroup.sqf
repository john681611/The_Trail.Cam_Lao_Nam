params ["_config"];
_array = [];
"_array pushBack getText ( _x >> 'vehicle' )" configClasses _config;

_array;