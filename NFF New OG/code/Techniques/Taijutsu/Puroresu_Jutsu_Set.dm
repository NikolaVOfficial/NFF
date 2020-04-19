mob/proc/Lariat()//8-10k EXP first Jutsu
	if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.BrokenLegs)
		return
	else
		src.StaminaDrain(300);
		var/I=10
		while(I>=1)
			flick("Attack2",src);
			step(src,src.dir)
			if(prob(50))
				step(src,src.dir)
			for(var/mob/M in get_step(src,src.dir))
				I=0
			sleep(1)
			I--
		for(var/mob/M in get_step(src,src.dir))
			if((M.ReactionBelow&&prob(55)&&M.tai<src.tai)||(M.ReactionBelow&&prob(70)&&M.tai>=src.tai))
				M<<"You grab [src]'s leg as he flies at you and slam him into the ground face first!"
				src<<"[M] grabs your leg as you make contact with him and he slams your face into the ground!"
				if(M.tai<src.tai)
					M.StaminaDrain(100)
				else
					M.StaminaDrain(50)
				src.stamina-=(M.tai*2)
				src.Bloody();src.Bloody();src.Bloody()
				src.DamageProc(M.tai*2,"Health",M)
				if(M.ReactionBelowCounter&&prob(25))
					M<<"You managed to break [src]'s hand while you threw him down to the ground!"
					src<<"You can't feel your hands anymore!"
					src.BrokenLegs=1
					src.BrokenLegsTime=(M.tai*2)
				if(M.ReactionBelowCounter&&prob(25))
					M<<"Your face first impact managed to give [src] slight head trauma!"
					src<<"You feel a bit dizzy."
					src.DizzyProc(50)
				return
			flick("throw",src);
			var/damage=round(rand(src.tai*75,src.tai*100))
			if(src.Trait=="Powerful")
				damage*=1.25
			damage/=(M.Endurance/15)
			if(damage>2000)
				damage=2000
			if(!M.Mogu && !M.InHydro)
				if(damage>=1500)
					for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
						del(P)
				if(M.Kaiten|M.ingat|M.intank)
					spawn() src.HitBack(4,turn(src.dir,180))
					return
				if(M.sphere)
					viewers()<<sound('SFX/Guard.wav',0)
				else
					if(M.Guarding)
						viewers()<<sound('SFX/Guard.wav',0)
					else
						viewers()<<sound('SFX/HitStrong.wav',0)
					view(M)<<output("<font color=green size=2>[M] has been hit by Lariat!([damage])</font>","Attack")
					M.DamageProc(damage,"Stamina",src)
					spawn() M.HitBack(rand(5,10),src.dir)
					spawn()AttackEfx(M.x,M.y,M.z)
					//if(M.RaiArmor)
					//	src.DamageProc(100,"Health",M);src.HitBack(1,(src.dir-4))


mob/proc/Guillotine_Drop()//15k EXP Second Jutsu
	if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!="")
		return
	else
		var/mob/M
		for(var/mob/O in get_step(src,src.dir))
			M=O
			break
		if(!M)
			return
		flick("highkick",src);
		var/damage=round(rand(src.tai*90,src.tai*120));
		var/damage2=(damage*0.15)/100
		src.StaminaDrain(400)
		if(M.KagDance=="Karamatsu")
			src.health-=damage2
			src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
			if(M.Deflection)
				src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
			return
		damage/=(M.Endurance/10)
		if(!M.Mogu && !M.InHydro)
			if(damage>=1500)
				for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
					del(P)
			if(M.Kaiten|M.ingat|M.intank)
				spawn() src.HitBack(4,turn(src.dir,180))
				return
			if(M.sphere)
				viewers()<<sound('SFX/Guard.wav',0)
			else
				if(M.Guarding)
					viewers()<<sound('SFX/Guard.wav',0)
				else
					viewers()<<sound('SFX/HitStrong.wav',0)
				M.DamageProc(damage,"Stamina",src,"impact into the air!","green")
				M.RestrictOwnMovement=1
				spawn(7)
					M.RestrictOwnMovement=0
				M.dir=get_dir(M,src)
				spawn() M.HitBack(rand(5,6),src.dir)
				spawn() AttackEfx(M.x,M.y,M.z)
				spawn() AttackEfx(M.x,M.y,M.z)
				spawn() AttackEfx(M.x,M.y,M.z)
				spawn(7)
					var/turf/T=get_step(M,turn(M.dir,pick(90,-90)))
					if(!T.density)
						flick("zan",src)
						sleep(3)
						src.invisibility=99
						src.Frozen=1
						src.loc=T
						sleep(3)
						src.dir=get_dir(src,M)
						src.invisibility=1
						if(!M.Guarding)
							flick("crashingleg",src)
						//	spawn() M.HitBack(rand(5,10),src.dir)
							spawn() AttackEfx(M.x,M.y,M.z)
							spawn() AttackEfx(M.x,M.y,M.z)
							spawn() AttackEfx(M.x,M.y,M.z)
							M.DamageProc(damage*1.2,"Stamina",src,"Guillotine Drop!","green")
							src.Frozen=0
						src.Frozen=0

mob/proc/Oppression_Horrizontal_Chop()//3rd Taijutsu and 25k EXP
	if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.BrokenArms)
		return
	else
		src.Target()
		if(src.ntarget)
			return
		var/mob/m=src.target
		src.StaminaDrain(300)
		src.firing=1
		if(m.hyoushou)
			return
		else
			src.StaminaDrain(300)
			if(m.z!=src.z)
				spawn(10) src.firing=0
				return
			if(get_dist(src,m)>1)
				src<<"Your target is too far to use this attack!"
				src.firing=0
				return
			var/turf/T
			if(m.dir==NORTH) T=locate(m.x,m.y-1,m.z)
			if(m.dir==SOUTH) T=locate(m.x,m.y+1,m.z)
			if(m.dir==EAST) T=locate(m.x-1,m.y,m.z)
			if(m.dir==WEST) T=locate(m.x+1,m.y,m.z)
			if(m.dir==NORTHEAST) T=locate(m.x-1,m.y-1,m.z)
			if(m.dir==SOUTHEAST) T=locate(m.x-1,m.y+1,m.z)
			if(m.dir==NORTHWEST) T=locate(m.x+1,m.y-1,m.z)
			if(m.dir==SOUTHWEST) T=locate(m.x+1,m.y+1,m.z)
			if(T&&!T.density)
				src.loc=T
			flick("zan",src);
			src.dir=get_dir(src,m)
			if(prob(50))
				flick("Attack1",src)
			else
				flick("Attack2",src)
			src.buyou=1
			src.firing=1
			spawn(15)
				src.firing=0
				src.buyou=0
			for(var/mob/M in get_step(src,src.dir))
				if(M.InHydro)
					return
				if((M.ReactionAbove&&prob(55)&&M.tai<src.tai)||(M.ReactionAbove&&prob(70)&&M.tai>=src.tai))
					M<<"You grab [src]'s arm as they appear behind you and flip them over your head!"
					src<<"[M] grabs your arm as you appear behind them and they flip you over their head!"
					if(M.dir==NORTH) T=locate(M.x,M.y+1,M.z)
					if(M.dir==SOUTH) T=locate(M.x,M.y-1,M.z)
					if(M.dir==EAST) T=locate(M.x+1,M.y,M.z)
					if(M.dir==WEST) T=locate(M.x-1,M.y,M.z)
					if(M.dir==NORTHEAST) T=locate(M.x+1,M.y+1,M.z)
					if(M.dir==SOUTHEAST) T=locate(M.x+1,M.y-1,M.z)
					if(M.dir==NORTHWEST) T=locate(M.x-1,M.y+1,M.z)
					if(M.dir==SOUTHWEST) T=locate(M.x-1,M.y-1,M.z)
					if(T&&!T.density)
						src.loc=T
					if(M.tai<src.tai)
						M.StaminaDrain(100)
					else
						M.StaminaDrain(50)
					src.Status="Asleep"
					src.StatusEffected=(M.tai*1.5)
					src.stamina-=(M.tai*2)
					src.Bloody();src.Bloody();src.Bloody()
					src.DamageProc(M.tai*2,"Health",M)
					if(M.ReactionAboveCounter&&prob(25))
						M<<"You managed to break [src]'s arms while you threw him down to the ground!"
						src<<"You can't feel your arms anymore!"
						src.BrokenArms=1
						src.BrokenArmsTime=(M.tai*2)
					if(M.ReactionAboveCounter&&prob(25))
						M<<"Your face first impact managed to give [src] slight head trauma!"
						src<<"You feel a bit dizzy."
						src.DizzyProc(50)
						src.firing=0
					return
				if(!M.Mogu && !M.InHydro)
					src.DodgeCalculation(M)
					if(M.Dodging)
						M.Dodge();return
					if(M.Kaiten|M.ingat|M.intank)
						spawn()
							src.HitBack(4,(src.dir-4))
							src.firing=0
							src.buyou=0
						return
					if(M.intank|M.sphere||M.Mogu)
						viewers()<<sound('SFX/Guard.wav',0);
						src.firing=0
						src.buyou=0
						return
					else
						spawn()AttackEfx(M.x,M.y,M.z)
						var/damage=round(rand(usr.tai*35,usr.tai*60));var/Damage=(damage/(M.Endurance/12))/(M.BaikaCharged+1)
						if(Damage>1500)
							Damage=1500
					//	var/damage2=Damage*0.15
					//	if(M.KagDance=="Karamatsu")
					//		src.health-=damage2
					//		src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
					//		return
						if(M.Deflection)
							src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
							return
						if(Damage>=1500)
							for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
								del(P)
						if(src.Trait=="Powerful")
							Damage*=1.25
						if(M.Guarding)
							viewers()<<sound('SFX/Guard.wav',0)
						else
							viewers()<<sound('SFX/HitMedium.wav',0)
							flick("hit",M)
					//	view(M)<<output("<font color=green size=2>[M] has been hit by Lion Punch!([Damage])</font>","Attack")
						M.DamageProc(Damage,"Stamina",src);
						src.ExpGain(M,damage)
						spawn()
							M.HitBack(4,src.dir)
						flick("Attack2",src)
						step(src,src.dir)
						flick("Attack2",src)
						step(src,src.dir)
						flick("Attack2",src)
						step(src,src.dir)
						flick("Attack2",src)
						step(src,src.dir)
						view(M)<<output("<font color=green size=2>[M] has been hit by the Horizontal Chop!([Damage])</font>","Attack")
						src.firing=0
						src.buyou=0
						M.DamageProc(Damage,"Stamina",src)
						spawn()
							M.DamageProc(Damage,"Stamina",src)
						spawn()
							M.HitBack(rand(3,6),src.dir)
						if(M.RaiArmor)
							src.DamageProc(100,"Health",M);src.HitBack(1,(turn(src.dir,180)))


mob/proc/Liger_Bomb()//Last Technique 50k 1.2k Tai Knowledge
	if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!="")
		return
	else
		var/mob/M
		for(var/mob/O in get_step(src,src.dir))
			if(O.sphere||O.InHydro)
				return
			M=O
			break
		if(!M)
			return
		M.Frozen=1;M.firing=1;M.inchoke=1
		src.firing=1;src.choking=1;src.Frozen=1;src.inchoke=1
		src.icon_state = "throw"
		view(M) << "[src] picks [M] by the neck and begins lifting him into the air.."
		var/damage=round(src.tai)/(M.BaikaCharged+1)
		spawn(50)
			if(!M)
				return
			src.StaminaDrain(400)
			view(M) << "Liger Bomb!"
			spawn()
				Quake_Effect(M,5,1)
				M.CreateCrator()
		//	for(var/mob/C in oview(7))
		//		Quake_Effect(C,5,1)
			for(var/turf/T in oview(4,src))
				spawn()
					if(prob(17))
						T.CreateSmoke("Light")
			M.health-=damage
			M.stamina-=damage*rand(5,13)
			M.icon_state="dead"
			spawn(20)
				M.icon_state=""
				src.firing=0;src.choking=0;src.Frozen=0;src.inchoke=0;M.inchoke=0
				M.Frozen=0;M.firing=0
			src.icon_state = ""


			M.Death(src)


