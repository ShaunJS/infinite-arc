if (fadeinStarted) && (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_any))
{
    textProgress = scribble_autotype_get(textContent);
    if (textProgress != 1) && (textProgress > 0.2)
    {
        scribble_autotype_skip(textContent); 
    }
    else
    {
		if (scribble_page_on_last(textContent))
		{
			with (oShip)
			{
				alarm[0] = 60;
				alarm[1] = 90;
			}
			global.gameStage = 1;
			instance_destroy();
		}
		else
		{
			scribble_page_set(textContent,scribble_page_get(textContent)+1)
			scribble_autotype_fade_in(textContent, 0.5, 1, false);
		}
    }
}