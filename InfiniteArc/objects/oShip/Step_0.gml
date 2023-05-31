highlightX = -1;
highlightY = -1;

if (blueprintMode)
{
	paused = true;
	if (!instance_exists(oEventOn))
	{
		var _mx = mouse_x;
		var _my = mouse_y;
		if (point_in_rectangle(_mx, _my, x, y, (x+SHIP_WIDTH*32)-1, (y+SHIP_HEIGHT*32)-1) )
		{
			//Normalize to grid area
			_mx -= x;
			_my -= y;
		
			//Find closest cell center
			var _closestX = (_mx div 32) * 32 + 16;
			var _closestY = (_my div 32) * 32 + 16;
		
			//Is distance small enough?
			if (point_distance(_mx,_my,_closestX,_closestY) < 13)
			{
				highlightX = _mx div 32;
				highlightY = _my div 32;
				var _socket = inventory[# highlightX, highlightY];
				if (_socket != 0) && (_socket != -1) 
				{
					//Tooltip(_socket.type[? "name"], _socket.type[? "description"]);
					TooltipModule(_socket);
					if (mouse_check_button_pressed(mb_left)) 
					{
						if (is_undefined(_socket.type[? "nomove"]))
						{
							grabbing = _socket;
							grabx = highlightX;
							graby = highlightY;
						}
					}
				
					if (mouse_check_button_released(mb_left))
					{
						if (oHeldItem.held == -1) && (global.gameStage == 2)
						{
							UseModule(_socket);	
						}
					}
				}
			}
		}
	}
}
else
{
	if (global.gameStage == 2) && (!instance_exists(oEventOn))
	{
		if (food < foodconsumption*10)
		{
			if (warnFood == false)
			{
				warnFood = true
				ShipMessage("food supplies are running low...");
			}
		}
		else warnFood = false;
			
		if (fuel < fuelconsumption*10)
		{
			if (warnFuel == false)
			{
				warnFuel = true
				ShipMessage("Warp fuel is running low...");
			}
		}
		else warnFuel = false;
			
		if (hp < 200)
		{
			if (warnHull == false)
			{
				warnHull = true
				ShipMessage("The ship's hull cannot sustain much more damage.");
			}
		}
		else warnHull = false;
			
		if (shields < (shieldsmax*0.2))
		{
			if (warnShields == false)
			{
				warnShields = true
				ShipMessage("Shields are low and will take time to recharge.");
			}
		}
		else warnShields = false;	
	}
}



if (!mouse_check_button(mb_left))
{
	grabbing = 0;
}


if (grabbing != 0) 
{
	if (grabx != highlightX) && (graby != highlightY)
	{
		with (oHeldItem) 
		{
			held = other.grabbing;
			source = other.id;
			sourcex = other.grabx;
			sourcey = other.graby;
		}
		UpdateStats();
		grabbing = 0;
		inventory[# grabx, graby] = 0;
	}
}

if (messageFadeOut)
{
	messagePlaying = Approach(messagePlaying,0,0.025);	
}

statsAlpha = Approach(statsAlpha,statsShow,0.025);	
if (enginesOn) engineAlpha = Approach(engineAlpha,1*(1-paused),0.025);

if (!paused) && (global.gameStage == 2)
{
	if (fuel > 0) && (speedwarp > 0) distanceTravelled += ((engineAlpha * speedwarp)/60)/5; else enginesOn = false;
	
	fuelEaten += ((engineAlpha * fuelconsumption)/60)/5;
	if (fuelEaten > 1)
	{
		fuelEaten--;
		show_debug_message("fuel eaten nom nom");
		ConsumeResource("fuel",fuelconsumption);
	}
	
	if (!blueprintMode)
	{
		foodEaten += ((foodconsumption)/60)/5;
		if (foodEaten > 1)
		{
			foodEaten--;
			show_debug_message("food eaten nom nom");
			ConsumeResource("food",foodconsumption);
		}
	}
	shields = min(shieldsmax,shields + ((shieldsmax/500)/60)*4);
}

if (global.gameStage < 2)
{
	shields = shieldsmax;	
}

if (global.gameStage == 3)
{
	doomAlpha = Approach(doomAlpha,1,0.025);
}