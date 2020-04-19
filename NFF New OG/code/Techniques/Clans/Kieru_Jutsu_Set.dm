mob/var
	JintonIntensity=0
	JintonControl=0
	tmp/HakuriCube=0
	tmp/HakuriCubeTime=0
	tmp/GenkaiHakuri=0
obj/Jutsu/Kieru
	FloatingSpeck
		icon='Icons/Jutsus/Floating Speck.dmi'
		icon_state = "Floating Speck"
		density=1
		New()
			..()
			spawn(45)
				del(src)
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M=A;
				var/mob/O=src.Owner
				if(M.Kaiten||M.sphere)
					return
				var/damage=rand(M.maxhealth*0.03,M.maxhealth*0.04)
				M.DamageProc(damage,"Health",O)
				view(M)<<output("[M] was hit by the floating speck!([damage])","Attack")
				del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
				del(src)
obj/Jutsu/Kieru
	HakuriProjectile
		icon='Icons/Jutsus/HakuriProjectile.dmi'
		icon_state="Projectile2"
		density=1
		New()
			..()
			spawn(35)
				del(src)
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M=A
				var/mob/O=src.Owner
				if(M.client)
					M.FrozenBind="Hakuri"
//				if(M.Kaiten||M.sphere)
//					return
				var/obj/Jutsu/Kieru/HakuriCube/B=new();
				B.Owner=O
				B.loc=M.loc
				del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
				del(src)
obj/Jutsu/Kieru
	HakuriCube
		icon='Icons/Jutsus/JintonHakuri.dmi'
		icon_state="Jinton Hakuri no Jutsu 1,1"
		layer=MOB_LAYER+1
	//	pixel_y=8
		New()
			..()
			src.overlays+=/obj/Jutsu/Kieru/HakuriCube/Part1
			src.overlays+=/obj/Jutsu/Kieru/HakuriCube/Part2
			src.overlays+=/obj/Jutsu/Kieru/HakuriCube/Part3
			src.overlays+=/obj/Jutsu/Kieru/HakuriCube/Part4
			src.overlays+=/obj/Jutsu/Kieru/HakuriCube/Part5
			src.overlays+=/obj/Jutsu/Kieru/HakuriCube/Part6
			src.overlays+=/obj/Jutsu/Kieru/HakuriCube/Part7
			src.overlays+=/obj/Jutsu/Kieru/HakuriCube/Part8
			spawn(10)
				var/mob/B=src.Owner
				var/obj/Jutsu/Kieru/HakuriExplosion/C=new();
				C.Owner=B
				C.nin=B.nin
				C.loc=src.loc
				del(src)

			spawn(45)
				del(src)
		Part1
			icon_state="Jinton Hakuri no Jutsu 2,0"
			pixel_x=32//32
			pixel_y=-32//-64
		Part2
			icon_state="Jinton Hakuri no Jutsu 2,1"
			pixel_x=32//32
//			pixel_y=-8//-32
		Part3
			icon_state="Jinton Hakuri no Jutsu 2,2"
			pixel_x=32
			pixel_y=32
		Part4
			icon_state="Jinton Hakuri no Jutsu 1,2"
			pixel_y=32
		Part5
			icon_state="Jinton Hakuri no Jutsu 1,0"
			pixel_y=-32
		Part6
			icon_state="Jinton Hakuri no Jutsu 0,1"
			pixel_x=-32
	//		pixel_y=-8
		Part7
			icon_state="Jinton Hakuri no Jutsu 0,0"
			pixel_x=-32
			pixel_y=-32
		Part8
			icon_state="Jinton Hakuri no Jutsu 0,2"
			pixel_x=-32
			pixel_y=32
	HakuriExplosion
		icon='Icons/Jutsus/Explosion(1).dmi'
		icon_state="particle"
		JutsuLevel=150
		layer=MOB_LAYER
		var/nin=10
		dir=NORTH
		New()
			..()
	//		overlays+=/obj/Jutsu/Explosion/A;overlays+=/obj/Jutsu/Explosion/B;overlays+=/obj/Jutsu/Explosion/C;overlays+=/obj/Jutsu/Explosion/D
	//		overlays+=/obj/Jutsu/Explosion/E;overlays+=/obj/Jutsu/Explosion/F;overlays+=/obj/Jutsu/Explosion/G;overlays+=/obj/Jutsu/Explosion/H
			spawn()
				sleep(1)
			//	spawn(1)
				//	spawn() src.CreateSmoke()
				//	spawn() src.SoundEngine('SFX/Bang.wav',10.60)
				//	for(var/obj/NinjaEquipment/TheWires/W in oview(1,src))
				//		spawn() W.BurnWire()
				for(var/mob/M in oview(1,src))
					spawn()
						if(M==src.Owner)
							return
			//			if(M.SensoryRange>=5&&M.ByakuganMastery>1000&&!M.aflagged&&!M.Frozen&&M.FrozenBind==""&&prob(40))
			//				step_away(M,src)
						if(M&&!M.UsingDomu)//&&!M.Kaiten&&!M.sphere&&!M.SusanooIn)
							var/mob/O=src.Owner
							var/damage=(O.nin*rand(1,1.5))*O.JintonIntensity/2
							var/damage2=(O.nin*rand(2,4))*O.JintonIntensity
						//	var/damage=M.maxstamina*(0.009*(O.ExplosiveMastery/20))
						//	var/damage2=M.maxhealth*(0.007*(O.ExplosiveMastery/20))
					//		if(M.Guarding)
					//			damage/=10
					//			damage2/=2
					//		if(M.Mogu)
					//			damage=damage/2
					//			damage2=damage2/2
							if(M.PaperStyleDance)
								M.PaperStyleDance=0
							view(M)<<output("<font color=red>[M] has been hit by the explosion for [damage]!</font>","Attack")
						//	var/Chakraz=M.ChakraArmor*0.01
							if(M)
								spawn()
									M.DamageProc(damage2,"Stamina",src.Owner,"explosion","red","atomic")
								spawn()
									M.DamageProc(damage,"Health",src.Owner,"explosion","red","atomic")
								if(M.FrozenBind=="Hakuri")
									M.FrozenBind=""
								//	M.HitBack(rand(5,8),rand(1,8))
				for(var/obj/O in oview(1,src))
					O.DamageProc(150)
			spawn(5)
				del(src)
obj/Jutsu/Kieru/GenkaiStartLeft
	icon='Icons/Jutsus/Jinton Genkai Hakuri no Jutsu.dmi'
	icon_state="First Left"
	density=1
	New()
		..()
		spawn(71)
			del(src)
obj/Jutsu/Kieru/GenkaiBlastLeft
	icon='Icons/Jutsus/Jinton Genkai Hakuri no Jutsu.dmi'
	icon_state="Blast Left"
	density=1
	var/nin=10
	New()
		..()
		spawn(71)
			del(src)
	Move()
		var/turf/old_loc=src.loc
		..()
		var/obj/Jutsu/Kieru/GenkaiBlastLeft/L=new();
		L.loc=old_loc;
		L.dir=src.dir;
		L.Owner=src.Owner
	Bump(A)
		if(istype(A,/turf/))
			var/turf/T = A
			if(T.density)
				del(src)
obj/Jutsu/Kieru/GenkaiBlastMiddle
	icon='Icons/Jutsus/Jinton Genkai Hakuri no Jutsu.dmi'
	icon_state="Blast Middle"
	density=0
	layer=MOB_LAYER+1
	var/nin=10
	New()
		..()
		spawn()
			while(src)
				for(var/mob/C in src.loc)
					var/mob/O=src.Owner
					var/damage=round(src.nin*5.5);
					damage=round(damage*(O.JintonIntensity*0.10+0.8));
					var/Chakraz=C.ChakraArmor*0.01
					C.DamageProc((damage-(Chakraz*damage)),"Stamina",O,"atomic force","grey","atomic")
					C.DamageProc((damage-(Chakraz*damage)/3),"health",O,"atomic force","red","atomic")
				sleep(4)
		spawn(71)
			del(src)
	Bump(A)
		..()
		if(ismob(A))
			var/mob/M = A
			var/mob/O=src.Owner
			var/damage=round(src.nin*5.5);
			damage=round(damage*(O.JintonIntensity*0.10+0.8));
			var/Chakraz=M.ChakraArmor*0.01
			M.DamageProc((damage-(Chakraz*damage)),"Stamina",O,"atomic force","grey")
			M.DamageProc((damage-(Chakraz*damage)/3),"health",O,"atomic force","red")
			src.loc=M.loc
		if(istype(A,/turf/))
			var/turf/T = A
			if(T.density)
				del(src)
	Move()
		var/turf/old_loc=src.loc
		..()
		var/obj/Jutsu/Kieru/GenkaiBlastMiddle/L=new();
		L.Owner=src.Owner
		L.nin=src.nin
		L.loc=old_loc;
		L.dir=src.dir;
	//	L.Owner=src.Owner
obj/Jutsu/Kieru/GenkaiBlastRight
	icon='Icons/Jutsus/Jinton Genkai Hakuri no Jutsu.dmi'
	icon_state="Blast Right"
	density=1
	var/nin=10
	New()
		..()
		spawn(71)
			del(src)
	Move()
		var/turf/old_loc=src.loc
		..()
		var/obj/Jutsu/Kieru/GenkaiBlastRight/L=new();
		L.loc=old_loc;
		L.dir=src.dir;
		L.Owner=src.Owner
	Bump(A)
		if(istype(A,/turf/))
			var/turf/T = A
			if(T.density)
				del(src)
obj/Jutsu/Kieru/GenkaiStartMiddle
	icon='Icons/Jutsus/Jinton Genkai Hakuri no Jutsu.dmi'
	icon_state="First Middle"
	density=1

	New()
		..()
		spawn(71)
			del(src)
obj/Jutsu/Kieru/GenkaiStartRight
	icon='Icons/Jutsus/Jinton Genkai Hakuri no Jutsu.dmi'
	icon_state="First Right"
	density=1
	var/nin=10
	New()
		..()
		spawn(71)
			del(src)
mob/proc/FloatingSpeck()
	if(src.ingat|src.intank|src.Kaiten|src.firing)
		return
	else
		if(src.target)
			src.dir=get_dir(src,src.target)
	//	if(src.JintonControl>1)
		src.ChakraDrain(15000/(src.JintonControl+1))
		flick("Attack1",src);
		var/obj/Jutsu/Kieru/FloatingSpeck/K=new();
		K.loc=src.loc;
		K.Move_Delay=0;
		K.name="[src]";
		K.Owner=src;
		K.dir=src.dir;
		walk(K,K.dir);
		sleep(1);
		A--
mob/proc/JintonHakuri()
	if(src.ingat|src.intank|src.Kaiten|src.firing)
		return
	src.ChakraDrain(45000/(src.JintonControl+1))
	src<<"You begin to form Hakuri in your hands..."
	spawn(15)
		src<<"You have used the particles to create Hakuri in your hands. Use the right hand to launch. It'll last [((src.JintonControl*0.40)+1)] seconds!"
		src.HakuriCube=1
		spawn((((src.JintonControl*0.40)*10)+10))
			if(src.HakuriCube)
				src.HakuriCube=0
				src<<"The Hakuri dissipitates.."
mob/proc/JintonGenkaiHakuri()
	if(src.ingat|src.intank|src.Kaiten|src.firing)
		return
	src.ChakraDrain(85000/(src.JintonControl+1))
	src<<"You begin to form Jinton Genkai Hakuri in your hands..."
	spawn(55)
		src<<"You have used the particles to charge up Jinton Genkai Hakuri. Use the Right Hand to launch. It'll last [((src.JintonControl*0.50)+3)] seconds!"
		src.GenkaiHakuri=1
		spawn((((src.JintonControl*0.50)*10)+3))
			if(src.GenkaiHakuri==1)
				src.GenkaiHakuri=0
				src<<"The Hakuri dissipitates.."
mob/proc/JintonGenkaiHakuriShoot()
	if(src.ingat|src.intank|src.Kaiten|src.firing)
		return
	if(src.dir==NORTHEAST||src.dir==SOUTHEAST)
		src.dir=EAST
	if(src.dir==NORTHWEST||src.dir==SOUTHWEST)
		src.dir=WEST
	src.GenkaiHakuri=0
	src.icon_state="handseal"
	src.FrozenBind="Doing GenkaiHakuri"
	spawn(11)
		src.FrozenBind=""
		src.icon_state=""
	if(src.dir==NORTH)
		var/obj/Jutsu/Kieru/GenkaiStartLeft/A=new();
		var/obj/Jutsu/Kieru/GenkaiStartMiddle/B=new();
		var/obj/Jutsu/Kieru/GenkaiStartRight/C=new();
		A.dir=src.dir
		B.dir=src.dir
		C.dir=src.dir
		A.loc=locate(src.x-1,src.y+1,src.z)
		B.loc=locate(src.x,src.y+1,src.z)
		C.loc=locate(src.x+1,src.y+1,src.z)
		var/obj/Jutsu/Kieru/GenkaiBlastMiddle/AA=new();
		var/obj/Jutsu/Kieru/GenkaiBlastMiddle/BB=new()
		var/obj/Jutsu/Kieru/GenkaiBlastMiddle/CC=new();
		AA.Owner=src
		AA.nin=src.nin
		BB.Owner=src
		BB.nin=src.nin
		CC.Owner=src
		CC.nin=src.nin
		AA.loc=locate(src.x-1,src.y+2,src.z)
		AA.dir=src.dir
		walk(AA,AA.dir)
		BB.loc=locate(src.x,src.y+2,src.z)
		BB.dir=src.dir
		walk(BB,BB.dir)
		CC.loc=locate(src.x+1,src.y+2,src.z)
		CC.dir=src.dir
		walk(CC,CC.dir)
	if(src.dir==SOUTH)
		var/obj/Jutsu/Kieru/GenkaiStartLeft/A=new();
		var/obj/Jutsu/Kieru/GenkaiStartMiddle/B=new();
		var/obj/Jutsu/Kieru/GenkaiStartRight/C=new();
		A.dir=src.dir
		B.dir=src.dir
		C.dir=src.dir
		A.loc=locate(src.x+1,src.y-1,src.z)
		B.loc=locate(src.x,src.y-1,src.z)
		C.loc=locate(src.x-1,src.y-1,src.z)
		var/obj/Jutsu/Kieru/GenkaiBlastMiddle/AA=new();
		var/obj/Jutsu/Kieru/GenkaiBlastMiddle/BB=new()
		var/obj/Jutsu/Kieru/GenkaiBlastMiddle/CC=new();
		AA.Owner=src
		AA.nin=src.nin
		BB.Owner=src
		BB.nin=src.nin
		CC.Owner=src
		CC.nin=src.nin
		AA.loc=locate(src.x+1,src.y-2,src.z)
		AA.dir=src.dir
		walk(AA,AA.dir)
		BB.loc=locate(src.x,src.y-2,src.z)
		BB.dir=src.dir
		walk(BB,BB.dir)
		CC.loc=locate(src.x-1,src.y-2,src.z)
		CC.dir=src.dir
		walk(CC,CC.dir)
	if(src.dir==EAST)
		var/obj/Jutsu/Kieru/GenkaiStartLeft/A=new();
		var/obj/Jutsu/Kieru/GenkaiStartMiddle/B=new();
		var/obj/Jutsu/Kieru/GenkaiStartRight/C=new();
		A.dir=src.dir
		B.dir=src.dir
		C.dir=src.dir
		A.loc=locate(src.x+1,src.y+1,src.z)
		B.loc=locate(src.x+1,src.y,src.z)
		C.loc=locate(src.x+1,src.y-1,src.z)
		var/obj/Jutsu/Kieru/GenkaiBlastMiddle/AA=new();
		var/obj/Jutsu/Kieru/GenkaiBlastMiddle/BB=new()
		var/obj/Jutsu/Kieru/GenkaiBlastMiddle/CC=new();
		AA.Owner=src
		AA.nin=src.nin
		BB.Owner=src
		BB.nin=src.nin
		CC.Owner=src
		CC.nin=src.nin
		AA.loc=locate(src.x+2,src.y+1,src.z)
		AA.dir=src.dir
		walk(AA,AA.dir)
		BB.loc=locate(src.x+2,src.y,src.z)
		BB.dir=src.dir
		walk(BB,BB.dir)
		CC.loc=locate(src.x+2,src.y-1,src.z)
		CC.dir=src.dir
		walk(CC,CC.dir)


	if(src.dir==WEST)
		var/obj/Jutsu/Kieru/GenkaiStartLeft/A=new();
		var/obj/Jutsu/Kieru/GenkaiStartMiddle/B=new();
		var/obj/Jutsu/Kieru/GenkaiStartRight/C=new();
		A.dir=src.dir
		B.dir=src.dir
		C.dir=src.dir
		A.loc=locate(src.x-1,src.y+1,src.z)
		B.loc=locate(src.x-1,src.y,src.z)
		C.loc=locate(src.x-1,src.y-1,src.z)
		var/obj/Jutsu/Kieru/GenkaiBlastMiddle/AA=new();
		var/obj/Jutsu/Kieru/GenkaiBlastMiddle/BB=new()
		var/obj/Jutsu/Kieru/GenkaiBlastMiddle/CC=new();
		AA.Owner=src
		AA.nin=src.nin
		BB.Owner=src
		BB.nin=src.nin
		CC.Owner=src
		CC.nin=src.nin
		AA.loc=locate(src.x-2,src.y+1,src.z)
		AA.dir=src.dir
		walk(AA,AA.dir)
		BB.loc=locate(src.x-2,src.y,src.z)
		BB.dir=src.dir
		walk(BB,BB.dir)
		CC.loc=locate(src.x-2,src.y-1,src.z)
		CC.dir=src.dir
		walk(CC,CC.dir)


/*
Alright.
First off before anyone cries, this will not disintegrate the target, lol.
To be balanced, this will do vitality damage and a smaller amount of stam.
It will work as follows- The Kieru using this tech will form the cube in their hands, they have a set amount of time before the cube disappears to hit the target with the cube.
I suggest that a once the target is hit, they get trapped inside a cube (think getting hit with a rasengan but no pushback and a new icon, or water prison with a new icon) for about .5 secs (a time that wont be a stun pls) and they take the vit and stam damage.
Then the jutsu is over, and they are able to run.
This is not homing.
This jutsu is shot in a straight linear line, and does a good amount of damage.
However it has a high drain and does no damage if missed.
*/


mob/proc/HakuriCubeLaunch()
	src.HakuriCube=0
	var/obj/Jutsu/Kieru/HakuriProjectile/F=new();
	F.loc=src.loc;
	F.Owner=src;
	F.dir=src.dir;
	walk(F,F.dir)
/*
mob/proc/HakuriCubeClose(mob/M)
	if(!M)
		return
	src.HakuriCube=0
	M.FrozenBind="Hakuri Cube"
	var/obj/Jutsu/Kieru/HakuriCube/P=new();
	P.Owner=src
	P.loc=M.loc
	*/