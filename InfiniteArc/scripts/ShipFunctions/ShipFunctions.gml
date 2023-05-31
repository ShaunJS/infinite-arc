function UpdateStats()
{
	with (oShip)
	{
		//reset base stats that can be modified by modules
		hpmax = 1000;
		armour = 0;
		shieldsmax = 0;
		speedlocal = 2;
		speedwarp = 0;
		crew = 0;
		colonists = 0;
		probes = 0;
		fuel = 0;
		food = 0;
		materials = 0;
		foodconsumption = 0;
		fuelconsumption = 0;
		attackenergy = 0;
		attackphysical = 0;
		playerhp = 0;
		freesockets = 0;
		
		for (var _x = 0; _x < ds_grid_width(inventory); _x++)
		{
			for (var _y = 0; _y < ds_grid_height(inventory); _y++)
			{
				var _socket = inventory[# _x, _y];
				if (_socket != 0) && (_socket != -1)
				{
					var _type = _socket.type;
					if (!is_undefined(_type[? "speedlocal"])) speedlocal += round(_type[? "speedlocal"] * (_socket.hp/100));
					if (!is_undefined(_type[? "speedwarp"])) 
					{
						speedwarp += ceil(_type[? "speedwarp"] * (_socket.hp/100));
					}
					if (!is_undefined(_type[? "foodconsumption"])) foodconsumption += _type[? "foodconsumption"];
					if (!is_undefined(_type[? "fuelconsumption"])) fuelconsumption += _type[? "fuelconsumption"];
					
					if (!is_undefined(_type[? "armour"])) armour += ceil(_type[? "armour"] * (_socket.hp/100));
					if (!is_undefined(_type[? "shieldsmax"])) shieldsmax += ceil(_type[? "shieldsmax"] * (_socket.hp/100));
					
					if (!is_undefined(_type[? "attackenergy"])) attackenergy += ceil(_type[? "attackenergy"] * (_socket.hp/100));
					if (!is_undefined(_type[? "attackphysical"])) attackphysical += ceil(_type[? "attackphysical"] * (_socket.hp/100));
					
					if (!is_undefined(_type[? "hullmax"])) hpmax += _type[? "hullmax"];
					if (!is_undefined(_type[? "crew"])) crew += _type[? "crew"];
					
					if (_type[? "name"] == "Colonists") colonists += _socket.hp;
					if (_type[? "name"] == "Warp Fuel") fuel += _socket.hp;
					if (_type[? "name"] == "Materials") materials += _socket.hp;
					if (_type[? "name"] == "Food") food += _socket.hp;
					if (_type[? "name"] == "Probes") probes += _socket.hp;
					if (_type[? "name"] == "You") playerhp += _socket.hp;
				}
				else
				{
					if (_socket == 0) freesockets++;	
				}
			}
		}	
	
		if (!blueprintMode) && (global.gameStage == 2)
		{
			if (food <= 0) {NewEvent("gameoverevents",1,0); exit;}
			if (hp <= 0) {NewEvent("gameoverevents",2,0); exit;}
			if (colonists <= 0) {NewEvent("gameoverevents",3,0); exit;}
			if (playerhp <= 0) {NewEvent("gameoverevents",5,0); exit;}
			if ((fuel <= 0) || (speedwarp == 0)) && (global.doomedAlready == false) 
			{
				NewEvent("gameoverevents",4,0); 
				global.doomedAlready = true; 
				exit; 
			}
		}
	}
}

function ShipMessage(_content)
{
	with (oShip)
	{
		messageContent = _content;
		messageJustStarted = true;
		messagePlaying = 1;
		messageFadeOut = false;
		alarm[2] = 300;
	}
}

function ConsumeResource(_type, _amount)
{
	with (oShip)
	{
		_type = global.moduleData[? _type];
		for (var _x = 0; _x < ds_grid_width(inventory); _x++)
		{
			for (var _y = 0; _y < ds_grid_height(inventory); _y++)
			{
				var _socket = inventory[# _x, _y];
				if (_socket != 0) && (_socket != -1) && (_socket.type == _type)
				{
					show_debug_message(string(_socket.hp) + "-" + string(_amount));
					var _amountToRemove = min(_socket.hp,_amount);
					_amount -= _amountToRemove;
					_socket.hp -= _amountToRemove;
					if (_socket.hp <= 0)
					{
						delete inventory[# _x, _y];
						inventory[# _x, _y] = 0;
					}
					if (_amount <= 0)
					{
						UpdateStats();
						return;	
					}
				}
			}
		}
		UpdateStats();
		return;	
	}
}