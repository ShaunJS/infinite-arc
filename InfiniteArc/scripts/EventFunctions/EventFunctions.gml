function NewEvent(_eventType,_eventNumber,_distance,_effects)
{
	with (instance_create_depth(0,0,-5000,oEvent))
	{
		event = global.eventData[? _eventType][| _eventNumber];
		distance = oShip.distanceTravelled + _distance;
		effects = "";
		if (!is_undefined(argument[3])) 
		{
			effects = _effects;
			effects += "\n";
		}
		CompositeEvent();
	
	}
}

function CompositeEvent()
{
	content = "";
	content += "[fa_center]" + event[? "title"];
	content += "\n\n";
	if (event[? "description"] != "")
	{
		content += event[? "description"];
		content += "\n";
	}
	content += effects;
	
	responses = "\n";
	for (var i = 0; i < ds_list_size(event[? "responses"]); i++)
	{
		responses += "[#66CCAE]";
		if (ds_list_size(event[? "responses"]) > 1) responses += string(i+1) + ". ";
		responses += event[? "responses"][| i];
		responses += "\n";
	}
	scribble_set_box_align(fa_left,fa_top,false);
	scribble_set_starting_format("fDefault",c_white,fa_center);
	scribble_set_wrap(480,360,false);
	full = scribble_cache(content + responses);
	content = scribble_cache(content);
	bbox = scribble_get_bbox(EVENTX,EVENTY,full,10,10,10,10);
	responseY = scribble_get_height(content);
}

function ResolveEvent(_choice)
{
	var _resolutions = event[? "resolutions"];
	var _chosenResolution = _resolutions[| _choice];
	if (_chosenResolution == -1)
	{
		with (oShip) 
		{
			paused = false;
			UpdateStats();	
		}
		instance_destroy();
	}
	else
	{
		switch (_chosenResolution)
		{
			case 0://Just continue on
			{
				NewEvent("resolutionevents",0,0);
				instance_destroy();
			}break;
			case 1://Asteroid cryostasis
			{
				var _report = "\n\n";
				_report += DamageShip(125,225);
				_report += "\n" + DamageColonists(50,450);
				NewEvent("resolutionevents",1,0,_report);
				instance_destroy();
			}break;
			case 2://Asteroid weapons
			{
				//get ship attack strength
				
				var _attack = (oShip.attackenergy * 0.5) + (oShip.attackphysical);
				if (_attack > 15)
				{
					NewEvent("resolutionevents",2,0);
				}
				else
				{
					var _report = "\n\n";
					_report += DamageShip(350,550);
					_report += "\n" + DamageWeapons(12,24);
					NewEvent("resolutionevents",3,0,_report);
				}
				instance_destroy();
			}break;
			
			case 3://Asteroid engines
			{
				var _report = "\n\n";
				_report += DamageShip(150,250);
				_report += "\n" + DamageEngines(25,45);
				NewEvent("resolutionevents",1,0,_report);
				instance_destroy();
			}break;
			case 4://Toxic fuel harvest
			{
				NewEvent("resolutionevents",4,0);
				instance_destroy();
			}break;
			case 5://Toxic food harvest
			{
				NewEvent("resolutionevents",5,0);
				instance_destroy();
			}break;
			case 6://Board the station
			{
				if (random(1) < 0.5)
				{
					NewEvent("resolutionevents",6,0);
				}
				else
				{
					mitigation = 1;
					var _report = "\n";
					if (oShip.crew > 1)	_report += DamageCrew(75,150);
					_report += "\n" + DamageSelf(25,70);
					NewEvent("resolutionevents",7,0,_report);
				}
				instance_destroy();
			}break;
			case 7://Launch a probe
			{
				if (oShip.probes > 0)
				{
					ConsumeResource("probe",1);	
					NewEvent("resolutionevents",8,0);
					instance_destroy();
				}
			}break;			
			case 8://Harvest
			{
				if (oShip.attackenergy > 3)
				{
					NewEvent("resolutionevents",10,0);
					instance_destroy();
				}
				else
				{
					NewEvent("resolutionevents",11,0);
					instance_destroy();
				}
			}break;
			case 9://Leave
			{
				NewEvent("resolutionevents",9,0);
				instance_destroy();
			}break;
			
			case 10://GAMEOVER - used artifact
			{
				NewTimeline();
				instance_destroy();
			}break;
			
			case 11://Attempt to evade damage
			{
				var _evasion = (random(100) < oShip.speedlocal)
				if (!_evasion)
				{
					mitigation = 1;
					var _report = "\n\n";
					_report += DamageShip(150,250);
					switch (irandom(2))
					{
						case 0: _report += "\n" + DamageEngines(10,15); break;
						case 1: _report += "\n" + DamageWeapons(10,15); break;
						case 2: _report += "\n" + DamageColonists(50,150); break;
					}
					NewEvent("resolutionevents",1,0,_report);
				}
				else
				{
					NewEvent("resolutionevents",12,0, "\nEvasion chance was: [#0051CC]" + string(oShip.speedlocal) + "%[/c]");
				}
				instance_destroy();
			}break;
			
			case 12://The great machine
			{
				if (oShip.hp < (oShip.hpmax*0.5))
				{
					with (oShip) hp = hpmax;
					NewEvent("resolutionevents",14,0);
					instance_destroy();
				}
				else
				{
					oShip.hp = 0;
					NewEvent("resolutionevents",13,0);
					instance_destroy();
				}
			}break;
			
			case 13: //the black hole
			{
				NewEvent("resolutionevents",15,3);
				with (oShip) 
				{
					paused = false;
					UpdateStats();	
				}
				instance_destroy();
			}break;
			
			case 14: //the black hole resolution
			{
				if (oShip.freesockets >= 5)
				{
					NewEvent("resolutionevents",16,0);
					instance_destroy();
				}
				else
				{
					NewEvent("gameoverevents",2,0);	
					instance_destroy();
				}
				instance_destroy();
			}break;
			
			case 15: //settled a random planet
			{
				
				var _planet = irandom(4);
				if (global.timelines < 2) || (oShip.distanceTravelled < 45) _planet = irandom_range(2,4);
				var _multiplier = 1;
				switch (_planet)
				{
					case 0: _multiplier = 5; break;	
					case 1: _multiplier = 4; break;	
					case 2: _multiplier = 0; break;	
					case 3: _multiplier = 2; break;	
					case 4: _multiplier = 1; break;	
				}
				//work out score here before giving final event
				var _score = PlanetScore(_multiplier);
				NewEvent("settleevents",_planet,0,_score)
				
				instance_destroy();
			}break;
			
			case 16: //send a probe to the planet
			{
				if (oShip.probes > 0)
				{
					ConsumeResource("probe",1);
					var _minPlanet = 1;
					if (global.timelines < 2) || (oShip.distanceTravelled < 45) _minPlanet = 3
					NewEvent("planetevents",irandom_range(_minPlanet,ds_list_size(global.eventData[? "planetevents"])-1),0);
					instance_destroy();
				}
			}break;
			
			case 17: //move on from planet
			{
				NewEvent("resolutionevents",17,0);
				instance_destroy();
			}break;
			
			case 18: //settle earthlike
			{
				if (random(1) < 0.3)
				{
					var _score = PlanetScore(4);
					NewEvent("settleevents",1,0,_score)
					instance_destroy();
				}
				else
				{
					var _score = PlanetScore(5);
					NewEvent("settleevents",0,0,_score)
					instance_destroy();
				}
			}break;
			
			case 19: //settle xenomorphs
			{
				var _score = PlanetScore(0);
				NewEvent("settleevents",2,0,_score)
				instance_destroy();
			}break;
			
			case 20: //settle arctic
			{
				var _score = PlanetScore(2);
				NewEvent("settleevents",3,0,_score)
				instance_destroy();
			}break;
			
			case 21: //settle barren
			{
				var _score = PlanetScore(1);
				NewEvent("settleevents",4,0,_score)
				instance_destroy();
			}break;
			case 22://harvest asteroid belt
			{
				if ((oShip.attackphysical*0.5) + oShip.attackenergy > 8) && (oShip.speedlocal > 6)
				{
					NewEvent("resolutionevents",18,0);
					instance_destroy();
				}
				else
				{
					mitigation = 1;
					var _report = "\n\n";
					_report += DamageShip(150,250);
					switch (irandom(2))
					{
						case 0: _report += "\n" + DamageEngines(10,15); break;
						case 1: _report += "\n" + DamageWeapons(10,15); break;
						case 2: _report += "\n" + DamageColonists(50,150); break;
					}
					NewEvent("resolutionevents",19,0,_report);
				}
				instance_destroy();
			}break;
			
			case 23: //Fire on twin ship
			{
				if ((oShip.attackphysical + oShip.attackenergy) > 0)
				{
					global.killedthetwinship = true;
					global.twinshiptime = oShip.distanceTravelled;
					NewEvent("resolutionevents",20,0)
					instance_destroy();
				}
			}break;
			
						
			case 24: //destroyed BY the twin ship
			{
				global.killedthetwinship = false;
				NewTimeline();
				instance_destroy();
			}break;
		}
	}
	
	//Lootbox
	if (!is_undefined(event[? "loot"]))
	{
		var _lootArray = [0];
		for (var i = 0; i < ds_list_size(event[? "loot"]); i++)
		{
			_lootArray[i] = event[? "loot"][| i];
			Lootbox(_lootArray);
		}
	}
	
}

function DamageShip(mn,mx)
{
	var _damage = irandom_range(mn,mx);
	var _mitigate = min(_damage,(oShip.armour * 10) + (oShip.shields/10))
	mitigation = 1 - (_mitigate/_damage);
	_damage -= _mitigate;
	
	with (oShip) 
	{
		shields = max(0,shields-(_mitigate*10));
		hp = max(0, hp - _damage);
	}
	var _theReport = "[#0051CC]" + string(_damage) + "[/c] damage"
	if (_mitigate != 0) _theReport += " ([#0051CC]" + string(_mitigate) + "[/c] mitigated)";
	_theReport += " to the ship hull.";
	return _theReport;
}

function DamageColonists(mn, mx)
{
	var _damage = ceil(irandom_range(mn,mx) * mitigation);
	ConsumeResource("colonists",_damage)
	global.liveslost += min(oShip.colonists,_damage);
	if (mitigation == 0) return "all further damage was prevented.";
	var _theReport = "[#0051CC]" + string(min(oShip.colonists,_damage)) + "[/c] Colonists lost.";
	return _theReport;
}

function DamageCrew(mn, mx)
{
	var _damage = ceil(irandom_range(mn,mx) * mitigation);
	ConsumeResource("crewmember",_damage)
	if (mitigation == 0) return "all further damage was prevented.";
	return "Some crew members were injured or killed";
}

function DamageSelf(mn, mx)
{
	var _damage = ceil(irandom_range(mn,mx) * mitigation);
	ConsumeResource("you",_damage);
	if (mitigation == 0) return "all further damage was prevented.";
	return "You were injured";
}

function DamageWeapons(mn, mx)
{
	var _damage = ceil(irandom_range(mn,mx) * mitigation);
	ConsumeResource("basicslugs",_damage)
	_damage = ceil(irandom_range(mn,mx) * mitigation);
	ConsumeResource("basiclaser",_damage)
	if (mitigation == 0) return "all further damage was prevented.";
	return "The weapons sustained some damage";
}

function DamageEngines(mn, mx)
{
	var _damage = ceil(irandom_range(mn,mx) * mitigation);
	ConsumeResource("warpdrive",_damage)
	_damage = ceil(irandom_range(mn,mx) * mitigation);
	ConsumeResource("thruster",_damage)
	if (mitigation == 0) return "all further damage was prevented.";
	return "The engines and thrusters sustained some damage.";
}


function Lootbox(_moduleArray)
{
	with (oShip)
	{
		with (instance_create_depth(0,0,depth-1,oLootbox))
		{
			loot = _moduleArray;
		}
	}
}

function NewTimeline()
{
	global.gameStage = 3;
	with (oShip)
	{
		blueprintMode = false;
		blueprintAlpha = 0.02;
		alarm[4] = 60;
	}
}

function NewTimelineCommit()
{
	global.timelines++;
	global.liveslost+= oShip.colonists + max(oShip.crew-1,0);
	global.distance += oShip.distanceTravelled;
	room_goto(global.roomTarget);	
}

function PlanetScore(_multiplier)
{
	var _score = "\n[#0051CC]";
	var _actualScore = ((oShip.fuel) + (oShip.food) + oShip.materials + (oShip.probes) + (oShip.colonists)) * _multiplier;
	_score += "Planet Multiplier " + "x" + string(_multiplier) + "\n";
	_score += "Colonists: " + string(oShip.colonists) + "\n";
	_score += "Supplies bonus: " + string((oShip.fuel ) + (oShip.food) + oShip.materials + (oShip.probes)) + "\n";
	_score += "Final score: " + string(_actualScore);
	return _score;
}