event_inherited();
var _col = c_white;
var _mats = "0";
if (oShip.materials < 10) 
{
	_col = c_gray;
	_mats = "1";
}
label = "Repair Hull (10[sRepairS," + _mats + "]) ";
x = lerp(x,xstart,0.1);
y = lerp(y,ystart,0.1);
scribble_set_box_align(fa_left,fa_top,false);
scribble_set_starting_format("fDefault",_col,fa_center);
elem = scribble_cache(label);
bbox = scribble_get_bbox(x, y, elem, 2, 0, 10, 10); //5px border