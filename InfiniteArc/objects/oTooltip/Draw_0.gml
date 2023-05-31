if (on)
{
	tooltip = "[fTooltip][fa_left][fa_bottom]" + title + "[/font]\n" + content;
	scribble_set_wrap(200,300);
	scribble_set_box_align(fa_left,fa_top,false);
	draw_set_alpha(0.75);
	var _w = scribble_get_width(tooltip)+10;
	var _x = mouse_x;
	if (_x + _w > RESW) _x = _x + (RESW - (_x + _w));
	var _bbox = scribble_get_bbox(_x, mouse_y, tooltip, 5, 5, 5, 5); //5px border
	draw_set_color(c_black);
	draw_rectangle(_bbox[0], _bbox[1], _bbox[2], _bbox[3], false);
	draw_set_color(cBorder);
	draw_rectangle(_bbox[0], _bbox[1], _bbox[2], _bbox[3], true);
	draw_set_alpha(1.0);
	
	scribble_draw(_x,mouse_y,tooltip);
}

