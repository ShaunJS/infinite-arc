event_inherited();
image_alpha = 0.3;
if (image_index != 0) image_alpha = 1;
label = "[sVolume," +string(global.volumeState) + "]";
x = lerp(x,xstart,0.1);
y = lerp(y,ystart,0.1);
scribble_set_box_align(fa_left,fa_top,false);
scribble_set_starting_format("fDefault",c_white,fa_center);
elem = scribble_cache(label);
bbox = scribble_get_bbox(x, y, elem, 0, 0, 12, 10); //5px border