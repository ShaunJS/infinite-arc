//if (live_call()) return live_result;

if (display)
{
	scribble_set_box_align(fa_left,fa_top,false);
	scribble_set_starting_format("fDefault",c_white,fa_center);
	scribble_set_wrap(480,300,false);
	NineSliceBox_stretch(sButton9s,bbox[0],bbox[1],bbox[2],bbox[3],0)
	scribble_draw(EVENTX,EVENTY,content);
	scribble_draw(EVENTX,bbox[1]+responseY+10,responses);
	/*
	draw_set_alpha(0.5);
	draw_rectangle(bbox[0],bbox[1],bbox[2],bbox[3],false);
	draw_set_alpha(0.75);
	draw_rectangle(bbox[0],bbox[1]+responseY+20,bbox[2],bbox[3],false);
	draw_set_alpha(1.0);
	*/
}