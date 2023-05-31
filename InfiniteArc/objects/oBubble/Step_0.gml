if (point_in_circle(mouse_x,mouse_y,x+16,y+16,13))
{
	highlighted = true;	
	if (socket != 0)
	{
		TooltipModule(socket);
		if (mouse_check_button_pressed(mb_left)) grabbing = 1;	
		if (!mouse_check_button(mb_left)) grabbing = 0;
	}
}
else
{
	highlighted = false;
	if (grabbing == 1) && (socket != 0)
	{
		with (oHeldItem) 
		{
			held = other.socket;
			source = other.id;
			sourcex = -1;
			sourcey = -1;
			
		}
		
		if (infinite) 
		{
			socket = new moduleCopy(socket.type,socket.hp);	
		} else socket = 0;
	}
	grabbing = 0;
}

if (x != xTo) || (y != yTo)
{
	if (curve != -1)
	{
		entryCurrent = Approach(entryCurrent,entryTime,1);
		var _channel = animcurve_get_channel(curve, 0);
		var _val = animcurve_channel_evaluate(_channel,  entryCurrent/entryTime);
		x = lerp(xstart,xTo,_val);
		y = lerp(ystart,yTo,_val);
	}
}
else
{
	xstart = x;
	ystart = y;
	if (goAway) instance_destroy();
}

image_alpha = oShip.blueprintAlpha;

if (bin) && (image_alpha == 0)
{
	if (socket != 0)
	{
		if (socket.type[? "name"] = "Colonists") global.liveslost += socket.hp;
		delete socket;
		socket = 0;
	}
}