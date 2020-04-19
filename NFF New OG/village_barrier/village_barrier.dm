world
	New()
		..()

		for(var/v in village_barrier_list)
			var/obj/village_barrier_machine/m = new()
			m.village = v
			var/list/vb = village_barrier_list[v]
			m.Move(vb[1])

			spawn(10)
				world << v

var
	village_barrier_list = list(

	"Rain" = list(
	locate(3,3,1),
	rgb(50,100,200),
	list(locate(5,5,1),locate(6,5,1)),
	)

	)

obj
	village_barrier_machine
		icon = 'village_barrier_machine.dmi'
		icon_state = "0,0"
		var
			village = null

			chakra = 0
			max_chakra = 100

		New()
			..()
			for(var/xx = 0 to 0)
				for(var/yy = 1 to 1)
					var/obj/o = new()
					o.appearance = appearance
					o.icon_state = "[xx],[yy]"
					o.pixel_x = xx*32
					o.pixel_y = yy*32

					overlays += o

	village_barrier
		icon = 'village_barrier.dmi'
		var
			village = null

turf
	icon = 'dbturf.dmi'

mob
	icon = 'dbmob.dmi'

client
	fps = 25