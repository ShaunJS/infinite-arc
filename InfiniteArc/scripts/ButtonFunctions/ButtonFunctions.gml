function ButtonFunctions(_type)
{
	switch(_type)
	{
		case -1: break;
		
		//launch ship and start game
		case 0:
		{
			global.gameStage = 2;
			with (oShip) 
			{
				messageFadeOut = true;
				blueprintMode = false;
				paused = false;
				alarm[3] = 120;	
				UpdateStats();
			}
			with (oBubble)
			{
				if (!bin)
				{
					xTo = RESW*0.5;
					yTo = RESH+50;
					entryCurrent = 0;
					curve = curveExit;
					goAway = true;
					entryTime = 60;
				}
			}
			instance_create_depth(RESW-48,RESH-32,depth-10,oButtonManageShip);
			instance_create_depth(RESW-48-100,RESH-32,depth-10,oButtonRepairHull);
			instance_destroy();
		}break;
		case 1:
		{
			if (global.gameStage == 2) && (!instance_exists(oEventOn))
			{
				with (oShip) 
				{
					if (blueprintAlpha == 0) || (blueprintAlpha == 1)
					{
						blueprintMode = !blueprintMode;
						paused = blueprintMode;
						
						if (blueprintMode == false) UpdateStats();
					}
				}
			}
			
		}break;
		case 2:
		{
			with (oShip)
			{
				if (materials > 10) && (hp != hpmax)
				{
					hp = min(hp+100,hpmax);
					ConsumeResource("materials",10);
				}
			}		
		}break;
		case 3:
		{
			global.volumeState = IntegerWrap(global.volumeState+1,0,3);	
			var _vol = global.volumeState/3;
			audio_set_master_gain(0,_vol)
		}break
		case 4:
		{
			window_set_fullscreen(!window_get_fullscreen());			
		}break;
	}
}