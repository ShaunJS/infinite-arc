//if (live_call()) return live_result;
blueprintAlpha = Approach(blueprintAlpha,blueprintMode,0.025);
if (blueprintAlpha > 0)
{
	draw_set_alpha(blueprintAlpha*0.5);
	draw_set_color(cDkTeal);
	
	var _time = get_timer()*0.0001;
	_time *= 0.5;
	draw_set_alpha(blueprintAlpha*0.25);
	draw_sprite_tiled(sGrid,0,_time,_time);
	draw_set_alpha(blueprintAlpha*0.15);
	draw_sprite_tiled(sGrid,0,_time*0.5,_time*0.5);
	draw_set_alpha(blueprintAlpha*0.5);
	draw_rectangle(0,0,640,360,false);
}

image_alpha = 1-blueprintAlpha;


if (enginesOn)
{
	draw_set_alpha(engineAlpha*0.75);
	draw_sprite_stretched(sBeams,0,-10,y+44,80+x,sprite_get_height(sBeams));
	draw_set_alpha(1.0);
}

draw_self();
draw_sprite_ext(sShip,2,x,y,image_xscale,image_yscale,image_angle,c_white,doomAlpha);

if (blueprintAlpha > 0)
{
	
	draw_set_alpha(blueprintAlpha*0.45);
	draw_sprite(sShip,1,x,y);

	draw_set_alpha(blueprintAlpha);
	//The inventory
	for (var _xx = 0; _xx < ds_grid_width(inventory); _xx++)
	{
		for (var _yy = 0; _yy < ds_grid_height(inventory); _yy++)
		{
			var _xxx = x+_xx*32 
			var _yyy = y+_yy*32
			var _socket = inventory[# _xx, _yy]
			if (_socket != -1)
			{
				draw_sprite_ext(sSocket, 0 , _xxx +1, _yyy +1,image_xscale,image_yscale,0,c_black,blueprintAlpha*0.4);
				if (highlightX == _xx) && (highlightY = _yy)
				{
					draw_sprite(sHighlightModule,0,_xxx,_yyy);	
				}
				if (_socket == 0)
				{
					draw_sprite(sSocket, 0 , _xxx , _yyy);
				}
				else
				{
					var _image = _socket.type[? "image"];	
					draw_sprite(sModules, _image, _xxx , _yyy);
				}
			}
		}
	}
	draw_set_alpha(1.0);
}

//if (keyboard_check_pressed(vk_shift)) blueprintMode = !blueprintMode;

//Draw Stats at bottom
scribble_set_blend(c_white,statsAlpha);
scribble_set_starting_format("fDefault",c_white,fa_left);
scribble_set_box_align(fa_left,fa_bottom,false);
var _statText = "";
_statText += "Hull integrity: [#66CCAE]" + string((hp/hpmax)*100) + "%" + "\n[/c]";
_statText += "Armour: [#66CCAE]" + string(armour) + "\n[/c]";
_statText += "Shields: [#66CCAE]" + string(round(shields)) + "/" + string(shieldsmax) + "\n[/c]";
_statText += "Evasion: [#66CCAE]" + string(speedlocal);
scribble_draw(10,RESH-10,_statText);

_statText = "";
_statText += "Travelled: [#66CCAE]" + string(distanceTravelled) + "ly" + "\n[/c]";
_statText += "Colonists: [#66CCAE]" + string(colonists) + "\n[/c]";
_statText += "Food: [#66CCAE]" + string(food) + "\n[/c]";
_statText += "Fuel: [#66CCAE]" + string(fuel);
scribble_draw(140,RESH-10,_statText);

_statText = "";
_statText += "Probes: [#66CCAE]" + string(probes) + "\n[/c]";
if (global.liveslost > 0) _statText += "Lives lost: [#0051CC]" + string(global.liveslost) + "\n[/c]";
if (global.timelines > 1) _statText += "Timelines: [#0051CC]" + string(global.timelines) + "\n[/c]";
if (global.distance > 0) _statText += "Total Travelled: [#0051CC]" + string(global.distance + distanceTravelled) + "ly" + "\n[/c]";
scribble_draw(270,RESH-10,_statText);
scribble_set_blend(c_white,1);

//Draw any ship messages
scribble_set_starting_format("fDefault", c_white, fa_center);
scribble_set_box_align(fa_left,fa_middle,false);
scribble_set_wrap(480,400,false);

scribble_set_blend(c_white,messagePlaying);
if (messagePlaying > 0)
{
	if (instance_exists(oEventOn))
	{
		messageJustStarted = true;	
	}
	
	if (messageJustStarted == true)
	{
		scribble_autotype_fade_in(messageContent, 0.5, 1, false);
		messageJustStarted = false;	
	}
	
	if (!instance_exists(oEventOn)) scribble_draw(MESSAGE_X,MESSAGE_Y,messageContent);
}
scribble_set_blend(c_white,1);

