mob/var/tmp/SharinganNotice=0
mob/var/tmp/UchihaAuraOn=0
mob/var/tmp/ControllingAmat=0
mob/var/tmp/GhostParasite=0
mob/var/tmp/UsingStakes=0
mob/var/FirstTimeActivation=0
mob/var
	SusanooMastery = 0 // new susanoo system, determines how well susanoo performs
	SusanooHealth = 0 // new way to break susanoo, this health is based on susanoo mastery, ninjutsu knowledge, and the stage of susanoo
	SusanooBones=0
	SusanooSkeleton=0  // this is used to determine how much of a damage reduction your susanoo gives, skeleton will give
							//a full on shield with health that allows some damge to seep through bones is simply a reduction
	SusanooPerfect=0 // perfect gives the best reduction + most health and damage wont seep through until broken
var/list/Mangekyous=list("")
proc
	MSSave()
		if(length(Mangekyous))
			var/savefile/F = new("Mangekyous.sav")
			F["Mangekyous"]	<< Mangekyous
	MSListLoad()
		if(fexists("Mangekyous.sav"))
			var/savefile/F = new ("Mangekyous.sav")
			F["Mangekyous"] >> Mangekyous
mob/proc/MangekyouCheck()
	if(usr.CanGetMangekyo)
		var/list/MS=list("obito","itachi","sasuke","star","bladed","gridlock","shuriken","shisui","gate","crescent","nova")
		var/mangekyou=pick(MS)
		usr.mangekyouC=mangekyou
		MS.Remove("[usr.mangekyouC]");world<<"[usr.mangekyouC] has been removed."
		//var/savefile/F = new("Saves/[usr.mangekyouC]/[src.ckey].sav")
		//Write(F)
obj/Mshar
	icon='Code/Techniques/shading.dmi'
	icon_state="weak"
	screen_loc="1,1 to 19,19"
	layer=MOB_LAYER+10
	mouse_opacity=0
obj/MMshar
	icon='Code/Techniques/shading.dmi'
	icon_state="weak"
	screen_loc="1,1 to 19,19"
	layer=MOB_LAYER+10
	mouse_opacity=0
obj/Jutsu/Uchiha
	AmatFireStuff
		icon='Icons/Jutsus/KatonTechniques.dmi'
		icon_state="AmatFire"
		layer=80
		var/nin = 10
		density = 0
		New()
			..()
			spawn()
				var/mob/O=src.Owner
				while(src)
			//		src.SoundEngine('SFX/FireSFX.wav',4)
					for(var/mob/M in src.loc)//range(1,src))
						if(M&&M!=O)
							if(!M.knockedout)
								var/damage=round(O.nin*rand(0.5,0.6))
								M.DamageProc(damage,"Health",O)
					//		sleep(7)
					sleep(11)
			spawn(600)
				del(src)
	AmatFireStuff2
		icon='Icons/Jutsus/KatonTechniques.dmi'
		icon_state="AmatFire"
		layer=80
		density = 0
		New()
			..()
			spawn()
				var/mob/O=src.Owner
				while(src)
				//	src.SoundEngine('SFX/FireSFX.wav',4)
					for(var/mob/M in oview(1,src))
						if(M&&M!=O)
							if(!M.knockedout)
								var/damage=round(O.nin*rand(0.5,0.6))
								M.DamageProc(damage,"Health",O)
					sleep(11)
	//		spawn(600)
	//			del(src)
	AMAExplosion
		icon='Icons/Jutsus/KatonTechsBlack.dmi'
		icon_state="AmatExplode"
		layer=6
		density = 0
		New()
			..()
			spawn()
				while(src)
					for(var/mob/M in src.loc)
						var/mob/O=src.Owner
						if(M&&M!=O)
							var/damage=round(O.nin*rand(1.2,1.5))
							if(M.RaiArmor==2)
								damage/=2
							if(!M.knockedout)
								M.DamageProc(damage,"Health",O);M.DamageProc(damage*1.5,"Stamina",O)
					sleep(11)
			spawn(30)
				del(src)
		Del()
		//	var/obj/Jutsu/Uchiha/AMAProjectile/Z=new();Z.loc=src.loc;Z.name="[src]";Z.dir=NORTH;Z.Owner=src.Owner;walk(Z,Z.dir)
			var/num=12
			var/loldir=src.dir
			while(num>0)
				var/obj/Jutsu/Uchiha/AMAProjectile/K=new();K.loc=src.loc;K.nin=pick(40,50);K.dir=loldir;K.name="[src]";K.Owner=src;walk(K,K.dir)
				loldir=turn(loldir,45)
				num--
		//	var/obj/Jutsu/Uchiha/AMAProjectile/C=new();C.loc=src.loc;C.name="[src]";C.dir=SOUTH;C.Owner=src.Owner;walk(C,C.dir)
		//	var/obj/Jutsu/Uchiha/AMAProjectile/B=new();B.loc=src.loc;B.name="[src]";B.dir=EAST;B.Owner=src.Owner;walk(B,B.dir)
		//	var/obj/Jutsu/Uchiha/AMAProjectile/A=new();A.loc=src.loc;A.name="[src]";A.dir=WEST;A.Owner=src.Owner;walk(A,A.dir)
		//	var/obj/Jutsu/Uchiha/AMAProjectile/F=new();F.loc=src.loc;F.name="[src]";F.dir=NORTHEAST;F.Owner=src.Owner;walk(F,F.dir)
		//	var/obj/Jutsu/Uchiha/AMAProjectile/G=new();G.loc=src.loc;G.name="[src]";G.dir=SOUTHWEST;G.Owner=src.Owner;walk(G,G.dir)
		//	var/obj/Jutsu/Uchiha/AMAProjectile/Y=new();Y.loc=src.loc;Y.name="[src]";Y.dir=SOUTHEAST;Y.Owner=src.Owner;walk(Y,Y.dir)
		//	var/obj/Jutsu/Uchiha/AMAProjectile/T=new();T.loc=src.loc;T.name="[src]";T.dir=NORTHWEST;T.Owner=src.Owner;walk(T,T.dir)
			..()
	AMA
		icon='Icons/Jutsus/KatonTechsBlack.dmi'
		icon_state = "Amaterasu"
		layer=MOB_LAYER+2
		density = 0
		New()
			..()
			spawn()
				while(src)
			//		src.SoundEngine2('SFX/FireSFX.wav',volume=50)
					for(var/mob/M in oview(1,src))
						var/mob/O=src.Owner
						if(M&&!M.knockedout&&M!=O)
							var/damage=round(O.nin*rand(1.45,1.6))
							if(M.RaiArmor==2)
								damage/=2
							if(!M.knockedout)
								M.DamageProc(damage,"Health",O)
								M.DamageProc(damage*3,"Stamina",O)
					sleep(11)

			spawn(600)
				del(src)
		Move()
			var/obj/Jutsu/Uchiha/AMATrail/Z=new();Z.loc=src.loc;Z.dir=src.dir;Z.Owner=src.Owner
			var/obj/Jutsu/Uchiha/AMATrail/ZZ=new();ZZ.loc=src.loc;ZZ.dir=src.dir;ZZ.Owner=src.Owner
			..()
	AMATrail
		icon='Icons/Jutsus/KatonTechsBlack.dmi'
		icon_state = "Amaterasu"
		layer=MOB_LAYER+2
		density = 0
		New()
			..()
			spawn()
				pixel_x=rand(-8,8)
				pixel_y=rand(-8,8)
				while(src)
				//	src.SoundEngine2('SFX/FireSFX.wav',volume=50)
					for(var/mob/M in range(1,src))
						var/mob/O=src.Owner
						if(M&&M!=O)
							var/damage=round(O.nin*rand(0.7,0.75))
							if(M.RaiArmor==2)
								damage/=2
							if(!M.knockedout)
								M.DamageProc(damage,"Health",O);M.DamageProc(damage*1.5,"Stamina",O)
					sleep(14)

			spawn(300)
				del(src)
	LightAMATrail
		icon='Icons/Jutsus/KatonTechniques.dmi'
		icon_state = "LightAmaterasu"
		layer=MOB_LAYER+2
		density = 0
		New()
			..()
			spawn()
				while(src)
			//		src.SoundEngine('SFX/FireSFX.wav',100)
					for(var/mob/M in range(1,src))
						var/mob/O=src.Owner
						if(M!=O)
							var/damage=round(50*rand(0.5,1))
							if(M.RaiArmor==2)
								damage/=10
							M.DamageProc(damage,"Health",O);M.DamageProc(damage,"Stamina",O)
					sleep(11)

			spawn(300)
				del(src)
	AMAProjectile
		icon='Icons/Jutsus/KatonTechniques.dmi'
		icon_state = "AmaterasuProjectile"
		layer=MOB_LAYER+2
		density = 1
		var/nin=10
		New()
			..()
			spawn()
				while(src)
					sleep(11)
				//	src.SoundEngine('SFX/FireSFX.wav',100)
			spawn(100)
				del(src)
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M=A
				var/mob/O=src.Owner

				var/damage=round(O.nin*rand(25,50));M.DamageProc(damage,"Health",O);M.DamageProc(damage,"Stamina",O)

				src.loc=M.loc;del(src)
			if(istype(A,/obj/))
				return 0
		Move()
			src.AmaterasuFire()
			..()
		Del()
			src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire()
			..()
	WhiteAMAProjectile
		icon='Icons/Jutsus/KatonTechniques.dmi'
		icon_state="WhiteAmaProjectile"
		layer=MOB_LAYER+2
		density = 1
		var/nin=10
		New()
			..()
			spawn()
				while(src)
					sleep(11)
		//			src.SoundEngine('SFX/FireSFX.wav',100)

			spawn(600)
				del(src)
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M=A
				var/mob/O=src.Owner

				var/damage=round(src.nin*rand(50,100))
				M.DamageProc(damage,"Health",O)
				M.DamageProc(damage,"Stamina",O)

				src.loc=M.loc;del(src)
			if(istype(A,/obj/))
				return 0
			if(istype(A,/turf/))
				del(src)
		Move()
			src.AmaterasuFire()
			..()
		Del()
			src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire()
			..()
/*obj/Jutsu/Uchiha
	AmatFireStuff
		icon='Icons/Jutsus/KatonTechniques.dmi'
		icon_state="AmatFire"
		layer=80
		density = 0
		var
			no_move = 0
			nin=10
		Bump(atom/o)
			..()
			if(istype(o,/obj/Jutsu))
				if(o != src)
					del(o)
		Cross(atom/movable/o)
			..()
			if(istype(o,/obj/Jutsu))
				if(o != src)
					del(o)
			if(istype(o,/turf))
				if(o.density)
					no_move = 1
					step(src,turn(dir,180))
			if(istype(o,/mob))
				return 1
		New()
			..()
			spawn()
				while(src)
			//		src.SoundEngine('SFX/FireSFX.wav',4)
					for(var/mob/M in range(1,src))//range(1,src))
						var/O=src.Owner
						if(M&&M!=O)
							if(!M.knockedout)
								var/damage=round(50*rand(0.5,1))
								M.DamageProc(damage,"Health",O)
					//		sleep(7)
					sleep(11 + rand(-5,5))
			spawn(600)
				del(src)
		AmatFireStuff2
		icon='Icons/Jutsus/KatonTechniques.dmi'
		icon_state="AmatFire"
		layer=80
		density = 0

		var
			no_move = 0
			nin=10

		Move()
			if(no_move)
				return
			..()

		Bump(atom/o)
			..()
			if(istype(o,/obj/Jutsu))
				if(!findtext(o.icon_state,"Amat") && !findtext(o.icon_state,"WhiteAma"))
					if(o != src)
						del(o)
		Cross(atom/movable/o)
			..()
			if(istype(o,/obj/Jutsu))
				if(!findtext(o.icon_state,"Amat") && !findtext(o.icon_state,"WhiteAma"))
					if(o != src)
						del(o)
			if(istype(o,/turf))
				if(o.density)
					no_move = 1
					step(src,turn(dir,180))
			if(istype(o,/mob))
				return 1

		New()
			..()
			spawn()
				while(src)
				//	src.SoundEngine('SFX/FireSFX.wav',4)
					for(var/mob/M in oview(1,src))
						if(!M.knockedout)
							var/damage=round(nin*rand(0.5,1))
							M.DamageProc(damage,"Health",src)
					sleep(11 + rand(-5,5))
			spawn(600)
				del(src)
	AMAExplosion
		icon='Icons/Jutsus/KatonTechsBlack.dmi'
		icon_state="AmatExplode"
		layer=6
		density = 0

		var
			no_move = 0

		New()
			..()
			spawn()
				while(src)
					for(var/mob/M in src.loc)
						var/mob/O=src.Owner
						if(M&&M!=O)
							var/damage=round(O.nin*rand(1.2,1.5))
							if(M.RaiArmor==2)
								damage/=2
							if(!M.knockedout)
								M.DamageProc(damage,"Health",O);M.DamageProc(damage*1.5,"Stamina",O)
					sleep(11 + rand(-5,5))
			spawn(30)
				del(src)
		Del()
			var/mob/P=src.Owner
		//	var/obj/Jutsu/Uchiha/AMAProjectile/Z=new();Z.loc=src.loc;Z.name="[src]";Z.dir=NORTH;Z.Owner=src.Owner;walk(Z,Z.dir)
			var/num=12
			var/loldir=src.dir
			while(num>0)
				sleep(1)
				var/obj/Jutsu/Uchiha/AMAProjectile/K=new();K.loc=src.loc;K.Owner=P;K.nin=P.nin;K.dir=loldir;K.name="[src]";walk(K,K.dir)
				loldir=turn(loldir,45)
				num--
		//	var/obj/Jutsu/Uchiha/AMAProjectile/C=new();C.loc=src.loc;C.name="[src]";C.dir=SOUTH;C.Owner=src.Owner;walk(C,C.dir)
		//	var/obj/Jutsu/Uchiha/AMAProjectile/B=new();B.loc=src.loc;B.name="[src]";B.dir=EAST;B.Owner=src.Owner;walk(B,B.dir)
		//	var/obj/Jutsu/Uchiha/AMAProjectile/A=new();A.loc=src.loc;A.name="[src]";A.dir=WEST;A.Owner=src.Owner;walk(A,A.dir)
		//	var/obj/Jutsu/Uchiha/AMAProjectile/F=new();F.loc=src.loc;F.name="[src]";F.dir=NORTHEAST;F.Owner=src.Owner;walk(F,F.dir)
		//	var/obj/Jutsu/Uchiha/AMAProjectile/G=new();G.loc=src.loc;G.name="[src]";G.dir=SOUTHWEST;G.Owner=src.Owner;walk(G,G.dir)
		//	var/obj/Jutsu/Uchiha/AMAProjectile/Y=new();Y.loc=src.loc;Y.name="[src]";Y.dir=SOUTHEAST;Y.Owner=src.Owner;walk(Y,Y.dir)
		//	var/obj/Jutsu/Uchiha/AMAProjectile/T=new();T.loc=src.loc;T.name="[src]";T.dir=NORTHWEST;T.Owner=src.Owner;walk(T,T.dir)
			..()
	AMA
		icon='Icons/Jutsus/KatonTechsBlack.dmi'
		icon_state = "Amaterasu"
		layer=MOB_LAYER+2
		density = 0

		var
			no_move = 0

		Move()
			if(no_move)
				return
			..()

		Bump(atom/o)
			..()
			if(istype(o,/obj/Jutsu))
				if(!findtext(o.icon_state,"Amat") && !findtext(o.icon_state,"WhiteAma"))
					if(o != src)
						del(o)
		Cross(atom/movable/o)
			..()
			if(istype(o,/obj/Jutsu))
				if(!findtext(o.icon_state,"Amat") && !findtext(o.icon_state,"WhiteAma"))
					if(o != src)
						del(o)
			if(istype(o,/turf))
				if(o.density)
					no_move = 1
					step(src,turn(dir,180))
			if(istype(o,/mob))
				return 1

		New()
			..()
			spawn()
				while(src)
			//		src.SoundEngine2('SFX/FireSFX.wav',volume=50)
					for(var/mob/M in oview(1,src))
						var/mob/O=src.Owner
						if(M&&!M.knockedout&&M!=O)
							var/damage=round(O.nin*rand(1.55,1.6))
							if(M.RaiArmor==2)
								damage/=2
							if(!M.knockedout)
								M.DamageProc(damage,"Health",O)
								M.DamageProc(damage*1.2,"Stamina",O)
					sleep(11 + rand(-5,5))

			spawn(600)
				del(src)
		Move()
			var/obj/Jutsu/Uchiha/AMATrail/Z=new();Z.loc=src.loc;Z.dir=src.dir;Z.Owner=src.Owner
			var/obj/Jutsu/Uchiha/AMATrail/ZZ=new();ZZ.loc=src.loc;ZZ.dir=src.dir;ZZ.Owner=src.Owner
			..()
	AMATrail
		icon='Icons/Jutsus/KatonTechsBlack.dmi'
		icon_state = "Amaterasu"
		layer=MOB_LAYER+2
		density = 0

		var
			no_move = 0

		Move()
			if(no_move)
				return
			..()

		Bump(atom/o)
			..()
			if(istype(o,/obj/Jutsu))
				if(!findtext(o.icon_state,"Amat") && !findtext(o.icon_state,"WhiteAma"))
					if(o != src)
						del(o)
		Cross(atom/movable/o)
			..()
			if(istype(o,/obj/Jutsu))
				if(findtext(o.icon_state,"Amaterasu"))
					o.loc=src.loc
				else if(!findtext(o.icon_state,"Amat") && !findtext(o.icon_state,"WhiteAma"))
					if(o != src)
						del(o)
			if(istype(o,/turf))
				if(o.density)
					no_move = 1
					step(src,turn(dir,180))
			if(istype(o,/mob))
				return 1

		New()
			..()
			spawn()
				pixel_x=rand(-8,8)
				pixel_y=rand(-8,8)
				while(src)
				//	src.SoundEngine2('SFX/FireSFX.wav',volume=50)
					for(var/mob/M in range(1,src))
						var/mob/O=src.Owner
						if(M&&M!=O)
							var/damage=round(O.nin*rand(0.5,0.55))
							if(M.RaiArmor==2)
								damage/=2
							if(!M.knockedout)
								M.DamageProc(damage,"Health",O);M.DamageProc(damage*1.5,"Stamina",O)
					sleep(14 + rand(-5,5))

			spawn(300)
				del(src)
	LightAMATrail
		icon='Icons/Jutsus/KatonTechniques.dmi'
		icon_state = "LightAmaterasu"
		layer=MOB_LAYER+2
		density = 0

		var
			no_move = 0

		Move()
			if(no_move)
				return
			..()

		Bump(atom/o)
			..()
			if(istype(o,/obj/Jutsu))
				if(!findtext(o.icon_state,"Amat") && !findtext(o.icon_state,"WhiteAma"))
					if(o != src)
						del(o)
		Cross(atom/movable/o)
			..()
			if(istype(o,/obj/Jutsu))
				if(!findtext(o.icon_state,"Amat") && !findtext(o.icon_state,"WhiteAma"))
					if(o != src)
						del(o)
			if(istype(o,/turf))
				if(o.density)
					no_move = 1
					step(src,turn(dir,180))
			if(istype(o,/mob))
				return 1

		New()
			..()
			spawn()
				while(src)
			//		src.SoundEngine('SFX/FireSFX.wav',100)
					for(var/mob/M in range(1,src))
						var/mob/O=src.Owner
						if(M!=O)
							var/damage=round(50*rand(0.5,1))
							if(M.RaiArmor==2)
								damage/=10
							M.DamageProc(damage,"Health",O);M.DamageProc(damage,"Stamina",O)
					sleep(11 + rand(-5,5))

			spawn(300)
				del(src)
	AMAProjectile
		icon='Icons/Jutsus/KatonTechniques.dmi'
		icon_state = "AmaterasuProjectile"
		layer=MOB_LAYER+2
		density = 0
		var/nin=10
		var
			no_move = 0
		Move()
			if(no_move)
				return
			..()
		New()
			..()
	//		spawn()
	//			while(src)
	//				sleep(11)
				//	src.SoundEngine('SFX/FireSFX.wav',100)
			spawn(100)
				del(src)
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M=A
				var/mob/O=src.Owner
				var/damage=round(O.nin*rand(25,50));M.DamageProc(damage,"Health",O);M.DamageProc(damage,"Stamina",O)
				src.loc=M.loc;del(src)
			if(istype(A,/obj/Jutsu))
				del(A)
			if(istype(A,/turf/))
				var/turf/B = A
				if(B.density)
					del(src)
		Move()
			src.AmaterasuFire()
			..()
		Del()
			src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire()
			..()
	WhiteAMAProjectile
		icon='Icons/Jutsus/KatonTechniques.dmi'
		icon_state="WhiteAmaProjectile"
		layer=MOB_LAYER+2
		density = 0
		var/nin=10

		var
			no_move = 0

		Move()
			if(no_move)
				return
			..()
		New()
			..()

			spawn()
				while(src)
					sleep(11)
		//			src.SoundEngine('SFX/FireSFX.wav',100)

			spawn(600)
				del(src)
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M=A
				var/mob/O=src.Owner
				var/damage=round(src.nin*rand(50,100))
				M.DamageProc(damage,"Health",O)
				M.DamageProc(damage,"Stamina",O)
				src.loc=M.loc;del(src)
			if(istype(A,/obj/Jutsu))
				del(A)
			if(istype(A,/turf/))
				var/turf/B = A
				if(B.density)
					del(src)
		Move()
			src.AmaterasuFire()
			..()
		Del()
			src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire()
			..()*/
	UchihaAura
		icon='Icons/Jutsus/Uchiha Aura.dmi'
		icon_state="0,0"
		layer=MOB_LAYER+1
		Part1
			icon_state="0,0"
			pixel_x=-16
		Part2
			icon_state="1,0"
			pixel_x=16
		Part3
			icon_state="0,1"
			pixel_x=-16
			pixel_y=32
		Part4
			icon_state="1,1"
			pixel_x=16
			pixel_y=32
	Susanoo
		//icon='Icons/Jutsus/Susanoo.dmi'
		icon='New Icons(Con4)/Susanoo Ribcage.dmi'
		//icon_state="5"
		density=1
		layer=MOB_LAYER+1
		//var/mob/O=src.Owner
		var/Type="Itachi"
		var/AmatShieldOn=0
		var/EntonDefenceBoost=0
		Bump(A)
			if(ismob(A))
				var/mob/M = A
				if(src.Owner==M)
					src.loc=M.loc
		New()
			spawn()
				src.icon_state=""
			//itachiPerfect
				if(src.icon_state==""&&src.Type=="itachiPerfect")
					src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part5;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part1;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part2;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part3;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part4;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part6;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part7;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part8;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part9
			//itachiBones
				if(src.icon_state==""&&src.Type=="itachiBones")
				//	src.overlays+=icon=='New Icons(Con4)/Susanoo Ribcage.dmi'
					src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part0003;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part0004;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part0001;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part0002
			//itachiSkeleton
				if(src.icon_state==""&&src.Type=="itachiSkeleton")
					src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part123456;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part12345;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part1234;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part123;
			//sasukeBones
				if(src.icon_state==""&&src.Type=="sasukeBones")
					src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part11;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part33;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part77;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part99
			//sasukeSkeleton
				if(src.icon_state==""&&src.Type=="sasukeSkeleton")
					src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part654321;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part54321;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part4321;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part321;
			//sasukePerfect
				if(src.icon_state==""&&src.Type=="sasukePerfect")
					src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part555;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part111;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part222;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part333;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part444;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part666;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part777;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part888;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part999

			//shisuiBones
				if(src.icon_state==""&&src.Type=="shisuiBones")
					src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part013;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part014;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part011;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part012
			//madaraBones
				if(src.icon_state==""&&src.Type=="madaraBones")
					src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part023;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part024;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part021;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part022
			//madaraSkeleton
				if(src.icon_state==""&&src.Type=="madaraSkeleton")
					src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part234;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part345;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part456;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part567;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part678;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part789;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part890;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part901;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part902;
			//madaraPerfect
				if(src.icon_state==""&&src.Type=="madaraPerfect")
					src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Parta;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Partb;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Partc;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Partd;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Parte;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Partf;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Partg;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Parth;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Parti

				while(src)
					for(var/obj/Jutsu/A in oview(1,src))
						if(A.Owner!=src.Owner)
							del(A)
					for(var/obj/Jutsu/A in src.loc)
						if(A.Owner!=src.Owner)
							del(A)
					if(src.Type=="itachi"||src.Type=="sasuke"||src.Type!="")
						for(var/mob/A in oview(1,src))
							if(A!=src.Owner)
								var/damage
								if(findtext(src.Type,"Perfect"))
									damage=rand(200,500)
								if(findtext(src.Type,"Skeleton"))
									damage=rand(100,200)
								if(findtext(src.Type,"Bones"))
									damage=rand(1,100)
								if(findtext(src.Type,"sasuke"))
									damage/=2.5
									if(src.EntonDefenceBoost==1)
										damage*=2.5
									if(src.EntonDefenceBoost==2)
										damage*=2.65
									if(src.EntonDefenceBoost==3)
										damage*=3
								A.DamageProc(damage*rand(1),"Health",src.Owner)
								A.DamageProc(damage*rand(1,2),"Stamina",src.Owner)
					sleep(11)
		proc/AmatDefenceProc(LevelOfDefence,PixelY,PixelX,Yvar,Xvar,Number1=1,Number2=3)
			var/mob/P=src.Owner
			if(src.AmatShieldOn==1)
				src.AmatShieldOn=0
				for(var/obj/Jutsu/Uchiha/AmatFireStuff2/A in src.view)
					if (src == Owner)
						del(A)
				for(var/obj/SkillCards/SusanooAmatDefence/A in P.LearnedJutsus)
					A.DelayIt(400,P,"Clan")
				P<<"You release the Enton shielding you....."
				return
			if(LevelOfDefence=="Light")
				src.AmatShieldOn=1
				src.EntonDefenceBoost=1
				var/a=rand(Number1,Number2)
				while(a>0)
					sleep(1)
					var/obj/Jutsu/Uchiha/AmatFireStuff2/F=new()
					F.Owner=src.Owner
					F.pixel_y=rand(PixelY,PixelY+((Yvar*2)-6))
					F.pixel_x=rand(PixelX,PixelX+((Xvar*2)-1))
		//			F.dir=Dir
					src.overlays+=F
					a--
			if(LevelOfDefence=="Medium")
				src.AmatShieldOn=1
				src.EntonDefenceBoost=2
				var/a=rand(Number1,Number2)
				while(a>0)
					sleep(1)
					var/obj/Jutsu/Uchiha/AmatFireStuff2/F=new()
					F.Owner=src.Owner
					F.pixel_y=rand(PixelY,PixelY+((Yvar*2)-5))
					F.pixel_x=rand(PixelX,PixelX+((Xvar*2)-1))
		//			F.dir=Dir
					src.overlays+=F
					a--
			if(LevelOfDefence=="Heavy")
				src.AmatShieldOn=1
				src.EntonDefenceBoost=3
				var/a=rand(Number1,Number2)
				while(a>0)
					sleep(1)
					var/obj/Jutsu/Uchiha/AmatFireStuff2/F=new()
					F.Owner=src.Owner
					F.pixel_y=rand(PixelY,PixelY+((Yvar*2)-4))
					F.pixel_x=rand(PixelX,PixelX+((Xvar*2)-1))
		//			F.dir=Dir
					src.overlays+=F
					a--
///////itachiPerfect//////
		Part1
			icon_state="1"
			pixel_x=-32
			pixel_y=32
		Part2
			icon_state="2"
			pixel_y=32
		Part3
			icon_state="3"
			pixel_x=32
			pixel_y=32
		Part5
			icon_state="5"
		Part4
			icon_state="4"
			pixel_x=-32
		Part6
			icon_state="6"
			pixel_x=32
		Part7
			icon_state="7"
			pixel_x=-32
			pixel_y=-32
		Part8
			icon_state="8"
			pixel_y=-32
		Part9
			icon_state="9"
			pixel_x=32
			pixel_y=-32
///////sasukePerfect//////
		Part111
			icon_state="111"
			pixel_x=-32
			pixel_y=32
		Part222
			icon_state="222"
			pixel_y=32
		Part333
			icon_state="333"
			pixel_x=32
			pixel_y=32
		Part555
			icon_state="555"
		Part444
			icon_state="444"
			pixel_x=-32
		Part666
			icon_state="666"
			pixel_x=32
		Part777
			icon_state="777"
			pixel_x=-32
			pixel_y=-32
		Part888
			icon_state="888"
			pixel_y=-32
		Part999
			icon_state="999"
			pixel_x=32
			pixel_y=-32
////sasukeBones/////
		Part11
			icon_state="11"
			pixel_x=-18//-32
			pixel_y=24//16//32
		Part33
			icon_state="33"
			pixel_x=14//32
			pixel_y=24//32
		Part77
			icon_state="77"
			pixel_x=-18//-32
			pixel_y=-8//-16//-32
		Part99
			icon_state="99"
			pixel_x=14//32
			pixel_y=-8//-16//-32
//////ItachiBones///////

		Part0003
			icon_state="0003"
			pixel_x=-18//-32
			pixel_y=24//16//32
		Part0004
			icon_state="0004"
			pixel_x=14//32
			pixel_y=24//32
		Part0001
			icon_state="0001"
			pixel_x=-18//-32
			pixel_y=-8//-16//-32
		Part0002
			icon_state="0002"
			pixel_x=14//32
			pixel_y=-8//-16//-32
//////itachiSkeleton///////

		Part123
			icon_state="123"
			pixel_x=-16//-32
			//pixel_y=24//16//32
		Part1234
			icon_state="1234"
			pixel_x=16//32
			//pixel_y=24//32
		Part12345
			icon_state="12345"
			pixel_x=-16//-32
			pixel_y=32//-16//-32
		Part123456
			icon_state="123456"
			pixel_x=16//32
			pixel_y=32//-16//-32
//////sasukeSkeleton///////

		Part321
			icon_state="321"
			pixel_x=-16//-32
			//pixel_y=24//16//32
		Part4321
			icon_state="4321"
			pixel_x=16//32
			//pixel_y=24//32
		Part54321
			icon_state="54321"
			pixel_x=-16//-32
			pixel_y=32//-16//-32
		Part654321
			icon_state="654321"
			pixel_x=16//32
			pixel_y=32//-16//-32
///////Shisui Bones////////

		Part013
			icon_state="013"
			pixel_x=-18//-32
			pixel_y=24//16//32
		Part014
			icon_state="014"
			pixel_x=14//32
			pixel_y=24//32
		Part011
			icon_state="011"
			pixel_x=-18//-32
			pixel_y=-8//-16//-32
		Part012
			icon_state="012"
			pixel_x=14//32
			pixel_y=-8//-16//-32
////////Madara Bones//////

		Part023
			icon_state="023"
			pixel_x=-18//-32
			pixel_y=24//16//32
		Part024
			icon_state="024"
			pixel_x=14//32
			pixel_y=24//32
		Part021
			icon_state="021"
			pixel_x=-18//-32
			pixel_y=-8//-16//-32
		Part022
			icon_state="022"
			pixel_x=14//32
			pixel_y=-8//-16//-32
//////////Madara skleton/////////
		Part345
			icon_state="345" // centered
		Part234
			icon_state="234" //left
			pixel_x=-32
		Part456
			icon_state="456" //right
			pixel_x=32
		Part567
			icon_state="567" // left up
			pixel_x=-32
			pixel_y=32
		Part789
			icon_state="789" //right up
			pixel_x=32
			pixel_y=32
		Part678
			icon_state="678" // up
			pixel_y=32
		Part890
			icon_state="890" //left up up
			pixel_y=64
			pixel_x=-32
		Part901
			icon_state="901" //up up
			pixel_y=64
		Part902
			icon_state="902" //right up up
			pixel_y=64
			pixel_x=32
///////madaraPerfect//////
		Parta
			icon_state="a"
			pixel_x=-32
			pixel_y=32
		Partb
			icon_state="b"
			pixel_y=32
		Partc
			icon_state="c"
			pixel_x=32
			pixel_y=32
		Parte
			icon_state="e"
		Partd
			icon_state="d"
			pixel_x=-32
		Partf
			icon_state="f"
			pixel_x=32
		Partg
			icon_state="g"
			pixel_x=-32
			pixel_y=-32
		Parth
			icon_state="h"
			pixel_y=-32
		Parti
			icon_state="i"
			pixel_x=32
			pixel_y=-32


mob/owner/verb/TestUchihaAura()
	var/obj/Jutsu/Uchiha/UchihaAura/Part1/A=new();var/obj/Jutsu/Uchiha/UchihaAura/Part2/B=new()
	var/obj/Jutsu/Uchiha/UchihaAura/Part3/C=new();var/obj/Jutsu/Uchiha/UchihaAura/Part4/D=new();
	usr.overlays+=A;usr.overlays+=B;usr.overlays+=C;usr.overlays+=D
mob/owner/verb/TestUchihaAuraRemoval()
	var/obj/Jutsu/Uchiha/UchihaAura/Part1/A=new();var/obj/Jutsu/Uchiha/UchihaAura/Part2/B=new()
	var/obj/Jutsu/Uchiha/UchihaAura/Part3/C=new();var/obj/Jutsu/Uchiha/UchihaAura/Part4/D=new();
	usr.overlays-=A;usr.overlays-=B;usr.overlays-=C;usr.overlays-=D
mob/proc/SasukeAmatDefence(HowStrong)
	var/AmatStrength=HowStrong
	src.MUses++
	view()<<"[src] encoats themself in a Black Flame..."
	for(var/obj/Jutsu/Uchiha/Susanoo/A in world)
		if(A.Owner==src)
			if(HowStrong=="Light")
			//	A.AmatDefenceProc(AmatStrength,PixelY,PixelX,Yvar,Xvar,Dir=SOUTH,Number1=1,Number2=3)
				A.AmatDefenceProc(AmatStrength,-8,-18,26,32,8,15)
			if(HowStrong=="Medium")
				A.AmatDefenceProc(AmatStrength,-8,-18,26,32,15,24)
			if(HowStrong=="Heavy")
				A.AmatDefenceProc(AmatStrength,-8,-18,26,32,24,30)
mob/proc/FieldOfBlackFlames()
	src.MUses+=5
	if(src.ControllingAmat==1)
		src<<"You stop controlling your Amaterasu."
		src.ControllingAmat=0
	src<<"You are able to form Black Flames anywhere on the field! Double Click to place Sawa!"
	src.ControllingAmat=1
	while(src.ControllingAmat==1)
		src.ChakraDrain(20000)
		if(prob(25))
			src.MUses+=3
		if(src.knockedout)
			src.ControllingAmat=0
			src<<"You stop controlling your Sawa."
			return
		sleep(20)
mob/proc/TimeCollaboration()
	src.MUses++
	view()<<"[src] decreases the speed of time around them!"
	src.health-=25
	if(prob(30))
		src.Bloody()
	src.chakra-=250
	for(var/obj/Jutsu/B in oview(8,src))
		if(B.Owner!=src.Owner)
			walk(B,0)
	for(var/obj/Jutsu/C in src.loc)
		if(istype(C,/obj/Jutsu/Uchiha/Susanoo))
			break
		if(C.Owner!=src.Owner)
			del(C)
	for(var/mob/M in oview(4,src))
		if(M in OnlinePlayers && !M.knockedout)
			M<<"Time is slown down around you!"
			M.Running=0
			M.StunAdd(20)

obj/proc/AmaterasuFire()
	var/obj/Jutsu/Uchiha/AmatFireStuff/A=new()
	A.loc=src.loc;A.pixel_x+=rand(1,8)
	A.pixel_y+=rand(1,8)
	A.nin=50
	A.icon='Icons/Jutsus/KatonTechniques.dmi'
	A.icon_state="AmatFire"
	if(src.icon_state=="WhiteAmaProjectile"||src.icon_state=="WhiteAmatSmall")
		A.icon_state="WhiteAmatFire"
	var/obj/Jutsu/S=src
	A.Owner=S.Owner
mob/proc
	Illuminate()
		src.see_invisible=99
		if(src.mangekyou)
			src.see_invisible=100
	IlluminateOff()
		src.see_invisible=1

mob/var
	DoujutsuTechs=0
	tmp/shari=0
	tmp/mangekyou=0
	tmp/SharCounter=0
	tmp/CopyMode=0
	tmp/GenjutsuCounterMode=0
	tmp/SusanooIn=0
	tmp/UsingAmaterasu=0
	tmp/Phasing=0
	tmp/Kamui=0
obj/WarpEffect
	icon='Warp2.dmi'
	icon_state="Zap"
	layer=5
	pixel_x=-16
	pixel_y=-16
	New()
		..()
		spawn(9)
			del(src)
mob/var/tmp
	MindGenjutsuReady=0
	MindGenjutsuWho="Missing Ninja"
	MindGenjutsuRank="Genin"
	MindGenjutsuWhat="Message"
	MindGenjutsuMode="Say"
	MindGenjutsuTarget
mob/proc
	Mind_Genjutsu()
		usr.Target()
		if(usr.ntarget)
			return
		else if(usr.MindGenjutsuReady)
			usr<<"You already prepared a Mind Genjutsu, to cancel the previous one, Shift+Click yourself. To execute it, Shift+Click on the person to say it, or Shift+Click on anything else to make the name you typed say it with no speech bubble."
			return
		else
			var/mob/M=usr.target
			var/Mode=input(usr,"Village Say or Say?","Mode",usr.MindGenjutsuMode) in list("Say","Village Say","Cancel")
			if(Mode=="Cancel") return
			var/A=input(usr,"What do you want to make [M] think that they are hearing?","Message") as text
			var/B=input(usr,"Who is going to say it? You can leave this blank and simply click on the person you want them to think is saying it. If you do not click on a mob though, the name will appear as <i>Missing Ninja</i> and no speech bubble will appear.","Name",usr.MindGenjutsuWho) as text
			usr<<"Now Shift + Click the person you want [M] to think is talking. To cancel, Shift+Click yourself. For no speech bubble and the default name, click a turf or object."
			if(B==null)
				B="Missing Ninja"
			usr.MindGenjutsuWho=B;usr.MindGenjutsuWhat=A;usr.MindGenjutsuMode=Mode;usr.MindGenjutsuTarget=M
			usr.MindGenjutsuReady=1
	Invisibility()
		if(src.invisibility==100)
			src.invisibility=1;src.AttackDelay=0
			src<<"You release the invisibility genjutsu.."
		else
			src.icon_state="handseal"
			src.MUses++
			src<<"You begin to cast a genjutsu of invisibility around yourself.."
			spawn(30)
				if(src.icon_state=="handseal")
					src.invisibility=100;src.AttackDelay=1
					src<<"Success! You're completely invisible to all but those with the keenest eyes. In this mode you're incapable of attacking."
				else
					src<<"The genjutsu failed."
					for(var/obj/SkillCards/Invisibility/A in src.LearnedJutsus)
						A.DelayIt(600,src,"Clan")

	False_Bunshin(atom/movable/A in world)
		var/mob/Clones/Clone/M = new()
		src.MUses++
		M.CloneType="GenjutsuClone"
		M.name=A.name;M.icon=A.icon;M.overlays=A.overlays;M.Owner=src;M.health=100000;M.density=1
		M.x=src.x-1;M.y=src.y;M.z=src.z

	Bunshin_MindFuck()
		if(src.controlled)
			var/mob/K=src.controlled
			for(var/mob/W in world)
				if(W.client&&W.client.eye==K)
					if(W!=src)
						W.client.eye=src
					else
						src.client.eye=src;src.client.perspective=MOB_PERSPECTIVE
						src.controlled=null
				sleep(25)
				del(K)
			return
		if(!src.target)
			src<<"You need a target.";return
		var/mob/M=usr.target
		var/mob/Clones/Clone/K=new()
		K.loc=locate(src.x,src.y,src.z)
		src.controlled=K;src.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;src.client.eye=K
		for(var/mob/P in range(15,src))
			if(src==P.target)
				M.target=K
				for(var/image/x in M.client.images)
					if(x.icon=='Icons/target1.dmi'&&x.icon_state!="Number2")
						del(x)
				var/image/I = image('Icons/target1.dmi',K)
				M<<I
		for(var/mob/W in world)
			if(W.client&&W.client.eye==src)
				W.client.eye=K
		if(K)
			for(var/V in src.vars)
				var/list/BAD = list("locs","cansave","key","ckey","client","type","parent_type","verbs","vars","group","x","y","z","loc","contents","controlled","alterV","alterC","alterR","OriginalVillage","Orank","OClan","ImmuneToDeath")
				if(!BAD.Find(V))
					K.vars[V] = src.vars[V]
			K.CloneType="GenjutsuClone"
			K.RunningSpeed=5;K.Running=1;K.density=1
			K.icon=src.icon;K.overlays+=src.overlays
			K.name="[src.name]";K.Owner=src
			K.tai=K.tai;K.nin=K.nin;K.gen=K.gen
			K.Running=1;K.RunningSpeed=5;src.KBunshinOn=1
			K.icon_state="running";K.Clone=1;K.cansave=0
		while(K&&src.chakra>0&&src.mangekyou)
			src.invisibility=100
			src.sight |= SEE_SELF
			src.density=0
			src.ImmuneToDeath=1
			sleep(20)
		if(K)
			for(var/mob/W in world)
				if(W.client&&W.client.eye==K)
					if(W!=src)
						W.client.eye=src
			sleep(25)
			del(K)
		src.client.eye=src;src.client.perspective=MOB_PERSPECTIVE
		src.controlled=null
		src.invisibility=1
		src.sight &= ~SEE_SELF
		src.density=1
		src.ImmuneToDeath=0




mob/var/tmp/UsingAmaterasuExplosion=0
mob/var/EternalMangekyoSharingan=0 //0 = None or Regular. 1 = Eternal MS. 2 = Extended Life MS.



mob/proc
	Sharingan()
//		if(src.Clan!="Uchiha")
//			return
		if(src.mangekyou)
			return
		if(src.shari)
			src<<"You release your sharingan.";usr.ChangeEyeStyle(usr.EyeStyle,usr.reye,usr.geye,usr.beye);src.shari=0;src.IlluminateOff();src.GenjutsuCounterMode=0;src.SharCounter=0;src.CopyMode=0;src.ChakraSight(0);
			for(var/obj/SkillCards/SharinganIlluminate/Z in usr.LearnedJutsus)
				del(Z)
			for(var/obj/SkillCards/SharinganFocus/Z in usr.LearnedJutsus)
				del(Z)
			src.UpdateInv()
			return
		else
			if(!src.shari)
				src.icon_state="1";usr.ChangeEyeStyle(usr.EyeStyle,200,0,0)
				var/image/I = new('Icons/Jutsus/sharinganthing.dmi');I.pixel_y=32;I.layer=6
				if(src.SharinganMastery==0)
					src.AwardMedal("Sharingan!")
				if(src.SharinganMastery<45)
					view()<<"[src]'s eyes shines brightly red, revealing 1 tomoe!";I.icon_state="1 tomoe"
				if(src.SharinganMastery<91&&src.SharinganMastery>=45)
					view()<<"[src]'s eyes shines brightly red, revealing 2 tomoes!";I.icon_state="2 tomoe"
				if(src.SharinganMastery>=91)
					view()<<"[src]'s eyes shines brightly red, revealing 3 tomoes!";I.icon_state="3 tomoe"
				if(src.SharinganMastery>200)
					view()<<"[src]'s eyes shines brightly red, revealing a very mature Sharingan!"
					src.LearnedJutsus+=new/obj/SkillCards/SharinganFocus
				if(src.SharinganMastery>=31)
					src<<"You can see through taijutsu techniques a lot better now!";usr.SharCounter=1
				if(src.SharinganMastery>=61)
					src.LearnedJutsus+=new/obj/SkillCards/SharinganIlluminate
					src<<"You can see through taijutsu techniques on a high level!";src.SharCounter=2
				src.UpdateInv()
				src.overlays+=I
				spawn(30)
					src.overlays-=I
					del(I)
				src.shari=1;src.Illuminate();sleep(30);src.ChakraSight(1)
				while(src.shari)
					var/A=src.SharinganMastery
					if(A<1) A=1
					var/ChakraDrain=(src.Mchakra/(A*15))
					if(ChakraDrain>65)
						ChakraDrain=65
					if(ChakraDrain<5)
						ChakraDrain=5
					src.chakra-=ChakraDrain
					if(prob(1))
						src.SharinganMastery+=pick(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1)
					if(src.Charging&&prob(3))
						src.SharinganMastery+=pick(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1)
					sleep(25)
	Sharingancopy()
		if(!src.shari)
			src<<"You need Sharingan on!";return
		else
			src<<"The next attack done by any ninja will be copied by you!";src.CopyMode=1
	SharinganFocus()
		if(!src.shari)
			src<<"You need Sharingan on!";return
		else
			if(src.SharinganNotice)
				src<<"You stop focusing on their handseals"
				src.SharinganNotice=0
				return
			else
				src<<"You begin to focus on the Opponents Handseals."
				src.SharinganNotice=1
	SharinganIlluminate()
		if(!src.shari)
			src<<"You need Sharingan on!";return
		else
			src<<"You focus your Sharingan to see chakra."
			src.IlluminateOff()
			src.ChakraSight(0)
			src.Illuminate()
			src.ChakraSight(1)
	GenjutsuCounter()
		if(!src.shari)
			src<<"You need Sharingan on!";return
		else
			var/TimeLimit=100+(usr.SharinganMastery/10);src<<"You have the ability to counter genjutsu for [TimeLimit/10] seconds.";src.GenjutsuCounterMode=1
			spawn(TimeLimit)
				src.GenjutsuCounterMode=0
	Konsui()
		if(!src.shari)
			src<<"You need Sharingan on!";return
		if(src.firing||src.Frozen)
			return
		src.chakra-=500
		for(var/mob/M in get_step(src,src.dir))
			if(M.dir==(get_dir(M,src))&&usr.dir==(get_dir(src,M)))
				if(M.knockedout)
					src<<"They're currently knocked out!";return
				if(M.Majest)
					src<<"You look deeply into [M]'s eyes!"
					spawn(15)
						src<<"Their Golden Majestic Eyes saw through your hypnosis, and prevented your genjutsu from working!"
				if(M.FrozenBind=="Sharingan")
					src<<"You've already captured them in a genjutsu, you can't cast the Hypnosis spell when they're in this much pain!";return
				M<<"[src] looks deeply into your eyes, their eyes spinning rapidly!";src<<"You look deeply into [M]'s eyes!";var/SleepingCount=30
				while(SleepingCount>0)
					if(SleepingCount>10&&M.gencounter)
						view()<<"[M] uses Genjutsu Release to prevent [src]'s attack from working!";M.gencounter=0;SleepingCount=0;return
					if(SleepingCount==20)
						M<<"You feel rather tired."
					if(SleepingCount==10)
						M<<"You feel like you're going to collapse."
					if(SleepingCount<=10)
						M.Running=0
					if(SleepingCount==1)
						M<<"You are way too tired, you are collapsing."
						M.Status="Asleep";M.icon_state="dead"
						M.StatusEffected=min(rand(src.SharinganMastery/25,src.SharinganMastery/15),20)
					SleepingCount-=1
					if(M.knockedout||M.ImmuneToDeath||M.Dead)
						src<<"The genjutsu failed."
						SleepingCount=0
						return
					sleep(11)
			else
				usr<<"You need to make eye contact!";return
	Kasegui()
		if(!src.shari)
			src<<"You need Sharingan on!";return
		if(src.firing)
			return
		if(src.Frozen)
			return
		var/Damage=(src.SharinganMastery+src.GenjutsuKnowledge)
		var/mob/ST   //Specified Target     I defined these variables so that the mob or turf is not lost in runtime//By movement or other things
		var/Distance=round(src.SharinganMastery/100)
		if(Distance<1) Distance=1
		if(Distance>10) Distance=10
		var/turf/DM = get_steps(src,src.dir,Distance)  //Distance Marker
		var/a=0
		while(a<Distance&&!ST)
			a++
			DM = get_steps(src,src.dir,a)
			for(var/mob/M in DM)
				if(M!=src&&M.dir==(get_dir(M,src))&&src.dir==(get_dir(src,M))&&M.FrozenBind==""&&!M.knockedout&&M.FrozenBind!="DoBind")
					ST=M   //Catch the first mob in the line. If he makes eyecontact then he's caught
					//If not, then the jutsu ends because anyone behind him wouldn't make eyecontact period.
					break
		if(!ST)
			src<<"You couldn't make eye contact with anyone.";return
		if(ST.shika)
			if(src.target!=ST)
				src<<"Due to [ST] being on all fours you weren't able to succesfully look them in the eyes.";return
		if(ST.ImmuneToDeath)
			return
		ST.FrozenBind="Sharingan"
		var/b=(ST.GenjutsuSight+(ST.GenjutsuKnowledge/100))///10))
		if(b<1) b=1
		if(b>10) b=10
		Damage=(Damage/b)+src.Mgen
		var/StartHealth=ST.health
		var/spot=src.loc
		src.UsingStakes=1
		var/image/A=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);A.icon_state="1";var/image/B=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);B.icon_state="2"
		var/image/C=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);C.icon_state="3";var/image/D=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);D.icon_state="4"
		var/image/E=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);E.icon_state="5";var/image/F=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);F.icon_state="6"
		var/image/G=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);G.icon_state="7";var/image/H=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);H.icon_state="8";var/image/I=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);I.icon_state="9"
		src<<A;src<<B;src<<C;src<<D;src<<F;src<<G;src<<H;src<<I
		if(ST.client) ST<<A;ST<<B;ST<<C;ST<<D;ST<<F;ST<<G;ST<<H;ST<<I
		sleep(18)
		ST.stamina-=Damage
		src<<output("[ST] was hurt by the genjutsu!([Damage])","Attack")
		while(ST&&src&&ST.FrozenBind=="Sharingan"&&!src.firing&&ST.Status!="Asleep"&&src.loc==spot&&src.UsingStakes)
			if(ST.health>(StartHealth-100)&&src.shari&&src.dir==(get_dir(src,ST)))
				var/ChakraDrain=100;src.chakra-=ChakraDrain;ST.FrozenBind="Sharingan";src<<E;ST<<E;ST.firing=1;src.UnableToChargeChakra=1;sleep(11)
				if(prob(10))
					ST.stamina-=Damage/10;src<<output("[ST] was hurt by the genjutsu!([Damage/10])","Attack")
				if(src.chakra<ChakraDrain)
					src<<"The bind on [ST] breaks!"
					ST.FrozenBind="";src.UnableToChargeChakra=0;step(src,ST.dir)
					for(var/image/x in src.client.images)
						if(x.icon=='Icons/Jutsus/GenjutsuTechniques.dmi')
							del(x)
					if(ST.client)
						for(var/image/c in ST.client.images)
							if(c.icon=='Icons/Jutsus/GenjutsuTechniques.dmi')
								del(c)
			else
				src<<"You break the bind!";ST.firing=0;src.UnableToChargeChakra=0;ST.FrozenBind=""
				for(var/image/x in src.client.images)
					if(x.icon=='Icons/Jutsus/GenjutsuTechniques.dmi')
						del(x)
				if(ST.client)
					for(ST in src.view)
						for(var/image/x in ST.client.images)
							if(x.icon=='Icons/Jutsus/GenjutsuTechniques.dmi')
								del(x)
		ST<<"The binds breaks!"
		ST.firing=0;src.UnableToChargeChakra=0;ST.FrozenBind="";src.UsingStakes=0
		for(var/image/x in src.client.images)
			if(x.icon=='Icons/Jutsus/GenjutsuTechniques.dmi')
				del(x)
		if(ST.client)
			for(var/image/x in ST.client.images)
				if(x.icon=='Icons/Jutsus/GenjutsuTechniques.dmi')
					del(x)
	MangekyouPrep()
		if(src.firing)
			return
		if(src.mangekyou)
			src.mangekyou=0
			if(!src.shari)
				src.ChangeEyeStyle(src.EyeStyle,src.reye,src.geye,src.beye);src.IlluminateOff()
			else
				src<<"You release the mangekyou sharingan, and your eyes return to their 3 tomoe state.."
			var/list/Techniques=list("MindGenjutsu","Invisibility","FalseBunshin","GenjutsuBunshin","Kamui","TimeCollaboration","Phase","Amateratsu","AmateratsuProjectile","WhiteAmaterasuProjectile","Susanoo","Tsukiyomi","WhiteAmaterasu360","SusanooAmatDefence","SusanooAmatDefence2","SusanooAmatDefence3")
			while(Techniques.len>0)
				var/Choice=pick(Techniques)
				Techniques.Remove(Choice)
				var/Path=text2path("/obj/SkillCards/[Choice]")
				var/obj/SkillCards/S = locate(Path) in src.LearnedJutsus
				if(!S)
					continue
				else
					S.NonKeepable=1
					src.LearnedJutsus-=S
			var/X=0
			for(var/obj/SkillCards/O in src.LearnedJutsus)//Loop through all the items in the players contents
				winset(src, "Jutsu.Jutsus", "current-cell=1,[++X]")	//Add multiple cells horizontally for each obj
				src << output(O, "Jutsu.Jutsus")//Send the obj's in src.contents to the Grid
			winset(src,"Jutsu.Jutsus", "cells=[X]")
			src<<"You release your Mangekyou Sharingan.";src.ChakraSight(0);src.Phasing=0;src.mangekyou=0
			for(var/obj/MMshar/MM in src.client.screen)
				del(MM)
			if(src.MUses>250)
				var/obj/MMshar/MM=new()
				MM.screen_loc = "1,1 to 32,23"
				src.client.screen+=MM
				if(src.MUses>250&&usr.MUses<350)
					MM.icon_state="weak"
				if(src.MUses>=350&&usr.MUses<500)
					MM.icon_state="strong"
				if(src.MUses>=500)
					MM.icon_state="blind"
				if(src.MUses>=600)
					MM.icon_state="blinder"
			if(src.SusanooIn)
				src.SusanooHealth=0
				src.SusanooDeleteCheck()
			src.RemoveUchihaAura()
			src.UpdateInv()
		else
			if(!src.shari)
				src<<"Turn on your regular sharingan first."
				return
				//src.ChangeEyeStyle(src.EyeStyle,src.reye,src.geye,src.beye);src.shari=0;src.IlluminateOff();src.GenjutsuCounterMode=0;src.SharCounter=0;src.CopyMode=0;src.ChakraSight(0);return
			src.mangekyou=1;src.ChakraSight(1);src.ChangeEyeStyle(src.EyeStyle,200,0,0)
			view(9,src)<<"[src]'s pupils spin and transform into the Legendary Mangekyou Sharingan!";usr.Illuminate()
			var/image/A = new('Icons/Jutsus/sharinganthing.dmi');
			A.pixel_y=32;A.layer=6 //Begin Added stuff
			if(!src.EternalMangekyoSharingan)
				A.icon_state="[src.mangekyouC]"
			else if(src.EternalMangekyoSharingan==2)
				A.icon_state="ELMS"
			src.overlays+=A
			spawn(30)
				src.overlays-=A
				del(A)//End Added stuff
			if(src.mangekyouC=="6 point")
				src.mangekyouC="bladed"
			for(var/obj/MMshar/MM in src.client.screen)
				del(MM)
			if(src.MUses>350)
				var/obj/MMshar/MM=new()
				MM.screen_loc = "1,1 to 32,23"
				src.client.screen+=MM
				MM.icon_state="weak"
				var/obj/I=new()
				var/obj/I2=new()
				I.icon='Icons/Jutsus/sharinganthing.dmi';I2.icon=I.icon
				I.pixel_y=16;I2.pixel_y=16
				I.pixel_x=-20;I2.pixel_x=20
				if(src.MUses>=300)
					MM.icon_state="strong"
					I.icon_state="blind 1";I2.icon_state=I.icon_state
				if(src.MUses>=400)
					MM.icon_state="blind"
					I.icon_state="blind 2";I2.icon_state=I.icon_state
				if(src.MUses>=500)
					MM.icon_state="blinder"
					I.icon_state="blind 3";I2.icon_state=I.icon_state
				src.overlays+=I;src.overlays+=I2
				spawn(20)
					src.overlays-=I;src.overlays-=I2
					del(I)
			else
				var/obj/I=new();var/obj/I2=new()
				I.icon='Icons/Jutsus/sharinganthing.dmi';I2.icon=I.icon
				I.icon_state="[src.mangekyouC]";I2.icon_state=I.icon_state
				I.pixel_y=16;I2.pixel_y=16
				I.pixel_x=-20;I2.pixel_x=20
				src.overlays+=I;src.overlays+=I2
				spawn(20)
					src.overlays-=I;src.overlays-=I2
					del(I)
			if(findtext(usr.mangekyouC,"argon",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/AmateratsuExplosion
				src.LearnedJutsus+=new/obj/SkillCards/AmateratsuProjectile
				src.LearnedJutsus+=new/obj/SkillCards/WhiteAmateratsuProjectile
			if(findtext(usr.mangekyouC,"crescent",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Amateratsu
				src.LearnedJutsus+=new/obj/SkillCards/WhiteAmaterasu360
				//src.LearnedJutsus+=new/obj/SkillCards/Susanoo
			if(findtext(usr.mangekyouC,"nova",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/FieldOfBlackFlames
				src.LearnedJutsus+=new/obj/SkillCards/WhiteAmaterasu360
				src.LearnedJutsus+=new/obj/SkillCards/AmateratsuExplosion
			if(findtext(usr.mangekyouC,"gate",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Phase
				src.LearnedJutsus+=new/obj/SkillCards/TimeCollaboration
			if(findtext(usr.mangekyouC,"obito",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Phase
			if(findtext(usr.mangekyouC,"shuriken",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/TimeCollaboration
			if(findtext(usr.mangekyouC,"itachi",1,0)||findtext(usr.mangekyouC,"sasuke",1,0)||findtext(usr.mangekyouC,"madara",1,0)||findtext(usr.mangekyouC,"star",1,0)||findtext(usr.mangekyouC,"gridlock",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Tsukiyomi
			if(findtext(usr.mangekyouC,"itachi",1,0)||findtext(usr.mangekyouC,"bladed",1,0)||findtext(usr.mangekyouC,"shuriken",1,0)||findtext(usr.mangekyouC,"niro",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Amateratsu
			if(findtext(usr.mangekyouC,"sasuke",1,0)||findtext(usr.mangekyouC,"bladed",1,0)||findtext(usr.mangekyouC,"star",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/AmateratsuProjectile
			if(findtext(usr.mangekyouC,"gridlock",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/WhiteAmateratsuProjectile
				src.LearnedJutsus+=new/obj/SkillCards/WhiteAmaterasu360
			if(findtext(usr.mangekyouC,"obito",1,0)||findtext(usr.mangekyouC,"bladed",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Kamui
			if(findtext(usr.mangekyouC,"itachi",1,0)||findtext(usr.mangekyouC,"sasuke",1,0)/*||findtext(usr.mangekyouC,"niro",1,0)*/||findtext(usr.mangekyouC,"madara",1,0)||findtext(usr.mangekyouC,"shisui",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Susanoo
			if(findtext(usr.mangekyouC,"sasuke",1,0))
				if(src.SusanooMastery>=25)
					src<< " Your Susanoo Mastery has inceased giving you the ability to use Enton"
					src.LearnedJutsus+=new/obj/SkillCards/SusanooAmatDefence
				if(src.SusanooMastery>=50)
					src<<"You feel as though you're able to use the Enton more effectively...!"
					if(!(locate(/obj/SkillCards/SusanooAmatDefence2) in src.LearnedJutsus))
						src.LearnedJutsus+=new/obj/SkillCards/SusanooAmatDefence2
				if(src.SusanooMastery>=100)
					src<<"You feel as though you've mastered your use of Enton..,,,"
					if(!(locate(/obj/SkillCards/SusanooAmatDefence3) in src.LearnedJutsus))
						src.LearnedJutsus+=new/obj/SkillCards/SusanooAmatDefence3
			if(findtext(usr.mangekyouC,"shisui",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/MindGenjutsu
				src.LearnedJutsus+=new/obj/SkillCards/Invisibility
				src.LearnedJutsus+=new/obj/SkillCards/FalseBunshin
				src.LearnedJutsus+=new/obj/SkillCards/GenjutsuBunshin
			if(findtext(usr.MMove1,"AmateratsuP",1,0)||findtext(usr.MMove2,"AmateratsuP",1,0)||findtext(usr.MMove3,"AmateratsuP",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/AmateratsuProjectile
			if(findtext(usr.MMove1,"Amateratsu",1,0)||findtext(usr.MMove2,"Amateratsu",1,0)||findtext(usr.MMove3,"Amateratsu",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Amateratsu
			if(findtext(usr.MMove1,"Tsukiyomi",1,0)||findtext(usr.MMove2,"Tsukiyomi",1,0)||findtext(usr.MMove3,"Tsukiyomi",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Tsukiyomi
			if(findtext(usr.MMove1,"Susanoo",1,0)||findtext(usr.MMove2,"Susanoo",1,0)||findtext(usr.MMove3,"Susanoo",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Susanoo
			if(findtext(usr.MMove1,"Phase",1,0)||findtext(usr.MMove2,"Phase",1,0)||findtext(usr.MMove3,"Phase",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Phase
			if(findtext(usr.MMove1,"Kamui",1,0)||findtext(usr.MMove2,"Kamui",1,0)||findtext(usr.MMove3,"Kamui",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Kamui
			if(findtext(usr.MMove1,"WAmaterasuP",1,0)||findtext(usr.MMove2,"WAmaterasuP",1,0)||findtext(usr.MMove3,"WAmaterasuP",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/WhiteAmateratsuProjectile
			if(findtext(usr.MMove1,"WAmaterasu",1,0)||findtext(usr.MMove2,"WAmaterasu",1,0)||findtext(usr.MMove3,"WAmaterasu",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/WhiteAmaterasu360
			src.UpdateInv()
			while(src.shari&&src.mangekyou&&src.chakra>0)
				sleep(120)
				if(prob(20))
					src.stamina-=(src.maxstamina/100)
				src.chakra-=rand(75,90)
				if(prob(10))
					if(src.invisibility<=1)
						src.Bloody()
					src.health-=70
			if(!src.shari&&src.mangekyou)
				src.MangekyouPrep()
				return
			else if(src.chakra<=10&&src.mangekyou)
				src<<"You're unable to sustain the Mangekyo with your current chakra levels so it deactivates.."
				src.MangekyouPrep()
				return
		src.UpdateInv()

	Amateratsu()
		src.MUses+=6;
		src.chakra-=1500;
		src.stamina-=rand(200,350);
		src.health-=rand(150,250)
		if(src.MUses<=0)
			src.health-=150
	//	src.Handseals(50-src.HandsealSpeed)
	//	if(src.HandsSlipped) return
		src.SaveK()
		src.UsingAmaterasu=1;var/obj/Jutsu/Uchiha/AMA/K=new();K.loc=src.loc;K.dir=src.dir;K.name="[src]";K.Owner=src
		while(src.UsingAmaterasu)
			src.chakra-=80;
			src.health-=45;
			src.stamina-=35;
			sleep(pick(60,70))
		src.client.perspective=MOB_PERSPECTIVE;src.client.eye=src;del(K)
	AmaterasuExplosion()
		src<<"You begin to concentrate on a location very hard and begin to form a manifestation of Enton!"
		src<<"Double Click on an area to spawn an Enton particle that will release into Amaterasu in time!"
		src.MUses+=5;src.chakra-=850;src.stamina-=rand(100,250);src.health-=rand(50,150)
	//	src.HandSeals(50-src.HandsealSpeed)
		src.UsingAmaterasuExplosion=1
		src.SaveK()
		while(src.UsingAmaterasuExplosion)
			src.chakra-=25;src.health-=25;src.stamina-=25;sleep(10)
	AmaterasuFire()
		var/obj/Jutsu/Uchiha/AmatFireStuff/A=new();A.loc=src.loc;A.pixel_x+=rand(1,8);A.pixel_y+=rand(1,8);A.icon='Icons/Jutsus/KatonTechniques.dmi';A.icon_state="AmatFire";A.Owner=src
		if(src.icon_state=="WhiteAmaProjectile")
			A.icon_state="WhiteAmatFire"
	ProjectileAmaterasu()
	//	if(!src.InSusano)
		src.chakra-=500;src.stamina-=rand(150,300);src.MUses+=3
		src.SaveK()
	//	src.Handseals(50-src.HandsealSpeed)
	//	if(src.HandsSlipped) return
		var/obj/Jutsu/Uchiha/AMAProjectile/K=new();K.loc=src.loc;K.dir=src.dir;K.name="[src]";K.Owner=src;walk(K,src.dir)
	WhiteProjectileAmaterasu()
		src.chakra-=450;src.stamina-=rand(150,300);src.MUses+=5
		src.SaveK()
	//	src.Handseals(31-src.HandsealSpeed)
	//	if(src.HandsSlipped) return
		var/obj/Jutsu/Uchiha/WhiteAMAProjectile/K=new();K.loc=src.loc;K.nin=src.nin;K.dir=src.dir;K.name="[src]";K.Owner=src;walk(K,src.dir)
	WhiteFireShot()
		set name = "White Amaterasu: 360 Degrees"
		src.chakra-=1000;src.stamina-=rand(250,400);src.MUses+=10
		src.SaveK()
		var/num=8
		var/loldir=src.dir
		while(num>0)
			var/obj/Jutsu/Uchiha/WhiteAMAProjectile/K=new();K.icon_state="WhiteAmatSmall";K.loc=src.loc;K.nin=src.nin/10;K.dir=loldir;K.name="[src]";K.Owner=src;walk(K,K.dir)
			loldir=turn(loldir,45)
			num--
	Tsukiyomi()
		src.Target()
		if(src.ntarget)
			return
		var/mob/M   //Specified Target     I defined these variables so that the mob or turf is not lost in runtime
											//By movement or other things
		var/Distance=round(src.SharinganMastery/100)
		if(Distance<1) Distance=1
		if(Distance>10) Distance=10
		var/turf/DM = get_steps(src,src.dir,Distance)  //Distance Marker
		var/a=0
		while(a<Distance&&!M)
			a++
			DM = get_steps(src,src.dir,a)
			for(var/mob/P in DM)
				if(P!=src&&P.dir==(get_dir(P,src))&&src.dir==(get_dir(src,P))&&P.FrozenBind==""&&!P.knockedout)
					M=P   //Catch the first mob in the line. If he makes eyecontact then he's caught
					//If not, then the jutsu ends because anyone behind him wouldn't make eyecontact period.
					break
		if(!M)
			src<<"You couldn't make eye contact with anyone.";return
		src.MUses+=5
		src.SaveK()
		src.Handseals(10-src.HandsealSpeed)
		if(src.HandsSlipped) return
		if(M.FrozenBind!="")
			src<<"They're already binded right now.";return
		if(M.knockedout)
			src<<"Not now.";return
		if(M in oview(4,src))
			src.Struggle=0;M.Struggle=0
			src<<"Quickly, press the space bar repeatedly to do damage to [M]'s willpower!"
			M<<"You're suddenly caught in a Genjutsu! Press the space bar repeatedly to escape!";M.FrozenBind="Tsukiyomi"
			spawn(1)
				var/i=rand(40,60)
				while(i>0)
					sleep(1);M<<output("[src] slashes you!","Attack");M<<sound('SFX/Slice.wav',0);i--
			M.sight |= (SEE_SELF|BLIND);var/obj/A=new();A.icon='Icons/Jutsus/sharinganthing.dmi';A.icon_state="[usr.mangekyouC]";A.screen_loc="10,10";A.layer=MOB_LAYER+1;M.client.screen+=A
			spawn(60)
				if(M.Struggle<src.Struggle+5)
					M.deathcount+=((src.Struggle/10)-(M.Struggle/10))
				else
					src<<"[M] over came the Tsukiyomi!"
					M<<"You over came the Tsukiyomi!"
				M.FrozenBind="";M.sight &= ~(SEE_SELF|BLIND)
				for(var/obj/C in M.client.screen)
					if(C.icon=='Icons/Jutsus/sharinganthing.dmi')
						del(C)
	Phase()
		if(src.Phasing)
			src<<"You begin to come back and phase back into reality."
			src.Phasing=0
			src.density=1
			return
		src.Phasing=1;src<<"You begin to phase out of reality, nothing can harm you but you're unable to attack."

		while(src.Phasing)
			src.MUses+=0.05;src.density=0;src.chakra-=100;sleep(20)
		src.density=1
	Kamui()
		if(src.knockedout||src.Dead||!src.mangekyou)
			src.firing=0
			return
		src.MUses+=20;
		src.health-=rand(150,250);src<<"Your eyes feel strained."
		src.Kamui=1
		src.SaveK()
		src<<"You ready your Kamui technique. Click on a target to warp it away. Be precise to do the most damage possible."
		while(src.Kamui)
			src.chakra-=(src.Mchakra/100)
			src.stamina-=(src.maxstamina/25)
			sleep(7)
	WarpHole(atom/movable/M,iconX,iconY)
		var/obj/WarpEffect/W=new()
		W.pixel_x+=iconX;W.pixel_y+=iconY;W.loc=M.loc
		if(ismob(M))
			if(!M.density)
				src<<"For some reason, they're not affected!?";src.Kamui=0;return
			else if(iconX>=14&&iconX<=18&&iconY>=23&&iconY<=26)
				src.Kamui=0
				spawn()
					Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z)
				spawn()
					Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z)
				src<<"You use your Mangekyo to create a worm hole at [M]'s head, killing them instantly!"
				M:Stun=10
				M<<"[src] blows your head through a worm hole with their Mangekyo!"
				M:health=0;M:stamina=0;M:Death(src)
				spawn(2)
					M:DeathStruggle(src,1)
			else if(iconX>=13&&iconX<=19&&iconY>=10&&iconY<=17)
				src.Kamui=0
				spawn()
					Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z)
				src<<"You use your Mangekyo to create a worm hole in [M]'s torso, dealing massive damage!"
				M:Stun=10
				M<<"[src] blows a hole through your torso with their Mangekyo!"
				M.DamageProc(500,"Health",src)
				M:CBleeding=1
			else
				src.Kamui=0
				spawn()
					Blood(M.x,M.y,M.z)
				src<<"You use your Mangekyo to create a worm hole on [M], but you only knick them with it!"
				M:Stun=5
				M<<"[src] creates a worm hole near you with their Mangekyo!"
				M:DamageProc(100,"Health",src)
		else if(isobj(M))
			if(istype(M,/obj/Jutsu/Uchiha/Susanoo))
				var/obj/Jutsu/Uchiha/Susanoo/A=M
				var/mob/P = A.Owner
				if(!A.Owner||!P)
					return
				P<<"Your Susano has been warped away?!"
				P.SusanooIn=0
				src.Kamui=0
				src<<"You successfully warped away [P]'s Susano'o!"
				del(M)
			if(istype(M,/obj/VillageScrollPost))
				src<<"Nah."
				src.Kamui=0
				src.DamageProc(2000,"Health")
				return
			if(istype(M,/obj/Hidden_Ninja_Scroll))
				src<<"Nah."
				src.Kamui=0
				src.DamageProc(2000,"Health")
				return
			src.Kamui=0
			viewers(src)<<"[src] uses their Mangekyo to create a worm hole on the [M], warping it away!"
			del(M)

///////New susanooo proc ////////
	Susanoo(/*Uses*/CharacterType,WhatStage,ActivationCost,Mastery,CurrentChakra)// example passthrough args Susanoo(M.mangekyouC,"Bones",1000,M.SusanooMastery, M.chakra)
		if(Mastery<=50&&(findtext(WhatStage,"Perfect"))) // if mastery is less than 50, stage will be skeleton
			WhatStage="Skeleton"
		if(CurrentChakra<=Mchakra*0.5&&(findtext(WhatStage,"Perfect"))) //if chakra is less than 50% stage will be skeleton
			WhatStage="Skeleton"
		if(CharacterType=="shisui") // shisui doesn't have skeleton or perfect yet
			src << " Shisui doesn't have full susanoo right now..."
			return
		var/Z = (CharacterType+WhatStage)
		var/X = ActivationCost
		var/Y = Mastery

		var/drain = 1// this is based on what stage the user is in bones will have a 1:1 ration of drain, skeleton has a 1.5:1 ratio of drain, and perfect has a 2:1 ratio drain
		var/boost =1 // multiplies susanoo health, higher the stage the bigger the multipler
		//if(src.MUses<=0)
		//	src.health-=100
		if(findtext(Z,"Bones"))
			src.MUses+=0.5;
			drain =1
			src.SusanooBones=1
			boost = 0.8
		if(findtext(Z,"Skeleton"))
			src.MUses+=5;
			drain = 1.5
			src.SusanooSkeleton=1
			boost = 1.6
			X=X*(1.3)
		if(findtext(Z,"Perfect"))
			src.MUses+=20;
			drain = 2
			src.SusanooPerfect=1
			boost = 2
			X=(X*1.5)
		src.chakra-=((X)-(Y*2)) // this is the drain its based on X the activation cost given and Y the users susanoo mastery (try not to give a drain less than 200 on the passthrough proc it will be buggy)
		src.stamina-=(X/2)-(Y)
		src.Handseals(1-src.HandsealSpeed)
		src.SaveK()
		//if(src.HandsSlipped) return // do not enable this, it prevents bones from displaying because hold x uses the jutsu but doesn't visually show it
		var/obj/Jutsu/Uchiha/Susanoo/K=new();K.name="[src]";K.Owner=src;src.SusanooIn=1;K.loc=src.loc;walk_towards(K,src)
		src.SusanooHealth =src.NinjutsuKnowledge + ((50*boost)*Y)
		K.Type=Z
		while(src.SusanooIn)
			if(src.SusanooMastery>=100)
				src.SusanooMastery=100;
			src.chakra-=(pick(130,150,180)*drain)-Y;
			src.stamina-=(pick(100,120,180,150)*drain)-Y;
			src.Running=0
		/*	if(src.MUses<=0)
				if(prob(30))
					if(src.SusanooMastery<=75)
						src.health-=80*/
		/*	if(prob(15))
				src.Bloody();
				src.health-=(250-Y);
				src.MUses+=2*/
			sleep(50)
			src.SusanooMastery+=rand(0.1,0.3)



	EMS()
		if(src.firing)
			return
		if(src.mangekyou)
			src.mangekyou=0;src.MUses=-5000;src.ChangeEyeStyle(src.EyeStyle,src.reye,src.geye,src.beye);src.IlluminateOff()
			for(var/obj/SkillCards/MindGenjutsu/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/Invisibility/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/FalseBunshin/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/Kamui/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/TimeCollaboration/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/Phase/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/Amateratsu/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/AmateratsuProjectile/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/WhiteAmateratsuProjectile/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/Susanoo/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/Tsukiyomi/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/Kamui/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/WhiteAmaterasu360/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/AmateratsuExplosion/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/FieldOfBlackFlames/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/SusanooAmatDefence/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/SusanooAmatDefence2/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/SusanooAmatDefence3/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/UchihaAura/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/UchihaAuraOff/A in src.LearnedJutsus)
				del(A)
			src<<"You release your Mangekyou Sharingan.";
			src.RemoveUchihaAura()
			src.UpdateInv()
			src.ChakraSight(0);
			src.Phasing=0;
			src.mangekyou=0
			if(src.SusanooIn)
				src.SusanooHealth = 0
				src.SusanooDeleteCheck()

		else
			if(!src.shari)
				src<<"Activate your regular sharingan first.";return
			src.mangekyou=1;src.ChakraSight(1);src.ChangeEyeStyle(src.EyeStyle,200,0,0)
			view(9,src)<<"[src]'s pupils spin and transform into an Eternal Mangekyou Sharingan!";usr.Illuminate()
			for(var/obj/MMshar/MM in src.client.screen)
				del(MM)
			var/obj/I=new();var/obj/I2=new()
			I.icon='Icons/Jutsus/sharinganthing.dmi';I2.icon=I.icon
			I.icon_state="";I2.icon_state=I.icon_state
			I.pixel_y=16;I2.pixel_y=16
			I.pixel_x=-20;I2.pixel_x=20
			src.overlays+=I;src.overlays+=I2
			spawn(20)
				src.overlays-=I;src.overlays-=I2
				del(I)
			src.CreateUchihaAura()
			spawn(30)
				src.RemoveUchihaAura()
			src.LearnedJutsus+=new/obj/SkillCards/Phase
			src.LearnedJutsus+=new/obj/SkillCards/TimeCollaboration
			src.LearnedJutsus+=new/obj/SkillCards/Tsukiyomi
			src.LearnedJutsus+=new/obj/SkillCards/Amateratsu
			src.LearnedJutsus+=new/obj/SkillCards/AmateratsuProjectile
			src.LearnedJutsus+=new/obj/SkillCards/AmateratsuExplosion
			src.LearnedJutsus+=new/obj/SkillCards/FieldOfBlackFlames
			src.LearnedJutsus+=new/obj/SkillCards/WhiteAmateratsuProjectile
			src.LearnedJutsus+=new/obj/SkillCards/WhiteAmaterasu360
			src.LearnedJutsus+=new/obj/SkillCards/Kamui
			src.LearnedJutsus+=new/obj/SkillCards/Susanoo
			src.LearnedJutsus+=new/obj/SkillCards/SusanooAmatDefence
			src.LearnedJutsus+=new/obj/SkillCards/SusanooAmatDefence2
			src.LearnedJutsus+=new/obj/SkillCards/SusanooAmatDefence3
			src.LearnedJutsus+=new/obj/SkillCards/MindGenjutsu
			src.LearnedJutsus+=new/obj/SkillCards/Invisibility
			src.LearnedJutsus+=new/obj/SkillCards/FalseBunshin
			src.LearnedJutsus+=new/obj/SkillCards/UchihaAura
			src.LearnedJutsus+=new/obj/SkillCards/UchihaAuraOff
			src.UpdateInv()
			while(src.mangekyou)
				sleep(100);src.chakra-=(rand(50,75))
			if(src.chakra<=10&&src.mangekyou)
				src<<"You're unable to sustain your Eternal Mangekyo with your current chakra levels so it deactivates.."
				src.EMS()
				return
mob/proc/SusanooDeleteCheck() // right before calling this proc, make sure to set susanoo health to 0, this proceeds when health is 0
	if(src.SusanooHealth <=0)
		if(src.SusanooBones) // this makes sure you dont set susanoo skillcard on cd just becuase bones ended (bones is bound to the X key)
			src << "You stop using Susanoo Bones"
			src.SusanooIn=0
			src.SusanooBones=0
			src.SusanooSkeleton=0
			src.SusanooPerfect=0
			for(var/obj/Jutsu/Uchiha/Susanoo/ABC in world)
				if(ABC.Owner==src)
					del(ABC)
			return

		src << " Your Susanoo fades away"
		src.SusanooIn=0
		src.SusanooBones=0
		src.SusanooSkeleton=0
		src.SusanooPerfect=0
		for(var/obj/SkillCards/Susanoo/P in src.LearnedJutsus)
			P.DelayIt(1200,src,"Nin")
		for(var/obj/Jutsu/Uchiha/Susanoo/ABC in world)
			if(ABC.Owner==src)
				del(ABC)