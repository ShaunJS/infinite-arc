blueprintMode = false;
blueprintAlpha = 0;
image_speed = 0;
image_index = 0;

messageContent = "";
messagePlaying = 0;
messageJustStarted = false;
messageFadeOut = false;

statsAlpha = 0;
statsShow = false;
engineAlpha = 0;
enginesOn = false;

inventory = ds_grid_create(SHIP_WIDTH,SHIP_HEIGHT);
ds_grid_clear(inventory,-1);

//Define shape of ship interior
inventory [# 1, 2] = 0;
inventory [# 2, 1] = 0;
inventory [# 2, 2] = 0;
inventory [# 2, 3] = 0;
inventory [# 3, 1] = 0;
inventory [# 3, 2] = 0;
inventory [# 3, 3] = 0;
inventory [# 4, 1] = 0;
inventory [# 4, 2] = 0;
inventory [# 4, 3] = 0;
inventory [# 5, 1] = 0;
inventory [# 5, 2] = 0;
inventory [# 5, 3] = 0;
inventory [# 6, 1] = 0;
inventory [# 6, 2] = 0;
inventory [# 6, 3] = 0;
inventory [# 7, 2] = 0;



inventory [# 2, 2] = new module("warpdrive");
inventory [# 2, 1] = new module("colonists");
inventory [# 2, 3] = new module("colonists");
inventory [# 3, 1] = new module("colonists");
inventory [# 3, 3] = new module("colonists");
inventory [# 5, 2] = new module("food");
inventory [# 3, 2] = new module("artifact");
inventory [# 4, 2] = new module("fuel");
inventory [# 7, 2] = new module("you",100);

hp = 1000;
hpmax = 1000;
armour = 0;
shields = 0;
shieldsmax = 0;
speedlocal = 2;
speedwarp = 0;
crew = 0;
colonists = 0;
probes = 0;
fuel = 0;
food = 0;
materials = 0;
foodconsumption = 0;
fuelconsumption = 0;
attackenergy = 0;
attackphysical = 0;
distanceTravelled = 0;
fuelEaten = 0;
foodEaten = 0;
paused = false;

warnFood = false;
warnFuel = false;
warnShields = false;
warnHull = false;
doomAlpha = 0;


UpdateStats();
var _eventTypes = ds_list_size(global.eventData[? "basicevents"])
//NewEvent("planetevents",0,0.2);
//NewEvent("basicevents",7,0.5);
var _dist = 6;
var _planetEvery = 5;
var _nextPlanetAt = _planetEvery;
var _eventNo = 1;
var _lastEvent = [-1,-1,-1]
repeat(400)
{
	if (_eventNo == _nextPlanetAt)
	{
		_nextPlanetAt += _planetEvery;
		NewEvent("planetevents",0,_dist);
	}
	else
	{
		var _rando = irandom(_eventTypes-1)
		while ((_rando == _lastEvent[0]) || (_rando == _lastEvent[1]) || (_rando == _lastEvent[2]))
		{
			_rando = irandom(_eventTypes-1)
		}
		_lastEvent[2] = _lastEvent[1];
		_lastEvent[1] = _lastEvent[0];
		_lastEvent[0] = _rando;
		NewEvent("basicevents",_rando,_dist);
	}
	_dist += random_range(7,9);	
	_eventNo++
}

if (global.killedthetwinship == true)
{
	with (oEvent) if (abs(distance - global.twinshiptime) <= 4) instance_destroy();
	NewEvent("gameoverevents",6,global.twinshiptime);
}