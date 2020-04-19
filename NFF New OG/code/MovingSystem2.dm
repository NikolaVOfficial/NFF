//time spent standing still to lose our running bonus
//var/const/RUN_TIMEOUT = 30
//number of steps we must take to speed up 1 tick
//var/const/STEPS_PER_SPEEDUP = 5
//number of steps we lose for turning
//var/const/PENALTY_FOR_TURN = 5//is 5
mob
  var/tmp/runningspeed = 0
  //steps after maxrunning won't count.  In this case, our speed is reduced by 3 ticks at most
  //var/maxrunning = 10//2 * STEPS_PER_SPEEDUP
  var/tmp/nextmove = 0
 // var/minspeed = 3
  proc
    //tell us how long we should delay between steps
    getMoveDelay()
      if(!src.Running)
     //   world<<"Yes"
        src.runningspeed=0
      else if(src.Running&&!src.controlled)
        src.RunDrain()
      return 3 - round(runningspeed / 5)//the 3 was minspeed
    speedUp()
      var/TheMaximumRunningSpeed=(10+src.RunningSpeed)+(src.shika?20:0)//the 10 was maxrunning
      if(src.CheckForAutoRun()&&!src.LegSliced)
        TheMaximumRunningSpeed=15+(src.shika?20:0)
        if(src.runningspeed<(10+(src.shika?20:0)))
          src.runningspeed=10+(src.shika?20:0)
        src.Running=1
      else if((src.stamina/src.maxstamina)<0.1||(src.LegSliced)||(src.BaikaCharged>=1&&!src.intank))
        src.Running=0
      else if(src.deathcount>=6&&src.Running)
        src<<"You're too tired to run anymore. Get some rest quick."
        src.Running=0
      if(!src.Running&&!src.Clone)
        src.icon_state="";
//        world<<"Icon state changed to normal"
     //   world<<"Icon state changed to normal."
        return
      var/SpeedIncrease=round(src.Acceleration/2)+(src.shika?3:0)
      if(src.DragPerson!="None"||src.LegSliced)
        SpeedIncrease=0
      runningspeed+=(1+SpeedIncrease)+(src.shika?20:0)//added 6/23/12
      if(src.DragPerson!="None")
        runningspeed/=5
      runningspeed = min(runningspeed, TheMaximumRunningSpeed)
    //  src<<"You speed up to [runningspeed] runningspeed. Time until next move. [src.nextmove]"
      if(runningspeed>=10)
        var/IncreaseChance2=4+(src.ItemWeight/50)
        if(prob(IncreaseChance2))
          if(prob(2)&&src.Clan!="Ketsueki")
            src.hunger++
            if(src.hunger>=100) src.hunger=100
            if(src.Clan=="Inuzuka"&&src.hasdog)
              if(prob(40))
                src.pethunger++
                src.petthirst++
          else if(prob(2))
            src.thirst++
   //         if(src.Clan=="Inuzuka"&&src.hasdog)
    //          if(prob(40))
      //          src.petthirst++

          if(src.RunningSpeed<5)
            src.RunningSpeed+=0.05
          //  if(src.Trait=="Speedy")
            //  src.RunningSpeed+=(rand(1,5)*0.01)
            if(src.RunningSpeed>=5)
              src.RunningSpeed=5
      src.CheckForIconState()
    slowDown()
      //world<<"Slow down proc called."
     // if(src.controlled)
      	//var/mob/P=src.controlled
      //	if(P.stamina>P.maxstamina*0.10)
      	//	src.runningspeed=15
   	    // src.runningspeed=15;
       // return
    //  world<<"Called."
      if(src.controlled)//&&src.UsingEdo) CHANGED 4/4/2015
        var/mob/P=src.controlled
        if(P.stamina>P.maxstamina*0.10)
          src.runningspeed=15
      if(!src.Running)
        src.icon_state="";
     //   world<<"Slow Down Icon state called."
    //    world<<"Icon state changed to normal due to not running."
        return

      var/TheLostSpeed=(5-(src.RunningSpeed-1))
      if(src.GateIn!=""&&src.GateIn!="Initial"&&src.GateIn!="Heal")
        TheLostSpeed=0
      if(src.Trait2=="Hyperactivity"&&src.deathcount>=2)
        TheLostSpeed=0
      if(runningspeed>7)
        var/IncreaseChance=4+(src.ItemWeight/50)
        if(src.shika&&prob(4))
          src.ShikyakuControl+=pick(0.05,0.1,0.25)
          if(src.ShikyakuControl>10)
            src.ShikyakuControl=10
     //     if(prob(2))
    //        src.ShikyakuControl+=pick(0.05,0.1,0.25)
      //      if(src.ShikyakuControl>10)
        //     src.ShikyakuControl=10
        if(prob(IncreaseChance))
          src.Acceleration+=pick(0.05,0.1,0.25,0.5)
    //      if(src.Trait=="Speedy")
      //      src.Acceleration+=0.25
          if(src.Acceleration>10)
            src.Acceleration=10
      runningspeed = max((runningspeed - TheLostSpeed), 0)
    //  src<<"You slowed down to [runningspeed] runningspeed."
      src.CheckForIconState()

client
	Move(Loc, Dir, sx, sy)

		if(mob.RestrictOwnMovement)
//			world<<"Not moved due to restrict own movement"
			return
		if(mob.Shibari)
			if(Dir!=NORTH&&Dir!=SOUTH&&Dir!=EAST&&Dir!=WEST)
				return
	//	if(!mob.NewMovementStyle)
		//	if(!mob.controlled&&mob.runningspeed==0&&mob.dir!=Dir&&!mob.Frozen&&!mob.FrozenBind)//3/13/2013
		if(!mob.controlled&&!mob.runningspeed&&mob.dir!=Dir&&!mob.Frozen&&(!mob.FrozenBind||mob.FrozenBind=="Mane"))//changed mob.runningspeed==0 to !mob.

			mob.dir=Dir;
		//		world<<"Not moved due to new movement style."
//				return

		if(mob.Kumosenkyuu)//Place stuff here if you want to make actual legit bow and Arrows!
			for(var/obj/Jutsu/Spider/bow/B in view(1,mob))
				if(B.Owner==mob)
					B.dir=mob.dir;
				break
			for(var/obj/Jutsu/Spider/bowU/B2 in view(1,mob))
				if(B2.Owner==mob)
					B2.dir=mob.dir;
				break
		else if(mob.UsingBow)
			mob.dir=Dir
			return
	   //restrict movement speed
		if((mob.CheckIfFrozen() && !mob.controlled) || (mob.nextmove != 0 && mob.nextmove > world.time))//changed to a longer if statement as of 7/31/2016
		//	world<<"Not moved due to restrict movement speed."
			return 0
//		if(mob.CheckIfFrozen() && !mob.controlled)
		//		world<<"Not moved due to check if frozen."
//			return 0
	    //reset the running counter if we stand still for too long
		if(mob.nextmove + 30 < world.time)
		//	if(mob.Chidorion||mob.Raikirion)//just added 10/22/2013
		//		return
			if(!mob.Chidorion&&!mob.Raikirion)
				mob.runningspeed = 0
				mob.icon_state=""
//				world<<"Chidori mess up."
			//	world<<"Mob is no longer running by Client/Move."
				//mob<<"You've lost your running speed because you stayed still for too long."
	    //store our mob's current dir because it will change after we move
		var/D = mob.dir
	//	var/L = mob.loc
		if(mob.screwed||mob.Status=="Screwed")
			var/direction=pick(NORTH,EAST,SOUTH,WEST,NORTHEAST,SOUTHEAST,SOUTHWEST,NORTHWEST)
			step(mob,direction)
			mob.nextmove = world.time + mob.getMoveDelay()
			return
	    //perform the default action
		.=..()
			//if(.)
	      //if we are taking steps in the same direction, increase the running counter
		if(mob.InJibashi) // May want to replace this variable with a universal CurrentJutsuUsing="Jibashi" or something like that in the future
			for(var/obj/Jutsu/Elemental/Raiton/Electro/E in oview(15,mob))
				if(E.Owner==mob) del(E)
			mob.InJibashi=0;mob.firing=0
		//	if(mob.SelfHeal)
		//		mob.SelfHeal=0
		//	if(mob.InMirror)
		//		if(L!=Loc)
		//			mob.InMirror=0
		if(D == Dir)
			mob.CheckForQuickStep()
			mob.speedUp()
			  //otherwise, reduce it
		else if(!(mob.CheckForQuickStep()))
	//		if(!(mob.CheckForQuickStep()))
			mob.slowDown()
			//set when we can move next
		mob.nextmove = world.time + mob.getMoveDelay()
//	else
//		if(mob.InJibashi) // May want to replace this variable with a universal CurrentJutsuUsing="Jibashi" or something like that in the future
//			for(var/obj/Jutsu/Elemental/Raiton/Electro/E in oview(15,mob))
//				if(E.Owner==mob) del(E)
//			mob.InJibashi=0;mob.firing=0
	//	if(mob.InMirror)
	//		if(L!=Loc)
	//			mob.InMirror=0
	//	if(mob.Sprinting)
	//		mob.CheckForQuickStep()
	//	return ..()

mob
	Move()
		if(!src.client)
		//	if(src.CNNPC)
		//		return


		//	if(src.Clone)//&&!src.client) Changed as of 2/14/2014
		//		var/PrevDir=src.dir
		//		src.icon_state="running"
		//		src.dir=PrevDir
		//	else if(src.isdog)
		//		src.icon_state="beastman"

			if(src.Clone)//&&!src.client)
				var/PrevDir=src.dir
				src.icon_state="running"
				src.dir=PrevDir
			else if(src.isdog)
				src.icon_state="beastman"
			if((src.CheckIfFrozen()) || (src.nextmove != 0 && src.nextmove > world.time))
		//		world<<"Mob move return called."
				return 0
		//	if(src.CheckIfFrozen())
		//		world<<"Mob move frozen return called."
		//		return 0
			.=..()
			src.nextmove = world.time + src.MoveDelay
			if(src.isdog)
				src.nextmove = world.time
		else
			if(src.CheckIfFrozen())
		//		world<<"New movement style return called."
				return 0

		//	if(!src.NewMovementStyle)//getting rid of this since there is no new movement style and thus it's just a check for no reason

			.=..()
	//		else
	//			return ..()
/////////////////////////////////////////////////
/////////////////////////////////////////////////
//Procs for the Running System///////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////
mob/proc/RunDrain()
  var/BasicBonus=(src.Clan=="Basic" ? 200 : 0)
//  if(src.key=="Jwells100") return
  if(src.Clan=="Ketsueki")
    if(src.Banpaia&&prob(15-(src.BloodManipulation/10)))
      src.thirst+=(4-src.ThirstHold)
 // if(src.Clan!="Basic")//&&!src.Strong_NPC)
  if(src.ItemWeight>(500+BasicBonus+src.Mtai))//&&src.key!="CobraT1337")
    src.stamina-=src.ItemWeight*0.1
//  else if(!src.Strong_NPC)
 //   if(src.ItemWeight>(700+src.Mtai))//&&src.key!="CobraT1337")
  //    src.stamina-=src.ItemWeight*0.05
  if(prob(25))
    src.calories-=pick(0,1)
    if(src.ItemWeight>100)
      src.calories-=src.ItemWeight/200
    if(src.calories<=0)
      src.calories=0
      src.stamina-=rand(1,4)
/////////////////////////////////////////////////
/////////////////////////////////////////////////
mob/proc/CheckIfFrozen()
	if(src.FrozenBind!=""||src.Frozen||src.knockedout||src.Stun>0||src.Guarding||src.UsingHealthPack||src.resting||src.CastingGenjutsu||src.Status=="Asleep"||src.UsingBow||src.Kumosenkyuu||src.SoundSpinningKick||src.icon_state=="handseal"||src.icon_state=="Power"||src.alreadytalkingtohim)
		src.UsingHealthPack=0
		return 1
	else
		return 0
/////////////////////////////////////////////////
/////////////////////////////////////////////////
mob/proc/CheckForAutoRun()
  if(src.Clone||src.GateIn!=""||src.SatouDrunk||src.HoshiAutoRun||(src.shika&&src.stamina>(src.maxstamina*0.15))||src.intank||src.ingat||src.Banpaia||src.SageMode!="")//||//src.EffectsofDrinking)//||src.ARank=="Infiltrator"||(src.Bijuu=="Nibi"&&src.TailState!=0))
    return 1
  else
    return 0
/////////////////////////////////////////////////
/////////////////////////////////////////////////
mob/proc/CheckForQuickStep()
  if(src.Running&&(src.GateIn=="Limit"||src.GateIn=="View"||src.Banpaia))//||src.QuickFeet))
   // //if(src.QuickFeet)
     // src.chakra-=rand(1,3)
    src.Quick()
    //world<<"return 1"
    return 1
 // else if((src.ARank=="Infiltrator"&&src.HoldingS)||(src.shika&&src.ShikyakuControl>=10&&src.HoldingS)||(src.RunningSpeed>=10&&src.runningspeed>=20&&src.HoldingS)||(src.RunningSpeed>=10&&src.runningspeed>20&&src.GateIn!=")"||(src.RaiArmor==2&&src.HoldingS)||(src.SageMode!=""&&src.HoldingS)||(src.Bijuu=="Nibi"&&src.TailState>=1&&src.HoldingS&&src.deathcount<=5))
  else if((src.shika&&src.ShikyakuControl>=10&&src.HoldingS&&src.Running)||(src.SageMode!=""&&src.HoldingS)||(src.QuickFeet))//||(src.Bijuu=="Nibi"&&src.TailState>=1&&src.HoldingS&&src.deathcount<=5))
//	if(src.QuickFeet)
//	 src.chakra-=rand(5,10)
//	else
//	if(src.QuickFeet)
//		src.chakra-=rand(5,10)
////	else
    //	src.StaminaDrain(10)
    if(src.QuickFeet)
      src.chakra-=rand(10,20)
    else if(src.shika&&src.ShikyakuControl>=10&&src.HoldingS)
      src.stamina-=rand(30,40)
    else
      src.StaminaDrain(10)
    src.Quickness()
    //world<<"return 1"
    return 1
  else
    //world<<"return 0"
    return 0
/////////////////////////////////////////////////
/////////////////////////////////////////////////
mob/proc/CheckForIconState()
	if(runningspeed<=7&&src.icon_state!="handseals")
		src.icon_state=""
	else if(runningspeed>7)
		if((src.icon_state!="rest"&&src.icon_state!="Garouga"&&src.icon!='Icons/Jutsus/IwazukaTechniques.dmi'&&src.icon_state!="handseals")||(src.Clone))
			src.icon_state = "running"
			if(src.CurrentMission=="Jog Walk")

				src.NumberOfSteps++
				if(src.NumberOfSteps>=1000)
					src.MissionComplete()
	if(src.controlled)
		src.icon_state="running"
//GOODBYENOW		if(src.UsingEdo)
//GOODBYENOW			var/mob/P = src.controlled
	//	world<<"Icon state is [P.icon_state]"
//GOODBYENOW			P.icon_state="running"
	//	world<<"Check Icon state: [P.icon_state]"
//	else if(runningspeed>7)
//		if((!src.UsingClayCarrier&&src.icon!='Icons/Jutsus/IwazukaTechniques.dmi'&&src.icon_state!="rest"&&src.icon_state!="Garouga"&&src.icon_state!="handseals")||(src.Clone))
//			src.icon_state = "running"
//			if(src.CurrentMission=="Jog Walk")
//
//				src.NumberOfSteps++
//				if(src.NumberOfSteps>=1000)
//					src.MissionComplete()
//		if(src.TimeToAttack==5)
//			if(runningspeed>=10)
//				src.TimeToAttack=6
//				var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
//				sd_Alert(usr, "You successfully reached full speed!","[src]",,,,0,"400x150",,style)
	if((src.shika&&src.icon_state!="Garouga")||src.isdog||src.TailState>=1)
		if(src.icon!='Icons/Jutsus/IwazukaTechniques.dmi')
			src.icon_state = "beastman"
	if(src.RightHandSheath&&src.icon_state!="Garouga")
		var/A=src.WeaponInRightHand
		if(A!=""&&A!=null&&!(istype(A,/obj/WEAPONS/Kunai))&&!(istype(A,/obj/WEAPONS/Nunchuks))&&!(istype(A,/obj/WEAPONS/MeleeKunai))&&!(istype(A,/obj/WEAPONS/Senbon))&&!(istype(A,/obj/WEAPONS/Shuriken))&&!(istype(A,/obj/WEAPONS/Yanagi))&&!(istype(A,/obj/WEAPONS/Tsubaki))&&!(istype(A,/obj/WEAPONS/Bow))&&!(istype(A,/obj/WEAPONS/KnuckleKnives))&&A!="Spider"&&A!="Bird"&&A!="Wall"&&A!="Flower"&&A!="ClayKunai"&&A!="ClaySenbon"&&A!="Mine"&&A!="Spear"&&A!="Grasshopper")
			src.icon_state="weapon"
		A=null
	if(src.LeftHandSheath&&src.icon_state!="Garouga")
		var/A=src.WeaponInLeftHand
		if(A!=""&&A!=null&&!(istype(A,/obj/WEAPONS/Kunai))&&!(istype(A,/obj/WEAPONS/Nunchuks))&&!(istype(A,/obj/WEAPONS/MeleeKunai))&&!(istype(A,/obj/WEAPONS/Senbon))&&!(istype(A,/obj/WEAPONS/Bow))&&!(istype(A,/obj/WEAPONS/Yanagi))&&!(istype(A,/obj/WEAPONS/Tsubaki))&&!(istype(A,/obj/WEAPONS/Shuriken))&&!(istype(A,/obj/WEAPONS/KnuckleKnives))&&A!="Spider"&&A!="Bird"&&A!="Wall"&&A!="Flower"&&A!="ClayKunai"&&A!="ClaySenbon"&&A!="Mine"&&A!="Spear"&&A!="Grasshopper")
			src.icon_state="weapon"
		A=null
/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////
mob/var
	Running=0
	Frozen=0
	MoveDelay=0
	NewMovementStyle
//	Max_Running_Speed
mob/GainedAfterLogIn/verb
	X()
		set hidden=1
		if(usr.KBunshinOn)
			usr=usr.controlled
		else
			usr=src
		if(usr.CantRunTimer&&!usr.CursedSealActivated)
			usr<<"You are too tired to run at the moment."
			usr.Running=0
			return
		if(usr.Running)
			usr.Running=0
			usr<<"You begin to walk."
			return
		else
			usr.Running=1
			usr<<"You begin to run."
			return

mob/var/tmp
	ControlClients
	Moving
	MN;MS;ME;MW
	QueN;QueS;QueE;QueW
	Sprinting=0
	MovementSpeed=3.5
//	list/SprintDirs
//mob/Move(var/turf/NewLoc,NewDir)
//	if(src.Sprinting && !src.density && NewLoc.Enter(src))
//	if(src.client)
	//	if(src.client.eye!=src)	return
	//	src.overlays-=PressF
	//	if(NewLoc.Enter(src))	for(var/mob/NPCs/Humans/Generic_Talkers/N in get_step(NewLoc,NewDir))
	//		src.overlays-=PressF;src.overlays+=PressF	//if they can move check 2 in front

//	return ..()
/*
mob/proc
	ScreenShake()
		for(var/client/C in src.ControlClients)
			for(var/i=1;i<=5;i++)
				var/PickedAmt=rand(4,8)
				var/PickedDir=pick("pixel_x","pixel_y")
				C.vars[PickedDir]+=PickedAmt
				sleep(1);if(!src || !C)	return
				C.vars[PickedDir]-=PickedAmt
				*/
mob/proc
	ResetIS(/**/)
		if(src.Sprinting&&src.icon_state!="swimming"&&src.icon_state!="shika")
			src.icon_state="running"
		else
			if(src.icon_state!="swimming"&&src.icon_state!="shika")
				src.icon_state=""
	ResetFocus()
		if(src.client.eye==locate(289,100,1))	src.client.eye=src
	MovementLoop()
		walk(src,0)
		if(src.Moving)	return;src.Moving=1
		var/FirstStep=1
		while(src.MN || src.ME || src.MW || src.MS || src.QueN || src.QueS || src.QueE || src.QueW)
			if(src.MN || src.QueN)
				if(src.ME || src.QueE)	if(!step(src,NORTHEAST) && !step(src,NORTH))	step(src,EAST)
				else if(src.MW || src.QueW)	if(!step(src,NORTHWEST) && !step(src,NORTH))	step(src,WEST)
				else	step(src,NORTH)
			else	if(src.MS || src.QueS)
				if(src.ME || src.QueE)	if(!step(src,SOUTHEAST) && !step(src,SOUTH))	step(src,EAST)
				else if(src.MW || src.QueW)	if(!step(src,SOUTHWEST) && !step(src,SOUTH))	step(src,WEST)
				else	step(src,SOUTH)
			else	if(src.ME || src.QueE)	step(src,EAST)
			else	if(src.MW || src.QueW)	step(src,WEST)
			src.QueN=0;src.QueS=0;src.QueE=0;src.QueW=0
			if(FirstStep)	{sleep(1);FirstStep=0}
			sleep(max(1,src.MovementSpeed))
		src.Moving=0

mob/verb
	MoveNorth2()
		set hidden=1;set instant=1
//		world<<"Test."
		return
		src.ResetFocus()
		src.SprintCheck("North")
		if(src.FrozenBind!=""||src.icon_state=="Katon"||src.Frozen||src.CastingGenjutsu||src.Status=="Asleep"||src.UsingBow||src.Kumosenkyuu||src.Guarding||src.Stun>0||src.knockedout||src.SoundSpinningKick||src.icon_state=="handseal"||src.icon_state=="Controlling"||src.icon_state=="BeingCarried"||src.icon_state=="Power"||src.alreadytalkingtohim)
			return
		src.MN=1;src.MS=0;QueN=1;src.MovementLoop()
	StopNorth2()
		set hidden=1;set instant=1
		return
		src.MN=0;src.SprintCancel()

	MoveSouth2()
		set hidden=1;set instant=1
		return
		src.ResetFocus()

		src.SprintCheck("South")
		if(src.FrozenBind!=""||src.icon_state=="Katon"||src.Frozen||src.CastingGenjutsu||src.Status=="Asleep"||src.Kumosenkyuu||src.Guarding||src.Stun>0||src.knockedout||src.SoundSpinningKick||src.icon_state=="handseal"||src.icon_state=="Controlling"||src.icon_state=="BeingCarried"||src.icon_state=="Power"||src.alreadytalkingtohim)
			return
		src.MN=0;src.MS=1;QueS=1;src.MovementLoop()
	StopSouth2()
		set hidden=1;set instant=1
		return
		src.MS=0;src.SprintCancel()

	MoveEast2()
		set hidden=1;set instant=1
		return
		src.ResetFocus()
		src.SprintCheck("East")
		if(src.FrozenBind!=""||src.icon_state=="Katon"||src.Frozen||src.CastingGenjutsu||src.Status=="Asleep"||src.Kumosenkyuu||src.Guarding||src.Stun>0||src.knockedout||src.SoundSpinningKick||src.icon_state=="handseal"||src.icon_state=="Controlling"||src.icon_state=="BeingCarried"||src.icon_state=="Power"||src.alreadytalkingtohim)
			return
		src.ME=1;src.MW=0;QueE=1;src.MovementLoop()
	StopEast2()
		set hidden=1;set instant=1
		return
		src.ME=0;src.SprintCancel()

	MoveWest2()
		set hidden=1;set instant=1
		return
		src.ResetFocus()
		src.SprintCheck("West")
		if(src.FrozenBind!=""||src.icon_state=="Katon"||src.Frozen||src.CastingGenjutsu||src.Status=="Asleep"||src.Kumosenkyuu||src.Guarding||src.Stun>0||src.knockedout||src.SoundSpinningKick||src.icon_state=="handseal"||src.icon_state=="Controlling"||src.icon_state=="BeingCarried"||src.icon_state=="Power"||src.alreadytalkingtohim)
			return
		src.ME=0;src.MW=1;QueW=1;src.MovementLoop()
	StopWest2()
		set hidden=1;set instant=1
		return
		src.MW=0;src.SprintCancel()

mob/proc/SprintCheck(var/TapDir)
	return
//	if(!src.SprintDirs)	src.SprintDirs=list()
//	if(TapDir in src.SprintDirs)
//		if(!src.Sprinting&&src.stamina>src.maxstamina/10)
//			src.Sprinting=1
//			src.MovementSpeed-=((1+(10/5))+src.shika)
//			if(!src.icon_state || src.icon_state=="running")	src.ResetIS()
//		if(src.Sprinting&&src.icon_state==""&&!src.UsingClayCarrier)
//			src.icon_state="running"
//	else
//		src.SprintDirs+=TapDir
//		spawn(4)	src.SprintDirs-=TapDir

mob/proc/SprintCancel()
	return
	if(!src.Sprinting)	return
	if(!src.MN && !src.MS && !src.ME && !src.MW && src.Acceleration<10)
		src.MovementSpeed=initial(src.MovementSpeed)
		src.Sprinting=0
		//PlaySound(view(),'2860__prz__zigzig.ogg')
		if(!src.icon_state || src.icon_state=="running")	src.ResetIS()

mob/proc/GetMovementSpeed()
	return
	var/MovementDelay=src.MovementSpeed
	return max(1,MovementDelay)

mob/proc/CancelMovement()
	return
	src.MN=0;src.MS=0;src.MW=0;src.ME=0
	src.SprintCancel()
