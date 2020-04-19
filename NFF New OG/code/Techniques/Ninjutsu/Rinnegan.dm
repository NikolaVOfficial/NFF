mob/var/tmp/RinneganOn=0
mob/proc
	Rinnegan_Activate()
		if(src.RinneganOn)
			src.RinneganOn=0
			src<<"You deactivate the Rinnegan."
			var/list/Techniques=list("ShinraTensei","BashoTenin","SoulRip","RinneganSummon","AsuraRealm","AsuraRocket","AsuraPunch","NarakaRestoration")//NarakaSoulRip removed from list
			if(src.AsuraRealm)
				src.ToggleAsura()
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
		else
			src.RinneganOn=1
			view(9,src)<<"[src]'s eyes turn into a beautiful purple-silver and begin to ripple outwards.."
			var/obj/I=new()
			I.icon='Rinnegan.dmi'
			I.icon_state="Rinnegan"
			I.pixel_y=16
			src.overlays+=I
			spawn(12)
				src.overlays-=I
				del(I)
			var/list/Techniques=list("ShinraTensei","BashoTenin","SoulRip","RinneganSummon","AsuraRealm","NarakaRestoration")
			while(Techniques.len>0)
				var/Choice=pick(Techniques)
				Techniques.Remove(Choice)
				var/Path=text2path("/obj/SkillCards/[Choice]")
				var/obj/SkillCards/S = new Path
				S.NonKeepable=1
				src.LearnedJutsus+=S
			var/X=0
			for(var/obj/SkillCards/O in src.LearnedJutsus)//Loop through all the items in the players contents
				winset(src, "Jutsu.Jutsus", "current-cell=1,[++X]")	//Add multiple cells horizontally for each obj
				src << output(O, "Jutsu.Jutsus")//Send the obj's in src.contents to the Grid
			winset(src,"Jutsu.Jutsus", "cells=[X]")
			src.nin=src.Mnin*1.4
			src.gen=src.Mgen*1.4
			while(src.RinneganOn)
				src.chakra-=rand(20,40)
				sleep(15)
			src.nin=src.Mnin
			src.gen=src.Mgen
			/*
			//Deva
			var/obj/SkillCards/ShinraTensei/S=new()
			S.NonKeepable=1
			src.LearnedJutsus+=S
			var/obj/SkillCards/BashoTenin/B=new()
			B.NonKeepable=1
			src.LearnedJutsus+=B
			//Human
			var/obj/SkillCards/SoulRip/SR=new()
			SR.NonKeepable=1
			src.LearnedJutsus+=SR
			//Animal
			var/obj/SkillCards/RinneganSummon/RS=new()
			RS.NonKeepable=1
			src.LearnedJutsus+=RS*/
	ShinraTensei()
		src.chakra-=100
		spawn()
			for(var/obj/Jutsu/J in oview(6,src))
				spawn()
					walk(J,get_dir(src,J))
					sleep(40)
					walk(J,0)
		for(var/mob/M in oview(6,src))
			spawn()
				M.Strafe()
				M.HitBack(10,get_dir(src,M))
				M.Normal()
	BashoTenin()
		src.chakra-=(src.chakra*0.01)
		var/turf/T = src.loc
		spawn()
			for(var/obj/Jutsu/J in oview(6,src))
				walk_towards(J,T)
				sleep(40)
				walk(J,0)
		for(var/mob/M in oview(6,src))
			spawn()
				M.Strafe()
				walk_towards(M,T,0)
				sleep(40)
				M.Normal()
				walk(M,0)

	SoulRemove()
		if(src.knockedout)
			return
		else
			src.chakra-=2500
			for(var/mob/M in get_step(src,src.dir))
				if(M.knockedout)
					return
				src<<"You begin to rip out [M]'s soul. You have 15 seconds, rapidly tap the space bar to rip their soul out!"
				src.FrozenBind="Rinnegan"
				M.FrozenBind="Rinnegan"
				src.Struggle=0
				M.Struggle=0
				M<<"Your soul is being ripped out! Quick struggle to keep it inside you! Tap the space bar quickly!"
				var/i=15
				while(i>0&&!src.knockedout&&M in get_step(src,src.dir))
					i--
					sleep(10)
				if(src.knockedout)
					src<<"The jutsu failed because you lost consciousness!"
					src.FrozenBind="";M.FrozenBind=""
					return
				src.FrozenBind=""
				M.FrozenBind=""
				if(M in get_step(src,src.dir))
					if(src.Struggle>M.Struggle)
						src<<"You pull out [M]'s soul!"
						M<<"Your soul is ripped out from you! Your body begins to go limp and dies.."
						M.health=0
						M.knockedout=1
						M.icon_state="dead"
						M.DeathStruggle(src)
						src<<"[M]'s max vitality is [M.maxhealth]"
						src<<"[M]'s max stamina is [M.maxstamina]"
						src<<"[M]'s max chakra is [M.Mchakra]"
						src<<"[M]'s Village is [M.Village]"
						src<<"[M]'s Age is [M.Age]"
						src<<"[M]'s Death Age is [M.DeclineAge]"
						src<<"[M]'s rank is [M.rank]"
						src<<"[M]'s Clan is [M.Clan]"
						src<<"[M] has [M.LearnedJutsus.len] Jutsu."
						var/input=input(src,"Would you like a readout of all their jutsu?") in list("Yes","No")
						if(input=="Yes")
							for(var/obj/SkillCards/A in M.LearnedJutsus)
								src<<"They have <b>[A]</b> with <b>[A.Uses]</b>."
								sleep(1)
						return
					else
						src<<"[M] managed to struggle enough to keep their soul inside them. The technique failed."
						M<<"You pull your soul completely back inside you and break free from [src]'s technique!"
				else
					src<<"It seemed the target moved."
					return

	RinneganSummon(mob/M)
		if(global.contestantTwo == src||global.contestantOne == src)
			src<<"Arena is meant for one on one, not two on one."
			world<<"[src] tried summoning [M] while he was in the arena, and auto loses the match!"
			del(src)
			del(M)
		if(!M)
			return
		if(!M.client)
			return
			var/obj/O=new()
			src.chakra-=500
			O.icon='Icons/Jutsus/NarutoStuff.dmi'
			O.loc=get_step(src,src.dir)
			flick("Smoke",O)
			sleep(3)
			M.loc=O.loc
			sleep(3)
			O.loc=null
		else
			src<<"You attempt to summon [M]."
			src.chakra=0
			src.Mchakra-=50
			src.deathcount+=5
			M<<"[src] is trying to summon you. To accept, click the icon in the lower left hand corner of your screen."
			M<<"If you do not accept within 15 seconds the option expires."
			var/obj/SummonRequest/A=new /obj/SummonRequest
			A.Requester=src;A.Requestee=M
			M.client.screen+=A
	NarakaRestoration()
		if(src.firing||src.knockedout)
			return
		if(src.target)
			src.dir=get_dir(src,src.target)
		flick("throw",src)
		src.chakra-=400
		for(var/mob/M in get_step(src,src.dir))
			M<<"[src] uses the Rinnegan to restore your body."
			src<<"You begin to heal [M]"

			if(M.StruggleAgainstDeath>0)

				M.Struggle+=rand(80,100)

			if(M.health<M.maxhealth)
				M.health+=rand(300,500)
				M.deathcount--
				if(M.deathcount<0)
					M.deathcount=0
				if(M.health>M.maxhealth)
					M.health=M.maxhealth
			if(M.client&&M.Dead&&M.health>=M.maxhealth/2&&!PermDeath&&!M.CBleeding)
				M.Dead=0
				M.icon_state=""
				M.FrozenBind=""
				M.sight&=~(SEE_SELF|BLIND)
				orange(12,M)<<"<font size = 2>[M] was brought back from the brink of death!</font>"
			if(M.stamina<M.maxstamina)
				M.stamina+=rand(600,800)
				if(M.stamina>M.maxstamina)
					M.stamina=M.maxstamina
			M.chakra+=rand(100,200)
			M.ChakraPool+=rand(300,600)
			if(M.screwed)
				if(prob(src.Focus*rand(-5,5)))
					M.screwed=0;M<<"Your nerves were healed.";src<<"You healed their nerves."
			if(M.CBleeding)
				if(prob(usr.Focus*rand(-5,5)))
					M.CBleeding=0;M<<"Your no longer bleeding.";src<<"Your healed their internal bleeding."
	NarakaSoulRemove()
		if(src.knockedout)
			return
		else
			src.chakra-=1000
			for(var/mob/M in get_step(src,src.dir))
				if(M.knockedout)
					return
				src<<"You begin to rip out [M]'s soul. You have 15 seconds, rapidly tap the space bar to rip their soul out!"
				src.FrozenBind="Rinnegan"
				M.FrozenBind="Rinnegan"
				src.Struggle=0
				M.Struggle=0
				M<<"Your soul is being ripped out! Quick struggle to keep it inside you! Tap the space bar quickly!"
				var/i=15
				while(i>0&&!src.knockedout&&M in get_step(src,src.dir))
					i--
					sleep(10)
				if(src.knockedout)
					src<<"The jutsu failed because you lost consciousness!"
					src.FrozenBind="";M.FrozenBind=""
					return
				src.FrozenBind=""
				M.FrozenBind=""
				if(M in get_step(src,src.dir))
					if(src.Struggle+50>M.Struggle)
						src<<"You pull out [M]'s soul!"
						M<<"Your soul is ripped out from you! Your body begins to go limp and dies.."
						M.health=0
						M.knockedout=1
						M.icon_state="dead"
						M.DeathStruggle(src,1)
						return
					else
						src<<"[M] managed to struggle enough to keep their soul inside them. The technique failed."
						M<<"You pull your soul completely back inside you and break free from [src]'s technique!"
				else
					src<<"It seemed the target moved."
					return



	EdoTensei()
		if(!usr.controlled)
			var/list/people=list()
			for(var/mob/P in oview(8))
				if(findtext(P.name,"'s corpse")&&P.FrozenBind=="Dead")
					people += P
			var/who = input("Which corpse would you like to possess?") in people+"Cancel"
			if(who=="Cancel") return
			var/mob/M = who
			M.FrozenBind="";M.knockedout=0;M.Dead=0
			usr.controlled=M
			usr.client.eye=M
			usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
			usr.KBunshinOn=1
			M.RestrictOwnMovement=1
			if(!M.client)
				M.icon_state="running"
			var/X=0
			for(var/obj/SkillCards/O in M.LearnedJutsus)//Loop through all the items in the players contents
				winset(usr, "Jutsu.Jutsus", "current-cell=1,[++X]")	//Add multiple cells horizontally for each obj
				usr << output(O, "Jutsu.Jutsus")//Send the obj's in src.contents to the Grid
				winset(usr,"Jutsu.Jutsus", "cells=[X]")
		else
			var/mob/O=usr.controlled
			if(O)
				O.RestrictOwnMovement=0
			usr.KBunshinOn=0
			usr.controlled=null
			usr.client.eye=usr
			usr.client.perspective=MOB_PERSPECTIVE
			usr.UpdateInv()



	EdoGetStats(mob/M) //proc corpses call to get the original's vars...
		for(var/V in src.vars)
			var/list/BAD = list("locs","cansave","key","ckey","client","type","parent_type","verbs","vars","group","x","y","z","loc","contents","controlled","alterV","alterC","alterR","OriginalVillage","Orank","OClan","ImmuneToDeath","Owner","KBunshinOn")
			if(!BAD.Find(V))
				src.vars[V] = M.vars[V]
obj
	SummonRequest
		icon='Something.dmi'
		screen_loc="1,1"
		var
			Requester
			Requestee
		New()
			..()
			spawn(150)
				del(src)
		Click()
			if(usr==src.Requestee)
				if(usr.knockedout)
					usr<<"noep"
					del(src)
				var/obj/O=new()
				var/mob/M=Requester
				O.icon='Icons/Jutsus/NarutoStuff.dmi'
				O.loc=get_step(M,M.dir)
				flick("Smoke",O)
				sleep(3)
				usr.loc=O.loc
				sleep(3)
				del(src)
				O.loc=null
			else
				usr<<"You aren't supposed to be the one clicking this."
				return
mob/var/tmp/AsuraRealm=0
mob/proc/ToggleAsura()
	if(src.AsuraRealm)
		src.AsuraRealm=0
		src<<"You deactivate the Asura Realm."
		for(var/obj/SkillCards/AsuraPunch/A in src.LearnedJutsus)
			del(A)
		for(var/obj/SkillCards/AsuraRocket/A in src.LearnedJutsus)
			del(A)
		return
	else
		src.AsuraRealm=1
		src<<"You activate the Asura Realm."
		src<<"While in this mode you can use a Rocket Punch dealing weak stamina damage, a straight forward powerful missle Rocket, or click to send a weaker rocket that homes in on that targeted spot."
		src.LearnedJutsus+=new/obj/SkillCards/AsuraPunch
		src.LearnedJutsus+=new/obj/SkillCards/AsuraRocket
		while(src.AsuraRealm)
			src.chakra-=150
			sleep(rand(20,40))
mob/proc/AsuraRealmPunch()
	flick("Attack1",src)
	var/obj/Android/RocketPunch/A=new()
	A.icon+=rgb(src.BaseR,src.BaseG,src.BaseB)
	A.loc=src.loc
	A.Owner=src
	A.dir=src.dir
	walk(A,A.dir)

mob/proc/AsuraMissle(Strong=0,atom/Target)
	src.chakra-=150
	var/obj/Android/Missle/M=new()
	M.Owner=src
	M.loc=src.loc
	if(Strong)
		src.chakra-=200
		M.StrongMissle=1
	if(Target)
		walk_to(M,Target)
	else
		walk(M,src.dir)
obj/Android/Missle
	icon='Rinnegan.dmi'
	icon_state="Missile"
	density=1
	var/StrongMissle=0
	var/Owner
	New()
		spawn(25)
			del(src)
	Bump(A)
		if(ismob(A))
			var/mob/M = A
			if(M.sphere) return
			if(M.Kaiten)
				src.dir=turn(src.dir,pick(90,-90,180))
				return
			del(src)
		if(istype(A,/turf/))
			var/turf/T = A
			if(T.density)
				del(src)
		if(istype(A,/obj/))
			del(src)
	Del()
		if(src.StrongMissle)
			var/obj/Jutsu/StrongExplosion/K=new()
			K.loc=src.loc
			K.Owner=src.Owner
		else
			var/obj/Jutsu/Explosion/K=new()
			K.loc=src.loc
			K.Owner=src.Owner
		..()
obj/Android/RocketPunch
	icon='Rinnegan.dmi'
	icon_state="RocketPunch"
	density=1
	var/Owner
	New()
		spawn(25)
			del(src)
	Bump(A)
		if(ismob(A))
			var/mob/M = A
			var/mob/O=src.Owner
			if(M.sphere) return
			if(M.Kaiten)
				if(prob(25))
					src.dir=turn(src.dir,90)
					return
				if(prob(25))
					src.dir=turn(src.dir,-90)
					return
				else
					src.dir=turn(src.dir,180)
					return
			M.DamageProc(200,"Stamina",O)
			del(src)
		if(istype(A,/turf/))
			var/turf/T = A
			if(T.density)
				del(src)
		if(istype(A,/obj/))
			del(src)
	Del()
		for(var/mob/Q in oview(2,src))
			spawn()
				Q.HitBack(10,get_dir(src,Q))
		sleep(3)
		..()




