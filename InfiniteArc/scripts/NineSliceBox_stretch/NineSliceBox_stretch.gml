/// @desc NineSliceBox_stretch(_sprite, x1, y1, x2, y2);
/// @arg _sprite
/// @arg x1 left
/// @arg y1 top
/// @arg x2 right
/// @arg y2 bottom

function NineSliceBox_stretch(_sprite, _x1, _y1, _x2, _y2, frame) {
	
	var _size = sprite_get_width(_sprite) / 3;
	var _w = _x2 - _x1;
	var _h = _y2 - _y1;
	
	// MIDDLE
	draw_sprite_part_ext(_sprite, frame, _size, _size, 1, 1, _x1+_size, _y1+_size, _w-(_size*2), _h-(_size*2), c_white,1);

	// CORNERS
	//top left
	draw_sprite_part(_sprite, frame, 0, 0, _size, _size, _x1, _y1);
	//top right
	draw_sprite_part(_sprite, frame, _size*2, 0, _size, _size, _x1+_w-_size, _y1);
	//bottom left
	draw_sprite_part(_sprite, frame, 0, _size*2, _size, _size, _x1, _y1+_h-_size);
	//bottom right
	draw_sprite_part(_sprite, frame, _size*2, _size*2, _size, _size, _x1+_w-_size, _y1+_h-_size);

	//EDGES
	//left edge
	draw_sprite_part_ext(_sprite, frame, 0, _size, _size, 1, _x1, _y1+_size, 1, _h-(_size*2), c_white,1);
	//right edge
	draw_sprite_part_ext(_sprite, frame, _size*2, _size, _size, 1, _x1+_w-_size, _y1+_size , 1, _h-(_size*2), c_white, 1);
	//top edge
	draw_sprite_part_ext(_sprite, frame, _size, 0, 1, _size, _x1+_size, _y1, _w-(_size*2), 1, c_white,1);
	//bottom edge
	draw_sprite_part_ext(_sprite, frame, _size, _size*2, 1, _size, _x1+_size, _y1+_h-(_size), _w-(_size*2), 1, c_white,1);
}


function NineSliceBox_stretch_surf(_sprite, _x1, _y1, _x2, _y2, frame) {
	var _alpha = draw_get_alpha();
	draw_set_alpha(1);
	var _size = sprite_get_width(_sprite) / 3;
	var _w = _x2 - _x1;
	var _h = _y2 - _y1;
	var _surf = surface_create(_w,_h);
	surface_set_target(_surf);
	draw_clear_alpha(c_white,0);
	
	// MIDDLE
	draw_sprite_part_ext(_sprite, frame, _size, _size, 1, 1, _size, _size, _w-(_size*2), _h-(_size*2), c_white,1);

	// CORNERS
	//top left
	draw_sprite_part(_sprite, frame, 0, 0, _size, _size, 0, 0);
	//top right
	draw_sprite_part(_sprite, frame, _size*2, 0, _size, _size, _w-_size, 0);
	//bottom left
	draw_sprite_part(_sprite, frame, 0, _size*2, _size, _size, 0, 0+_h-_size);
	//bottom right
	draw_sprite_part(_sprite, frame, _size*2, _size*2, _size, _size, 0+_w-_size, 0+_h-_size);

	//EDGES
	//left edge
	draw_sprite_part_ext(_sprite, frame, 0, _size, _size, 1, 0, _size, 1, _h-(_size*2), c_white,1);
	//right edge
	draw_sprite_part_ext(_sprite, frame, _size*2, _size, _size, 1, 0+_w-_size, 0+_size , 1, _h-(_size*2), c_white, 1);
	//top edge
	draw_sprite_part_ext(_sprite, frame, _size, 0, 1, _size, 0+_size, 0, _w-(_size*2), 1, c_white,1);
	//bottom edge
	draw_sprite_part_ext(_sprite, frame, _size, _size*2, 1, _size, 0+_size, 0+_h-(_size), _w-(_size*2), 1, c_white,1);
	surface_reset_target();
	draw_set_alpha(_alpha);
	draw_surface(_surf,_x1,_y1);
	surface_free(_surf);


}