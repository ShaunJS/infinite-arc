function transitionFade(roomTarget){
	global.roomTarget = roomTarget;
	global.outTransition = sqFadeFromBlack;
	if (!layer_exists("transitions")) var _lay = layer_create(-9999,"transitions"); else _lay = layer_get_id("transitions");
	layer_sequence_create(_lay,0,0,sqFadeToBlack);
}

function transitionFadeW(roomTarget){
	global.roomTarget = roomTarget;
	global.outTransition = sqFadeFromWhite;
	if (!layer_exists("transitions")) var _lay = layer_create(-9999,"transitions"); else _lay = layer_get_id("transitions");
	layer_sequence_create(_lay,0,0,sqFadeToWhite);
}


function transitionComplete()
{
	room_goto(global.roomTarget);	
}
