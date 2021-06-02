
class Trail
{
	// Topic title (displayed only in topic listbox in Field Manual)
	displayName = "The Trail";
	class Overview
	{
		displayName = "Overview";
		displayNameShort = "Overview";
		description = "The Trail %1Based on the Ho Chi Minh it will slowly build from a hidden base to Saigon and if left unchecked will attack it.%1Find the trail using all the tools at your disposal and force them to abandon it.%1Once the trail is abandoned take out the revealed base to win!%1%1 Tail States%1%2 - Building - Finding its way Saigon.%1%2 - Reeling - Falling back a few locations to re-route after you just cut it.%1%2 - Supplying - Its at Saigon and is prepairing for an attack.%1%2 - Attacking - Saigon is under attack and you cannot do anything about the trail untill the attack has been repulsed. Once over the Trail will return to Supplying in preperation for another attack.%1%2 - Abandoned - You have successfully blocked off the trail and their base has been revealed.%1%1Finding the Trail%1Currently the only way to find the trail is to setup Outposts across the map and look out for zones turning red.%1%1Affecting the Trail%1Apart from cutting the trail by clearing hostiles from one of its zones you can clear other red zones slow its progress capturing that zone by 2x%1 Turning Blue and Grange zones green with supplies will slow tail building progress by 3x comaired to capturing a red zone%1%1";
		arguments[] = {
		};
	};
	class Map
	{
		displayName = "Map";
		displayNameShort = "Map";
		description = "The Map%1 You will notice that generally the map seems empty. Its not at all but your only been shown what intel we can gather from the Airbase Radar and any Outposts you have setup%1 you also have a very small range perception round your character revealing the surrounding.%1 Map Zones%1%2 - Red - Hositle, will spawn VC to resist you clear them out to turn Blue. You know a zone is active when your being shot at.%1%2 - Green - Friendly, resists the tail best and is easiest to spot being affected.%1%2 - Blue - Neutral, can be easily turned red by The Trail or can be turned Green by Distrubuting Food nearby.%1%2 - Orange - Ill can easily fall to the Trail but can be turned green by Distrubuting Aid.";
		arguments[] = {
		};
	};
	class OutPosts
	{
		displayName = "OutPosts";
		displayNameShort = "OutPosts";
		description = "OutPosts%1 Initally packed up at base you can transport these across the map and deploy them (As long as there are only Green Zones in the vicinity).%1 Once deployed they act as a intel gathering station revealing the zones around them. They also can be teleported to and from.%1 You have a limited ammount so be tatical with their use.";
		arguments[] = {
		};
	};
	class Intel
	{
		displayName = "Intel";
		displayNameShort = "Intel";
		description = "Gathering Intel%1 You can gather intel from two sources, searching bodies of officers or by questioning civilians.%1%1Officers look a bit more formal military than the usual units you will be fighting with olive green smock and helmet once killed you can search their body for intel.%1%1Civilian questioning comes in two forms depenging on surrounding zones.%1%2a civ with only friendly zones around them are usually cooperative and freely give informaiton.%1%2 a civ with neutral zones nearby will be less cooperative and questioning can be violent which can be fatal for the civ.%1%1 Intel its self depends on where you collect it officers can have intel further away from where they are operating than civilians.%1Intel can tell you one of three things:%1%2The Trail%1%2Ill civilians%1%2Hostile zones%1%1a Marker is placed on the map including a date and time when it was collected.";
		arguments[] = {
		};
	};
	class Civilians
	{
		displayName = "Civilians";
		displayNameShort = "Civilians";
		description = "Civilians%1 found roaming neutral and friendly zones are a good source of intel. Be wary as our relations with civilians is fragile at best. A civ perishing for any reason is blamed on us and means the area quickly takes up armes against you.";
		arguments[] = {
		};
	};
	class Distrubuting
	{
		displayName = "Distrubuting Food and Aid";
		displayNameShort = "Distrubuting";
		description = "Distrubuting Food and Aid%1 Food and Aid pallets can be found at base. Moving them to their respective zones and using the Distrubute action will effect the local zones. Each pallet has infinate supply but isn't tracked so don't loose them.";
		arguments[] = {
		};
	};
	class Teleporting
	{
		displayName = "Teleporting";
		displayNameShort = "Teleporting";
		description = "Teleporting%1 Both HQ and Saigon Camp have latines you can use to teleport. Outposts also have the ability to teleport you accross the map.%1 Vehicles can also be teleported but be aware its dangerous.";
		arguments[] = {
		};
	};
};