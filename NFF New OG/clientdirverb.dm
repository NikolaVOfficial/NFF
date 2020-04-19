client
	fps = 25

var
	autosave_delay = 0
	global_RegenerationProcMain_delay = 0

proc
	client_move_update_loop()
		set waitfor = 0
		while(1)
			sleep(world.tick_lag)
			for(var/client/c)
				c.moveverbproc()

				if(c.mob)
					if(global_RegenerationProcMain_delay < world.time)
						c.mob.RegenerationProcMain()

					if(autosave_delay < world.time)
						autosave_delay = world.time + 4500
						c.mob.SaveK()

			if(global_RegenerationProcMain_delay < world.time)
				global_RegenerationProcMain_delay = world.time + 10

world
	New()
		..()
		client_move_update_loop()

client
	var
		northverb = 0
		southverb = 0
		westverb = 0
		eastverb = 0

	verb
		clientnorthverbup()
			set hidden = 1
			set instant = 1
			northverb = 0
		clientnorthverb()
			set hidden = 1
			set instant = 1
			northverb = 1
		clientsouthverbup()
			set hidden = 1
			set instant = 1
			southverb = 0
		clientsouthverb()
			set hidden = 1
			set instant = 1
			southverb = 1
		clienteastverbup()
			set hidden = 1
			set instant =1
			eastverb = 0
		clienteastverb()
			set hidden = 1
			set instant = 1
			eastverb = 1
		clientwestverbup()
			set hidden = 1
			set instant = 1
			westverb = 0
		clientwestverb()
			set hidden = 1
			set instant = 1
			westverb = 1

		moveverbproc()

			if(northverb)
				if(eastverb)
					Northeast()
				else if(westverb)
					Northwest()
				else
					North()

			else if(southverb)
				if(eastverb)
					Southeast()
				else if(westverb)
					Southwest()
				else
					South()

			else if(eastverb)
				East()
			else if(westverb)
				West()