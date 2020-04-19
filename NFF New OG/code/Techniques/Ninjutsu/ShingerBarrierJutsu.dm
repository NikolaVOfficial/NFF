
mob
	ReflectionBarrier
		name="ReflectBarrier"
		icon='Icons/Jutsus/Star.dmi'//I used a recolored peacock wall(Blue/purple/red)
		icon_state="Block2"
		health=6000000
		stamina=1000
		Endurance = 100
		maxhealth=600
		maxstamina=1000
		layer = 999
		Frozen=1
		opacity = 0
		mouse_opacity = 2
		NPC=1
		MoveDelay=2
		Cross(atom/movable/O)
			walk(O,get_dir(src,O))
			return 1
		MouseDown()
			return
		New()
			spawn(300)
				del(src)
	ChakraBarrier
		name = "ChakraBarrier"
		icon='Icons/Jutsus/Star.dmi'//I used a recolored peacock wall(Blue/purple/red)
		icon_state="Block3"
		health=600
		stamina=1000
		Endurance = 100
		maxhealth=600
		maxstamina=1000
		layer = 999
		Frozen=1
		opacity = 1
		mouse_opacity = 2
		NPC=1
		MoveDelay=2
		Cross(atom/movable/O)
			return O.Bump(src)
		MouseDown()
			return
		New()
			..()
			spawn()
				while(src)
					if(src.stamina<=0)
						src.health-=600
						src.stamina=1
					if(src.health<1)
						src.loc=null
						src.Death(src)
					sleep(5)//might be too fast, just wanted it to be responsive,
			spawn(6000)//So just incase the user bugs after a minute it will delete
				del(src)

mob/proc/BarrierProtection()
	src.ChakraDrain(3000)
	src.Handseals(1-src.HandsealSpeed)
	if(src.HandsSlipped) return
	var/mob/M=src.target
	var/turf/DM = src.loc  //Distance Marker
	src.icon_state="handseal"
	while(src.icon_state=="handseal")
		if(distance(DM,M)>30)
			DM=M.loc
		DM = get_step_towards(DM,M)
		var/found=0
		for(var/mob/ChakraBarrier/B in DM)
			if(B in src.JutsuList)
				found=1
		if(found==0)
			var/mob/ChakraBarrier/C = new(DM)
			C.Owner=src;src.JutsuList+=C
			spawn(50)
				del(C)
		sleep(1)
	for(var/mob/ChakraBarrier/D in src.JutsuList)
		del(D)


mob/proc/BarrierBlock()
	src.ChakraDrain(3000)
	src.Handseals(1-src.HandsealSpeed)
	if(src.HandsSlipped) return
	src.icon_state="handseal"
	if(src.dir==NORTHEAST||src.dir==SOUTHEAST) src.dir=EAST
	if(src.dir==NORTHWEST||src.dir==SOUTHWEST) src.dir=WEST
	var/mob/ReflectionBarrier/b = new();b.Owner=src;src.JutsuList+=b
	b.loc=get_step(src,src.dir);
	b.dir=src.dir;
	flick("M",b);step(b,b.dir);
	src<<"You hold up a barrier click z to release";
	while(src.icon_state=="handseal")
		src.firing=1
		src.ChakraDrain(1500)
		if(src.HoldingR)
			var/DR=0
			for(var/mob/ReflectionBarrier/B in src.JutsuList)
				if(B.opacity==0)
					B.opacity=1
					DR=1
				else if(B.opacity==1)
					B.opacity=0
					DR=0
			if(DR==1)
				src<<"You make the Barrier Dark!"
			else
				src<<"The Barrier Fade to Light!"
		sleep(10);
	src.firing=0
	for(var/mob/ReflectionBarrier/B in src.JutsuList)
		del(b);

mob/proc/BarrierWall()
	src.ChakraDrain(10000)
	src.Handseals(1-src.HandsealSpeed)
	if(src.HandsSlipped) return
	if(src.dir==NORTHEAST||src.dir==SOUTHEAST) src.dir=EAST
	if(src.dir==NORTHWEST||src.dir==SOUTHWEST) src.dir=WEST
	var/mob/ChakraBarrier/a = new();a.loc=get_step(src,turn(src.dir,45));a.dir=src.dir;flick("M",a);step(a,a.dir);a.Owner=src;src.JutsuList+=a
	var/mob/ChakraBarrier/b = new();b.loc=get_step(src,src.dir);b.dir=src.dir;flick("M",b);step(b,b.dir);b.Owner=src;src.JutsuList+=b
	var/mob/ChakraBarrier/c = new();c.loc=get_step(src,turn(src.dir,-45));c.dir=src.dir;flick("M",c);step(c,c.dir);c.Owner=src;src.JutsuList+=c
	src<<"You hold up a barrier click z to release";
	while((a||b||c)&&src.icon_state!="handseal")
		src.ChakraDrain(1500)
		if(src.HoldingR)
			var/DR=0
			for(var/mob/ChakraBarrier/d in src.JutsuList)
				if(d.opacity==0)
					d.opacity=1
					DR=1
				else if(d.opacity==1)
					d.opacity=0
					DR=0
			if(DR==1)
				src<<"You make the Barriers Dark!"
			else
				src<<"The Barriers Fade to Light!"
		sleep(10);
	for(var/mob/ChakraBarrier/d in src.JutsuList)
		del(d)

mob/proc/BarrierTrap()
	src.ChakraDrain(15000)
	//src.Target()
	if(src.ntarget)
		return
	var/mob/M=src.target
	src.Handseals(1-src.HandsealSpeed)
	if(src.HandsSlipped) return
	src.icon_state="handseal"
	if(M.dir==NORTHEAST||M.dir==SOUTHEAST) M.dir=EAST
	if(M.dir==NORTHWEST||M.dir==SOUTHWEST) M.dir=WEST
	for(var/turf/T in range(1,M))
		var/mob/ChakraBarrier/B=new();B.Owner=src;src.JutsuList+=B
		B.loc=T
	src<<"You hold [M] in a barrier click z to release";
	M<<"You've been encased in a protective Barrier!"
	while(src.icon_state=="handseal")
		src.ChakraDrain(1500)
		src.firing=1
		sleep(10)
		if(src.HoldingR)
			var/DR=0
			for(var/mob/ChakraBarrier/b in src.JutsuList)
				if(b.opacity==0)
					b.opacity=1
					DR=1
				else if(b.opacity==1)
					b.opacity=0
					DR=0
			if(DR==1)
				src<<"You make the Barriers Dark!"
				M<<"The Barriers Darken around you!"
			else
				src<<"The Barriers Fade to Light!"
				M<<"The Barriers begin to allow Light in!"
	src.firing=0
	for(var/mob/ChakraBarrier/b in src.JutsuList)
		del(b)

mob/proc/BarrierShield()
	src.ChakraDrain(15000)
	view(10)<<"[src] is preforming a barrier jutsu";
	src.Handseals(1-src.HandsealSpeed)
	if(src.HandsSlipped) return
	if(src.dir==NORTHEAST||src.dir==SOUTHEAST) src.dir=EAST
	if(src.dir==NORTHWEST||src.dir==SOUTHWEST) src.dir=WEST
	src.icon_state="handseal";
	for(var/turf/T in oview(1,src))
		var/mob/ChakraBarrier/B=new();B.loc=locate(T.x,T.y,T.z);B.Owner=src
		src.JutsuList+=B
	sleep(3);
	for(var/mob/ChakraBarrier/b in src.JutsuList)
		b.density=1
	src<<"You hold up a barrier click z to release";
	while(src.icon_state=="handseal"&&!src.knockedout)
		src.ChakraDrain(1500)
		src.firing=1
		if(src.HoldingR)
			var/DR=0
			for(var/mob/ChakraBarrier/b in src.JutsuList)
				if(b.opacity==0)
					b.opacity=1
					DR=1
				else if(b.opacity==1)
					b.opacity=0
					DR=0
			if(DR==1)
				src<<"You make the Barriers Dark!"
			else
				src<<"The Barriers Fade to Light!"
		sleep(10)
	src.firing=0
	for(var/mob/ChakraBarrier/b in src.JutsuList)
		del(b);



var/list/Blist=new;
mob/proc/BarrierContainment()
	src.ChakraDrain(15000)
	view(10)<<"[src] is preforming a barrier jutsu";
	src.Handseals(1-src.HandsealSpeed)
	if(src.HandsSlipped) return
	if(src.dir==NORTHEAST||src.dir==SOUTHEAST) src.dir=EAST
	if(src.dir==NORTHWEST||src.dir==SOUTHWEST) src.dir=WEST
	var/X=4
	for(var/turf/T in oview(X,src))
		if(!(T in oview(X-1)))
			var/mob/ChakraBarrier/B=new();B.loc=locate(T.x,T.y,T.z);B.Owner=src
			src.JutsuList+=B
	sleep(3);
	for(var/mob/ChakraBarrier/b in src.JutsuList)
		b.density=1
	src<<"You hold up a barrier click z to release";
	while(!src.knockedout)
		src.ChakraDrain(1500)
		sleep(10)
		if(src.icon_state=="handseal")
			break
		if(src.HoldingR)
			var/DR=0
			for(var/mob/ChakraBarrier/b in src.JutsuList)
				if(b.opacity==0)
					b.opacity=1
					DR=1
				else if(b.opacity==1)
					b.opacity=0
					DR=0
			if(DR==1)
				src<<"You make the Barriers dark!"
			else
				src<<"The Barriers Fade to light!"
	for(var/mob/ChakraBarrier/b in src.JutsuList)
		del(b)

obj
	CenterPoint
		layer=TURF_LAYER


mob/proc/DestructiveBarrierContainment()
	if(!src.target)
		return
	src.ChakraDrain(15000)
	var/mob/M=src.target
	view(10)<<"[src] is preforming a barrier jutsu";
	src.Handseals(1-src.HandsealSpeed)
	if(src.HandsSlipped) return
	if(src.dir==NORTHEAST||src.dir==SOUTHEAST) src.dir=EAST
	if(src.dir==NORTHWEST||src.dir==SOUTHWEST) src.dir=WEST
	var/X=7
	src.firing=1;
	src.icon_state="handseal";
	var/obj/CenterPoint/Center=new()
	Center.loc=M.loc;Center.density=0;src.JutsuList+=Center
	if(src.icon_state=="handseal")
		spawn(1)
			while(src.icon_state=="handseal"&&!src.knockedout)
				src<<"You begin to maintain a Destructive Barrier!";
				viewers(Center)<<"You've been captured in an ominous Barrier!"
				for(var/turf/T in orange(X,Center))
					if(!(T in orange(X-1,Center)))
						var/mob/ChakraBarrier/B=new();B.loc=locate(T.x,T.y,T.z);B.Owner=src;src.JutsuList+=B
				sleep(20)
				if(!(src.icon_state=="handseal"))
					return
				X-=1
				for(var/turf/T in orange(X,Center))
					if(!(T in orange(X-1,Center)))
						var/mob/ChakraBarrier/C=new();C.loc=locate(T.x,T.y,T.z);C.Owner=src;src.JutsuList+=C
				viewers(Center)<<"The Barrier closes in! You need to escape FAST!!"
				sleep(20)
				if(!(src.icon_state=="handseal"))
					return
				X-=1
				for(var/turf/T in orange(X,Center))
					if(!(T in orange(X-1,Center)))
						var/mob/ChakraBarrier/D=new();D.loc=locate(T.x,T.y,T.z);D.Owner=src;src.JutsuList+=D
				viewers(Center)<<"The Barrier closes in! You need to escape FAST!!"
				sleep(20)
				if(!(src.icon_state=="handseal"))
					return
				X-=1
				for(var/turf/T in orange(X,Center))
					if(!(T in orange(X-1,Center)))
						var/mob/ChakraBarrier/E=new();E.loc=locate(T.x,T.y,T.z);E.Owner=src;src.JutsuList+=E
				viewers(Center)<<"The Barrier closes in! You need to escape FAST!!"
				sleep(20)
				if(!(src.icon_state=="handseal"))
					return
				X-=1
				for(var/turf/T in orange(X,Center))
					if(!(T in orange(X-1,Center)))
						var/mob/ChakraBarrier/F=new();F.loc=locate(T.x,T.y,T.z);F.Owner=src;src.JutsuList+=F
				viewers(Center)<<"The Barrier closes in! You need to escape FAST!!"
				sleep(20)
				if(!(src.icon_state=="handseal"))
					return
				src<<"Your Barrier Implodes!"
				for(var/obj/CenterPoint/Q in src.JutsuList)
					for(var/mob/player/A in orange(2,Q))
						A<<"The Barrier Crushes you!"
						A.health-=500
				src.icon_state=""
				break
		spawn(1)
			while(src.icon_state=="handseal"&&!src.knockedout)
				src.ChakraDrain(1500)
				for(var/obj/CenterPoint/Q in src.JutsuList)
					for(var/mob/U in view(5,Q))
						if(U!=src)
							U.Running=0
							step_towards(U,Q)
				sleep(10)
			src.firing=0
			for(var/mob/ChakraBarrier/b in world)
				if(b.Owner==src)
					spawn(rand(10,100))
						sleep(1)
						del(b)
			for(var/obj/CenterPoint/c in src.JutsuList)
				del(c)




/*for(var/obj/Nara/Shibari/Q in src.shadowList)
				if(Q.Owner==usr)
					Shib=Q;break*/
/*
var/list/Clist=new;
var/list/Dlist=new;
var/list/Elist=new;
var/list/Flist=new;
var/list/Glist=new;
var/list/Alilist=new;
var/Timez=0*/
