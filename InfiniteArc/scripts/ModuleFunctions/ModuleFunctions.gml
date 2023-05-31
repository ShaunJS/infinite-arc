//module = function(_type,_hp) constructor {
function module(_type, _hp) constructor 
{
	type = global.moduleData[? _type]
	if (!is_undefined(_hp))
	{
		hp = argument[1];
	}
	else
	{
		hp = type[? "hpmax"];
		if (hp == -1) hp = 100;
	}
}
//credit sahaun for letting me know how this works

function moduleCopy(_type, _hp) constructor 
{
	type = _type;
	if (!is_undefined(_hp))
	{
		hp = argument[1];
	}
	else
	{
		hp = type[? "hpmax"];
		if (hp == -1) hp = 100;
	}
}

function UseModule(_socket)
{
	if (oHeldItem.repairMode)
	{
		if (!is_undefined(_socket.type[? "canrepair"]))
		{
			var _amountWeCanRepair = oShip.materials;	
			var _amountNeeded = 100 - _socket.hp;
			var _amountToRepair = min(_amountWeCanRepair,_amountNeeded);
			ConsumeResource("materials",_amountToRepair);
			_socket.hp += _amountToRepair;
			if (oShip.materials == 0) with (oHeldItem) repairMode = false
		}
	}
	else
	{
		switch (_socket.type[? "name"])
		{
			case "The Artifact": NewEvent("gameoverevents",0,0); break;
			case "Materials": with (oHeldItem) repairMode = true; break;
		}
	}
}