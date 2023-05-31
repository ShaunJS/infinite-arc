function Approach(a, b, amount) {
	if (a < b)
	{
	    a += amount;
	    if (a > b)
	        return b;
	}
	else
	{
	    a -= amount;
	    if (a < b)
	        return b;
	}
	return a;
}
	
function EaseTowardsDirection(target, rate, easing) {
	//
	//  Rotates the calling instance towards the target direction,
	//  at a given rate and easing. The larger the easing factor,
	//  the more gradually the turn completes.
	//
	//      target      angle to turn towards (degrees), real
	//      rate        maximum turning rate (degrees), real
	//      easing      amount of easing [0..1], real
	//
	/// GMLscripts.com/license
	{
	    direction += median(-rate, rate, (1-easing) * angle_difference(target, direction));
	    return 0;
	}
}
	
function Wave(from, to, duration, offset) {
	//Wave(from, to, duration, offset)
	var a4 = (to - from) * 0.5;
	return from + a4 + sin((((current_time * 0.001) + duration * offset) / duration) * (pi*2)) * a4; 
}

function IntegerWrap(value, minimum, maximum) {
	var _value = value;
	if (_value < minimum) _value = maximum;
	if (_value > maximum) _value = minimum;
	return _value;
}
	
function Wrap(value, minimum, maximum) {
	var _mod = ( value - minimum ) mod ( maximum - minimum );
	if ( _mod < 0 ) return _mod + maximum else return _mod + minimum;
}

function DrawBoundingBox() {
	if (argument_count > 0) draw_set_color(argument[0]); else draw_set_color(c_yellow);
	draw_set_alpha(0.5);
	draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false);
	draw_set_alpha(1);
}
	
function DrawSetText(colour, font, halign, valign) {

// Allows one line setup of major text drawing vars.
// Requiring all four prevents silly coders from forgetting one
// And therefore creating a dumb dependency on other event calls.
// (Then wondering why their text changes later in development.)

	draw_set_colour(colour);
	draw_set_font(font);
	draw_set_halign(halign);
	draw_set_valign(valign);
}

//if (live_call()) return live_result;