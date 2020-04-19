
mob
	var
		tmp
			DA_AVOIDING = 0
			DA_AVOIDING_TIME = 0
/*
	Del()
		if(keyvar)
			spawn()
				src.DA_AVOIDING_TIME = world.time
				var/curr_DA_AVOIDING_TIME = src.DA_AVOIDING_TIME
				while(src.DA_AVOIDING > world.time)
					if(curr_DA_AVOIDING_TIME != src.DA_AVOIDING_TIME)
						break
					sleep(11 + rand(-5,5))
				if(curr_DA_AVOIDING_TIME == src.DA_AVOIDING_TIME)
					..()
		else
			..()
*/