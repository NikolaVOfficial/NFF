mob/var/tmp
	Rasenganon=0
	RasenganCharge=0
	RasenganD=0
	RasenganType=0
	DRasenganon=0
	DRasenganCounter=0
	RasenShurikenOn=0
/*Rasengan:
Chargeable move designed to destroy an opponent from spiraling damage.
*/


mob/proc/SpirallingSpheres()
	if(src.Rasenganon==1)
		src.ChakraDrain(40000)
		src<<"You utilize your Sage Mode Chakra and place some of it into your Rasengan, strengthening it!"
		var/b = rand(10,25)
		src.SageModeTime-=b
		src.NatureChakra-=b
		if(src.NatureChakra<=0)
			src.NatureChakra=0
		src.RasenganD*=(pick(1.5,2,2.5))
	else
		src<<"You Need Rasengan on in order to use this!"
mob/proc/Rasengan()
	if(src.intank|src.Kaiten|src.sphere|src.inso|src.firing|src.Rasenganon)
		return
	else
		src<<"Hold down Z to charge your Rasengan!";src.RasenganCharge=1;src.Rasenganon=1;src.RasenganType=0
		var/A='Icons/Jutsus/Rasengan2.dmi';src.overlays-=A;src.overlays+=A;flick("Power",A)
		while(src.Rasenganon)
			src.SoundEngine('SFX/RasCharge.wav',5,50)
			if(!src.RasenganCharge)
			//	src.RasenganD-=10
				src.RasenganD-=20
				for(var/obj/Jutsu/Kiriame/S2 in src.loc)
					src.RasenganD=0
				if(src.RasenganD<=0)
					if(src.DRasenganCounter>0)
						src.DRasenganCounter=0;src.overlays-='Icons/Jutsus/Rasengan4.dmi'
					src.overlays-='Icons/Jutsus/Rasengan2.dmi';src<<"Your Rasengan ran out of energy!";src.Rasenganon=0
			sleep(8)
mob/proc/DoubleRasengan()
	if(src.intank|src.Kaiten|src.sphere|src.inso|src.firing)
		return
	else
		if(src.Rasenganon&&!src.RasenganCharge)
			var/A='Icons/Jutsus/KatonRasengan.dmi'
			var/D='Icons/Jutsus/FuutonRasengan.dmi'
			src.overlays-='Icons/Jutsus/Rasengan5.dmi'
			src.overlays-='Icons/Jutsus/Rasengan6.dmi'
			var/B='Icons/Jutsus/Rasengan2.dmi'
			var/C='Icons/Jutsus/OdamaRasengan.dmi'
			var/E='Icons/Jutsus/Rasengan4.dmi'
			src.overlays-=B
			src.overlays+=B
			src.overlays-=A
			src.overlays-=D
			src.overlays-=C
			src.overlays+=E
			src<<"You add another Rasengan to your other hand!"
			src.DRasenganCounter=2
			src.SoundEngine('SFX/RasCharge.wav',7,75)
			src.RasenganType=50
			src.RasenganD=(src.RasenganD/1.25)//src.RasenganD*2
/*Giant Rasengan:
Increases the size of the current Rasengan causing it to do massive damage.
*/
mob/proc/Giant_Rasengan()
	if(src.intank|src.Kaiten|src.sphere|src.inso|src.firing)
		return
	else
		if(src.Rasenganon&&!src.RasenganCharge)
			src.ChakraDrain(75000)
			var/A='Icons/Jutsus/KatonRasengan.dmi'
			var/D='Icons/Jutsus/FuutonRasengan.dmi'
			src.overlays-='Icons/Jutsus/Rasengan5.dmi'
			var/B='Icons/Jutsus/Rasengan2.dmi'
			var/C='Icons/Jutsus/OdamaRasengan.dmi'
			var/E='Icons/Jutsus/Rasengan4.dmi'
			src.overlays-=B
			src.overlays-=A
			src.overlays-=D
			src.overlays-=E
			src.overlays+=C
			src<<"The size of your Rasengan doubles in size!"
			src.SoundEngine('SFX/RasCharge.wav',7,75)
			src.RasenganType+=0.5
			src.RasenganD=src.RasenganD*2



/*Fire Rasengan:
Fire based version.
*/
mob/proc/KRasengan()
	if(src.intank|src.Kaiten|src.sphere|src.inso|src.firing|src.Rasenganon)
		return
	else
		src<<"Hold down Z to charge your Rasengan!";src.RasenganCharge=1;src.RasenganType=100;src.Rasenganon=1;
	//	var/A='Icons/Jutsus/KatonRasengan.dmi';
	//	src.overlays-=A;
	//	src.overlays+=A;
	//	flick("Power",A)
		src.overlays-='Icons/Jutsus/Rasengan6.dmi'
		src.overlays+='Icons/Jutsus/Rasengan6.dmi'
		while(src.Rasenganon)
			src.SoundEngine('SFX/RasCharge.wav',100)
			if(!src.RasenganCharge)
//				src.RasenganD-=10
				src.RasenganD-=20
				for(var/obj/Jutsu/Kiriame/S2 in src.loc)
					src.RasenganD=0
				if(src.RasenganD<=0)
					src.overlays-='Icons/Jutsus/KatonRasengan.dmi';
					src.overlays-='Icons/Jutsus/Rasengan6.dmi'
					src<<"Your Rasengan ran out of energy!";
					src.Rasenganon=0
			sleep(8)
/*
/*Wind Rasengan:
Wind based version.
*/
*/
mob/proc/WRasengan()
	if(src.intank|src.Kaiten|src.sphere|src.inso|src.firing|src.Rasenganon)
		return
	else
		src<<"Hold down Z to charge your Rasengan!";src.RasenganCharge=1;src.RasenganType=200;src.Rasenganon=1;var/A='Icons/Jutsus/Rasengan5.dmi';src.overlays-=A;src.overlays+=A;flick("Power",A)
		while(src.Rasenganon)
			src.SoundEngine('SFX/RasCharge.wav',50)
			if(!src.RasenganCharge)
			//	src.RasenganD-=10
				src.RasenganD-=20
				for(var/obj/Jutsu/Kiriame/S2 in src.loc)
					src.RasenganD=0
				if(src.RasenganD<=0)
				//	src.overlays-='Icons/Jutsus/FuutonRasengan.dmi';
					src.overlays-='Icons/Jutsus/Rasengan5.dmi'
					src<<"Your Rasengan ran out of energy!";
					src.Rasenganon=0
			sleep(8)

obj
	Jutsu
		RasenShurikenThrow
			icon='Icons/Jutsus/Rasenshuriken.dmi'
			icon_state="Throw"
			density=1
			Move_Delay=0
			pixel_step_size=16
			var/nin=10;
			Move()
				var/PrevLoc=src.loc
				var/obj/Jutsu/RasenShurikenMove/P=new()
				P.loc=PrevLoc
				..()
			Bump(A)
				..()
				if(ismob(A))
					var/mob/E=src.Owner
					var/mob/P=A
					if(!P.knockedout)
						E.RasenShurikenProc(A)
						del(src)
				if(istype(A,/turf/))
					var/turf/B=A
					src.loc=B
				if(isobj(A))
					var/obj/O=A
					src.loc=O.loc
					return
			Del()
				..()
		RasenShurikenMove
			icon='Icons/Jutsus/Rasenshuriken2.dmi'
			icon_state="Throw"
			Move_Delay=0
			pixel_step_size=16
			New()
				..()
				spawn(5)
					del(src)

mob/proc/RasenShuriken()
	src.ChakraDrain(15000)
	src.Handseals(1)
	if(src.HandsSlipped) return
	var/mob/Clones/Clone/A=new();
	var/obj/SmokeCloud/S=new()
	var/mob/Clones/Clone/AA=new();
	var/obj/SmokeCloud/SS=new()
	A.name="[src.name]";
	A.Owner=src;
	A.Clone=1;
	A.Running=1
	A.icon=src.icon;
	A.overlays+=src.overlays
	A.icon_state="running"
	A.CloneType="Rasenshuriken"
	A.density=1
	A.loc=get_step(src,turn(src.dir,90))
	S.loc=locate(A.x,A.y,A.z)
	A.dir=turn(src.dir,270)
	//
	AA.name="[src.name]";
	AA.Owner=src;
	AA.Clone=1;
	AA.Running=1
	AA.icon=src.icon;
	AA.overlays+=src.overlays
	AA.icon_state="running"
	AA.CloneType="Rasenshuriken"
	AA.density=1
	AA.loc=get_step(src,turn(src.dir,-90))
	SS.loc=locate(AA.x,AA.y,AA.z)
	AA.dir=turn(src.dir,-270)
	src<<"Your clones begin to provide your chakra with shape manipulation and nature transformation...This will take some time.."
	var/TimeUntilRasenS=0
	var/RasenCreated=0
	while(TimeUntilRasenS<30&&AA&&A&&!src.knockedout)
		src.icon_state="throw"
		if(src.SageMode=="Toad")
			TimeUntilRasenS+=4
		if(TimeUntilRasenS>=14)
			RasenCreated=1
		if(prob(40))
			flick("Attack1",A)
		else if(prob(40))
			flick("Attack2",A)
		if(prob(40))
			flick("Attack1",AA)
		else if(prob(40))
			flick("Attack2",AA)
		TimeUntilRasenS++
		sleep(5)
	if(RasenCreated)
//		src<<"Sasna da best."
		src.overlays-='Icons/Jutsus/Rasenshuriken.dmi'
		src.overlays+='Icons/Jutsus/Rasenshuriken.dmi'
		view()<<"The ground shakes and cracks as [src] holds within their grasp a large body of chakra resembling a fuuma shuriken..."
//		Quake_Effect(mob/M,duration,strength=1)
		spawn()
			src.CreateCrator()
//		src.firing=1
		src.RasenShurikenOn=1
		src.Rasenganon=1
		for(var/turf/T in oview(4,src))
			spawn()
				if(prob(20))
					T.CreateSmoke("Light")
		Quake_Effect(src,15,1)
		spawn(20)
			del(A)
			del(AA)
	else
		src<<"You failed to add the proper shape manipulation and nature transformation for the jutsu..."
		del(A)
		del(AA)




mob/proc/RasenShurikenProc(mob/M)
	if(!M)
		return
	Quake_Effect(M,20,3)
	src.overlays-='Icons/Jutsus/Rasenshuriken.dmi'
	var/damage=rand(20,30)*rand((src.GenSkill+src.NinSkill))
	if(M.sphere)
		view() << "<i><font size = 2>[src] has pierced through [M]'s defence!</font></i>"
		M.FrozenBind="";M.firing=0;M.sphere=0;M.usingS=0
		M.overlays -= /obj/Jutsu/Sand/Sphere
	damage=(damage/M.Endurance)
//	if(damage>15000)
//		damage=15000
	src.RasenShurikenOn=0
	view() << "<i><font size = 2 color = #007ba7>[src] hit [M] with their Rasen Shuriken for [damage] damage!</font></i>"
	M.adir=src.dir
	var/image/I = image('Icons/Jutsus/Rasenshuriken.dmi',M,"overlay")
	for(var/mob/P in range(10,M))
		P << I
//		spawn(30) del(I)
	M.Stun=0
	spawn()
		M.DamageProc(damage/5,"Stamina",src)
		M.Bloody()
	spawn()
		M.DamageProc(damage/5,"Stamina",src)
		M.Bloody()
	spawn()
		M.DamageProc(damage/5,"Stamina",src)
		M.Bloody()
	spawn()
		M.DamageProc(damage/5,"Stamina",src)
		M.Bloody()
	M.Running=1
	M.icon_state = "rasenganhit";
	M.HitBack(rand(20,30),src.dir)
	src.overlays-='Icons/Jutsus/Rasenshuriken.dmi'
	src.overlays-='Icons/Jutsus/Rasengan2.dmi'
	src.overlays-='Icons/Jutsus/OdamaRasengan.dmi'
	src.overlays-='Icons/Jutsus/KatonRasengan.dmi'
	src.overlays-='Icons/Jutsus/FuutonRasengan.dmi'
	src.overlays-='Icons/Jutsus/Rasengan5.dmi'
	src.overlays-='Icons/Jutsus/Rasengan6.dmi'
//	src.firing=0
	spawn(25)
	//	del(I)
		for(var/turf/T in oview(6,M))
			spawn()
				if(prob(20))
					var/obj/Jutsu/C3Explosion/KE=new()
					KE.Owner=src
					KE.loc=T
		var/obj/Jutsu/C3Explosion/K=new();
		K.loc=M;
		K.Owner=src
		M.deathcount++
		damage=rand(200,400)
		M.DamageProc(damage,"Health",src)
		del(I)
//	return



mob/proc/RasenShurikenThrowProc()
//	world<<"RasenShurikenThrowProc called."
	src.overlays-='Icons/Jutsus/Rasenshuriken.dmi'
	src.RasenShurikenOn=0
	src.Rasenganon=0
	var/obj/Jutsu/RasenShurikenThrow/F=new();
	F.loc=src.loc;
	F.Owner=src;
	F.dir=src.dir;
	walk(F,F.dir)








