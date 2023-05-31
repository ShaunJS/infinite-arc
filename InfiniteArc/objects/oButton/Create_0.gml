image_alpha = 0;
scribble_set_starting_format("fDefault",c_white,fa_left);
elem = scribble_cache(label);
bbox = scribble_get_bbox(x, y, elem, 0, 0, 10, 10); //5px border
on = true;