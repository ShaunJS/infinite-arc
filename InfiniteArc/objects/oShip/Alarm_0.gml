/// @description Toggle blueprint mode
blueprintMode = true;
var _bubble = instance_create_depth(128,128,depth-10,oBubble);
with (_bubble)
{
	socket = 0;
	//curve = curveEntry;
	//yTo = 128;
	//xTo = 128;
	entryTime = 60;
	bin = true;
}