if  (display == false) && (oShip.distanceTravelled >= distance)
{
	if (!instance_exists(oEventOn))
	{
		display = true;
		instance_change(oEventOn,false);
		with (oShip) paused = true;	
	}
}

if (display) 
{
	entryCurrent = Approach(entryCurrent,entryTime,1);
	var _channel = animcurve_get_channel(curveEntry, 0);
	var _val = animcurve_channel_evaluate(_channel,  entryCurrent/entryTime);
	unfoldProgress = _val;
	
	var responseYY = bbox[1]+responseY+20;
	if (mouse_y > responseYY) && (mouse_y < bbox[3])
	{
		var _optionSep = ((bbox[3]-10) - responseYY) / ds_list_size(event[? "responses"]);
		var _optionHover = (mouse_y - responseYY) div _optionSep;
		var _col = "[#FFFFFF]";
		if (mouse_check_button(mb_left)) _col = "[#777777]";
		responses = "\n";
		for (var i = 0; i < ds_list_size(event[? "responses"]); i++)
		{
			if (i == _optionHover) responses += _col; else responses += "[#66CCAE]";
			if (ds_list_size(event[? "responses"]) > 1) responses += string(i+1) + ". ";
			responses += event[? "responses"][| i];
			responses += "\n";
		}
		
		if (mouse_check_button_released(mb_left))
		{
			ResolveEvent(_optionHover);
		}		
	}
}