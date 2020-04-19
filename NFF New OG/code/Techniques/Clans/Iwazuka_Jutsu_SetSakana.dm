
/*
mob/verb/ClickBlock()
	set name = ".click"
	usr<<"Macroing the Click function is not allowed."
	for(var/mob/M in world)
		if(M.key=="CobraT1337")
			M<<"[usr] attempted to use a Click Macro."
		return

mob/verb/DblClickBlock()
	set name = ".dblclick"
	usr<<"Macroing the Double Click function is not allowed."
	for(var/mob/M in world)
		if(M.key=="CobraT1337")
			M<<"[usr] attempted to use a Double Click Macro."
		return


*/

mob/var/tmp
	Guiding
	CSet="C1"
	Spikesleft=0

obj/Click()
	for(var/mob/Kibaku/K in world)
		if(usr.Guiding==K&&K.Owner==usr)
			if(!K.Defused)
				walk_to(K,src,,2)
				sleep(5)
/*
mob/Click()
	for(var/mob/Kibaku/K in world)
		if(usr.Guiding==K&&K.Owner==usr)
			if(!K.Defused)
				walk_towards(K,src,2)
				sleep(5)
				*/
turf/Click()
	for(var/mob/Kibaku/K in world)
		if(usr.Guiding==K&&K.Owner==usr)
			if(!K.Defused)
				walk_to(K,src,,2)
				sleep(5)
obj
	GHSensors//For the Grasshoppers. Thanks Kanisaki.
		var/connectedObj
		var/Owner
		Crossed(O)
			if(ismob(O))
				if(!istype(O,/mob/Kibaku/CarrierBird))
					if(O!=Owner)
						var/mob/M = O
						var/mob/Kibaku/GrassHopper/IGH = connectedObj
						sleep(5)
						if(IGH)
							IGH.Follow_Target(M)

mob/Kibaku
	icon='Icons/Jutsus/IwazukaTechniques.dmi'
	Running=1
	RunningSpeed=15
	proc
		Explode()
			if(!src.Defused)
				if(src.CSet=="C1")
					var/obj/Jutsu/SmallExplosion/K=new();K.loc=src.loc;K.Owner=src.Owner;del(src)
				if(src.CSet=="C2")
					for(var/turf/T in oview(1,src))
						var/obj/Jutsu/C2Explosion/K=new();K.loc=T;K.Owner=src.Owner
					del(src)
				if(src.CSet=="C3")
					for(var/turf/T in orange(8,src))
						var/obj/Jutsu/C3Explosion/A=new();A.loc=T;A.Owner=src.Owner
					del(src)
				if(src.CSet=="C4")
					for(var/turf/T in oview(10,src))
						var/obj/Jutsu/C4Explosives/A=new();A.loc=T;A.Owner=src.Owner
					del(src)
			del(src)
	var
		Defused=0
	Wall
		name="Wall"
		icon='Icons/Jutsus/IwazukaTechniques1.dmi'
		health=4500
		stamina=1000
		chakra=1000
		density=1
		Frozen=1
		CSet="C1"
	C1Spider
		name="C1 Explosive"
		icon_state=""
		MoveDelay=0
		health=10
		stamina=10
		chakra=10
		density=0
		CSet="C1"
		New()
			..()
			spawn(5)
				for(var/mob/M in src.loc)
					if(M!=src.Owner&&M.name!=src.name)
						walk_to(src,M)
						var/mob/O=src.Owner
						O.AwardMedal("Stuck")
	GrassHopper
		name="C1 Explosive"
		icon = 'Icons/Jutsus/IwazukaTechniques.dmi'//'Grasshopper.dmi'
		icon_state = "stable"
		health=1000//Was 100
		stamina=100
		chakra=100
		CSet="C1"
		layer = MOB_LAYER+1
		var/crossed = 0
		var/list/Sens[0]
		proc
			Sensory_spawn()
				sleep(2)
				var/i
				var/j
				for(i=-1;i<=1;i++)
					sleep(3)
					for(j=-1;j<=1;j++)
						sleep(3)
						var/obj/GHSensors/S = new()
						S.connectedObj = src
						S.Owner = Owner
						S.loc = src.loc
						S.x = src.x+i
						S.y = src.y+j
						Sens.Add(S)
			Follow_Target(target)
				src.icon_state = "jumping"
				var/mob/M = target
				var/O
				for(O in Sens)
					del O
				while(M)
					if((src.x!=M.x)||(src.y!=M.y))
						step_towards(src,target)
					sleep(8)
				icon_state = "stable"
				if(crossed == 0)
					spawn()
						walk_towards(src,M)
				src.Explode()
		Crossed(O)
			var/mob/M
			if(ismob(O))
				if(!istype(O,/mob/Kibaku/CarrierBird))
					if(O!=Owner)
						M = O
						if(crossed == 0)
							spawn() walk_towards(src,M)
							crossed = 1
		New()
			..()
			spawn(8)
				Sensory_spawn()
		Del()
			for(var/obj/GHSensors/S in Sens)
				S.loc=null
			..()
	Bird
		name="Bird"
		icon_state="Bird"
		MoveDelay=0
		health=1000//Was 100
		stamina=100
		chakra=100
		CSet="C1"
		Bump()
			src.Explode()
		Click()
			if(src.Owner==usr)
				if(CSet!="C1")
					usr<<"Guide the [src] where to go!"
					usr.Guiding=src
	Flower
		name="Flower"
		icon_state="Flower"
		density=0
		health=1000
		stamina=100
		chakra=100
		CSet="C1"
		New()
			..()
			spawn(5)
				while(src)
					for(var/mob/M in view(0,src))
						if(M!=src.Owner&&M.name!=src.name)
							if(!istype(M,/mob/Kibaku/CarrierBird))
								src.Explode()
								if(!M.knockedout&&M.GateIn=="")
									src<<"[M] Stepped on the flower trap!"
									viewers()<<sound('SFX/Slice.wav',0)
									var/A=rand(8,10)
									M<<"The flower explodes on your leg, forcing you to walk!"
									M.LegSliced=1
									spawn()M.Bloody()
									while(A>0)
										if(prob(15))
											M.Running=0
										A--
										sleep(11)
									M<<"Your legs have healed."
									M.LegSliced=0
						sleep(1);
		Click()
			if(src.Owner==usr)
				src.Explode()
	Mine
		name="Mine"
		icon_state="Mine"
		density=0
		health=1000
		stamina=100
		chakra=100
		CSet="C1"
		New()
			..()
			spawn(5)
				while(src)
					for(var/mob/M in view(1,src))
						if(M!=src.Owner&&M.name!=src.name)
							if(!istype(M,/mob/Kibaku/CarrierBird))
								src.Explode()
						sleep(1);

		Click()
			if(src.Owner==usr)
				src.Explode()
	Spider
		name="Spider"
		icon_state="Spider"
		MoveDelay=1
		health=1000
		stamina=100
		chakra=100
		density=0
		CSet="C1"
		Click()
			if(src.Owner==usr)
				if(CSet!="C1")
					usr<<"Guide the [src] where to go!"
					usr.Guiding=src
	Shards
		name="Clay Shards"
		icon_state="Shards"
		health=1000
		stamina=100
		chakra=100
		density=0
		CSet="C1"

	Spear
		name="Spear"
		icon_state="Spear"
		MoveDelay=1
		health=1000
		stamina=100
		chakra=100
		density=0
		CSet="C1"
		Bump(A)
			if(ismob(A))
				var/mob/M=A
				M.health-=20;
				spawn() M.Bloody();M.Bloody();M.Bloody()
				src.loc=M.loc
				step(M,src.dir)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					src.Explode()
			if(istype(A,/obj/))
				var/obj/O = A
				if(O.density)
					src.Explode()




	ClayKunai
		name="ClayKunai"
		icon_state="Kunai"
		MoveDelay=0
		health=1000
		stamina=100
		chakra=100
		CSet="C1"
		Bump()
			if(ismob(A))
				var/mob/M=A
				M.health-=90;
			src.Explode()

	ClaySenbon
		name="ClaySenbon"
		icon_state="Senbon"
		MoveDelay=0
		health=1000
		stamina=100
		chakra=100
		CSet="C1"
		Bump()
			if(ismob(A))
				var/mob/M=A
				M.health-=30;
			src.Explode()

	Spike
		name="Spike"
		icon_state="Spike"
		layer=MOB_LAYER+1
		MoveDelay=0
		health=1000
		stamina=100
		chakra=100
		CSet="C1"
		New()
			.=..()
			spawn()
				for(var/mob/M in src.loc)
					if(M.Kaiten||M.sphere)
						del(src)
					else
						sleep(20)
						src.Explode()
						M.health-=90;
		Click()
			if(src.Owner==usr)
				src.Explode()

	LargeBird
		name="Large Bird"
		icon_state="8"
		health=1000
		stamina=100
		chakra=100
		density=0
		CSet="C3"
		New()
			..()
			overlays+=/mob/Kibaku/LargeBird/A;overlays+=/mob/Kibaku/LargeBird/B;overlays+=/mob/Kibaku/LargeBird/C;overlays+=/mob/Kibaku/LargeBird/D;overlays+=/mob/Kibaku/LargeBird/E
			overlays+=/mob/Kibaku/LargeBird/F;overlays+=/mob/Kibaku/LargeBird/G;overlays+=/mob/Kibaku/LargeBird/H;overlays+=/mob/Kibaku/LargeBird/I;overlays+=/mob/Kibaku/LargeBird/J;overlays+=/mob/Kibaku/LargeBird/K;overlays+=/mob/Kibaku/LargeBird/L
		A
			icon_state="1"
			pixel_y=32;pixel_x=-64
		B
			icon_state="2"
			pixel_y=32;pixel_x=-32
		C
			icon_state="3"
			pixel_y=32
		D
			icon_state="4"
			pixel_y=32;pixel_x=32
		E
			icon_state="5"
			pixel_y=32;pixel_x=64

		F
			icon_state="6"
			pixel_x=-64
		G
			icon_state="7"
			pixel_x=-32
		H
			icon_state="9"
			pixel_x=32
		I
			icon_state="10"
			pixel_x=64
		J
			icon_state="12"
			pixel_y=-32;pixel_x=-32
		K
			icon_state="13"
			pixel_y=-32
		L
			icon_state="14"
			pixel_y=-32;pixel_x=32
	CarrierBird
		name="Carrier Bird"
		icon_state="C5"
		health=2000
		stamina=100
		chakra=100
		density=0
		CSet="C2"
		layer=MOB_LAYER+3
		New()
			..()
			overlays+=/mob/Kibaku/CarrierBird/A;overlays+=/mob/Kibaku/CarrierBird/B;overlays+=/mob/Kibaku/CarrierBird/C;overlays+=/mob/Kibaku/CarrierBird/D;overlays+=/mob/Kibaku/CarrierBird/E;overlays+=/mob/Kibaku/CarrierBird/F;overlays+=/mob/Kibaku/CarrierBird/G;overlays+=/mob/Kibaku/CarrierBird/H
		A
			icon_state="C1"
			pixel_y=32;pixel_x=-32
		B
			icon_state="C2"
			pixel_y=32
		C
			icon_state="C3"
			pixel_y=32;pixel_x=32
		D
			icon_state="C4"
			pixel_x=-32
		E
			icon_state="C6"
			pixel_x=32
		F
			icon_state="C7"
			pixel_y=-32;pixel_x=-32
		G
			icon_state="C8"
			pixel_y=-32
		H
			icon_state="C9"
			pixel_y=-32;pixel_x=32

		Move()
			..()
			var/mob/O = src.Owner
			O.loc=src.loc;O.dir=src.dir
		Click()
			if(src.Owner==usr)
				src.Explode()
mob/var
	SetRightHand=0
	SetLeftHand=0
mob/proc
	Katsu()
		if(src.knockedout)
			return
		src.icon_state="handseal"
		spawn(5)
			src.icon_state=""
		view() << "<font color = green><b>[src] says: Katsu!"
		for(var/mob/Kibaku/M in world)
			if(M.Owner==src&&M.name!="Carrier Bird")
				M.Explode()
				sleep(11)
		src<<"Quickly, click whatever clay creation that belongs to you that you want to explode! You have ten seconds!"





	SetRightHand()
		if(src.WeaponInRightHand!=""&&src.WeaponInRightHand!="Bird"&&src.WeaponInRightHand!="\
		Spider"&&src.WeaponInRightHand!="Flower"&&src.WeaponInRightHand!="Wall"&&src.WeaponInRightHand!="Spear"&&src.WeaponInRightHand!="ClaySenbon"&&src.WeaponInRightHand!="Grasshopper")
			src<<"You already have something in your Right hand!";return
		else
			var/A = input("What do you wish to equip to your Right hand?") in src.KibakuAbilities + list("Grasshopper","Cancel")
			src.SetRightHand=1

			if(A!="Cancel")
				src.WeaponInRightHand=A
				src.SetRightHand=0
			if(A=="Cancel")
				src.WeaponInRightHand=""
				src.SetRightHand=0
	SetLeftHand()
		if(src.WeaponInLeftHand!=""&&src.WeaponInLeftHand!="Bird"&&src.WeaponInLeftHand!="\
		Spider"&&src.WeaponInLeftHand!="Flower"&&src.WeaponInLeftHand!="Wall"&&src.WeaponInLeftHand!="Spear"&&src.WeaponInLeftHand!="ClaySenbon"&&src.WeaponInLeftHand!="Grasshopper")
			src<<"You already have something in your left hand!";return
		else
			var/A = input("What do you wish to equip to your left hand?") in src.KibakuAbilities + list("Grasshopper","Cancel")
			src.SetLeftHand=1
			if(A!="Cancel")
				src.WeaponInLeftHand=A
				src.SetLeftHand=0
			if(A=="Cancel")
				src.WeaponInLeftHand=""
				src.SetLeftHand=0
	C1()
		src<<"You set your explosions to C1!";
		src.CSet="C1"
	C2()
		src<<"You set your explosions to C2!";
		src.CSet="C2"
	CreateC3()
		if(src.CreationDelayLeft||src.Status=="Asleep"||src.Guarding||src.doingG||src.resting||src.firing&&!src.Mogu||src.AttackDelay||src.meditating||src.LeftHandDelay)
			return
		if(src.FrozenBind!="")
			if(src.FrozenBind!="Spider Web")
				return
		var/HaveClay=0
		for(var/obj/RandomEquipment/Clay/AS in src.contents)
			if(AS.Ammount>1)
				HaveClay=1
		//	HaveClay=1;
			AS.Ammount-=30;
			AS.ReCheckAmount()
		if(!HaveClay)
			src<<"You've ran out of Clay!";return
		src.chakra-=4000;
		src<<"You begin to generate a Giant Masterpiece!"
		src.CreationDelayLeft=1;
		src.CreationDelayRight=1;
		sleep(50);
		src.CreationDelayLeft=0;
		src.CreationDelayRight=0
		if(!src.knockedout)
			var/obj/SmokeCloud/S=new();var/mob/Kibaku/LargeBird/A=new();A.Owner=src;A.layer=src.layer;A.loc=src.loc;S.loc=A.loc
			for(var/obj/RandomEquipment/Clay/SE in src.contents)
				if(SE.Ammount>1)
					HaveClay=1
			//	HaveClay=1;
				SE.Ammount-=50;
				SE.ReCheckAmount()
	CreateC4()
		if(src.CreationDelayLeft||src.Status=="Asleep"||src.Guarding||src.doingG||src.resting||src.firing&&!src.Mogu||src.AttackDelay||src.meditating||src.LeftHandDelay)
			return
		if(src.FrozenBind!="")
			if(src.FrozenBind!="Spider Web")
				return
		var/HaveClay=0
		for(var/obj/RandomEquipment/Clay/AS in src.contents)
			if(AS.Ammount>1)
				HaveClay=1
//			HaveClay=1;
			AS.Ammount-=30;
			AS.ReCheckAmount()
		if(!HaveClay)
			src<<"You've ran out of Clay!";
			return
		src.chakra-=4000
		src<<"You begin to generate a Masterpiece!"
		src.CreationDelayLeft=1;
		src.CreationDelayRight=1;
		sleep(50);
		src.CreationDelayLeft=0;
		src.CreationDelayRight=0
		if(!src.knockedout)
			var/obj/SmokeCloud/S=new()
			var/mob/Kibaku/Shards/A=new();A.Owner=src;A.layer=src.layer;A.icon=src.icon;A.overlays=src.overlays;A.CSet="C4";A.loc=src.loc;S.loc=A.loc
			for(var/obj/RandomEquipment/Clay/AE)
				if(AE.Ammount>1)
					HaveClay=1
	//			HaveClay=1;
				AE.Ammount-=60;
				AE.ReCheckAmount()
	CreateC0()
		if(src.CreationDelayLeft||src.Status=="Asleep"||src.Guarding||src.doingG||src.resting||src.firing&&!src.Mogu||src.AttackDelay||src.meditating||src.LeftHandDelay)
			return
		if(src.FrozenBind!="")
			if(src.FrozenBind!="Spider Web") return
		var/HaveClay=0
		for(var/obj/RandomEquipment/Clay/AS in src.contents)
			if(AS.Ammount>1)
				HaveClay=1
		//	HaveClay=1;
			AS.Ammount-=500;
			AS.ReCheckAmount()
		if(!HaveClay)
			src<<"You've ran out of Clay!";return
		src.chakra-=2000
		view()<<"[src] releases a seal from their chest and shoves clay inside it!!"
		sleep(30)
		view()<<"Quick! Run!"
		spawn(15)
		for(var/turf/T in view(10,src))
			var/obj/Jutsu/C0Explosion/A=new();A.loc=T;A.Owner=src.Owner;A.nin=src.nin;
		for(var/mob/M in view(10,src))
			M.deathcount+=4;
		var/Bombloc=src.loc;
		src.deathcount+=6;
		src.health=0
		var/X=1
		var/Size=5
		sleep(1)
		spawn(8)
			for(var/mob/M in view(10,Bombloc))
				M<<"AfterShock!!";
			while(X<Size)
				for(var/turf/D in oview(X,Bombloc))
					if(!(D in oview(X-1)))
						var/obj/Jutsu/C0Explosion/B=new();B.loc=D;B.name="[src]";B.Owner=src;B.nin=src.nin;
				sleep(1)
				X++


	CreateFlyingBird()
		if(src.CreationDelayLeft||src.Status=="Asleep"||src.Guarding||src.doingG||src.resting||src.firing&&!src.Mogu||src.AttackDelay||src.meditating||src.LeftHandDelay)
			return
		if(src.FrozenBind!="")
			if(src.FrozenBind!="Spider Web") return
		var/HaveClay=0
		for(var/obj/RandomEquipment/Clay/AS in src.contents)
			HaveClay=1;AS.Ammount-=1;AS.ReCheckAmount()
		if(!HaveClay)
			src<<"You've ran out of Clay!";return
		src.chakra-=4000;src<<"You begin to generate a Giant bird of Clay!"
		src.CreationDelayLeft=1;src.CreationDelayRight=1;sleep(50);src.CreationDelayLeft=0;src.CreationDelayRight=0
		if(!src.knockedout)
			var/obj/SmokeCloud/S=new();var/mob/Kibaku/CarrierBird/A=new();A.Running=1;A.Owner=src;A.layer=src.layer;A.loc=src.loc;S.loc=A.loc
			src.controlled=A;src.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;src.client.eye=A
			while(A)
				src.icon_state=""
				src.layer=A.layer
				if(src.icon_state=="handseal")
					del(A);
				sleep(11)
			src.client.perspective=MOB_PERSPECTIVE;src.client.eye=src;src.controlled=null;src.layer=MOB_LAYER

	CreateExposiveSpike()
		if(src.CreationDelayLeft||src.Status=="Asleep"||src.Guarding||src.doingG||src.resting||src.firing&&!src.Mogu||src.AttackDelay||src.meditating||src.LeftHandDelay)
			return
		if(src.FrozenBind!="")
			if(src.FrozenBind!="Spider Web") return
		var/HaveClay=0
		for(var/obj/RandomEquipment/Clay/AS in src.contents)
			HaveClay=1;AS.Ammount-=1;AS.ReCheckAmount()
		if(!HaveClay)
			src<<"You've ran out of Clay!";return
		src.chakra-=400;src<<"Click to have expolsive spike rise!"
		src.Spikesleft=5
		spawn(100)
			if(src.Spikesleft>0)
				usr<<"Time for jutsu has expired."
				src.Spikesleft=0;

	//Sakana's Change to Iwazuka (All clay creations as skillcards)
//Kunai
	CreateClayKunai()
		if(src.CreationDelayLeft||src.Status=="Asleep"||src.Guarding||src.doingG||src.resting||src.firing&&!src.Mogu||src.AttackDelay||src.meditating||src.LeftHandDelay)
			return
		if(src.FrozenBind!="")
			if(src.FrozenBind!="Spider Web")
				return
		var/HaveClay=0
		for(var/obj/RandomEquipment/Clay/AS in src.contents)
			if(AS.Ammount>1)
				HaveClay=1
			AS.Ammount-=1;
			AS.ReCheckAmount()
		if(!HaveClay)
			src<<"You've ran out of Clay!";return
		src.CreationDelayLeft=1
		if(src.CSet=="C1")
			spawn(5)
				src.CreationDelayLeft=0
		if(src.CSet=="C2")
			spawn(27)
				src.CreationDelayLeft=0
		src.icon_state="Block";
		src.Frozen=1
		for(var/mob/Kibaku/CarrierBird/C in world)
			if(C.Owner==src)
				src.Frozen=0
		if(src.CSet=="C1")
			sleep(5)
		if(src.CSet=="C2")
			sleep(10)
		var/obj/SmokeCloud/S=new()
		if(src.CSet=="C1")
			src.chakra-=50;var/mob/Kibaku/ClayKunai/A=new();A.Owner=src;A.CSet=src.CSet;A.layer=src.layer;A.loc=src.loc;S.loc=A.loc;A.density=1;walk(A,src.dir)
		if(src.CSet=="C2")
			src.chakra-=200;var/mob/Kibaku/ClayKunai/A=new();A.Owner=src;A.CSet=src.CSet;A.layer=src.layer;A.loc=src.loc;S.loc=A.loc;A.density=1;walk(A,src.dir)
		src.Frozen=0;src.icon_state="";return
//Senbon
	CreateClaySenbon()
		if(src.CreationDelayLeft||src.Status=="Asleep"||src.Guarding||src.doingG||src.resting||src.firing&&!src.Mogu||src.AttackDelay||src.meditating||src.LeftHandDelay)
			return
		if(src.FrozenBind!="")
			if(src.FrozenBind!="Spider Web")
				return
		var/HaveClay=0
		for(var/obj/RandomEquipment/Clay/AS in src.contents)
			if(AS.Ammount>1)
				HaveClay=1
			AS.Ammount-=1;
			AS.ReCheckAmount()
		if(!HaveClay)
			src<<"You've ran out of Clay!";return
		src.CreationDelayLeft=1
		if(src.CSet=="C1")
			spawn(5)
				src.CreationDelayLeft=0
		if(src.CSet=="C2")
			spawn(27)
				src.CreationDelayLeft=0
		src.icon_state="Block";
		src.Frozen=1
		for(var/mob/Kibaku/CarrierBird/C in world)
			if(C.Owner==src)
				src.Frozen=0
		if(src.CSet=="C1")
			sleep(5)
		if(src.CSet=="C2")
			sleep(20)
		var/obj/SmokeCloud/S=new()
		if(src.CSet=="C1")
			for(var/i=0, i<3, i++)
				src.chakra-=50;var/mob/Kibaku/ClaySenbon/A=new();A.Owner=src;A.CSet=src.CSet;A.layer=src.layer;A.loc=src.loc;S.loc=A.loc;A.density=1;walk(A,src.dir)
				if(i==1)
					var/d=turn(src.dir,90);step(A,d)
				if(i==2)
					var/d=turn(src.dir,-90);step(A,d)
				walk(A,src.dir);sleep(1)
		if(src.CSet=="C2")
			for(var/i=0, i<3, i++)
				src.chakra-=100;var/mob/Kibaku/ClaySenbon/A=new();A.Owner=src;A.CSet=src.CSet;A.layer=src.layer;A.loc=src.loc;S.loc=A.loc;A.density=1;walk(A,src.dir)
				sleep(2)
		src.Frozen=0;src.icon_state="";return
//Wall
	CreateClayWall()
		if(src.CreationDelayLeft||src.Status=="Asleep"||src.Guarding||src.doingG||src.resting||src.firing&&!src.Mogu||src.AttackDelay||src.meditating||src.LeftHandDelay)
			return
		if(src.FrozenBind!="")
			if(src.FrozenBind!="Spider Web")
				return
		var/HaveClay=0
		for(var/obj/RandomEquipment/Clay/AS in src.contents)
			if(AS.Ammount>1)
				HaveClay=1
			AS.Ammount-=1;
			AS.ReCheckAmount()
		if(!HaveClay)
			src<<"You've ran out of Clay!";return
		src.CreationDelayLeft=1
		if(src.CSet=="C1")
			spawn(5)
				src.CreationDelayLeft=0
		if(src.CSet=="C2")
			spawn(27)
				src.CreationDelayLeft=0
		src.icon_state="Block";
		src.Frozen=1
		for(var/mob/Kibaku/CarrierBird/C in world)
			if(C.Owner==src)
				src.Frozen=0
		if(src.CSet=="C1")
			sleep(1)
		if(src.CSet=="C2")
			sleep(5)
		for(var/i=0, i<3, i++)
			var/obj/SmokeCloud/S=new()
			var/mob/Kibaku/Wall/A=new();
			A.Owner=src;A.CSet=src.CSet;
			A.layer=src.layer;A.loc=get_step(src,src.dir);
			S.loc=get_step(src,src.dir)
			if(src.CSet=="C1")
				src.chakra-=100
				src.Frozen=0;src.icon_state="";return
			if (i==1)
				var/d=turn(src.dir,45);A.loc=get_step(src,d)
				if(src.CSet=="C2")
					src.chakra-=100;A.icon='Icons/Jutsus/IwazukaTechniques1.dmi'
			if (i==2)
				var/d=turn(src.dir,-45);A.loc=get_step(src,d)
				if(src.CSet=="C2")
					src.chakra-=100;A.icon='Icons/Jutsus/IwazukaTechniques1.dmi'
		src.Frozen=0;src.icon_state="";return
//Spider
	CreateClaySpider()
		if(src.CreationDelayLeft||src.Status=="Asleep"||src.Guarding||src.doingG||src.resting||src.firing&&!src.Mogu||src.AttackDelay||src.meditating||src.LeftHandDelay)
			return
		if(src.FrozenBind!="")
			if(src.FrozenBind!="Spider Web")
				return
		var/HaveClay=0
		for(var/obj/RandomEquipment/Clay/AS in src.contents)
			if(AS.Ammount>1)
				HaveClay=1
			AS.Ammount-=1;
			AS.ReCheckAmount()
		if(!HaveClay)
			src<<"You've ran out of Clay!";return
		src.CreationDelayLeft=1
		if(src.CSet=="C1")
			spawn(5)
				src.CreationDelayLeft=0
		if(src.CSet=="C2")
			spawn(27)
				src.CreationDelayLeft=0
		src.icon_state="Block";
		src.Frozen=1
		for(var/mob/Kibaku/CarrierBird/C in world)
			if(C.Owner==src)
				src.Frozen=0
		if(src.CSet=="C1")
			var/counter=0
			for(var/mob/Kibaku/C1Spider/S in world)
				if(S.Owner==src)
					counter++
			if(counter>=21)
				src<<"You have enough C1 spiders out. Explode them.";src.Frozen=0; return
			sleep(5)
		if(src.CSet=="C2")
			sleep(30)
		if(src.CSet=="C1")
			src.chakra-=100;var/obj/SmokeCloud/S=new()
			var/n=rand(4,7)
			while(n>0)
				var/mob/Kibaku/C1Spider/A=new();A.layer=src.layer;A.Owner=src;A.CSet=src.CSet;A.pixel_x=rand(-16,16);A.pixel_y=rand(-16,16);A.loc=get_step(src,src.dir);S.loc=A.loc;n--
			for(var/mob/Kibaku/C1Spider/B in view(3,src))
				spawn()
					var/steps=rand(1,5)
					while(steps>0)
						step(B,src.dir)
						steps--
				src.Frozen=0
				return
		if(src.CSet=="C2")
			sleep(15);src.chakra-=550
		var/obj/SmokeCloud/S=new();var/mob/Kibaku/Spider/A=new();A.layer=src.layer
		A.Owner=src;A.CSet=src.CSet;A.icon_state="Spider2";src.Guiding=A;src.chakra-=150
		A.loc=src.loc;S.loc=A.loc;src.Frozen=0;src.icon_state="";return
//Flower
	CreateClayFlower()
		if(src.CreationDelayLeft||src.Status=="Asleep"||src.Guarding||src.doingG||src.resting||src.firing&&!src.Mogu||src.AttackDelay||src.meditating||src.LeftHandDelay)
			return
		if(src.FrozenBind!="")
			if(src.FrozenBind!="Spider Web")
				return
		var/HaveClay=0
		for(var/obj/RandomEquipment/Clay/AS in src.contents)
			if(AS.Ammount>1)
				HaveClay=1
			AS.Ammount-=1;
			AS.ReCheckAmount()
		if(!HaveClay)
			src<<"You've ran out of Clay!";return
		src.CreationDelayLeft=1
		if(src.CSet=="C1")
			spawn(5)
				src.CreationDelayLeft=0
		if(src.CSet=="C2")
			spawn(27)
				src.CreationDelayLeft=0
		src.icon_state="Block";
		src.Frozen=1
		for(var/mob/Kibaku/CarrierBird/C in world)
			if(C.Owner==src)
				src.Frozen=0
		if(src.CSet=="C1"||src.CSet=="C2")
			var/counter=0
			for(var/mob/Kibaku/Flower/S in world)
				if(S.Owner==src)
					counter++
			if(counter>=4)
				src<<"You have enough flowers out. Explode them.";src.Frozen=0; return
		if(src.CSet=="C1")
			sleep(5)
		if(src.CSet=="C2")
			sleep(30)
		var/obj/SmokeCloud/S=new()
		if(src.CSet=="C1")
			src.chakra-=100
		if(src.CSet=="C2")
			src.chakra-=550
		var/mob/Kibaku/Flower/A=new();A.Owner=src;A.CSet=src.CSet;A.icon_state="Flower2";A.layer=src.layer;A.loc=src.loc;S.loc=A.loc
		src.Frozen=0;src.icon_state="";return
//Bird
	CreateClayBird()
		if(src.CreationDelayLeft||src.Status=="Asleep"||src.Guarding||src.doingG||src.resting||src.firing&&!src.Mogu||src.AttackDelay||src.meditating||src.LeftHandDelay)
			return
		if(src.FrozenBind!="")
			if(src.FrozenBind!="Spider Web")
				return
		var/HaveClay=0
		for(var/obj/RandomEquipment/Clay/AS in src.contents)
			if(AS.Ammount>1)
				HaveClay=1
			AS.Ammount-=1;
			AS.ReCheckAmount()
		if(!HaveClay)
			src<<"You've ran out of Clay!";return
		src.CreationDelayLeft=1
		if(src.CSet=="C1")
			spawn(5)
				src.CreationDelayLeft=0
		if(src.CSet=="C2")
			spawn(27)
				src.CreationDelayLeft=0
		src.icon_state="Block";
		src.Frozen=1
		for(var/mob/Kibaku/CarrierBird/C in world)
			if(C.Owner==src)
				src.Frozen=0
		if(src.CSet=="C1")
			sleep(15)
		if(src.CSet=="C2")
			sleep(30)
		var/obj/SmokeCloud/S=new()
		if(src.CSet=="C1")
			src.chakra-=100;var/mob/Kibaku/Bird/A=new();
			A.Owner=src;
			A.CSet=src.CSet;
			A.layer=src.layer;
			A.loc=src.loc;
			S.loc=A.loc;
			A.density=1;
			src.Guiding=A
		if(src.CSet=="C2")
			src.chakra-=550;var/mob/Kibaku/Bird/A=new();A.Owner=src;A.CSet=src.CSet;A.icon_state="Bird2";A.layer=src.layer;A.loc=src.loc;S.loc=A.loc;src.Guiding=A
		src.Frozen=0;src.icon_state="";return
//Mine
	CreateClayMine()
		if(src.CreationDelayLeft||src.Status=="Asleep"||src.Guarding||src.doingG||src.resting||src.firing&&!src.Mogu||src.AttackDelay||src.meditating||src.LeftHandDelay)
			return
		if(src.FrozenBind!="")
			if(src.FrozenBind!="Spider Web")
				return
		var/HaveClay=0
		for(var/obj/RandomEquipment/Clay/AS in src.contents)
			if(AS.Ammount>1)
				HaveClay=1
			AS.Ammount-=1;
			AS.ReCheckAmount()
		if(!HaveClay)
			src<<"You've ran out of Clay!";return
		src.CreationDelayLeft=1
		if(src.CSet=="C1")
			spawn(5)
				src.CreationDelayLeft=0
		if(src.CSet=="C2")
			spawn(27)
				src.CreationDelayLeft=0
		src.icon_state="Block";
		src.Frozen=1
		for(var/mob/Kibaku/CarrierBird/C in world)
			if(C.Owner==src)
				src.Frozen=0
		if(src.CSet=="C1"||src.CSet=="C2")
			var/counter=0
			for(var/mob/Kibaku/Mine/S in world)
				if(S.Owner==src)
					counter++
			if(counter>=16)
				src<<"You have enough mines out. Explode them.";src.Frozen=0; return
		if(src.CSet=="C1")
			sleep(30)
		if(src.CSet=="C2")
			sleep(30)
		//var/obj/SmokeCloud/S=new()
		//if(src.CSet=="C1")
			//src.chakra-=100;var/mob/Kibaku/Mine/A=new();A.Owner=src;A.CSet=src.CSet;A.layer=src.layer;A.loc=src.loc;A.density=0;S.loc=A.loc
		for(var/i=0, i<4, i++)
			var/obj/SmokeCloud/S=new()
			var/mob/Kibaku/Mine/A=new();
			A.Owner=src;A.CSet=src.CSet;
			A.layer=src.layer;A.loc=get_step(src,src.dir);
			S.loc=get_step(src,src.dir)
			if(src.CSet=="C2")
				src.chakra-=550
				src.Frozen=0;A.icon_state="Mine2";;return
			if (i==1)
				var/d=turn(src.dir,90);A.loc=get_step(src,d)
				if(src.CSet=="C1")
					src.chakra-=100;
			if (i==2)
				var/d=turn(src.dir,-90);A.loc=get_step(src,d)
				if(src.CSet=="C1")
					src.chakra-=100;
			if (i==3)
				var/d=turn(src.dir,-180);A.loc=get_step(src,d)
				if(src.CSet=="C1")
					src.chakra-=100;

		//if(src.CSet=="C2")
			//src.chakra-=550;var/mob/Kibaku/Mine/A=new();A.Owner=src;A.CSet=src.CSet;A.icon_state="Mine2";A.layer=src.layer;A.loc=src.loc;S.loc=A.loc
		src.Frozen=0;src.icon_state="";return
//Spear
	CreateClaySpear()
		if(src.CreationDelayLeft||src.Status=="Asleep"||src.Guarding||src.doingG||src.resting||src.firing&&!src.Mogu||src.AttackDelay||src.meditating||src.LeftHandDelay)
			return
		if(src.FrozenBind!="")
			if(src.FrozenBind!="Spider Web")
				return
		var/HaveClay=0
		for(var/obj/RandomEquipment/Clay/AS in src.contents)
			if(AS.Ammount>1)
				HaveClay=1
			AS.Ammount-=1;
			AS.ReCheckAmount()
		if(!HaveClay)
			src<<"You've ran out of Clay!";return
		src.CreationDelayLeft=1
		if(src.CSet=="C1")
			spawn(5)
				src.CreationDelayLeft=0
		if(src.CSet=="C2")
			spawn(27)
				src.CreationDelayLeft=0
		src.icon_state="Block";
		src.Frozen=1
		for(var/mob/Kibaku/CarrierBird/C in world)
			if(C.Owner==src)
				src.Frozen=0
		if(src.CSet=="C1")
			sleep(5)
		if(src.CSet=="C2")
			sleep(15)
		var/obj/SmokeCloud/S=new()
		if(src.CSet=="C1")
			src.chakra-=100;var/mob/Kibaku/Spear/A=new();A.Owner=src;A.CSet=src.CSet;A.layer=src.layer;A.loc=src.loc;A.density=1;S.loc=A.loc;walk(A,src.dir)
		if(src.CSet=="C2")
			src.chakra-=550;var/mob/Kibaku/Spear/A=new();A.Owner=src;A.CSet=src.CSet;A.layer=src.layer;A.loc=src.loc;A.density=1;S.loc=A.loc;walk(A,src.dir)
		src.Frozen=0;src.icon_state="";return
//Grasshopper
	CreateClayGrasshopper()
		if(src.CreationDelayLeft||src.Status=="Asleep"||src.Guarding||src.doingG||src.resting||src.firing&&!src.Mogu||src.AttackDelay||src.meditating||src.LeftHandDelay)
			return
		if(src.FrozenBind!="")
			if(src.FrozenBind!="Spider Web")
				return
		var/HaveClay=0
		for(var/obj/RandomEquipment/Clay/AS in src.contents)
			if(AS.Ammount>1)
				HaveClay=1
			AS.Ammount-=1;
			AS.ReCheckAmount()
		if(!HaveClay)
			src<<"You've ran out of Clay!";return
		src.CreationDelayLeft=1
		if(src.CSet=="C1")
			spawn(5)
				src.CreationDelayLeft=0
		if(src.CSet=="C2")
			spawn(27)
				src.CreationDelayLeft=0
		src.icon_state="Block";
		src.Frozen=1
		for(var/mob/Kibaku/CarrierBird/C in world)
			if(C.Owner==src)
				src.Frozen=0
		if(src.CSet=="C1"||src.CSet=="C2")
			var/counter=0
			for(var/mob/Kibaku/GrassHopper/S in world)
				if(S.Owner==src)
					counter++
			if(counter>=6)
				src<<"You have enough grasshoppers out. Explode them.";src.Frozen=0; return
		if(src.CSet=="C1")
			sleep(5)
		if(src.CSet=="C2")
			sleep(20)
		var/obj/SmokeCloud/S=new()
		if(src.CSet=="C1")
			src.chakra-=100;var/mob/Kibaku/GrassHopper/A=new();A.Owner=src;A.CSet=src.CSet;A.layer=src.layer;A.loc=src.loc;S.loc=A.loc;A.density=0;//walk(A,src.dir)
		if(src.CSet=="C2")
			src.chakra-=550;var/mob/Kibaku/GrassHopper/A=new();A.Owner=src;A.CSet=src.CSet;A.layer=src.layer;A.loc=src.loc;S.loc=A.loc;A.density=0;//walk(A,src.dir)
		src.Frozen=0;src.icon_state="";return

	//end of the line, you bastard!!!

mob/proc/MakeSpike(atom/Target)
	src.Frozen=1;src.firing=1;spawn(5)
		src.Frozen=0;src.firing=0;src.icon_state=""
	var/mob/Kibaku/Spike/A=new();A.loc=Target.loc;A.name="[src]";A.Owner=src;





mob/proc/GrassHopper_Spawn()
	src.ChakraDrain(30000)//Average amount of charka drain
	src.Handseals(1-src.HandsealSpeed)//Move should be instant but calls proc have checks to prevent use in binds and etc.
	if(src.HandsSlipped) return//standerd
	icon_state = "Block"
	src.FrozenBind="Grasshopper" //------------------------- ADD IN OWN STUN PROCK
	sleep(10)
//	var/obj/Iwazuka_GrassHopper/IGH = new()
	var/mob/Kibaku/GrassHopper/IGH = new()
	IGH.loc=src.loc;IGH.Owner=src;IGH.dir=src
	IGH.pixel_x = rand(-3,3)
	IGH.pixel_y = rand(-7,7)
	icon_state = "running"
	src.FrozenBind="" //------------------------- ADD IN OWN STUN PROCK





obj/Iwazuka_GrassHopper
	icon = 'Icons/Jutsus/IwazukaTechniques.dmi'//'Grasshopper.dmi'
	icon_state = "stable"
	layer = MOB_LAYER+1
	var/crossed = 0
	var/list/Sens[0]
	var/Owner
	proc
		Sensory_spawn()
			sleep(10)
			var/i
			var/j
			for(i=-1;i<=1;i++)
				for(j=-1;j<=1;j++)
					var/obj/GHSensors/S = new()
					S.connectedObj = src
					S.Owner = Owner
					S.loc = src.loc
					S.x = src.x+i
					S.y = src.y+j
					Sens.Add(S)
		Follow_Target(target)
			src.icon_state = "jumping"
			var/mob/M = target
			var/O
			for(O in Sens)
				del O
			while((src.x!=M.x)||(src.y!=M.y))
				sleep(10)
				step_towards(src,target)
			icon_state = "stable"
			if(crossed == 0)
				spawn() walk_towards(src,M)
			src.Explosion() //--------------------- ADD IN OWN EXPLOSION PROC
		Explosion()
			sleep(10)
			flick("exploding",src)
			sleep(5)
			icon_state = "nothing"
			var/mob/M
			var/mob/O = Owner
			for(M in view(1,src))
				if(ismob(M))
					var/damage = rand(50,100)
					if(M.key&&M)
						M.DamageProc(damage,"Health",O)
						view(M)<<output("<font>[M] was by bomb for ([damage]) damage!</font>","Attack")
					var/obj/S = new()
					S.icon = 'explosion.dmi'
					S.layer = MOB_LAYER+2
					S.x = src.x
					S.y = src.y
					S.z = src.z
					spawn(4) del S
					spawn(4)del src

	Crossed(O)
		var/mob/M
		if(ismob(O))
			if(!istype(O,/mob/Kibaku/CarrierBird))
				if(O!=Owner)
					M = O
					if(crossed == 0)
						spawn() walk_towards(src,M)
						crossed = 1


	New()
		..()
		spawn(1) Sensory_spawn()