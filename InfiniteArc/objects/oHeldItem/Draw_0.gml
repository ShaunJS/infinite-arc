if (held != -1)
{
	draw_sprite(sModules,held.type[? "image"],mouse_x-16,mouse_y-16)	
}

if (repairMode)
{
	//draw_sprite(sModules,14,mouse_x-16,mouse_y-16)	
	scribble_set_starting_format("fDefault",c_white,fa_left);
	scribble_set_box_align(fa_left,fa_bottom,false);
	scribble_draw(mouse_x,mouse_y,"[sRepair,0] " + string(oShip.materials));
}