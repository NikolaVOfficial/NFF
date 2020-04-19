mob/var/tmp/InDazeParticle=0
mob/var/tmp/ParticleMigraned=0
///////Here's the idea. There will be 3 Kyomou NPCs, who all teach a different set of moves.
///////They teach a kyomou how to use their particles, and life force in different ways.
///////Now, each move is seperated into tiers. How many tiers? Haven't decided. Maybe 7? which makes 21 moves?
///////However, you can only get 1 jutsu from any tier, so in the end you can only have up to 7 jutsu.
///////Each teacher teaches one jutsu of each tier. So there are three groups.
///////The Three groups are as followed: Illusion/Supplement, Offensive, and Life-Force
///////Illusion/Supplement would have genjutsu/genjutsu-like moves, and moves that distort one's chakra.
///////Offensive would be more aggresive moves,
///////Life-Force would be kind of a mix. There'd be healing,
///////		but also some damageing moves that revolve around some sort of life-fore manipulation.

///////Now, the last two tiers would be considered "Super Tiers" if you will,
///////Essentually, you are only allowed to know so many moves, from any of the groups,
///////So when you get to the second last tier, you won't be able to learn from the teacher who taught you the most,
///////And at the last one, you won't be able to pick from the one you just came from.
///////My reasoning for this, is that Kyomous are a clan of secrets, and deny giving out TOO much information.

///////Kyomou, Tokui	Illusion/Supplement
///////Kyomou, Gekido	Offense
///////Kyomou, Eien		Life-Force

///////Tier (Aka Req)	 Tokui - Eien - Gekido								EXP

///////Tier 1 (25)  	: Blind - Burn - Rejuvination			10k
///////Tier 2 (60)  	: Chakra Clones - Migrane - Chakra Damage			15k
///////Tier 3 (100) 	: Doujutsu Counter - Anorexiation - Chakra Restore	20k
///////Tier 4 (150) 	: Daze - Stamina Damage - Reservoir Absorbtion		20k
///////Tier 5 (200) 	: Stun - Vitality Damage - Disruption				25k
///////Tier 6 (500) 	: Sleep - Redirection - Life Absorbtion				35k
///////Tier 7 (1000)	: Constraint - Release - Life-Force Restoration		50k

///////Move Descriptions

//Blind - This move will cause the affected's screen to be covered with red, and unable to target people. DONE
//Burn - Causes the affected to feel the after affects of a burning fire. DONE
//Rejuvination - Uses chakra from the user to heal the wounds of the affected. DONE

//Chakra Clones - Creates any number of clones resembeling those in the area, including one's self. Clones have a chakra Aura. DONE
//Migrane - Causes the affected's screens to wobble out of control as they suffer damage from the trauma of a migrane. DONE
//Chakra Damage - Causes the affected's body to leak chakra. DONE

//Doujutsu Counter - If the affected posseses a doujutsu, it is deactivated. DONE
//Anorexiation - This causes the body of the affected to reject calories, and food. There's a chance of causing
	//an auto immune response. DONE
//Chakra Restore - Causes the affected to produce more chakra. DONE

//Daze - Causes the affected to become dazed and confused, as their eye-sight goes crazy. DONE
//Stamina Damage - Causes the affected's body to cramp, and damage itself. DONE
//Reservoir Absorbtion - The user uses their particles to steal away reserved chakra from the affected. DONE

//---- The rest below are for a later update (Unlearnable)

//Stun - The affected are not only stunned, but also forced to walk. DONE
//Vitality Damage - Tricks the body of the affected into performing an auto-immune response, causing vitality damage. DONE
//Disruption - This causes a f in the chakra of any affected, or jutsus. (undoes charged moves, and deletes jutsu objs.) DONE

//Sleep - Causes the brain of the affected to release sleep inducing hormones. DONE
//Redirection - This allows the user to absorb incoming moves, and transform the damage into one's own stats. (Nin, gen, tai)
//Life Absorbtion - This allows the user to sap the life from any affected, (Stamina, Chakra, Reservoir, and WP) DONE

//Constraint - This causes the chakras of anyone close to another to become linked, and constrained, disallowing them from
	//walking too far from the other, with out difficulty, or consiquense.
//Release - The user uses their particles to unlock their body's potential, which pushes them into overdrive,
	//multiplying all of their stats, and constantly healing their stamina. The cost is the chakra reservoir, and vitality.
//Life-Force Restoration - The user converts their own chakra into life-force, which swells into the affected. DONE


///////Modes of Transport
///////Of course, there is more than 1 way for these affects to reach their target.

//Direct Contact - This is the most potent, and least costly method, as it requires you to be within a single tile from your target. DONE
//Projectile Particles - Projectiles lose their potency in distance, and require a bit more chakra to create.
//Particle Field - Particle Fields aren't as potent as the other forms, and cost extra chakra to spread ones chakra that far.
	//The way fields will work is that when creating one, one must remain stationary, and while they do, the field expands
	//until it reaches a maximum size. The speed at which the expand (like all methods) is determined by "Particle Usage"
	//They only last for a while (duration dependent on Akametsuki mastery) DONE


//TO DO LIST:
	//Edit Attack file, so that punching and kicking transfers Particle affects... (Same for slashing)
	//Edit Weapon file, so thrown weapons transfer particles...
	//
	//
	//


mob/var/tmp/Majest=0
mob/var/tmp/AkametsukiBlind=0
mob/var/tmp/Rejuvination=0
mob/var/tmp/list/attached
var/FriendlyAka=list("Rejuvination","Chakra Restore","Life Restore")//Can be made to only work on allies, while others don't work on allies
mob/var/tmp
	ParticleAffect=""
	Akametsuki=0
	AkametsukiTrack=0
	ParticleMineCount=0
	ParticleCharging=0

obj/Makam
	icon = 'Icons/Jutsus/GenjutsuTechniques.dmi'
	icon_state = "strong"
	layer=MOB_LAYER+1
	screen_loc="1,1 to 19,19"
	mouse_opacity = 1
obj/Kyomou
	Particles
		icon = 'Icons/Jutsus/GenjutsuTechniques.dmi'
		icon_state = "strong"
		mouse_opacity = 0
		layer=MOB_LAYER+2
	WaveParticles
		icon = 'Icons/Jutsus/Kyomou.dmi'
		icon_state="Wave"
		mouse_opacity = 0
	//	invisibility=100
		density=0
		var
			mob/Owner
			Dist=1
			Affect
		New()
			..()
			spawn(60)
				del(src)
		Crossed(atom/movable/A)
			..()
			if(src.Affect())
				del(src)
		Move(turf/NewLoc)
		//	world<<"Move proc called."
			if(src.Affect()) //When attempting to move, attempt to Affect Current loc
				del(src)
			//	return //If an effect was given, this is deleted, and stop the Move() proc.//1/28/2014
			if(!NewLoc) //Delete if trying to walk into the void
				del(src)
			//	return//1/28/2014
			if(NewLoc.density) //Manually check if the next loc is dense, because this obj is non-dense
				del(src) //I have it liek this, so that it doesn't unintendedly act as a shield...
			//	return//1/28/2014
			if(..()) //carry out default Move() proc
				Dist++
				if(src.Affect()) //After moving, check current loc, for effect again.
					del(src)
				//	return//1/28/2014
		proc/Affect()
	//		world<<"Affect proc called."
			for(var/obj/Jutsu/Elemental/A in src.loc)
				if((istype(A,/obj/Jutsu/Elemental)))
					if(src.Affect=="Disruption" && A!=src)
						del(A)
			//		spawn() Owner.AkametsukiAffect("Wave",Affect,O=A)
						return 1
			for(var/mob/A in src.loc)
		//	for(var/atom/movable/A in src.loc)

				if(A != src)
					if(A == Owner)
//						del(src)
						return 0
					if(src.Affect=="Disruption" && istype(A,/obj))
						spawn() Owner.AkametsukiAffect("Wave",Affect,O=A)
						return 1
			//		else if(ismob(A))

					var/dev=(3/src.Dist)
				//		world<<"Mob recognized and dev is [dev]."
					//	spawn()
				//		world<<"Akametsuki Affect being called. Wave type. Affect is [Affect], mob is [A] and effectiveness is [dev], particles dist = [src.Dist]"
				//		spawn()
					Owner.AkametsukiAffect("Wave",Affect,A,dev)
				//		spawn(100)
				//		del(src)
						//del(src)
					//	world<<"AkametsukiAffect called."
					return 1
				sleep(1)
			return 0
	BulletParticles
		icon = 'Icons/Jutsus/Kyomou.dmi'
		icon_state="Bullet"
		mouse_opacity = 0
	//	invisibility=100
		density=0
		var
			mob/Owner
			Dist=1
			Affect
		New()
			..()
			spawn(300)
				del(src)
		Crossed(atom/movable/A)
			..()
	//		world<<"Crossed proc called."
			if(src.Affect())
				del(src)
		Move(turf/NewLoc)
	//		world<<"Move proc called."
			if(src.Affect()) //When attempting to move, attempt to Affect Current loc
				del(src)
		//		return //If an effect was given, this is deleted, and stop the Move() proc.//1/28/2014
			if(!NewLoc) //Delete if trying to walk into the void
				del(src)
			//	return//1/28/2014
			if(NewLoc.density) //Manually check if the next loc is dense, because this obj is non-dense
				del(src) //I have it liek this, so that it doesn't unintendedly act as a shield...
			//	return//1/28/2014
			if(..()) //carry out default Move() proc
				Dist++
				if(src.Affect()) //After moving, check current loc, for effect again.
					del(src)
				//	return//1/28/2014
		proc/Affect()
			if(src.Affect=="Disruption")
				for(var/obj/Jutsu/Elemental/M in src.loc)
					if((istype(M,/obj/Jutsu/Elemental)))
						M.loc=null
						spawn(5)
							del(src)
				var/dev=(rand(5,8)/src.Dist)
				for(var/mob/E in src.loc)
					if(E!=Owner&&E.client)
						spawn() Owner.AkametsukiAffect("Bullet",Affect,E,dev)
						spawn()
							del(src)
			else
				var/dev=(rand(5,8)/src.Dist)
				for(var/mob/A in src.loc)
					if(A != src)
						if(A == Owner)
							return 0
						spawn() Owner.AkametsukiAffect("Bullet",Affect,A,dev)
						spawn()
							del(src)
			return 0
	ParticleGate
		icon = 'Icons/Jutsus/GenjutsuTechniques.dmi'
		icon_state="strong"
		mouse_opacity = 0
		invisibility=1
		density=1
		var
			mob/Owner
			Affect
			Dev=0.5
		New()
			spawn()
				..()
				while(src)
					if(src.Affect=="Disruption")
						for(var/obj/Jutsu/Elemental/M in src.loc)
							if((istype(M,/obj/Jutsu/Elemental)))
								M.loc=null
					sleep(20)
			spawn(600)
				del(src)
		Cross(atom/movable/O)
			if(ismob(O))
				O.loc=src.loc
				if(O!=Owner)
					Owner.AkametsukiAffect("Gate",Affect,O,Dev)
	ParticleMine
		icon = 'Icons/Jutsus/GenjutsuTechniques.dmi'
		icon_state="ParticleMine"
		mouse_opacity = 0
		invisibility=1
		density=0
		var
			mob/Owner
			Affect
			dev=1.5
		New()
			..()
			spawn(300)
				del(src)
			spawn(5)
				while(src)
					for(var/obj/Jutsu/Elemental/M in orange(1,src))
						if(src.Affect=="Disruption")
							if((istype(M,/obj/Jutsu/Elemental)))
								M.loc=null
								spawn(10)
									del(src)
					for(var/mob/M in orange(1,src))
						if(M!=src.Owner)
							spawn() Owner.AkametsukiAffect("Mine",Affect,M,dev)
							spawn()
								del(src)
					sleep(1);


mob/Kyomou/verb
	AkametsukiSearch()
		set name="Akametsuki Search"
		set category="Doujutsu"
		if(usr.AkametsukiTrack)
			usr.AkametsukiTrack=0
			usr.firing=0
			usr.controlled=null
			usr.client.perspective=MOB_PERSPECTIVE
			usr.client.eye=usr
			for(var/mob/Kyomou/AkametsukiTrack/P in world)
				if(P.Owner == usr)
					del(P)
		else
			usr.firing=1
			var/mob/Kyomou/AkametsukiTrack/P=new()
			P.loc=locate(usr.x-1,usr.y,usr.z)
			P.Owner=usr
			usr.controlled = P
			usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
			usr.client.eye = P
			usr.AkametsukiTrack=1
	RefreshSight()
		set name = "Refresh Auras"
		set category = "Doujutsu"
		src.ChakraSight(0)
		spawn(20)
			src.ChakraSight(1)
		src.verbs-=/mob/Kyomou/verb/RefreshSight
		spawn(300)
			if(src.Akametsuki && !(locate(/mob/Kyomou/verb/RefreshSight) in src.verbs))
				src.verbs+=/mob/Kyomou/verb/RefreshSight

mob/Kyomou/AkametsukiTrack
	name=""
	density=0


mob/proc
	AkametsukiSearch2(Uses)
		if(usr.AkametsukiTrack)
			src.AkametsukiTrack=0
			src.firing=0
			src.controlled=null
			src.client.perspective=MOB_PERSPECTIVE
			src.client.eye=src
			for(var/mob/Kyomou/AkametsukiTrack/P in world)
				if(P.Owner == src)
					del(P)
		else
			src.firing=1
			var/mob/Kyomou/AkametsukiTrack/P=new()
			P.loc=locate(src.x-1,src.y,src.z)
			P.Owner=src
			src.controlled = P
			src.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
			src.client.eye = P
			src.AkametsukiTrack=1
	AkametsukiIllumin(Uses)
		src.ChakraSight(0)
		src.ChakraSight(1)
		src.verbs-=/mob/Kyomou/verb/RefreshSight
		sleep(300)
		if(src.Akametsuki && !(locate(/mob/Kyomou/verb/RefreshSight) in src.verbs))
			src.verbs+=/mob/Kyomou/verb/RefreshSight
mob/proc
	Akametsuki(Uses)
		if(src.Akametsuki>=1)
			src.Akametsuki=0
			src.see_invisible=1
			src<<"You disactivate Akametsuki!"
			usr.ChangeEyeStyle(usr.EyeStyle,usr.reye,usr.geye,usr.beye)
			src.ChakraSight(0)
			src.verbs-=/mob/Kyomou/verb/AkametsukiSearch;
			src.verbs-=/mob/Kyomou/verb/RefreshSight
		else
			src.Akametsuki=1;
			src.ChakraSight(1);
			src.verbs+=/mob/Kyomou/verb/AkametsukiSearch;
			src.verbs+=/mob/Kyomou/verb/RefreshSight
			if(src.AkametsukiMastery>30)
				src.Akametsuki=2
			if(src.AkametsukiMastery>60)
				src.Akametsuki=3
			src<<"You activate Akametsuki!";
			usr.ChangeEyeStyle(usr.EyeStyle,200,0,0);
			src.see_invisible=100
			if(src.ParticleUsage>10)
				src.ParticleUsage=10
			while(src.Akametsuki>=1)
				sleep(10)
				var/A=src.AkametsukiMastery
				if(A<1) A=1
				var/ChakraDrain=(src.Mchakra/(A*15))
				if(ChakraDrain>75)
					ChakraDrain=75
				if(ChakraDrain<4)//11)
					ChakraDrain=4//11
				src.chakra-=ChakraDrain
				if(prob(2))
					src.AkametsukiMastery+=pick(0.1,0.2,0.3,0.4,0.5)





///////Jutsu
mob/var/tmp/AkaSleep
mob/var/tmp/AkaConst
mob/var/tmp/AkaConstUsr
mob/var/tmp/FieldInUse=0
mob/var/tmp/AkaReturn
mob/var/tmp/ParticleMelee=0
mob/var/tmp/ParticleMeleeMode=0
mob/proc
	ParticleConduction()	//Direct contact
		set background = 1
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.BrokenArms)
			return
		else
			if(src.ParticleMeleeMode==1)
				src.ParticleMeleeMode=0
				src.ParticleMelee=0
				src<<"You discharge your fists!"
			else
				src.ParticleMeleeMode=1
				src<<"You begin to generate Particles for your hands and Mines!"
				spawn()
					while(src.ParticleMeleeMode)
						if(src.ParticleMelee<3)
							sleep(50)
							src.ParticleMelee+=1
							src<<"You have [src.ParticleMelee]/3 particle infused punches!"
						sleep(10)
				spawn()
					while(src.ParticleMeleeMode)
						if(src.ParticleMineCount<3)
							sleep(200)
							src.ParticleMineCount+=1
							src<<"You [src.ParticleMineCount]/3 Particle Mines!"
						sleep(10)
	ParticleImpact(M)
		var
			Affect=src.ParticleAffect
			Dev=2.5
		if(src.ParticleUsage<10 && prob(10))
			src.ParticleUsage += pick(0.35,0.5,0.75)
			if(src.ParticleUsage>10) src.ParticleUsage = 10
		spawn() src.AkametsukiAffect("Punch",Affect,M,Dev)
	ParticleField()
		set background=1
		if(src.firing||src.knockedout||src.FieldInUse)
			return
		src << "You begin to emit a field of particles."
		var/Affect=src.ParticleAffect
		var/spot = src.loc
		var/ParticleRange=(src.Akametsuki*2-1)
		src.icon_state="handseal"
		while(!src.knockedout&&src.Akametsuki&&src.loc==spot&&src.icon_state=="handseal")
			src.FieldInUse=1
			if(src.ParticleUsage < 10 && prob(3))
				src.ParticleUsage += pick(0.25,0.5,0.75)
				if(src.ParticleUsage > 10)
					src.ParticleUsage = 10
			for(var/mob/M in view(ParticleRange,src))
				if(M!=src)
					spawn() src.AkametsukiAffect("Field",Affect,M,1)
			if(Affect=="Disruption")
				var/Disruptcount=max(1,round(src.AkametsukiMastery/30))
				if(!src.knockedout&&src.Akametsuki&&src.loc==spot&&src.icon_state=="handseal"&&Disruptcount>0)
					for(var/obj/Jutsu/Elemental/M in view(ParticleRange,src))
						if((istype(M,/obj/Jutsu/Elemental))&&Disruptcount>0)
							M.loc=null
							Disruptcount--
			sleep(10)
		src.FieldInUse=0
	ParticleWaves()
		set background = 1
		if(src.Kaiten||src.firing)
			return
		var/count=3
		while(count)
			src.ChakraDrain(3000)
			if(prob(count*(120+src.ParticleUsage)/3) || count == 2)
				var/obj/Kyomou/WaveParticles/W = new(get_step(src,src.dir));
				W.Owner=src;
				W.dir=src.dir
				W.Affect=src.ParticleAffect
				walk(W,W.dir,2)
				if(src.ParticleUsage<10 && prob(1))
					src.ParticleUsage += pick(0.25,0.5,0.75)
					if(src.ParticleUsage>10) src.ParticleUsage = 10
			if(prob(count*(120+src.ParticleUsage)/3)|| count == 2)
				var/obj/Kyomou/WaveParticles/W = new(get_step(src,turn(src.dir,90)));W.Owner=src;W.dir=src.dir
				W.Affect=src.ParticleAffect
				walk(W,W.dir,2)
				if(src.ParticleUsage<10 && prob(5))
					src.ParticleUsage += pick(0.25,0.5,0.75)
					if(src.ParticleUsage>10) src.ParticleUsage = 10
			if(prob(count*(120+src.ParticleUsage)/3) || count == 2)
				var/obj/Kyomou/WaveParticles/W = new(get_step(src,turn(src.dir,-90)));W.Owner=src;W.dir=src.dir
				W.Affect=src.ParticleAffect
				walk(W,W.dir,2)
				if(src.ParticleUsage<10 && prob(5))
					src.ParticleUsage += pick(0.25,0.5,0.75)
					if(src.ParticleUsage>10) src.ParticleUsage = 10
			count--
			sleep(8)

	ParticleBullet()
		set background = 1
		if(src.Kaiten||src.firing)
			return
		flick(pick("Attack1","Attack2"),src)
		src.ChakraDrain(6000)
		var/obj/Kyomou/BulletParticles/B = new(get_step(src,src.dir));
		B.dir=src.dir;B.Owner=src
		B.Affect=src.ParticleAffect
		if(src.ParticleUsage<10 && prob(5))
			src.ParticleUsage += pick(0.25,0.5,0.75)
			if(src.ParticleUsage>10) src.ParticleUsage = 10
		walk(B,B.dir,0.5)

	AkametsukiClones()
		set background = 1
		if(src.Kaiten||src.firing)
			return
		src.ChakraDrain(10000)
		src.Handseals(40-src.HandsealSpeed*10)
		if(src.HandsSlipped) return
		src.invisibility=101
		var/count=15
		while(count>0)
		//	sleep(2)
			var/mob/Clones/Clone/A=new();var/obj/SmokeCloud/S=new()
			A.RunningSpeed=src.RunningSpeed;A.Acceleration=src.Acceleration;A.Running=1;A.HasAura=1
			PICKASPOT
			var/turf/spot = locate(src.x+rand(-6,6),src.y+rand(-6,6),src.z)
			if( !(spot in view(src)) || !spot || spot.density==1 )
				goto PICKASPOT
			if(A)
				A.name="[src]";A.Owner=src;A.Clan = "Kyomou";A.ChakraColorR=180;src.ChakraColorG=0;src.ChakraColorB=0
				A.icon=src.icon;A.overlays+=src.overlays;A.chakra=src.chakra;A.Mchakra=src.Mchakra
				A.RunningSpeed=src.RunningSpeed;A.Acceleration=src.Acceleration;A.CloneType="Particle"
				S.loc=spot;A.loc=spot
				walk(A,src.dir)
				spawn(600) if(A) del(A)
			for(var/mob/M in range(15,src))//misdirect targets
				if(src==M.target&&prob(10))
					M.target=A
					for(var/image/x in M.client.images)
						if(x.icon=='Icons/target1.dmi'&&x.icon_state!="Number2")
							del(x)
					var/image/I = image('Icons/target1.dmi',A);M<<I
				if(M.client)//And now make sure everyone who can see chakra, sees it.
					if(M.shari&&!findtext("Sharingan",M.Doujutsu)||M.bya||M.Akametsuki)
						src.tempmix='Icons/Jutsus/ChakraAuraRed.dmi'
						//src.tempmix+=rgb(src.ChakraColorR,src.ChakraColorG,src.ChakraColorB)
						var/icon/Q=icon(src.tempmix)
						var/image/I=image(Q,A,"",FLY_LAYER+1)
						M << I
			count--
			sleep(1)
		src.invisibility=1
	ParticleGate()
		set background = 1
		if(src.Kaiten||src.firing)
			return
		src.ChakraDrain(10000)
		src.Handseals(40-src.HandsealSpeed*10)
		if(src.HandsSlipped) return
		if(src.ParticleUsage<10 && prob(5))
			src.ParticleUsage += pick(0.25,0.5,0.75)
			if(src.ParticleUsage>10) src.ParticleUsage = 10
		if(src.HoldingR)
			var/a=3//this is the range
			var/prevloc=get_step(src,src.dir)
			while(a>0)
				var/b=1
				while(b>0)
					var/obj/Kyomou/ParticleGate/D=new();D.Owner=src;D.loc=prevloc;D.Affect=src.ParticleAffect;b--
				prevloc=get_step(prevloc,src.dir);a--
		else
			for(var/turf/T in range(1,src))
				if(src.dir==NORTH||src.dir==SOUTH)
					if(T.y==src.y)
						var/obj/Kyomou/ParticleGate/D=new();D.Owner=src;D.loc=get_step(T,src.dir);D.Affect=src.ParticleAffect
				if(src.dir==WEST||src.dir==EAST)
					if(T.x==src.x)
						var/obj/Kyomou/ParticleGate/D=new();D.Owner=src;D.loc=get_step(T,src.dir);D.Affect=src.ParticleAffect
	ParticleMine()
		set background = 1
		if(src.Kaiten||src.firing)
			return
		src.ChakraDrain(10000)
		src.Handseals(40-src.HandsealSpeed*10)
		if(src.HandsSlipped) return
		if(src.ParticleUsage<10 && prob(5))
			src.ParticleUsage += pick(0.25,0.5,0.75)
			if(src.ParticleUsage>10) src.ParticleUsage = 10
		var/obj/Kyomou/ParticleMine/E = new();E.loc=src.loc;E.Owner=src;E.Affect=src.ParticleAffect

	AkametsukiAffect(Type,Affect,mob/M,num=1,obj/O)
			//Affect: Self Explanatory
			//M: The mob being effected...
			//num: The effeciency multiplier (weaker/stronger effects)
			//O: If not a mob, but an object,
			//F: Avoid Friendly Fire? (The Particle Field is so far the only thing using this.)
		//if(src.key=="RageFury33") num*=2 // :P
	//	world<<"Akametsuki Affect called."
		if(!src || !M)
		//	world<<"[src] not located."
			return
	//	if(!M)
	//		return
	//	if(Type=="Field" && M)
	//		if(M == src)
	//			return
	//		if(src.Allies.len>0)
	//			if( (!(Affect in FriendlyAka)&&M in src.Allies) || (Affect in FriendlyAka&&!(M in src.Allies)) )
	//				return
		if(Type=="Wave")
			view() << "The [Affect] [Type] collided with [M]!"
		if(Type=="Punch")
			view() << "[src]'s [Affect] [Type] slammed into [M]!"
		else if(Type=="Bullet")// && M)
	//	if(Type in list("Wave","Bullet"))
			view() << "The [Affect] [Type] collided with [M]!"
		switch(Affect)
			//Tier 1
			if("Blind")
				if(!M.client||M.knockedout||M.ImmuneToDeath||M.AkametsukiBlind)
					return
				for(var/obj/Makam/X in M.client.screen)
					return
				var/obj/Makam/MM=new()
				if(src.AkametsukiMastery>100)
					MM.icon_state="strong"
				M.client.screen+=MM
				M.AkametsukiBlind=1
				//src.ChakraDrain(5000)

				src<<"You blind [M] with a red vision!"
				if(M.target)
					M.target=null
					for(var/image/x in M.client.images)
						if(x.icon=='Icons/target1.dmi'&&x.icon_state!="Number2")
							del(x)

				var/Z=src.AkametsukiMastery*10
				if(Z>300)//was 450...
					Z=300
				for(var/obj/HUD/A in M.client.screen)
					spawn()
						A.invisibility=101

		//		var/Timer=Z*num
		//		spawn()
		//			while(Timer>0)
		//				if(M.target)
		//					M.target=null
		//				for(var/image/x in M.client.images)
		//					if(x.icon=='Icons/target1.dmi'&&x.icon_state!="Number2")
		//						del(x)
		//				Timer-=10
		//				sleep(10)
				if(num>1)
					num=1
				spawn(Z*num)
					for(var/obj/Makam/ZX in M.client.screen)
						del(ZX)
					for(var/obj/HUD/A in M.client.screen)
						spawn()
							A.invisibility=0
					for(var/obj/Makam/ZXX in M.client.screen)
						del(ZXX)
					for(var/obj/HUD/AA in M.client.screen)
						spawn()
							AA.invisibility=0
					M.AkametsukiBlind=0
			if("Rejuvination")
				if(!M.client||!src.client)
					return
				if(M==src)
					return
		//		if(prob(2))
		//			M<<"[src] gives up their chakra to heal you!"
			//	src<<"You give up your chakra to heal [M]!"
				var/VitHeal=src.AkametsukiMastery/5
				var/StamHeal=src.AkametsukiMastery/2
				if(VitHeal>55)
					VitHeal=55
				if(StamHeal>120)
					StamHeal=120
				M.health+=(VitHeal*num)
				M.stamina+=(StamHeal*num)
				if(M.health>=M.maxhealth)
					M.health=M.maxhealth
				if(M.stamina>=M.maxstamina)
					M.stamina=M.maxstamina
				if(M.client&&M.Dead&&M.health>=M.maxhealth/2&&!PermDeath&&!M.ImmuneToDeath)
					M.Dead=0
					M.icon_state=""
					M.FrozenBind=""
					M.sight&=~(SEE_SELF|BLIND)
					orange(12,M)<<"<font size = 2>[M] was revived from the brink of death from [src.oname]'s Particles!</font>"
			if("Burn")
				//src.ChakraDrain(1000)
				if(M.knockedout||M.ImmuneToDeath)
					return
			//	var/ConstantBurn=1


				M.stamina-=30*num
				if(M.Status=="Burn")
					var/BurnExtra=0


					M.StatusEffected+=min((src.ParticleUsage*5)*num,2)
					if(M.StatusEffected>10)
						BurnExtra+=(num*(M.StatusEffected/rand(3,4)))
					M.stamina-=BurnExtra
					return

				var/image/A=image('Icons/Jutsus/GenjutsuTechniques.dmi',M);
				A.icon_state="Fire"
				M<<A
				var/Length=min((src.ParticleUsage*10)*num,30)
				spawn(Length)
					del(A)
				M.StatusEffected=Length
				M.Status="Burn";
		//		M.StatusEffected=Length//min((src.ParticleUsage*10)*num,30)
			//Tier 2
			if("Migrane")
				if(M.knockedout||M.ImmuneToDeath||M.ParticleMigraned)
					return
				M.ParticleMigraned=1
				var/Dur=(src.ParticleUsage/2)
				var/Str=round(src.AkametsukiMastery/100)
				if(Dur<1)
					Dur=1
				if(Dur>5)
					Dur=5
				if(Str>7)
					Str=7
				if(Type == "Field" && Dur>=1)
					//Dur=10
					Dur=rand(2,5)
			//	spawn()
				Quake_Effect(M,Dur,Str)
				while(Dur>0 && !M.Guarding)
					M.stamina-=(rand(5,10)*Str);
					Dur--
					sleep(10)
				M.ParticleMigraned=0
			if("Chakra Drain")
				if(M.knockedout||M.ImmuneToDeath)
					return
				var/Cdrain=((src.AkametsukiMastery/6)*num)
				if(Cdrain>275)
					Cdrain=275
				if(M.chakra-Cdrain<=0)
					Cdrain = M.chakra
				if(M.chakra>0)
					M.chakra-=Cdrain
			//Tier 3
			if("Doujutsu Counter")
				if(M.ImmuneToDeath)
					return
/*				if(M.Kurome)
					M.Kurome()
					for(var/obj/SkillCards/Kurome/S in M.LearnedJutsus)
						S.DelayIt(450,M,"Clan")*/
				if(M.shari)
					M.Sharingan()
					for(var/obj/SkillCards/Sharingan/S in M.LearnedJutsus)
						S.DelayIt(450,M,"Clan")
				else if(M.bya)
					M.ByakuganOn()
					for(var/obj/SkillCards/Byakugan/S in M.LearnedJutsus)
						S.DelayIt(450,M,"Clan")
		//		if(M.Majest)
		//			M.MajesticEyes()
		//			for(var/obj/SkillCards/MajesticEyes/S in M.LearnedJutsus)
		//				S.DelayIt(450,M,"Clan")
				if(M.Akametsuki && M.AkametsukiMastery < (src.AkametsukiMastery-100))
					M.Akametsuki()
					for(var/obj/SkillCards/Akametsuki/S in M.LearnedJutsus)
						S.DelayIt(150,M,"Clan")
			if("Anorexiation")
				var/Ano=src.AkametsukiMastery/10
				if(Ano>50)
					Ano=50
				if(M.knockedout||M.ImmuneToDeath)
					return
				if(M.calories>0)
					var/CalDrain=(50*(src.AkametsukiMastery/100))
					M.calories-=(CalDrain*num)
					if(M.calories<0)
						M.calories=0
				M.stamina-=((Ano)*num)
				var/anodrain=round(rand(1,2)*num);
				if(anodrain>3)
					anodrain=3
				M.hunger+=anodrain
				if(M.hunger>=100){M.hunger=100}
				M.thirst+=anodrain
				if(M.thirst>=100){M.thirst=100}
				M.Running=0
				if(prob((src.AkametsukiMastery/100)*num))
					spawn()
						M.Bloody();
						M.Bloody();
						M.Bloody();
					M.health-=rand(40,60)
			if("Chakra Restore")
				if(M.knockedout||M.ImmuneToDeath)
					return
				if(M.chakra<M.Mchakra)
					var/Cmax=((src.AkametsukiMastery/10)*num)
					if(Cmax>200)
						Cmax=200
					if(M.chakra+Cmax>M.Mchakra)
						Cmax -= ((M.chakra+Cmax)-M.Mchakra)
					M.chakra+=Cmax
				//	if(M.chakra>M.Mchakra*0.75)
				//		M.chakra=M.Mchakra*0.75
			//Tier 4
			if("Daze")
				if(M.knockedout||M.ImmuneToDeath||M.InDazeParticle)
					return
				var/Dur=(src.AkametsukiMastery/30)
				if(Type!="Field")
					M.InDazeParticle=1
					if(Dur>15)//Was 30
						Dur=15
					var/Length=Dur*num
					if(Length>15)
						Length=15
					while((Length)>0)
						if(prob(70))
							M.client:dir=pick(NORTH,SOUTH,WEST,EAST);
						Length--
						M.stamina-=rand(10,20);//Was 50
						sleep(10)
					M.client:dir=NORTH
					M.InDazeParticle=0
				else
					M.InDazeParticle=1
					if(prob(70)) M.client:dir=pick(NORTH,SOUTH,WEST,EAST)
				//	M.stamina-=30
					Dur=(src.AkametsukiMastery/100)
					if(Dur>7)
						Dur=7
				//	spawn()
					while((Dur*num)>0)
						if(prob(30+(5*num)))
							M.client:dir=pick(NORTH,SOUTH,WEST,EAST);
						Dur--
						M.stamina-=rand(7,10);//Was 50
						sleep(8)
					M.client:dir=NORTH
				//	while(src)
				//		sleep(10)
			//		M.client:dir:NORTH
				//	M.client:dir=NORTH
					M.InDazeParticle=0
			if("Stamina")
				if(M.knockedout||M.ImmuneToDeath)
					return
				var/Damage=(src.AkametsukiMastery/5)
				if(Type=="Field")
					if(Damage>200)//Was 500
						Damage=200
				if(Type=="Bullet")
					if(Damage>450)
						Damage=450
				else
					if(Damage>350)
						Damage=350
				Damage += rand(-75,75)
			//	if(prob(10))
			//		M<<"You feel a wave of exhaustion come over you.."
				spawn()
					M.DamageProc(Damage,"Stamina",src)
			if("Reservoir Absorbtion")
				if(M.knockedout||M.ImmuneToDeath)
					return
				if(M.ChakraPool>0 && src.ChakraPool<src.MaxChakraPool && M.client)
					var/Drain = (src.AkametsukiMastery*num)
					if(Drain>250)//There was no cap before
						Drain=250
					if(Type=="Wave")
						Drain/=3
					if(Type=="Bullet")
						Drain*=2.25
					if(src.ChakraPool+Drain>src.MaxChakraPool)
						Drain-=((src.ChakraPool+Drain)-src.MaxChakraPool)	//Subtract by the difference so it doesn't overcap.
					if((M.ChakraPool-Drain)<0)
						Drain+=(M.ChakraPool-Drain)	//"Add" the negative, to reduce the drain, so their res doesn't plung into negative.
				//	if(M.knockedout||M.ImmuneToDeath)
				//		return
					src.ChakraPool+=Drain;
					M.ChakraPool-=Drain
			//Tier 5
			if("Stun")
				if(M.knockedout||M.ImmuneToDeath)
					return
				M.StunAdd(round((src.AkametsukiMastery/40)*num,1))
				if(M.Stun>30)
					M.Stun=30
					M.Running=0
			if("Vitality")
				if(M.knockedout||M.ImmuneToDeath)
					return
				var/Damage=src.AkametsukiMastery/50
				if(Damage>45)
					Damage=45
				spawn()
					M.Bloody();
				M.DamageProc(Damage*num,"Health",src)
			if("Disruption")
				if(M.knockedout||M.ImmuneToDeath)
					return
				if(M.Rasenganon)//This is so odd, why rasengan? Id understand fuuton rasengan though.
					M.RasenganD=0
				if(M.Chidorion||M.Raikirion)
					M.ChidoriD=0
				if(M.DotonArmor)
					M.DotonArmor=0
				if(M.FrozenBind== "ColumnSpikes")
					M.FrozenBind=""
				if(M.FrozenBind=="In Arijigoku")
					M.FrozenBind=""
				if(M.FrozenBind=="DoBind")
					M.FrozenBind=""
					M.EarthBindedBy=""
				if(M.RaiArmor==1)
					for(var/obj/SkillCards/Yoroi/P in M.LearnedJutsus)
						P.Deactivate(M)
				if(M.FrozenBind=="Stone Bind")
					M.FrozenBind=""

			//Tier 6
			if("Sleep")
				if(!M.client||!src.client)
					return
				if(M.knockedout||M.ImmuneToDeath)
					return
				if(!M.Dead && !M.knockedout && M.StruggleAgainstDeath<1 && M.Status!="Asleep")
					if(!M.AkaSleep)
						M << "That's odd..You feel tired... drowzy..."
						spawn(50)
							while(M.AkaSleep>0)
								M.AkaSleep--
								sleep(10)
					M.AkaSleep+=1+num//simplistic
					if(M.Status!="Asleep" && M.AkaSleep > 15)
						M<<"Your body has gone completely numb!"
						M.Status="Asleep"
						M.StatusEffected=(min(src.AkametsukiMastery/100,15))//extreamly variable, can be short or long duration, depens on which method was used to proc the sleep effect.
						M.AkaSleep = 0
					//Sleep particles have to build up.
					//you have to reach 15 "hits" in 5 seconds, in order to pass out.
			if("Life Absorbtion")
				if(!M.client||!src.client)
					return
				if(M.knockedout||M.ImmuneToDeath)
					return
				if(M.health>0&&src.health<src.maxhealth)
					var/Drain = min(src.AkametsukiMastery/5,25)*num
					if(src.health+Drain>src.maxhealth)
						Drain-=((src.health+Drain)-src.maxhealth)
					if(M.health-Drain<0)
						Drain+=(M.health-Drain)
					M.health-=Drain;src.health+=Drain
				if(M.stamina>0&&src.stamina<src.maxstamina)
					var/Drain = min(src.AkametsukiMastery/2,50)*num
					if(src.stamina+Drain>src.maxstamina)
						Drain-=((src.stamina+Drain)-src.maxstamina)
					if(M.stamina-Drain<0)
						Drain+=(M.stamina-Drain)
					M.stamina-=Drain;src.stamina+=Drain
				if(src.deathcount>0&&M.deathcount<3)
					M.deathcount+=0.05;
					src.deathcount-=0.03
				M.Death(src)
			//Tier 7
			if("Constraint")
				if(!M.client||!src.client)
					return
				if(M.knockedout||M.ImmuneToDeath)
					return
				if(M.AkaConst<=0)
					M.AkaConst= min(src.AkametsukiMastery/10,30)
					M.AkaConstUsr="[src.oname]"
					M<<"You have been constrained to [src]!"
					src<<"[M] has been constrained to you!"
					while(M.AkaConst>0)
						if(M.knockedout)
							M.AkaConst=0
						if(distance(src,M)>10)
							M.chakra-=30 //Stamina and/or vit damage from this seemed op, in the sense of teaming in a village situation.
							M.Running=0
						if(distance(src,M)>20)
							step_towards(M,src)
						if(distance(src,M)>30)
							while(distance(src,M)>30)
								M.AkaConst-=3
								M.chakra-=50
								M.Running=0
								if(M.AkaConst<=0)
									M.AkaConst=0
									M.AkaConstUsr=""
									M<<"You snap the link!"
									src<<"The link was lost!"
									return
								sleep(10)
						if(M.AkaConst<=0)
							M.AkaConst=0
							M.AkaConstUsr=""
							M<<"The Binding Particles disperse!"
							src<<"Your particles leave [M]'s body!"
						M.AkaConst-=1
						if(M.AkaConst<=0)
							M.AkaConst=0
							M.AkaConstUsr=""
							M<<"The Binding Particles disperse!"
							src<<"Your particles leave [M]'s body!"
						sleep(10)
			if("Life Restore")
				if(!M.client||!src.client)
					return
				if(M.knockedout||M.ImmuneToDeath)
					return
				if(M.health<M.maxhealth)
					var/VitHeal = min(src.AkametsukiMastery/5,100)*num
					if(M.health+VitHeal>M.maxhealth)
						VitHeal-=((M.health+VitHeal)-M.maxhealth)
					M.health+=VitHeal
					src.health-=VitHeal
				if(M.stamina<M.maxstamina)
					var/StmHeal = min(src.AkametsukiMastery/2,300)*num
					if(M.stamina+StmHeal>M.maxstamina)
						StmHeal-=((M.stamina+StmHeal)-M.maxstamina)
					M.stamina+=StmHeal
					src.stamina-=StmHeal
				if(M.ChakraPool<M.MaxChakraPool&&src.ChakraPool>=0)
					var/Heal = ((src.AkametsukiMastery/25)*num)
					if(M.ChakraPool+Heal>M.MaxChakraPool)
						Heal-=((M.ChakraPool+Heal)-M.MaxChakraPool)	//Subtract by the difference so it doesn't overcap.
					if(src.ChakraPool-Heal<0)
						Heal-=(Heal-src.ChakraPool)
					M.ChakraPool+=Heal
					src.ChakraPool-=Heal
				if(M.deathcount>0)
					if(src.deathcount>15)
						src.health = 0
						src.Death(M)
						src.DeathStruggle(M,1)
					M.deathcount-=0.1
					src.deathcount+=0.1
					if(M.deathcount<0)
						M.deathcount=0
			if("Particle Return")//Dear lord
				if(!M.client||!src.client)
					return
				if(M.ImmuneToDeath||M.AkaReturn||M.knockedout||M.Frozen||(!(M.FrozenBind=="")))
					return
				if(distance(src,M)>30)
					return
				if(M.AkaConst&&M.AkaConstUsr!="[src.oname]")
					src<<"[M] is constrained and cannot be Returned to you!"
					return
				M.density=0
				M.AkaReturn=1
				walk_towards(M,src,1,0)
				M.firing=1
				M.RestrictOwnMovement=1
				spawn()
					spawn(30)
						if(M.AkaReturn==1)
							M.RestrictOwnMovement=0
							M.AkaReturn=2
							M.density=1
							M.firing=0
							walk(M,0)
							M.loc=src.loc
					while(M.AkaReturn==1&&(distance(src,M)<30))
						walk_towards(M,src,1,0)
						M.firing=1
						if(M.loc==src.loc)
							M.RestrictOwnMovement=0
							M.AkaReturn=2
							M.density=1
							M.firing=0
							walk(M,0)
						sleep(10)
					M.RestrictOwnMovement=0
					M.AkaReturn=0
					M.density=1
					M.firing=0
					walk(M,0)
			if("Genjutsu Shatter")//idek
				if(!M.client||!src.client)
					return
				if(M.knockedout||M.ImmuneToDeath)
					return
				if(M.InGenjutsu!=""&&M.InGenjutsu!="Kyomou")
					src.GenjutsuCanceling()
				if(M.InGenjutsu=="")
					M.InGenjutsu="Kyomou"
					M.GenjutsuBy="[src]"
					spawn(100)
						M.InGenjutsu=""
						M.GenjutsuBy=""



///////Kyomou NPCS

mob/Teachers/
	proc/AkametsukiTeacherCheck(mob/M)
		M<<"Ah yes, let's get started then, shall we?"
		var/list/A=M.LearnedJutsus
		if(!(locate(/obj/SkillCards/Akametsuki_Blind) in A)&&!(locate(/obj/SkillCards/Akametsuki_Burn) in A)&&!(locate(/obj/SkillCards/Akametsuki_Rejuvination) in A))
			M << "You must start with the basics of course."
			if(M.AkametsukiMastery<25)
				M<<"However, you do not posses the nescicary mastery to properly control your particles.";return
			M << "I however only am allowed to teach you one move. If you wish, the other proctors may teach you another move if you wish."
			if(src.name=="Kyomou, Gekido") M.LearnJutsu("Akametsuki Rejuvination",10000,"Akametsuki_Rejuvination","An ancient basic to the Kyomou's art of manipulating one's chakra in order to aid the body of another.","Ninjutsu")
			if(src.name=="Kyomou, Tokui") M.LearnJutsu("Akametsuki Blind",10000,"Akametsuki_Blind","This move blinds the enemy in red, and makes their focus much more difficult.","Ninjutsu")
			if(src.name=="Kyomou, Eien") M.LearnJutsu("Akametsuki Burn",10000,"Akametsuki_Burn","A slightly aggresive use of particles, the user causes the body of one's enemy to feel as if they are burning.","Ninjutsu")
			return
		else if(!(locate(/obj/SkillCards/Akametsuki_Clones) in A)&&!(locate(/obj/SkillCards/Akametsuki_Migrane) in A)&&!(locate(/obj/SkillCards/Akametsuki_Chakra_Drain) in A))
			M<<"Well, you're making progress."
			if(M.AkametsukiMastery<60)
				M<<"But not enough progress to learn the next tier of moves.";return
			if(src.name=="Kyomou, Tokui") M.LearnJutsu("Akametsuki Clones",15000,"Akametsuki_Clones","A simple move which creates a collection of illusionary clones, that are capable of fooling those with even the most keen sight.","Ninjutsu")
			if(src.name=="Kyomou, Eien") M.LearnJutsu("Akametsuki Migrane",15000,"Akametsuki_Migrane","The user utilizes the use of their particles to criple the mind of his enemies by causing painful mental damage.","Ninjutsu")
			if(src.name=="Kyomou, Gekido") M.LearnJutsu("Akametsuki Chakra Drain",15000,"Akametsuki_Chakra_Drain","A jutsu which uses particles that trick the body of the affected into leaking chakra..","Ninjutsu")
		else if(!(locate(/obj/SkillCards/Akametsuki_Doujutsu_Counter) in A)&&!(locate(/obj/SkillCards/Akametsuki_Anorexiation) in A)&&!(locate(/obj/SkillCards/Akametsuki_Chakra_Restore) in A))
			M<<"You've exceeded my expectations of your ability!"
			if(M.AkametsukiMastery<100)
				M<<"But you're not ready for the next step in our power!";return
			if(src.name=="Kyomou, Tokui") M.LearnJutsu("Akametsuki Doujutsu Counter",20000,"Akametsuki_Doujutsu_Counter","One of the Kyomou Clan's most faimed abilities! This technique will allow your particles to disable the use of Doujutsus from an enemy!","Ninjutsu")
			if(src.name=="Kyomou, Eien") M.LearnJutsu("Akametsuki Anorexiation",20000,"Akametsuki_Anorexiation","This causes the body of the affected to reject calories and nutrients, breaking itself down. It's possible to even cause an auto-immune response.","Ninjutsu")
			if(src.name=="Kyomou, Gekido") M.LearnJutsu("Akametsuki Chakra Restore",20000,"Akametsuki_Chakra_Restore","A jutsu which uses particles that trick the body of the affected mass producing chakra for itself.","Ninjutsu")
		else if(!(locate(/obj/SkillCards/Akametsuki_Daze) in A)&&!(locate(/obj/SkillCards/Akametsuki_Stamina_Damage) in A)&&!(locate(/obj/SkillCards/Akametsuki_Reservoir_Absorbtion) in A))
			M<<"You've exceeded my expectations of your ability!"
			if(M.AkametsukiMastery<150)
				M<<"But you're not ready for the next step in our power!";return
			if(src.name=="Kyomou, Tokui") M.LearnJutsu("Akametsuki Daze",20000,"Akametsuki_Daze","This particle effect disorients the affected.","Ninjutsu")
			if(src.name=="Kyomou, Eien") M.LearnJutsu("Akametsuki Stamina Damage",20000,"Akametsuki_Stamina_Damage","Causes a ninja to become exhausted, and lose the energy to fight.","Ninjutsu")
			if(src.name=="Kyomou, Gekido") M.LearnJutsu("Akametsuki Reservoir Absorbtion",20000,"Akametsuki_Reservoir_Absorbtion","Attacks one the their reserve of chakra, indirectly impeding their ability to fight.","Ninjutsu")
		else if(!(locate(/obj/SkillCards/Akametsuki_Stun) in A)&&!(locate(/obj/SkillCards/Akametsuki_Vitality) in A)&&!(locate(/obj/SkillCards/Akametsuki_Disruption) in A))
			M<<"You've exceeded my expectations of your ability!"
			if(M.AkametsukiMastery<200)
				M<<"But you're not ready for the next step in our power!";return
			if(src.name=="Kyomou, Tokui") M.LearnJutsu("Akametsuki Stun",25000,"Akametsuki_Stun","This particle effect disorients the affected and stuns them.","Ninjutsu")
			if(src.name=="Kyomou, Eien") M.LearnJutsu("Akametsuki Vitality",25000,"Akametsuki_Vitality","Causes a ninja to become mortally wounded.","Ninjutsu")
			if(src.name=="Kyomou, Gekido") M.LearnJutsu("Akametsuki Disruption",25000,"Akametsuki_Disruption","Attacks elemental objects and implodes in on them destroying it.","Ninjutsu")
		else if(!(locate(/obj/SkillCards/Akametsuki_Genjutsu_Shatter) in A)&&!(locate(/obj/SkillCards/Akametsuki_Particle_Return) in A)&&!(locate(/obj/SkillCards/Akametsuki_Constraint) in A))
			M<<"You've exceeded my expectations of your ability!"
			if(M.AkametsukiMastery<500)
				M<<"But you're not ready for the next step in our power!";return
			if(src.name=="Kyomou, Tokui") M.LearnJutsu("Akametsuki Genjutsu Shatter",35000,"Akametsuki_Genjutsu_Shatter","This particle effect restores disturbed chakra flow, canceling nearly all genjutsu!","Ninjutsu")
			if(src.name=="Kyomou, Eien") M.LearnJutsu("Akametsuki Constraint",35000,"Akametsuki_Constraint","Prevent your enemies from escaping by linking them too you, forces walking and lightly drains chakra if they are too far from you.","Ninjutsu")
			if(src.name=="Kyomou, Gekido") M.LearnJutsu("Akametsuki Particle Return",35000,"Akametsuki_Particle_Return","Support your allies or capture enemies by pulling them to you!.","Ninjutsu")
		else if(!(locate(/obj/SkillCards/Akametsuki_Sleep) in A)&&!(locate(/obj/SkillCards/Akametsuki_Life_Absorb) in A)&&!(locate(/obj/SkillCards/Akametsuki_Life_Restore) in A))
			M<<"You've exceeded my expectations of your ability!"
			if(M.AkametsukiMastery<1000)
				M<<"But you're not ready for the next step in our power!";return
			if(src.name=="Kyomou, Tokui") M.LearnJutsu("Akametsuki Sleep",50000,"Akametsuki_Sleep","This particle effect disorients the affected knocking them out if they become charged by this effect too much!","Ninjutsu")
			if(src.name=="Kyomou, Eien") M.LearnJutsu("Akametsuki Life Absorb",50000,"Akametsuki_Life_Absorb","Rip the very life out of those around, down right destroying them.","Ninjutsu")
			if(src.name=="Kyomou, Gekido") M.LearnJutsu("Akametsuki Life Restore",50000,"Akametsuki_Life_Restore","Revitalize your allies, but sacrifice yourself, This is an extreamly powerful effect, becareful when using.","Ninjutsu")
		else
			M << "Sorry, we don't have anything to teach you at the moment..."
			return
	//	else if(!(locate(/obg/Skillcards/) in A)&&!(locate(/obg/Skillcards/) in A)&&!(locate(/obg/Skillcards/) in A))
	//	else if(!(locate(/obg/Skillcards/) in A)&&!(locate(/obg/Skillcards/) in A)&&!(locate(/obg/Skillcards/) in A))
	//	else if(!(locate(/obg/Skillcards/) in A)&&!(locate(/obg/Skillcards/) in A)&&!(locate(/obg/Skillcards/) in A))

	KyomouTeacher1
		name = "Kyomou, Gekido"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Rain"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/KakashiH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(220,220,220)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi' + rgb(200,0,0)
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/BaggyPants.dmi' + rgb(200,0,0)
				src.overlays+='Icons/New Base/Clothing/cloak3.dmi' + rgb(200,0,0)
				src.overlays+='Icons/New Base/Clothing/Headbands/HeadbandNeck.dmi' + rgb(200,0,0)
				src.overlays-=Hair
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			sleep(3)
			var/Options = list("Tell me about the clan.")
			if(usr.Clan=="Kyomou")
				Options += "I'm a Kyomou too! Teach me!"
			switch(input(usr,"Hello, what can I do for you?", "Kyomou, Gekido") in Options)
				if("Tell me about the clan.")
					var/style = "<style>BODY {margin:0;font:arial;background:black;color:white;}</style>"
					sd_Alert(usr, "Ah, well the history of the clan goes back generations. But according to history it all started with a little boy named Ranmaru. He never knew his parents, but when he grew up, he went to the Hidden Mist Village to become a Ninja.<br>Everything else is a bit fuzy though.","[src]",,,,0,"400x150",,style)
				if("I'm a Kyomou too! Teach me!")
					if(!(locate(/obj/SkillCards/Particle_Field) in usr.LearnedJutsus) || ( !(locate(/obj/SkillCards/Particle_Gate) in usr.LearnedJutsus) && usr.AkametsukiMastery >= 60))
						alert("Ah, that is good news. It seems I have a few things to teach you...")
						switch(input("What would you like to learn?") in list("Teach me to create Particle [usr.AkametsukiMastery>=60?(!(locate(/obj/SkillCards/Particle_Field) in usr.LearnedJutsus)?"Field":"Gate"):"Field"]","Teach me to control my particles","Nevermind"))
							if("Teach me to create Particle Field")
								if((!(locate(/obj/SkillCards/Particle_Waves)in usr.LearnedJutsus))&&(!(locate(/obj/SkillCards/Particle_Punch)in usr.LearnedJutsus)))
									//If you haven't learned any other particle method, you get it free!
									var/obj/SkillCards/Particle_Field/P = new();usr.LearnedJutsus += P
									usr << "Very well. Here you go."
									return
								else
									usr.LearnJutsu("Particle Field",20000,"Particle_Field","Allows you to spread your particles into an area around you.","Ninjutsu")
									return
							if("Teach me to create Particle Gate")
								usr.LearnJutsu("Particle Gate",20000,"Particle_Gate","Allows you to concentrate your particles into a passable wall, afflicting those who pass through.","Ninjutsu")
								return
							if("Nevermind")
								return
							else
								src.AkametsukiTeacherCheck(usr)
					else
						src.AkametsukiTeacherCheck(usr)

	KyomouTeacher2
		name = "Kyomou, Eien"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Rain"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/KakashiH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(200,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi' + rgb(200,0,0)
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Clothing/BaggyPants.dmi' + rgb(200,0,0)
				src.overlays-=Hair
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			sleep(3)
			var/Options = list("Tell me about the clan.")
			if(usr.Clan=="Kyomou")
				Options += "I'm a Kyomou too! Teach me!"
			switch(input(usr,"Hello, what can I do for you?", "Kyomou, Gekido") in Options)
				if("Tell me about the clan.")
					var/style = "<style>BODY {margin:0;font:arial;background:black;color:white;}</style>"
					sd_Alert(usr, "Hmm, I really don't know too much about the clan. I'm more of a man of action, than a historian anyways. I DO know that the Kyomou clan has always had a relatively low population. I kinda like it that way.","[src]",,,,0,"400x150",,style)
				if("I'm a Kyomou too! Teach me!")
					if(!(locate(/obj/SkillCards/Particle_Punch) in usr.LearnedJutsus) || ( !(locate(/obj/SkillCards/Particle_Mine) in usr.LearnedJutsus) && usr.AkametsukiMastery >= 60))
						alert("Ah, that is good news. It seems I have a few things to teach you...")
						switch(input("What would you like to learn?") in list("Teach me to create Particle [usr.AkametsukiMastery>=60?(!(locate(/obj/SkillCards/Particle_Punch) in usr.LearnedJutsus)?"Punch":"Mine"):"Punch"]","Teach me to control my particles","Nevermind"))
							if("Teach me to create Particle Punch")
								if((!(locate(/obj/SkillCards/Particle_Field)in usr.LearnedJutsus))&&(!(locate(/obj/SkillCards/Particle_Waves)in usr.LearnedJutsus)))
									//If you haven't learned any other particle method, you get it free!
									var/obj/SkillCards/Particle_Punch/P = new();usr.LearnedJutsus += P
									usr << "Very well. Here you go."
									return
								else
									usr.LearnJutsu("Particle Punch",20000,"Particle_Punch","Allows you to charge up your fists to punch.","Ninjutsu")
									return
							if("Teach me to create Particle Mine")
								usr.LearnJutsu("Particle Mine",20000,"Particle_Mine","Allows you to concentrate your particles into a mine, You must be in Particle Punch mode!","Ninjutsu")
								return
							if("Nevermind")
								return
							else
								src.AkametsukiTeacherCheck(usr)
					else
						src.AkametsukiTeacherCheck(usr)

	KyomouTeacher3
		name = "Kyomou, Tokui"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Rain"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/MinatoH.dmi'
				Base+=rgb(235,145,52)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi' + rgb(200,0,0)
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/BaggyPants.dmi'
				src.overlays+='Icons/New Base/Clothing/cloak3.dmi'
				src.overlays+='Icons/New Base/Clothing/Headbands/HeadbandNeck.dmi' + rgb(200,200,200)
				src.overlays-=Hair
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			sleep(3)
			var/Options = list("Tell me about the clan.")
			var/style = "<style>BODY {margin:0;font:arial;background:black;color:white;}</style>"
			if(usr.Clan=="Kyomou")
				Options += "I'm a Kyomou too! Teach me!"
			switch(input(usr,"Hello, what can I do for you?", "Kyomou, Gekido") in Options)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;xolor:white;}</style>"
				if("Tell me about the clan.")
					sd_Alert(usr, "The Kyomou clan is by many considered the scorn of the Doujutsu, as we have the power to decieve those who believe their eyes to see all.","[src]",,,,0,"400x150",,style)
				if("I'm a Kyomou too! Teach me!")
					if(!(locate(/obj/SkillCards/Particle_Waves) in usr.LearnedJutsus) || ( !(locate(/obj/SkillCards/Particle_Bullet) in usr.LearnedJutsus) && usr.AkametsukiMastery >= 60))
						alert("Ah, that is good news. It seems I have a few things to teach you...")
						switch(input("What would you like to learn?") in list("Teach me to create Particle [usr.AkametsukiMastery>=60?(!(locate(/obj/SkillCards/Particle_Waves) in usr.LearnedJutsus)?"Waves":"Bullets"):"Waves"]","Teach me to control my particles","Nevermind"))
							if("Teach me to create Particle Waves")
								if((!(locate(/obj/SkillCards/Particle_Field)in usr.LearnedJutsus))&&(!(locate(/obj/SkillCards/Particle_Punch)in usr.LearnedJutsus)))
									//If you haven't learned any other particle method, you get it free!
									var/obj/SkillCards/Particle_Waves/P = new();usr.LearnedJutsus += P
									usr << "Very well. Here you go."
									return
								else
									usr.LearnJutsu("Particle Waves",20000,"Particle_Waves","Allows you to shape your particles into a series of waves.","Ninjutsu")
									return
							if("Teach me to create Particle Bullets")
								usr.LearnJutsu("Particle Bullet",20000,"Particle_Bullet","Allows you to concentrate your particles into a speeding bullet.","Ninjutsu")
								return
							if("Nevermind")
								return
							else
								src.AkametsukiTeacherCheck(usr)
					else
						src.AkametsukiTeacherCheck(usr)











mob/proc/OneEyeAkametsuki()
	if(src.Akametsuki>=1)
		src.Akametsuki=0
		src.see_invisible=1
		src<<"You cover up your Akametsuki, stopping its abilities."
		src.overlays-='Icons/Jutsus/sharinganthing.dmi';src.overlays-='Icons/Jutsus/SEye.dmi'
	//	src.verbs-=/mob/Kyomou/verb/AkametsukiBlind;src.verbs-=/mob/Kyomou/verb/AkametsukiSearch;src.verbs-=/mob/Kyomou/verb/Rejuvanate
	else
		src.Akametsuki=1
		src.verbs+=/mob/Kyomou/verb/AkametsukiSearch
		if(src.AkametsukiMastery>20)
			src.Akametsuki=2
		if(src.AkametsukiMastery>30)
			src.Akametsuki=3
		if(src.AkametsukiMastery>50)
			src.verbs+=/mob/Kyomou/verb/Rejuvanate
		if(src.AkametsukiMastery>55)
			src.verbs+=/mob/Kyomou/verb/AkametsukiBlind
		if(src.AkametsukiMastery>100)
			for(var/mob/M in view(src))
				if(M.shari)
					M<<"You Sharingan was disactivated!?"
					M.overlays-='Icons/Jutsus/sharinganthing.dmi';M.overlays-='Icons/Jutsus/SEyes.dmi'
					M.shari=0;M.SharCounter=0;M.CopyMode=0;M.IlluminateOff()
				if(M.bya)
					M<<"You Byakugan was disactivated!?"
					M.overlays-='Icons/Jutsus/BEyes.dmi';M.overlays-='Icons/Jutsus/BEyes.dmi'
					M.bya=0;M.see_invisible=1
				if(M.Akametsuki>=1)
					if(M.AkametsukiMastery*2<src.AkametsukiMastery)
						M<<"A doujutsu like yours has been activated, its power so tremendous it disactivated yours!"
						M.Akametsuki=0;M.see_invisible=1;M.overlays-='Icons/Jutsus/SEyes.dmi'
						M.verbs-=/mob/Kyomou/verb/AkametsukiBlind;M.verbs-=/mob/Kyomou/verb/AkametsukiSearch;M.verbs-=/mob/Kyomou/verb/Rejuvanate
		src<<"You activate Akametsuki!"
		src.overlays-='Icons/Jutsus/SEyes.dmi';src.overlays+='Icons/Jutsus/SEyes.dmi'
		src.see_invisible=99
		while(src.Akametsuki>=1)
			var/A=src.AkametsukiMastery
			if(A<1) A=1
			var/ChakraDrain=(src.Mchakra/(A*15))
			if(ChakraDrain>100)
				ChakraDrain=100
			src.chakra-=ChakraDrain
			if(prob(1))
				src.AkametsukiMastery+=pick(0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1)
			if(src.AkametsukiMastery>=100)
				for(var/mob/M in view(src))
					if(M.shari)
						M<<"You Sharingan was deactivated!?"
						M.overlays-='Icons/Jutsus/sharinganthing.dmi';M.overlays-='Icons/Jutsus/SEyes.dmi'
						M.shari=0;M.SharCounter=0;M.CopyMode=0;M.IlluminateOff()
					if(M.bya)
						M<<"You Byakugan was deactivated!?"
						M.overlays-='Icons/Jutsus/BEyes.dmi';M.overlays-='Icons/Jutsus/BEyes.dmi'
						M.bya=0;M.see_invisible=1
					if(M.Akametsuki>=1)
						if(M.AkametsukiMastery*2<src.AkametsukiMastery)
							M<<"A doujutsu like yours has been activated, its power so tremendous it disactivated yours!"
							M.Akametsuki=0;M.see_invisible=1;M.overlays-='Icons/Jutsus/SEyes.dmi'
							M.verbs-=/mob/Kyomou/verb/AkametsukiBlind;M.verbs-=/mob/Kyomou/verb/AkametsukiSearch;M.verbs-=/mob/Kyomou/verb/Rejuvanate
			sleep(50)
mob/proc/GoldenIlluminate()
	if(!src.Majest)
		src<<"You need Majestic Eyes on!";return
	else
		src<<"You focus your eyes to see chakra."
		src.IlluminateOff()
		src.ChakraSight(0)
		src.Illuminate()
		src.ChakraSight(1)
mob/proc/MajesticEyes()
	if(src.Majest)
		src<<"You release your Majestic Eyes.";usr.ChangeEyeStyle(usr.EyeStyle,usr.reye,usr.geye,usr.beye);src.Majest=0;src.ChakraSight(0);
		src.nin=src.Mnin;src.tai=src.Mtai;src.gen=src.Mgen;src.GenjutsuCounterMode=0
		for(var/obj/SkillCards/MajesticIlluminate/GG in src.LearnedJutsus)
			del(GG)
		return
	else
		usr.ChangeEyeStyle(usr.EyeStyle,255,215,0)
		src.LearnedJutsus+=new/obj/SkillCards/MajesticIlluminate
		if(src.MajesticMastery<1)
	//		src.Mchakra+=rand(3000,6000);
	//		src.chakra=src.Mchakra;
			src.MajesticMastery=1
			src << "<b><font color=#FFD700>Your eyes pulsate!</font></b>"
		if(src.MajesticMastery<200)
			view()<<"[src]'s eyes turn gold, revealing 1 ring around the pupil!"
		else if(src.MajesticMastery>=500)
			view()<<"[src]'s eyes turn pure gold, piercing your very soul!"
		else if(src.MajesticMastery>=300)
			view()<<"[src]'s eyes turn gold, revealing 3 rings around the pupil!"
		else if(src.MajesticMastery>=200)
			view()<<"[src]'s eyes turn gold, revealing 2 rings around the pupil!"
		src.Majest=1;
		src.ChakraSight(1)
		src.nin=src.Mnin*1.15
		src.tai=src.Mtai*1.15
		src.gen=src.Mgen*1.15
		if(src.MajesticMastery>=500)
			src.nin=src.Mnin*1.38
			src.tai=src.Mtai*1.22
			src.gen=src.Mgen*1.35
		while(src.Majest)
			var/A=src.MajesticMastery
			if(A<1) A=1
			if(A>200) src.GenjutsuCounterMode=1
			var/ChakraDrain=(src.Mchakra/(A*15))
			if(ChakraDrain>65) ChakraDrain=65
			if(ChakraDrain<5) ChakraDrain=1
		//	if(A>=500) ChakraDrain=0
			src.chakra-=ChakraDrain
			if(prob(1))
				src.MajesticMastery +=pick(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1)
			if(src.Charging&&prob(3))
				src.MajesticMastery +=pick(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1)
			sleep(25)
/*
mob/proc/MajesticEyes()
	if(src.Majest)
		src<<"You release your Majestic Eyes.";usr.ChangeEyeStyle(usr.EyeStyle,usr.reye,usr.geye,usr.beye);src.Majest=0;src.ChakraSight(0);
		src.nin=src.Mnin;src.tai=src.Mtai;src.gen=src.Mgen;src.GenjutsuCounterMode=0
		for(var/obj/SkillCards/MajesticIlluminate/Z in usr.LearnedJutsus)
			del(Z)
		return
	else
		usr.ChangeEyeStyle(usr.EyeStyle,255,215,0)
		if(src.MajesticMastery<1)
		//	src.Mchakra+=rand(3000,6000);src.chakra=src.Mchakra;
		/	src.MajesticMastery=1
			src << "<b><font color=#FFD700>Your eyes pulsate!</font></b>"
		if(src.MajesticMastery<200)
			view()<<"[src]'s eyes turn gold, revealing 1 ring around the pupil!"
		else if(src.MajesticMastery>=200&&src.MajesticMastery>100)
			view()<<"[src]'s eyes turn gold, revealing 2 rings around the pupil!"
		else if(src.MajesticMastery>=300)
			view()<<"[src]'s eyes turn gold, revealing 3 rings around the pupil!"
		src.Majest=1;src.ChakraSight(1)
		src.nin=src.Mnin*1.1
		src.tai=src.Mtai*1.1
		src.gen=src.Mgen*1.1
		src.LearnedJutsus+=new/obj/SkillCards/MajesticIlluminate
	//	if(src.MajesticMastery>=500)
	//		view()<<"[src]'s eyes turn pure gold, piercing your very soul!"
	//		src.nin=src.Mnin*1.38
	//		src.tai=src.Mtai*1.22
	//		src.gen=src.Mgen*1.35
		while(src.Majest)
			var/A=src.MajesticMastery
			if(A<1)
				A=1
			if(A>200)
				src.GenjutsuCounterMode=1
			var/ChakraDrain=(src.Mchakra/(A*15))
			if(ChakraDrain>65) ChakraDrain=65
			if(ChakraDrain<5) ChakraDrain=5
			if(A>=500) ChakraDrain=0
			src.chakra-=ChakraDrain
			if(prob(1))
				src.MajesticMastery +=pick(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1)
			if(src.Charging&&prob(3))
				src.MajesticMastery +=pick(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1)
			sleep(25)

*/





mob/Kyomou/verb/Rejuvanate()
	set category = "Doujutsu"
	set name = "Rejuvination"
	if(src.Rejuvination)
		return
	if(src.Akametsuki<1)
		src<<"You need to have Akametsuki on!";return
	else
		src.Rejuvination=1;spawn(10) src.Rejuvination=0
		for(var/mob/M in get_step(src,src.dir))
			if(!M.client||!src.client)
				return
			src.chakra-=100
			M<<"[usr] gives up their chakra to heal you!"
			usr<<"You give up your chakra to heal [M]!"
			M.health+=100;M.stamina+=100
			if(M.health>=M.maxhealth)
				M.health=M.maxhealth
			if(M.stamina>=M.maxstamina)
				M.stamina=M.maxstamina
			if(M.client&&M.Dead&&M.health>=M.maxhealth/2&&!PermDeath)
				M.Dead=0
				M.icon_state=""
				M.FrozenBind=""
				M.sight&=~(SEE_SELF|BLIND)
				orange(12,M)<<"<font size = 2>[M] was revived from the brink of death!</font>"

			return






mob/Kyomou/verb/AkametsukiBlind()
	set name="Akametsuki Blind"
	set category="Doujutsu"
	if(usr.AkametsukiBlind)
		return
	usr.Target()
	if(usr.ntarget)
		return
	var/mob/M=src.target
	if(!M.client)
		return
	if(M.Majest)

		src<<"A strange power overwhelms your eyes! Its power so tremendous it disactivated your Akametsuki!"
		src.Akametsuki=0;src.see_invisible=1;src.overlays-='Icons/Jutsus/SEyes.dmi'
		src.verbs-=/mob/Kyomou/verb/AkametsukiBlind;src.verbs-=/mob/Kyomou/verb/AkametsukiSearch;M.verbs-=/mob/Kyomou/verb/Rejuvanate
	for(var/obj/Makam/X in M.client.screen)
		del(X)
	var/obj/Makam/MM=new()
	M.client.screen+=MM
	usr.ChakraDrain(25000)
	usr<<"You blind [M] with a red vision!"
	if(usr.AkametsukiMastery>100)
		MM.icon_state="strong"
	usr.AkametsukiBlind=1;spawn(900)
		usr.AkametsukiBlind=0
	var/Z=usr.AkametsukiMastery*10
	if(Z>300)
		Z=300
	spawn(Z)
		for(var/obj/Makam/ZX in M.client.screen)
			del(ZX)




mob/Kyomou/verb/AkametsukiSearchOriginal()
	return
	/*
	set name="Akametsuki Search"
	set category="Doujutsu"
	if(usr.AkametsukiTrack)
		usr.AkametsukiTrack=0
		usr.firing=0
		usr.controlled=null
		usr.client.perspective=MOB_PERSPECTIVE
		usr.client.eye=usr
		for(var/mob/Kyomou/AkametsukiTrack/P in world) if(P.Owner == usr) del(P)
	else
		usr.firing=1
		var/mob/Kyomou/AkametsukiTrack/P=new()
		P.loc=locate(usr.x-1,usr.y,usr.z)
		P.Owner=usr
		usr.controlled = P
		usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
		usr.client.eye = P
		usr.AkametsukiTrack=1
		*/