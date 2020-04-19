mob/var/tmp/JashinMode=0
mob/var/tmp/JashinLocation=0
mob/var/tmp/JashinVictim=""
mob/var/tmp/TrueZombie=0
mob/var/tmp/TrueZombieCap=0
mob/var/JashinKnowledge=0

obj
	JashinCircle
		icon='Icons/Jutsus/JashinCircle.dmi'
		layer=TURF_LAYER
		var/Owner
		var/list/People=list()
		New()
			..()
			spawn()
				while(src)
					for(var/mob/M in src.loc)
						if(M==src.Owner)
							if(!(M in People))
								People+=M
								M.JashinMode=1
//								world<<"Jashin Mode: [M.JashinMode]"
					for(var/mob/A in People)
					//	if(M in People)
						if(!(A in src.loc))
							People-=A
							A.JashinMode=0
//							world<<"You exit Jahsin Mode: [A.JashinMode]"

					sleep(5)
			spawn(600)
				del(src)
		Del()
			for(var/mob/P in People)
				P.CancelRitual()
				P.JashinMode=0
			..()

mob/proc/IngestBlood()
	if(src.JashinMode||src.JashinVictim!="")
		src.CancelRitual()
		return
	if(!(locate(/obj/undereffect/) in src.loc))
		src<<"There isn't blood here."
		return
	for(var/obj/undereffect/x in src.loc)
		if(x.icon!='Blood.dmi')
			src<<"This isn't blood that you're standing on."
			return
		else
	//		world<<"You are standing on blood. It's owner is [x.Owner]."
			src<<"You reach down and scoop up [x.Owner]'s blood."
			var/turf/Check=src.loc
			src.FrozenBind="Jashin"
			var/Time=30
			var/Success=0
			while(src.loc==Check&&!src.knockedout&&Time>0)
	//		spawn(30)
				sleep(10)
				if(src.loc!=Check)
					src<<"You weren't able to ingest the blood."
					return
				Time-=10
			if(Time<=0)
				Success=1
			if(Success)
			//	spawn(1200)
			//		src.CancelRitual()
				var/I='Icons/New Base/JashinBase.dmi'
				src.Oicon=src.icon
				src.icon=I
				src.JashinLocation=src.loc
		//		src.JashinMode=1
				src.JashinVictim="[x.Owner]"
				src.FrozenBind=""
				src<<"You are in Jashin Mode, and your victim is [x.Owner]"
				del(x)
				view()<<"[src]'s body turns black and white like a representation of death...."
				if(!(locate(/obj/SkillCards/RelinquishRitual) in src.LearnedJutsus))
					src.LearnedJutsus+=new/obj/SkillCards/RelinquishRitual
				if(!(locate(/obj/SkillCards/CreateCircle) in src.LearnedJutsus))
					src.LearnedJutsus+=new/obj/SkillCards/CreateCircle
				if(!(locate(/obj/SkillCards/Masochism) in src.LearnedJutsus))
					src.LearnedJutsus+=new/obj/SkillCards/Masochism
				src.UpdateInv()
			else
				src.FrozenBind=""
				src<<"You weren't able to successfully acquire the blood."
				return

mob/proc/SadisticPleasure()
	var/Time=30
	if(src.JashinVictim=="")
		src<<"You don't have any victim's blood."
		return
	if(src.health<src.maxhealth*0.15)
		src<<"You're too low on vitals to utilize this technique."
		return
	src.DamageProc(150,src,"Health")
	src.ChakraDrain(15000)
	flick("weaponslash",src)
//	spawn()
	//	src.Bloody()
	//	src.Bloody()
	src<<"You inflict pain on yourself and enjoy the feeling it gives you..."
	src.Bloody();src.Bloody();src.Bloody();src.Bloody()
	while(Time<0)
		sleep(10)
		src.tai=src.Mtai*1.2
		src.nin=src.Mnin*1.2
		src.gen=src.Mgen*1.2
		Time-=1
	src<<"The pleasure you felt fades as you no longer feel the pain you gave yourself..."
	src.tai=src.Mtai
	src.nin=src.Mnin
	src.gen=src.Mgen
mob/proc/TrueZombie()
	if(src.JashinVictim=="")
		src<<"You don't have any victim's blood."
		return
	if(!src.TrueZombie)
		if(src.TrueZombieCap<3)
			src.ChakraDrain(25000)
			src.deathcount+=1
			src<<"When you fall in battle you will be revived with a bit of strength back."
			src.TrueZombieCap+=1
			if(src.TrueZombieCap>=3)
				spawn(3600)
					src.TrueZombieCap=0
			src.TrueZombie=1
		else
			src<<"You've used True Zombie enough for now."
	else
		src.TrueZombie=0
		src<<"You'll fall normally in battle once more."
		return
mob/proc/CancelRitual()
	src.icon=src.Oicon
	src.JashinLocation=null
	src.JashinMode=0
	src.JashinVictim=""
	src<<"You exit your Jashin Ritual."
	for(var/obj/SkillCards/RelinquishRitual/P in src.LearnedJutsus)
		del(P)
	for(var/obj/SkillCards/CreateCircle/A in src.LearnedJutsus)
		del(A)
	for(var/obj/SkillCards/HarmSelf/B in src.LearnedJutsus)
		del(B)
	for(var/obj/SkillCards/Masochism/P in src.LearnedJutsus)
		del(P)
	for(var/obj/SkillCards/TrueZombie/D in src.LearnedJutsus)
		del(D)
	src.UpdateInv()
mob/proc/SelfHarm()
	var/X=src.WeaponInLeftHand
	if(X=="")
		src<<"You need a weapon in your left hand to impale yourself!"
		return
	var/Time=30
	var/Location=src.loc
	var/Success=0
	view()<<"[src] raises their weapon up in the air and points it torwards themself, about to harm themselves."
	while(Location==src.loc&&Time>0&&!src.knockedout)
		if(Time<=0)
			Success=1
		sleep(10)
		Time-=10
		if(Time<=0)
			Success=1


	if(Success)
		view()<<"[src] impales themself! Also harming [src.JashinVictim]!"
		flick("weaponslash",src)
		src.health-=350
		spawn()
			src.Bloody()
			src.Bloody()
			src.Bloody()
		if(src.JashinVictim!="")
			var/mob/B = src.JashinVictim
			B<<"You feel a sharp pain through your body!"
			B.DamageProc(750,src,"Health")
	else
		src<<"You failed to harm yourself."

mob/proc/JashinRitual()
	if(src.loc!=src.JashinLocation)
		src<<"You need to be in the spot that the blood from your victim was located at!"
		return
	src.FrozenBind="Jashin"
	view()<<"[src] begins to create a black circle underneath themself."
	var/turf/Z=src.loc
	spawn(50)
		if(src.loc!=Z||src.knockedout)
			src<<"You were unable to successfully create the circle"
			return
		src<<"The circle for your Jashin Ritual has been created."
		var/obj/JashinCircle/A=new()
		A.loc=src.loc
		A.Owner=src
		src.FrozenBind=""
		if(!(locate(/obj/SkillCards/HarmSelf) in src.LearnedJutsus))
			src.LearnedJutsus+=new/obj/SkillCards/HarmSelf
		if(!(locate(/obj/SkillCards/TrueZombie) in src.LearnedJutsus))
			src.LearnedJutsus+=new/obj/SkillCards/TrueZombie
		if(!(locate(/obj/SkillCards/Masochism) in src.LearnedJutsus))
			src.LearnedJutsus+=new/obj/SkillCards/Masochism
		src.UpdateInv()
