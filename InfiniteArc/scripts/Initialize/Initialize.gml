function Initialize(){

	//Start initialisation:
	//  The font directory is set as the root of the sandbox
	//  The default font is set as "fnt_dialogue"
	//  Automatic scanning for fonts ("autoscan") is turned off
	
	global.timelines = 1;
	global.liveslost = 0;
	global.distance = 0;
	global.volumeState = 3;
	global.killedthetwinship = false;
	global.twinshiptime = 0;
	var _music = audio_create_stream("music1.ogg");
	audio_play_sound(_music,0,true);
	
	randomize();
	scribble_init("", "fDefault", true);
	instance_create_layer(0,0,"Instances",oTransitions);
	instance_create_layer(0,0,layer_create(-999,"tooltips"),oTooltip);
	instance_create_layer(0,0,layer_create(-1000,"cursor"),oHeldItem);
	var _txt = "";
	var _file = file_text_open_read("moduledata.json");
	while (!file_text_eof(_file))
	{
		_txt += file_text_readln(_file);
	}

	show_debug_message(_txt);
	file_text_close(_file);
	global.moduleData = json_decode(_txt);
	var _txt = "";
	var _file = file_text_open_read("eventdata.json");
	while (!file_text_eof(_file))
	{
		_txt += file_text_readln(_file);
	}

	show_debug_message(_txt);
	file_text_close(_file);
	global.eventData = json_decode(_txt);
	
	surface_resize(application_surface,RESW,RESH);
	room_goto(rGame);

}

function Clearup()
{
	ds_map_destroy(global.moduleData);	
	
	
}