/// @desc ???
// Inherit the parent event
event_inherited();
if (oShip.blueprintMode) 
{
	label = "Done"; 
} else label = "Manage Ship";
x = lerp(x,xstart,0.1);
y = lerp(y,ystart,0.1);
scribble_set_box_align(fa_left,fa_top,false);
scribble_set_starting_format("fDefault",c_white,fa_center);
elem = scribble_cache(label);
bbox = scribble_get_bbox(x, y, elem, 0, 0, 10, 10); //5px border