for (var i = 0; i < array_length(starfieldSurface); i++)
{
	if (!surface_exists(starfieldSurface[i])) 
	{
		var _starSep = 64;
		var _starRan = 16;
		starfieldSurface[i] = surface_create(RESW,RESH);
		surface_set_target(starfieldSurface[i]);
		draw_clear_alpha(c_black,0);
		for (var _x = 0; _x <= RESW div _starSep; _x++)
		{
			for (var _y = 0; _y <= RESH div _starSep; _y++)
			{	
				if (random(1) < 0.7) 
				{
					var _ranX = random_range(-_starRan,_starRan);
					var _ranY = random_range(-_starRan,_starRan);
					draw_sprite(sPixel, 0 , (_x * _starSep) + _ranX, (_y * _starSep) + _ranY);
					if (random(1) < 0.05) && (i == 3)
					{
						draw_sprite(sPixel, 0 , (_x * _starSep) + _ranX+1, (_y * _starSep) + _ranY);
						draw_sprite(sPixel, 0 , (_x * _starSep) + _ranX-1, (_y * _starSep) + _ranY);
						draw_sprite(sPixel, 0 , (_x * _starSep) + _ranX, (_y * _starSep) + _ranY+1);
						draw_sprite(sPixel, 0 , (_x * _starSep) + _ranX, (_y * _starSep) + _ranY-1);
					}
				}
			}
		}
		surface_reset_target();
	}
	var _time = get_timer()*starSpeed;
	var _xx = i*16;//-(_time/(i+1));
	var _yy = i*16;
	draw_surface_tiled_ext(starfieldSurface[i],_xx+xx[i],_yy,1,1,c_white,1 - (i*0.25));

	draw_set_alpha(1);
	
	if (keyboard_check(vk_f2)) starSpeed += 0.2;
	if (keyboard_check(vk_f3)) starSpeed -= 0.2;
}

xx[0] -= starSpeed;
xx[1] -= starSpeed/2;
xx[2] -= starSpeed/3;
xx[3] -= starSpeed/4;
for (var i = 0; i < 4; i++)
{
	if (xx[i] < -RESW) xx[i]+=RESW;
}

starSpeed = Approach(starSpeed,((oShip.enginesOn*5) * (1 - oShip.paused))+1,0.025);