scribble_set_starting_format("fDefault", c_white, fa_center);

if (fadeinStarted == false)
{
    scribble_autotype_fade_in(textContent, 0.5, 1, false);
    fadeinStarted = true;
}
textElement = scribble_draw(320,50,textContent);