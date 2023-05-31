if (global.outTransition != -1)
{
	if (!layer_exists("transitions")) var _lay = layer_create(-9999,"transitions"); else _lay = layer_get_id("transitions");
	layer_sequence_create(_lay,0,0,global.outTransition);
}