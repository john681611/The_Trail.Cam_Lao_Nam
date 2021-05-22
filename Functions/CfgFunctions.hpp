class IA
{
	tag = "TR";
	class script
	{
		file = "Functions";
		
		class addToAllCurators {};
		class getUnits {};
		class getUnitsFromConfigGroup {};
		class hideInBuilding {};
		class spawnGroup {};
		class spawnForce{};
		class spawnUnit {};
		class spawnVehicle {};
		class teleport{};
		class teleport_add_action{};
		class distribute_add_action{};
	};

	class MAP
	{
		file = "Functions\map";
		class getMarkers{};
		class setRandomZonesTo{};
		class generateTrail{};
		class getAjacentMarkers{};
		class generateAOE{};
		class initLiseningDevice{};
		class combatLoop{};
		class spawnAO{};
		class spawnBastion{};
	}


	class PLAYER
	{
		file = "Functions\player";
		class runMarker{};
		class vehicleMarker{};
		class initEarplugs{}
	}
};

class CBAEXT
{
	tag = "CBAEXT";
	class script
	{
		file = "Functions\CBAEXT";
		class addWaypoint{};
		class taskDefend{};
		class taskPatrol{};
		class taskAttack{};

	};
};

class COMP
{
	tag = "COMP"
	class script
	{
		file = "Compositions";
		class minefield{}
	}
}