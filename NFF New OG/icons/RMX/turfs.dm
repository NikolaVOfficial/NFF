mob/var/tmp
	Swimming=0
	Resting=0
	CanRest=1

turf/Cave
	icon='Icons/RMX/Cave.dmi'
	icon_state="10"
	var/
		Give=0
	New()
		..()
		if(src.Give)
			if(prob(6))
				src.icon_state="Tile[rand(1,2)]"
turf/BigThing
	icon='Icons/RMX/BigThing.dmi'
	icon_state=""
	layer=10
turf/Book
	icon='Icons/RMX/Book.dmi'
	icon_state=""
	layer=11
turf/Landscapes/Grass1
	icon='Icons/RMX/Grass.dmi'
	var/
		Give=0
	Grass1
		icon_state="1"
	New()
		..()
		if(src.Give)
			if(prob(6))
				src.icon_state="5.1"

turf/RMX
	GrassyM
		icon='icons/RMX/GrassyM.dmi'
		icon_state="1"
turf/RMX
	Grass
		icon='icons/RMX/RMXGrass.dmi'
		icon_state=""

		Entered(mob/M)
			if(ismob(M))
				if(prob(50))
					var/counta=100;var/countb=1;var/list/L = list()
					while(countb<10)
						var/list/S = range(countb)
						for(var/mob/X in L)
							S-=X
						S<<sound('SFX/StepInGrass.wav',0,0,0,50)
						for(var/mob/X in S)
							L+=X
						countb++;counta-=10

turf
	Water
		icon='icons/RMX/TWater.dmi'
		var
			DeepWater=0
		/*Enter(mob/M)
			if(ismob(M))
				if(!src.DeepWater)
					if(M.Diving)
						M.Diving=0
						M.layer=4
				return 1
			else return 1
		Entered(mob/M)
			if(ismob(M))
				M.underlays=null
				if(src.DeepWater)
					if(!M.Dive)	M.PPasives_Add("Basic/Swimming_Passives/Dive")
					if(!M.Swimmer)	M.PPasives_Add("Basic/Swimming_Passives/Swimmer")
					if(!M.Expert_Swimmer)	M.PPasives_Add("Basic/Swimming_Passives/Expert_Swimmer")
					if(!M.ChakraToFeet)
						if(!M.Diving)
							M.icon_state="swimming"
							M.AllowedToBoat = 1
						M.Sand_On_Body=0
						var/A=pick('Swim1.wav','Swim2.wav')
						src.SoundEngine(A,100)
						if(!M.Diving)
							if(!M.Expert_Swimmer&&!M.Aquatic)
								M.Stamina-=rand(10,50)
						if(src.icon_state=="Deep Water"&&!M.Aquatic)
							M.Stamina-=rand(100,250)
						if(M.Aquatic==2)
							M.layer=src.layer-1;M.icon_state="";M.Diving=1
						if(M.Stamina<=0&&!M.Aquatic)
							M.layer=src.layer-1
							M.icon_state=""
							M.Diving=1
							if(M.client)
								M.client.screen+=new/obj/HUD/Air
							if(!M.Diving)
								M<<"You fall into the Water."

					else
						var/A=pick('WaterStep1.wav')
						M.Sand_On_Body=0
						src.SoundEngine(A,100)
				else
					if(!M.Wind_Step)
						var/A=pick('WaterStep1.wav')
						src.SoundEngine(A,100)
						M.Sand_On_Body=0
			else return 1
		Exited(mob/M)
			if(ismob(M))
				if(M.icon_state=="swimming")
					M.icon_state=""
					M.AllowedToBoat = 0
				var/Check=0
				if(!Check)
					M.underlays=null
					var/obj/A=new();A.icon='ShadowX3.dmi';A.pixel_y-=1
					M.underlays+=A
			else return 1*/
	Water_Corners
		watercorner
			icon='icons/RMX/TWater.dmi'
			icon_state="c1"
			density=0
		watercorner1
			icon='icons/RMX/TWater.dmi'
			icon_state="c2"
			density=0
		watercorner3
			icon='icons/RMX/TWater.dmi'
			icon_state="c3"
			density=0
		watercorner4
			icon='icons/RMX/TWater.dmi'
			icon_state="c4"
			density=0
		watercorner5
			icon='icons/RMX/TWater.dmi'
			icon_state="c5"
			density=0
		watercorner6
			icon='icons/RMX/TWater.dmi'
			icon_state="c6"
			density=0
		watercorner7
			icon='icons/RMX/TWater.dmi'
			icon_state="c7"
			density=0
		watercorner8
			icon='icons/RMX/TWater.dmi'
			icon_state="c8"
			density=0

turf/RMX
	Resources
		icon='icons/RMX/Resources.dmi'
		icon_state="1"