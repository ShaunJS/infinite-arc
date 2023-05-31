scribble_set_box_align(fa_left,fa_top,false);
scribble_set_starting_format("fDefault",c_white,fa_left);
scribble_set_blend(c_white,image_alpha);
draw_set_alpha(image_alpha);
NineSliceBox_stretch_surf(sButton9s,bbox[0],bbox[1],bbox[2],bbox[3],image_index)
if (image_index == 2)
{
	scribble_draw(x+1+5,y+1+5,elem);
}
else scribble_draw(x+5,y+5,elem);

draw_set_color(c_white);

draw_set_alpha(1.0);
scribble_set_blend(c_white,1.0);