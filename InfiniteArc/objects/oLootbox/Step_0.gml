if (!instance_exists(oEventOn))
{
	if (!on)
	{
		on = true;
		
		with (oShip) 
		{
			blueprintMode = true;
			paused = true;	
		}
		for (var i = 0; i < 9; i++)	
		{
			var _bubble = instance_create_depth(RESW+60,RESH*0.5,depth-10,oBubble);
			with (_bubble)
			{
				socket = 0;
				if (i < array_length(other.loot)) socket = new module(other.loot[i]);
				curve = curveEntry;
				yTo = 96 + (i div 3) * 32;
				xTo = 512 + (i * 32) - ((i div 3) * 96);
				entryTime = 60+(i*2);
			}
		}
	
	}
}

if (on) && (oShip.blueprintMode == false)
{
	if (oShip.blueprintAlpha == 0)
	{
		with (oBubble) if (!bin) instance_destroy();
		instance_destroy();
	}
}