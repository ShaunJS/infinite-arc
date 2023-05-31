/// @desc Launch button + shop, start of game
instance_create_depth(640-128,131,depth-10,oButtonLaunch);

shopModules = ["thruster","warpdrive","colonists","food","fuel","hullplate","shieldmodule","basiclaser","basicslugs","probe","materials"]

for (var i = 0; i < array_length(shopModules); i++)
{
	var _x = (RESW*0.5) + ((-16 * array_length(shopModules)) +  i * 32);
	var _bubble = instance_create_depth(RESW*0.5,RESH+50,depth-10,oBubble);
	with (_bubble)
	{
		socket = new module(other.shopModules[i]);
		curve = curveEntry;
		yTo = 234;
		xTo = _x;
		entryTime = 60+(i*2);
		infinite = true;
	}
}



ShipMessage("I must choose carefully, we can only carry so much. The fate of humanity is at stake!");
statsShow = true;