if (held != -1) && (!mouse_check_button(mb_left))
{
	//Try to drop the item
	var _dropped = false;

	with (oBubble)
	{
		if (highlighted) && (socket == 0 || bin == true)
		{
			if (bin == true)
			{
				if (socket != 0) && (socket.type[? "name"] = "Colonists") global.liveslost += socket.hp;
			}
			socket = other.held;
			_dropped = true;
		}
	}
	with (oShip)
	{
		if (highlightX != -1)
		{
			var _heldOver = inventory[# highlightX, highlightY];
			if (_heldOver == 0)
			{
				inventory[# highlightX, highlightY] = other.held;
				_dropped = true;
			}
		}
		
		if (_dropped) UpdateStats();
	}
	
	//failed to drop item, put it back where it came from
	if (!_dropped) 
	{
		if (sourcex != -1)
		{
			with (oShip)
			{
				inventory[# other.sourcex, other.sourcey] = other.held;	
				UpdateStats();
			}
		}
		else
		{
			with (source) socket = other.held;
			
		}
	}
	
	held = -1;
}

if (mouse_check_button_released(mb_right))
{
	if (repairMode) repairMode = false;
}