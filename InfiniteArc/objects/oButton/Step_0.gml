if (point_in_rectangle(mouse_x,mouse_y,bbox[0],bbox[1],bbox[2],bbox[3]))
{
	image_index = 1;
	if (mouse_check_button(mb_left))
	{
		image_index = 2;
	}
	if (mouse_check_button_released(mb_left))
	{
		ButtonFunctions(buttonType);	
	}
}
else image_index = 0;

image_alpha = Approach(image_alpha,on,0.05);
