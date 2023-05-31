if (bin) image_index = 1;
draw_sprite_ext(sSocket, 0 , x +1, y +1,image_xscale,image_yscale,0,c_black,image_alpha*0.4);
draw_self();
draw_set_alpha(image_alpha);
if (socket != 0)
{
	var _image = socket.type[? "image"];
	draw_sprite(sModules,_image,x,y);
	if (highlighted) draw_sprite(sHighlightModule,0,x,y);	
}
draw_set_alpha(1.0);