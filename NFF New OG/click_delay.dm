client
	var
		click_delay = 0
	Click()
		if(src.click_delay > world.time)
			return
		src.click_delay = world.time + 2
		..()