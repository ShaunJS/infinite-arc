// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Tooltip(_title,_content)
{
	with (oTooltip)
	{
		on = true;
		title = _title;
		if (content != _content) {} //refresh typewriter effect
		
		content = _content;
		
	}

}

function TooltipModule(_socket)
{
	var _type = _socket.type;
	var _content = "";
	var _title = _type[? "name"];

	if (argument_count > 0)
	{
		if (_socket.hp != -1) 
		{
			_content += string(_socket.hp);
			if (_type[? "hpmax"] != -1) _content += "/" + string(_type[? "hpmax"]); else _content += "%";
			_content += "\n";
		}

	}
	
	if (!is_undefined(_type[? "tooltip"])) _content += _type[? "tooltip"] + "\n";
	if (!is_undefined(_type[? "description"])) _content += "[c_gray]" + _type[? "description"];
	Tooltip(_title, _content);
}