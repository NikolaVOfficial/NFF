mob/var/tmp/DoingPalms=0
mob/var/tmp/TrappedInGedoMazo=0
/*
mob/owner/verb/CreateACustomJutsu()
	name="Create a Custom Taijutsu"
	set category="Attacks"
	var/obj/SkillCards/Custom_Taijutsu/A=new()
	switch(input(src,"Does this move require charging? Charging a technique increases the time of the Charge.",text)in list("Yes","No"))
		if("Yes")
			var/Amount=input(usr,"How long do you want it to Charge? Note, 100 will equal 10 seconds.","Combo") as num
			A.Charge=Amount
	if(usr.TaijutsuKnowledge>100)
		switch(input(src,"Is this attack a Combo? .",text)in list("Yes","No"))
			if("Yes")
				A.Combo=1
	switch(input(src,"Is this a Striker type move or a Teleporter type Move? Strike moves attack straightforward while Teleporter moves teleports to the enemy if you're running and attacks.",text)in list("Striker","Teleporter"))
		if("Striker")
			A.MoveType="Striker".
		if("Teleporter")
			A.MoveType="Teleporter"
	switch(input(src,"Is this a Forgward movg or a Spinner move? Forward moves attack forward with a strong attack, Spinner move spins around and attacks.",text)in list("Forward","Spinner"))
		if("Forward")
			A.SpinerOrStriker="Striker"
		if("Spinner")
			A.SpinerOrStriker="Spinner"
	switch(input(src,"Is this a push back move or a stunner? A Push back moves pushes back the enemy when they're hit while a Stunner stuns the enemy after their hit.",text)in list("Push Back","Stunner"))
		if("Push Back")
			A.StunOrPush="Push"
		if("Stunner")
			A.StufnOrPush="Stun"
	var/characterfirstname=input(src,"What is this technique's name?","Name")
	A.name=characterfirstname
	var/EXP=input(usr,"How much EXP is required to learn this technique? Note the higher EXP the harder it'll be to learn the technique but the stronger it'll be.","EXP Usage") as num
	if(EXP<1000)
		EXP=1000
		usr<<"EXP automatically set to 1000."
	if(EXP>200000)
		EXP=200000
		usr<<"EXP automatically set to 200,000."
	A.ExpCost=round(EXP)
	usr.JutsuInLearning=A
	usr.JutsuEXPCost=0
	usr.exp=0
	usr.JutsuMEXPCost=A.ExpCost
	src<<"You are in training for [A.name]."
	src.TypeLearning="Taijutsu"
*/
mob/proc/Slot(N as num)
	var/SLOT=N+(10*(text2num(src.SlotYourOn)-1))
	for(var/obj/SkillCards/A in src.LearnedJutsus)
		if(A.Slot==SLOT)
			if(A.type in BannedJutsu)
				if(A.Delay)
					return
				usr<<"This jutsu is banned!";A.DelayIt(50,usr,"None");return
			if(usr.UsingStakes)
				usr.UsingStakes=0
			if(A.Target_Required)
				if(!usr.target)
					A.DelayIt(15,usr,"None");return
			if(A.TurnedOn)
				A.TurnedOn=0
				A.Deactivate(usr)
				return
			if(A.BunshinAble)
				if(usr.KBunshinOn)
					var/C=src.controlled
					usr=C
				else
					usr=src
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
	//		if(usr.ManeCommand)
	//			usr.ManeCommand=0
	//			A.Activate(usr)
	//			return
			if(usr.Jailed)
				return
			if(usr.knockedout)
				if((istype(A,/obj/SkillCards/CursedSealActivation)))
					usr<<"You use the cursed seal to revive yourself."
				else if((istype(A,/obj/SkillCards/BodyShedding)))
					usr<<"You shed your skin reviving yourself."
				else if((!(istype(A,/obj/SkillCards/BodyShedding)))&&(!(istype(A,/obj/SkillCards/CursedSealActivation)))&&(!(istype(A,/obj/SkillCards/FalseDeath))))
					usr<<"Not now."
					return
			if(A.Delay)
				usr<<output("You must wait to use this technique.","Attack")
				return
			else if((usr.firing&&!usr.intank&&!usr.ControllingPuppet1&&!usr.ControllingPuppet2)||usr.Dead||usr.FrozenBind=="Dead"||(usr.DoingPalms&&src.name!="Body Flicker"&&src.name!="128 Palms"))
				usr<<"Not now."
				return
			else if(src.ByakuganTrack&&!(istype(A,/obj/SkillCards/Search))&&!(istype(A,/obj/SkillCards/Watch)))
				usr<<"You can't do this while using Byakugan's extended abilities."
				return
			else if(usr.Status=="Asleep")
				usr<<"You're consumed with drowzy, beautiful sleep. Mmm, amazing."

	//		if(usr.InKageMane)
			//	var/obj/SkillCards/P = src//To show taht this is the skillcard you're using
	//			for(var/mob/M in oview(10,usr))
	//				if(M!=usr&&M.KageManed)
	//					if(locate(A) in M.LearnedJutsus)
	//						var/obj/SkillCards/P = A
	//						if(usr.key=="CobraT1337")
	//							usr<<"[M] does have the Skillcard [src]. [M] will use [P]."
	//						M.ManeCommand=1
	//						P.Activate(M)
			A.Activate(usr)

mob/GainedAfterLogIn/verb
	ChangeSlot()
		set hidden=1
		if(usr.SlotYourOn=="1")
			usr.SlotYourOn="2"
			usr.UpdateQuickSlots()
			return
		else if(usr.SlotYourOn=="2")
			usr.SlotYourOn="1"
			usr.UpdateQuickSlots()
			return
	Slot1()
		set hidden=1
		usr.Slot(1)
	Slot2()
		set hidden=1
		usr.Slot(2)
	Slot3()
		set hidden=1
		usr.Slot(3)
	Slot4()
		set hidden=1
		usr.Slot(4)
	Slot5()
		set hidden=1
		usr.Slot(5)
	Slot6()
		set hidden=1
		usr.Slot(6)
	Slot7()
		set hidden=1
		usr.Slot(7)
	Slot8()
		set hidden=1
		usr.Slot(8)
	Slot9()
		set hidden=1
		usr.Slot(9)
	Slot10()
		set hidden=1
		usr.Slot(10)




mob/proc/CustomTaijutsu(AttName,AttackIconState="Attack1",ChargeTime,MoveType,SpinerOrStriker,Combo,StunOrPush,EXPCost,CallOutName)
	if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.doingG)
		return
	else
		var/ChargeLength
		if(ChargeTime)
			ChargeLength=ChargeTime
		if(ChargeLength>=0)
			src.icon_state="Power"
		while(ChargeLength>0)
			if(src.icon_state!="Power")
				return
			ChargeLength--
			sleep(1)
		if(CallOutName)
			view<<"[usr]: [AttName]!"//Put them calling out the name.
		MoveStart
		if(src.target)
			src.dir=get_dir(src,src.target)
		var/Damage=src.tai
		if(EXPCost>25000&&EXPCost<=75000)
			Damage=Damage*rand(25,90)
		if(EXPCost>75000&&EXPCost<=125000)
			Damage=Damage*rand(90,150)
		if(EXPCost>125000)
			Damage=Damage*rand(150,300)
		if(EXPCost>25000) Damage+=EXPCost*0.1
		if(EXPCost>50000) Damage+=EXPCost*0.01
		if(EXPCost>75000) Damage+=EXPCost*0.001
		if(EXPCost>100000) Damage+=EXPCost*0.0001
		if(EXPCost>125000) Damage+=EXPCost*0.00001
		if(EXPCost>150000) Damage+=EXPCost*0.000001
		if(EXPCost>200000) Damage+=EXPCost*0.0000001
		Damage=Damage+Damage*(ChargeTime*0.01)
		if(Combo>0)
			Damage=Damage+1/Combo
		if(MoveType=="Teleporter")
			if(src.target&&src.Running)
				var/mob/M=src.target;src.loc=locate(M.x,M.y-1,M.z)
				Damage=Damage-Damage*0.1
		if(SpinerOrStriker=="Striker")
			flick(AttackIconState,src)
			for(var/mob/M in get_step(src,src.dir))
				Damage=((Damage/(M.Endurance+1))/(M.BaikaCharged+1))
				src.DodgeCalculation(M)
				if(M.Dodging)
					M.Dodge();return
				else
					if(M.Guarding)
						viewers()<<sound('SFX/Guard.wav',0)
					else
						viewers()<<sound('SFX/HitMedium.wav',0)
					M.DamageProc(Damage,"Stamina",src)
					if(StunOrPush=="Stun")
						M.StunAdd(5)
					if(StunOrPush=="Push")
						flick("rasenganhit",M)
						M.HitBack(rand(2,7),src.dir)
		if(SpinerOrStriker=="Spinner")
			var/SpinTime=8
			while(SpinTime)
				flick(AttackIconState,src)
				for(var/mob/M in get_step(src,src.dir))
					Damage=((Damage/(M.Endurance+1))/(M.BaikaCharged+1))
					src.DodgeCalculation(M)
					if(M.Dodging)
						M.Dodge();return
					else
						Damage=Damage/4
						M.DamageProc(Damage,"Stamina",src)
						if(StunOrPush=="Stun")
							M.StunAdd(5)
						if(StunOrPush=="Push")
							M.dir=usr.dir
							flick("rasenganhit",M)
							M.HitBack(rand(1,7),usr.dir)
				src.dir--
				if(src.dir<=0)
					src.dir=8
				//DamageThing
				SpinTime--
				sleep(1)
		if(Combo>0)
			Combo--
			goto MoveStart

/*proc/V_alert(title,T,mob/M)
	if(!T||!istext(T)) return
	if(M.showing_window)
		while(M.showing_window)
			sleep(6)
		sleep(3)
	M.showing_window=1
	M<<browse\
({"<body bgcolor=black><font color=white><font face=Manga Speak><big><b><center>[title]</big></b></center><hr>[T]<BR><BR><hr />
<center><a href=?action=V_alert&source=\ref[src]>OK</a></center>"},"window=V_alert;titlebar=0;size=380x380")


client/Topic(href,href_list[])
	switch(href_list["action"])
		if("V_alert")
			usr<< browse(null,"window=V_alert")
			usr.showing_window=0
	return ..()




obj/var/Mastered=0
mob/proc/Learn(var/Techniquename)
	var/NewTechnique=text2path("/obj/Techniques/[Techniquename]")
//	var/obj/X=new NewTechnique()
//	if(src.Skills.Find(X))	return
//	src.Skills=X
	//if(src.Level!=1)	src<<"<b>You Learned [X]!!"
obj/SkillCards/proc/Upgrade(mob/M)
	if(src.UpgradeLV==0)	return
	if(src.LV==src.UpgradeLV)
		M.Learn("[src.Upgrade]")
obj/SkillNum
	icon='SkillNums.dmi'
	layer=HUD_LAYER+1
*/
obj/SkillCards
	var

		Uses=0
		Delay=0
		BunshinAble=1
		NonKeepable=0
		TurnedOn=0
		Banned=0
		Copied=0
		LV=1
		MLV=10
		EPcost=1
		ElementType=""
		Jtype=""
		NotAbleToGainKnowledge=0
		Jnature="Neutral"
		Jname=""
		Upgrade=""
		UpgradeLV=0
		list/seals=list("")
		des=""
		effect=""
		Slot=null
		Target_Required=0
	icon='Skillcards.dmi'
/*	New()
		//src.Jname="[src.Jnature][src.name]"
		var/obj/SkillNum/X=new()
		X.icon_state="[src.LV]"
		mouse_drag_pointer=src.icon_state
		src.overlays+=X
		src.UpdateLV()
		..()
	MouseDrop(over_object,src_location,over_location)
		if(istype(over_object,/obj/HUD/ActualHUD/TechniqueInfo))
			src.DisplayInfo()
		else if(istype(over_object,/obj/HotKey))
			over_object:icon_state=src.icon_state
			over_object:mouse_drag_pointer=src.icon_state
			var/obj/SkillNum/X=new()
			X.icon_state="[src.LV]"
			over_object:overlays+=X
			usr.HotKeys[over_object:slot]=src


	proc
		UpdateLV()
			src.overlays.Remove(src.overlays)
			var/obj/SkillNum/X=new()
			X.icon_state="[src.LV]"
			src.overlays+=X
		DisplayInfo()
			var/T="<center><b>[src.Jtype]Technique</center></b><hr>[src.des]<ul>[src.effect]</ul>"
			if(length(src.seals)>1)
				T+="<font color=white><hr><b>Technique: </b>"
				for(var/X as anything in src.seals)
					T+="[X] "
			//var/icon/I=new(src.icon,icon_state=src.icon_state,dir=SOUTH)
			//usr<<browse_rsc(I,"Picture")
			V_alert("[src.name] ([src.EPcost] EP)",T,usr)
*/
	proc
		Activate(mob/M)
			if(M.HandsSlipped||M.LeftHandSheath||M.RightHandSheath)
				NotAbleToGainKnowledge=1
			if(M.Phasing&&(istype(src,/obj/SkillCards/Phase)))
				M<<"You release the Phase Jutsu, beginning to solidify."
				M.Phasing=0
				src.DelayIt(10,M,"Clan")
				return
			else if(M.Phasing)
				M<<"You can't do this while holding the Phase Jutsu!"
				return
			else if(M.invisibility==100&&!(istype(src,/obj/SkillCards/Invisibility))&&!(istype(src,/obj/SkillCards/MindGenjutsu))&&!(istype(src,/obj/SkillCards/FalseBunshin)))
				M<<"You can't attack while invisible."
				return
			if(M.FoxTimeChamber)
				src.Uses+=100
			..()
		Deactivate(mob/M)
			..()
		DelayIt(Time,mob/M,Type="None")
			if(src.Delay)
				return
			var/Delay
			if(M&&Type=="Clan")
				Delay=Time
			if(M&&M.CursedSealType=="Earth"&&M.CursedSealActivated&&Type=="Tai")
				Delay*=0.35
			if(M&&Type=="Tai")
				Delay=Time-M.TaijutsuMastery
			else if(M&&Type=="Nin")
				Delay=Time-(M.NinjutsuMastery*2)
				//
				//
				if(prob(Time/10)&&M.NinjutsuMastery<10)
					M.NinjutsuMastery+=0.1
				if(prob(Time/10))
					M.NinjutsuKnowledge+=1
				if(M.NinjutsuKnowledge<10)
					if(prob(35))
						M.NinjutsuKnowledge++
				//The above code snippet was repeated throughout almost all ninjutsu skillcards in this file
				//When a code snippet is repeated exactly the same, there is no reason to do so because it just wastes space.
				//Instead we turn it into a proc to keep things efficient.

				//I also changed the probability from 15 to Time/10. This prevents people from spamming jutsus with low delays
				//to increase the passive quickly. Instead it is now the higher the delay, the higher the chance it has to raise.
				//Thus balancing it out.

			else if(Type=="Gen")
				Delay=Time
			else if(Type=="None")
				Delay=Time
			else if(Type=="Element")
				Delay=Time-((M.NinjutsuMastery*2)+round(M.GenSkill*2.5)) // The point of this change was to give Control a little bit of an effect.
				//We can also place all the elemental passive raising here like we did with Ninjutsu but I was too lazy at this point,
				//after doing all the Ninjutsu ones. Its not hard just tedious.
			if(M&&M.Clan=="Fuuma"&&Type!="Element") //The reason I went through and catagorized it like this also prevents Fuumas passive from acting on jutsu that it should not.
				Delay=Delay*0.5
			else if(M&&M.Clan=="Yotsuki"&&ElementType=="Raiton")
				if(M.RaitonKnowledge>1000)
					Delay=Delay*0.85
				else
					Delay=Delay*0.90

			if(M&&M.Trait=="Speedy")
				Delay*=0.9
			else if(M&&M.Trait2=="Hyperactivity"&&M.stamina<M.maxstamina/1.5)
				Delay*=0.85
			src.Delay=1
			if(M.Trait3=="Unyielding")
				Delay/=1.85
			src.overlays+='Skillcards2.dmi'
			if(M&&M.client)
				if(Slot!=null)
					for(var/obj/HUD/HotKeys/A in M.client.screen)
						if(A.type==text2path("/obj/HUD/HotKeys/Slot[Slot]"))
							A.overlays+='Skillcards2.dmi'
				//		M.UpdateCards()//Added 6/19/2013
			spawn(Delay)
				src.Delay=0
				src.overlays-='Skillcards2.dmi'
				if(M&&M.client)
					if(Slot!=null)
						for(var/obj/HUD/HotKeys/A in M.client.screen)

							if(A.type==text2path("/obj/HUD/HotKeys/Slot[Slot]"))
								A.overlays-='Skillcards2.dmi'
				//			M.UpdateCards()//Added 6/19/2013
	MouseDrag()
		mouse_drag_pointer=icon(src.icon,src.icon_state)
	MouseDrop(over_object,src_location,over_location,src_control,over_control)
		if(src!=over_object)
			if(src_control=="Jutsu.Jutsus"&&over_control=="Jutsu.Jutsus"&&over_object)
				usr.LearnedJutsus.Swap(usr.LearnedJutsus.Find(src),usr.LearnedJutsus.Find(over_object))
				usr<<output(src,"[over_control]:[over_location]")
				usr<<output(over_object,"[src_control]:[src_location]")
			else if(src_control=="Jutsu.Jutsus"&&over_control=="default.mapwindow"&&istype(over_object,/obj/HUD/HotKeys/))
				var/obj/SkillCards/A = src
				if(!A)
					return
				else
					if(A.Delay)
						usr<<"You can't change the slot while you're on delay.";return
					for(var/obj/SkillCards/C in usr.LearnedJutsus)
						if(C.Slot==over_object:Slot)
							C.Slot=null
					A.Slot=over_object:Slot
					usr<<"You set [A] to slot [over_object:Slot]."
					//for(var/obj/HUD/HotKeys/Slot1/X in usr.client.screen)
					over_object:icon=A.icon
					over_object:icon_state=A.icon_state
					var/icon/I=new('Skillcards.dmi',"HotKey[over_object:Slot]")
					over_object:overlays+=I
		mouse_drag_pointer = MOUSE_INACTIVE_POINTER
	Click()
		if(usr.Jailed)
			return
		if(src.type in BannedJutsu)
			usr<<"This jutsu is banned!";src.DelayIt(50,usr,"None");return
		if(usr.UsingStakes)
			usr.UsingStakes=0
		if(src.Target_Required)
			if(!usr.target)
				src.DelayIt(15,usr,"None");return
		if(src.TurnedOn)
			src.TurnedOn=0
			src.Deactivate(usr)
			return
//		if(usr.ManeCommand)
//			usr.ManeCommand=0
//			src.Activate(usr)

//			return

		if(usr.knockedout)
			if((istype(src,/obj/SkillCards/CursedSealActivation)))
				usr<<"You activate the power of your Cursed Mark and force yourself awake!"
			else if((istype(src,/obj/SkillCards/BodyShedding)))
				usr<<"You shed your skin reviving you."
			else if(!istype(src,/obj/SkillCards/FalseDeath))
				usr<<"Not now."
				return

		if(src.Delay>0)
			usr<<output("You must wait to use this technique.","Attack")
			return
		else if(usr.Status=="Asleep")
			usr<<"You're consumed with drowzy, beautiful sleep. Mmm, amazing."
		else if(usr.resting||usr.meditating)
			usr<<"You can't do this, you're resting or in chakra generation mode."
			return
		if((usr.firing&&(!usr.InKageMane&&src.name!="Shadow Mimic Jutsu")&&!usr.intank&&!usr.ControllingPuppet1&&!usr.ControllingPuppet2)||usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms&&src.name!="128 Palms")
			usr<<"Not now."//(usr.firing&&!usr.InKageMane&&src.name!="Shadow Mimic Jutsu")
			return
		if(src.BunshinAble)
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
//		if(usr.InKageMane)
//			for(var/mob/M in oview(10,usr))
//				if(M!=usr&&M.KageManed)
//					if(locate(src) in M.LearnedJutsus)
//						var/obj/SkillCards/P = src
//						if(usr.key=="CobraT1337")
//							usr<<"[M] does have the Skillcard [src]. [M] will use [src]."
//						M.ManeCommand=1
//						P.Activate(M)

		src.Activate(usr)
		..()

////////////////////////////////////////
//Exclusive Stuff
/////////////////////
	Custom_Taijutsu
		name="CustomJutsu"
		icon_state="CustomJutsu"
		var
			ExpCost=0

			Style
			//If Style is Taijutsu
			Charge=0//Charge time
			Combo=0
			MoveType="Striker"//Striker or Teleport. Striker = Asshou, Teleport like Senpuu that teleports if you're running
			SpinerOrStriker="Spinner"//1 = Strike Forward
			StunOrPush
			AttackIconState

			CallOutName=0
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				var/DelayTime=src.ExpCost*0.01
				if(DelayTime>600)
					DelayTime=600
				src.DelayIt(DelayTime,usr)
				var/AmountofCombos=0
				if(Combo)
					AmountofCombos=src.ExpCost/10000
				usr.CustomTaijutsu(src.name,AttackIconState="Attack1",src.Charge,src.MoveType,src.SpinerOrStriker,AmountofCombos,src.StunOrPush,src.ExpCost,src.CallOutName)
				src.Uses+=1
	CustomJutsuNinjutsu
		name="CustomJutsu"
		icon_state="CustomJutsu"
		var
			ExpCost=0


			//If Style is Ninjutsu
			ChakraNature
			Projectile
			//If style is Projectile
			ProjectilesIconState
////////////////////////////////////////
//Clans
/////////////////////
//Astral Clan(DO NOT MAKE PUBLIC)///////////
	AstralSoulProject
		name="AstralSoul Projection"
		icon_state="Bunshin"
		Activate(mob/M)
			if(M.AstralSoulAtta)
				return
			if(M.AstralSoulForm)
				M.AstralSoulProjection()
				src.DelayIt(50,M,"Clan")
				return
			if(M.knockedout)
				return
			M.AstralSoulProjection()
			src.Uses+=1
	AstralSoulManifest
		name="AstralSoul Manifest"
		icon_state="Bunshin"
		Activate(mob/M)
			if(M.knockedout)
				return
			if(!M.AstralSoulForm)
				return
			if(M.AstralSoulForm)
				M.AstralSoulManifest()
				src.Uses+=1
				src.DelayIt(10,M,"Clan")
				return
	AstralSoulSeek
		name="AstralSoul Seek"
		icon_state="Bunshin"
		Activate(mob/M)
			if(M.knockedout)
				return
			if(!M.AstralSoulForm)
				return
			if(M.AstralSoulAtta)
				return
			if(M.AstralSoulHeal)
				return
			if(M.AstralSoulForm)
				M.AstralSoulSeek()
				src.Uses+=1
				src.DelayIt(10,M,"Clan")
				return
	AstralSoulAttach
		name="AstralSoul Attach"
		icon_state="Bunshin"
		Activate(mob/M)
			if(M.knockedout)
				return
			if(!M.AstralSoulForm)
				return
			if(M.AstralSoulForm)
				M.AstralSoulAttach()
				src.Uses+=1
				src.DelayIt(10,M,"Clan")
				return
	AstralSoulHeal
		name="AstralSoul Heal"
		icon_state="Bunshin"
		Activate(mob/M)
			if(M.knockedout)
				return
			if(!M.AstralSoulForm)
				return
			if(!M.AstralSoulAtta)
				M<<"You need to possess someone!"
				return
			if(M.AstralSoulHeal)
				M<<"Your already Healing!"
				return
			if(M.AstralSoulAtta)
				M.AstralSoulHeal()
				src.Uses+=1
				src.DelayIt(50,M,"Clan")
				return
//Aburame//////////////

	SummonKonchuu
		name="Summon Kikaichuu"
		icon_state="SummonKonchuu"
		Activate(mob/M)
			if(M.SummonedNumber>=10)
				src.DelayIt(100,M)
				M.DelBugs()

				return
			src.DelayIt(10,M,"Clan")
			src.Uses+=1
			if(prob(15))
				M.BugMastery+=0.1;if(M.BugMastery>50) M.BugMastery=50
			if(prob(15))
				if(M.BugMastery>=50)
					M.BugKeeper+=0.1
			M.SummonKonchuu()
	UnsummonKonchuu
		name="Unsummon Kikaichuu"
		icon_state="UnsummonKonchuu"
		Activate(mob/M)
			M.unsummonkonchuu()
	PlaceBug
		name="Place Bug"
		icon_state="PlaceBug"
		Activate(mob/M)
			src.DelayIt(200,M,"Clan")
			src.Uses+=1
			if(prob(15))
				M.BugMastery+=0.1;if(M.BugMastery>50) M.BugMastery=50
			if(prob(15))
				if(M.BugMastery>=50)
					M.BugKeeper+=0.1
			src.DelayIt(300,M)
			M.Placekonchuu()
	UnPlaceBug
		name="Take-Off Bug"
		icon_state="UnPlaceBug"
		Activate(mob/M)
			src.Uses+=1
			M.DestroyKonchuu()
	KonchuuTracking
		name="Kikkaichu Tracking"
		icon_state="KonchuuTracking"
		Activate(mob/M)
			src.DelayIt(350,M,"Clan")
			src.Uses+=1
			if(prob(15))
				M.BugMastery+=0.1;if(M.BugMastery>50) M.BugMastery=50
			if(prob(15))
				if(M.BugMastery>=50)
					M.BugKeeper+=0.1
			M.Konchuutracking()
	KikkaichuDrain
		name="Kikkaichu Drain"
		icon_state="KikkaichuDrain"
		Activate(mob/M)
			src.Uses+=1
			if(prob(15))
				M.BugMastery+=0.1;if(M.BugMastery>50) M.BugMastery=50
			if(prob(15))
				if(M.BugMastery>=50)
					M.BugKeeper+=0.1
			M.KonchuuDrain()
	KekkaiSheild
		name="Kikaichuu Shield"
		icon_state="KekkaiSheild"
		Activate(mob/M)
			src.Uses+=1
			if(M.UsingBugShield)
				M.UsingBugShield=0
				for(var/mob/Bugs/BugShield/B in world)
					if(B.Owner==usr)
						walk_towards(B,M)
						spawn(40)
							if(B)
								del(B)
				src.DelayIt(300,M,"Clan")
				return
			if(prob(15))
				M.BugMastery+=0.1;if(M.BugMastery>50) M.BugMastery=50
			if(prob(15))
				if(M.BugMastery>=50)
					M.BugKeeper+=0.1
			M.KonchuuShield()
	MushiDama
		name="Insect Sphere"
		icon_state="MushiDama"
		Activate(mob/M)
			src.Uses+=1
			if(prob(15))
				M.BugMastery+=0.1;if(M.BugMastery>50) M.BugMastery=50
			if(prob(15))
				if(M.BugMastery>=50)
					M.BugKeeper+=0.1
			src.DelayIt(850,M,"Clan")
			M.MushiDama()
	KekkaiKonchuuBunshin
		name="Insect Clone Jutsu"
		icon_state="MushiBunshin"
		Activate(mob/M)
			if(prob(15))
				M.BugMastery+=0.1;if(M.BugMastery>50) M.BugMastery=50
			if(prob(15))
				if(M.BugMastery>=50)
					M.BugKeeper+=0.1
			src.Uses+=1
			src.DelayIt(300,M,"Clan")
			M.KekkaiKonchuuBunshinnoJutsu()
	KekkaiArashi
		name="Insect Storm"
		icon_state="KekkaiArashi"
		Activate(mob/M)
			if(prob(15))
				M.BugMastery+=0.1;if(M.BugMastery>50) M.BugMastery=50
			if(prob(15))
				if(M.BugMastery>=50)
					M.BugKeeper+=0.5
			src.Uses+=1
			src.DelayIt(650,M,"Clan")
			M.KekkaiArashi()
	//Special bug Attacks
	NanoMite1
		name="NanoMite Burst"
		icon_state="NanoBurst"
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(50,M,"Clan")
//			M.SpecialSwarm(Mode="Health",Controllable=0,Number=1,Line=0,Circle=0,RequiredBugs=20)
	NanoMite2
		name="NanoMite Swarm"
		icon_state="NanoSwarm"
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(250,M,"Clan")
	//		M.SpecialSwarm(Mode="Health",Controllable=0,Number=1,Line=1,Circle=0,RequiredBugs=200)
	NanoMite3
		name="NanoMite Gathering"
		icon_state="NanoGathering"
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(650,M,"Clan")
		//	M.SpecialSwarm(Mode="Health",Controllable=1,Number=1,Line=0,Circle=1,RequiredBugs=4000)
	NanoMite4
		name="NanoMite Omni Burst"
		icon_state="NanoOmni"
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(450,M,"Clan")
		//	M.SpecialSwarm(Mode="Health",Controllable=0,Number=1,Line=0,Circle=1,RequiredBugs=1600)
	NanoMite5
		name="NanoMite Medic Swarm"
		icon_state="NanoSwarmHeal"
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(450,M,"Clan")
		//	M.SpecialSwarm(Mode="Health Heal",Controllable=1,Number=3,Line=0,Circle=0,RequiredBugs=1500)
//Akimichi//////////////
	Baika
		name="Body Expansion"
		icon_state="Baika"
		Activate(mob/M)
			if(prob(95-src.Uses)||M.Trait=="Genius"&&prob(50)&&src.Uses<100)
				M.SizeMastery+=pick(1,2);if(M.SizeMastery>50) M.SizeMastery=50
			src.Uses+=1
			src.DelayIt(600,M,"Clan")
			M.BaikaNoJutsu()
	Nikudan
		name="Rolling Meat Tank"
		icon_state="Nikudan"
		Activate(mob/M)
			if(M.intank)
				M.intank=0;M.Normal();M.overlays-='AkimichiTechniques.dmi';M.firing=0
				walk(M,0)
				src.DelayIt(250,M,"Clan")
				return
			if(prob(95-src.Uses)||M.Trait=="Genius"&&prob(50)&&src.Uses<100)
				M.SizeMastery+=pick(1,2);if(M.SizeMastery>50) M.SizeMastery=50
			src.Uses+=1
			M.Nikudan()
//	SpikedNikuudan
//		name="Spiked Rolling Meat Tank"
//		icon_state="NikudanSpikes"


	BubunBaika
		name="Partial Body Expansion"
		icon_state="BubunBaika"
		Activate(mob/M)
			if(prob(95-src.Uses)||M.Trait=="Genius"&&prob(50)&&src.Uses<100)
				M.SizeMastery+=pick(3,5);if(M.SizeMastery>50) M.SizeMastery=50
			src.DelayIt(450,M,"Clan")
			src.Uses+=1
			M.BubunBaika()
	AkimachiSlam
		name="Akimichi Slam"
		icon_state="DoubleStrike"
		Activate(mob/M)
			if(prob(95-src.Uses)||M.Trait=="Genius"&&prob(50)&&src.Uses<100)
				M.SizeMastery+=pick(3,5);if(M.SizeMastery>50) M.SizeMastery=50
			src.DelayIt(450,M,"Clan")
			src.Uses+=1
			M.AkimachiSlam()
//Haku//////////////////
	SensatsuSuishou
		name="Ice Senbon"
		icon_state="Sensatsu"
		Target_Required=1
		Activate(mob/M)
			if(M.hyoushou)
				if(!M.target)
					M<<"You need to target them when in the mirrors!";return
			if(prob(95-src.Uses)||M.Trait=="Genius"&&prob(50)&&src.Uses<100)
				M.IceRush+=pick(0.1,0.2);if(M.IceRush>100) M.IceRush=100
			if(M.TypeLearning=="Hyouton")
				M.exp+=rand(25,100)
			src.DelayIt(150,M,"Clan")
			src.Uses+=1
			M.SensatsuSuishou()
	ISawarabi
		name="Forest of Ice Sickles"
		icon_state="AisuSawarabi"
		Activate(mob/M)
			if(prob(95-src.Uses)||M.Trait=="Genius"&&prob(50)&&src.Uses<100)
				M.IceRush+=pick(0.1,0.2);if(M.IceRush>100) M.IceRush=100
			if(M.TypeLearning=="Hyouton")
				M.exp+=rand(50,350)
			src.DelayIt(550,M,"Clan")
			src.Uses+=1
			M.ISawarabi(src.Uses)
	IceField//IceField
		name="Hyouton: Ice Creation"
		icon_state="IceField"
		Activate(mob/M)
			if(prob(95-src.Uses)||M.Trait=="Genius"&&prob(50)&&src.Uses<100)
				M.IceRush+=pick(0.1,0.2);if(M.IceRush>100) M.IceRush=100
			if(M.TypeLearning=="Hyouton")
				M.exp+=rand(50,350)
			src.DelayIt(750,M,"Clan")
			src.Uses+=1
			M.IceField(Uses)
	IcePrison
		name="Hyouton: Ice Prison"
		icon_state="IcePrison"
		Activate(mob/M)
			if(prob(95-src.Uses)||M.Trait=="Genius"&&prob(50)&&src.Uses<100)
				M.IceRush+=pick(0.1,0.2);if(M.IceRush>100) M.IceRush=100
			if(M.TypeLearning=="Hyouton")
				M.exp+=rand(50,350)
			src.DelayIt(750,M,"Clan")
			src.Uses+=1
			M.IcePrison()


	MakyouHyoushou
		name="Crystal Ice Mirrors"
		icon_state="MakyouHyoushou"
		BunshinAble=0
		Activate(mob/M)
			if(M.hyoushou)
				for(var/obj/Jutsu/Elemental/Hyouton/DemonMirror/S in world)
					if(S.Owner==M)
						del(S)
				sleep(1)
				M.hyoushou=0
				M.UnableToChargeChakra=0
				src.DelayIt(600,M,"Clan")
				return
			if(prob(95-src.Uses)||M.Trait=="Genius"&&prob(50)&&src.Uses<100)
				M.IceRush+=pick(0.1,0.2);if(M.IceRush>100) M.IceRush=100
			if(M.TypeLearning=="Hyouton")
				M.exp+=rand(50,350)
			src.Uses+=1
			M.MakyouHyoushou()
	SnowShuriken
		name="Ice Shuriken"
		icon_state="YukiShuriken"
		Activate(mob/M)
			if(prob(95-src.Uses)||M.Trait=="Genius"&&prob(50)&&src.Uses<100)
				M.IceRush+=pick(0.1,0.2);if(M.IceRush>100) M.IceRush=100
			if(M.TypeLearning=="Hyouton")
				M.exp+=rand(50,350)
			src.DelayIt(150,M,"Clan")
			src.Uses+=1
			M.SnowShuriken(src.Uses)
	SnowAura
		name="Aura of Snow"
		icon_state="YukiShuriken"
		Activate(mob/M)
			if(prob(95-src.Uses)||M.Trait=="Genius"&&prob(50)&&src.Uses<100)
				M.IceRush+=pick(0.1,0.2);if(M.IceRush>100) M.IceRush=100
			if(M.TypeLearning=="Hyouton")
				M.exp+=rand(50,350)
			src.DelayIt(150,M,"Clan")
			src.Uses+=1
			M.SnowAura(src.Uses)
////Part2
	IceShard
		name="Ice Shard Jutsu"
		icon_state="IceShard"
		Activate(mob/M)
			if(prob(95-src.Uses)||M.Trait=="Genius"&&prob(50)&&src.Uses<100)
				M.IceRush+=pick(0.1,0.2);if(M.IceRush>100) M.IceRush=100
			if(M.TypeLearning=="Hyouton")
				M.exp+=rand(50,350)
			src.DelayIt(250,M,"Clan")
			src.Uses+=1
			M.IceShard(Uses)

//Hoshigaki/////////////
	SamehadeReturn
		icon_state="SamehadeReturn"
		Activate(mob/M)
			M<<"Disabled."
	samehadeChakraDrain
		name="Samehade: Chakra Drain"
		icon_state="SamehadeAbsorbtion"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(250,M,"Clan")
			M.samehadeChakraDrain()
	samehadeShred
		name="Samehade: Shred"
		icon_state="SamehadeShred"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(250,M,"Clan")
			M.SamehadeShred()
	samehadeThrow
		name="Samehade: Throw"
		icon_state="SamehadeThrow"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(250,M,"Clan")
			M.samehadeThrowing()
	samehadeUnleash
		name="Samehade: Unleash"
		icon_state="Daibakufu"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(600,M,"Clan")
			M.SamehadeUnleash()
	SamehadeDaibakufu
		name="Grand Waterfall Jutsu"
		icon_state="Daibakufu"
		NonKeepable = 1
		Activate(mob/M)
	//		if(src.Uses<100&&M.Trait!="Genius")
	//			if(prob(95-src.Uses))
	//				M<<output("The jutsu failed.","Attack");return
	//		else if(M.Trait=="Genius"&&src.Uses<50)
	//			if(prob(50-src.Uses))
	//				M<<output("The jutsu failed.","Attack");return
			if(prob(15))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(2650,3200)
			src.DelayIt(700,M,"Element")
			src.Uses+=1
			M.DaibakufuZ()

	SamehadeSuigadan
		name="Water Fang Jutsu"
		icon_state="Suigadan"
		Target_Required=1
		NonKeepable = 1
		Activate(mob/M)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.DelayIt(250,M,"Element")
			src.Uses+=1
			M.Suigadan()
	SamehadeSuiryuudan
		name="Water Dragon Jutsu"
		icon_state="Suiryuudan"
		BunshinAble=0
		NonKeepable = 1
		Deactivate(mob/M)
			M.SuiryuudanZ()
			src.DelayIt(350,M,"Element")
		Activate(mob/M)
			for(var/obj/Jutsu/Elemental/Suiton/Suiryedan/K in world)
				if(K.Owner==M)
					src.Deactivate(M)
					return
			if(prob(15))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(250,1000)
			src.DelayIt(350,M,"Element")
			src.Uses+=1
			M.SuiryuudanZ()

	SamehadeMizuameNabara
		name="Starch Syrup Capture Field"
		icon_state="StickySyrup"
		NonKeepable = 1
		Activate(mob/M)
			if(prob(15))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.DelayIt(1200,M,"Element")
			src.Uses+=1
			M.Syrup_Capture()

	SamehadeMizurappa
		name="Samehade Violent Water Wave"
		icon_state="Mizurappa"
		NonKeepable=1
		Activate(mob/M)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.DelayIt(250,M,"Element")
			src.Uses+=1
			M.MizurappaNoJutsu()

	SamehadeSuikoudan
		name="Samehade Water Shark Jutsu"
		icon_state="Suikoudan"
		NonKeepable=1
		Activate(mob/M)
			if(prob(15))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.DelayIt(650,M,"Element")
			src.Uses+=1
			M.SuikoudanZ(src.Uses)

	SamehadeBakuSuishouha
		name="Samehade Bursting Collision Waves"
		icon_state="BakuSuishou"
		NonKeepable=1
		Activate(mob/M)
			if(prob(15))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(725,1500)
			src.DelayIt(1100,M,"Element")
			src.Uses+=1
			M.BakuSuishouha(src.Uses)

	SamehadeTeppoudama
		name="Samehade Water Bullet"
		icon_state="Water Bullet"
		NonKeepable=1
		Activate(mob/M)
			if(prob(15))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(750,2000)
			src.DelayIt(600,M,"Element")
			src.Uses+=1
			M.Teppoudama()


//Hyuuga////////////////
	Byakugan
		icon_state="Byakugan"
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(150,M,"Clan")
			if(M.knockedout)
				return
			M.ByakuganOn()
			src.Uses+=1
	Range
		icon_state="Range"
		BunshinAble=0
		NonKeepable=1
		Activate(mob/M)
			spawn()
				src.DelayIt(30,M,"Clan")
			M.RangeExtension(0)
	Sense
		icon_state="Sense"
		BunshinAble=0
		NonKeepable=1
		Activate(mob/M)
			spawn()
				src.DelayIt(30,M,"Clan")
			M.ByaSense()
	Watch
		icon_state="Watch"
		BunshinAble=0
		NonKeepable=1
		Activate(mob/M)
			M.Watch()
			spawn()
				src.DelayIt(80,M,"Clan")
	RangeExtend
		icon_state="RangeExtend"
		BunshinAble=0
		NonKeepable=1
		Activate(mob/M)
			spawn()
				src.DelayIt(30,M,"Clan")
			M.RangeExtension(Goggles=1)

	Search
		icon_state="Search"
		BunshinAble=0
		NonKeepable=1
		Activate(mob/M)
			spawn()
				src.DelayIt(30,M,"Clan")
			M.ByaSearch()
	Kaiten
		name="Rotation"
		icon_state="Kaiten"
		Activate(mob/M)
			if(!M.client) return
			if(M.DoingPalms) return
			if(prob(15))
				M.StanceMastery+=0.5;if(M.StanceMastery>75) M.StanceMastery=75
			if(prob(20)&&M.bya)
				M.TaijutsuKnowledge+=pick(0.5,1,1.2,1.5)
			if(prob(20))
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			src.DelayIt(200,M)
			for(var/obj/SkillCards/KaitenKizu/A in M.LearnedJutsus)
				A.DelayIt(200,M,"Clan")
			src.Uses+=1
			M.Kaiten()
	KaitenKizu
		name="Reverse Rotation"
		icon_state="KaitenKizu"
		Activate(mob/M)
			if(!M.client) return
			if(M.DoingPalms) return
			if(prob(15))
				M.StanceMastery+=0.5;if(M.StanceMastery>75) M.StanceMastery=75
			if(prob(20)&&M.bya)
				M.TaijutsuKnowledge+=pick(0.5,1,1.2,1.5)
			if(prob(20)&&M.bya)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(!M.bya)
				M<<"You must have Byakugan on!";src.DelayIt(15,M);return
			src.DelayIt(600,M,"Clan")
			src.Uses+=1
			M.KaitenKizu()
	Rokujuu
		name="64 Palms"
		BunshinAble=0
		icon_state="Rokujuu"
		Activate(mob/M)
			if(!M.bya)
				M<<"You must have Byakugan on!";src.DelayIt(15,M);return
			if(prob(15))
				M.StanceMastery+=0.5;if(M.StanceMastery>75) M.StanceMastery=75
			if(prob(20)&&M.bya)
				M.TaijutsuKnowledge+=pick(0.5,1,1.2,1.5)
			if(prob(20)&&M.bya)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			src.DelayIt(600,M,"Clan")
			src.Uses+=1
			oview(M,8)<<"[M] changes their stance."
			var/Time=50
			if(M.ByakuganMastery>=1500)
				Time+=10
			if(M.ByakuganMastery>=3000)
				Time+=10
			if(M.ByakuganMastery>=5000)
				Time+=10
			M<<"You enter the 8 trigrams stance! You have [Time/10] seconds!";
			if(M.DoingPalms)
				M<<"You're already in the stance!";return
			M.DoingPalms=1
			spawn(Time)
				if(M.DoingPalms==1)
					M.DoingPalms=0;M<<"You ran out of time to begin the jutsu!"
	Hyakuni
		name="128 Palms"
		BunshinAble=0
		icon_state="Hyakuni"
		Activate(mob/M)
			if(!M.DoingPalms)
				M<<"You need to be in the 8 trigrams stance to use 128 Palms!";
				src.DelayIt(950,M,"Clan")
				return
			if(prob(15))
				M.StanceMastery+=0.5;if(M.StanceMastery>75) M.StanceMastery=75
			if(prob(20))
				M.TaijutsuKnowledge+=pick(0.5,1,1.2,1.5)
			src.DelayIt(900,M,"Clan")
			src.Uses+=1
		//	M.HakkeHyakunijuuhachishouz()
			oview(M,8)<<"[M] perfects their stance."
			var/Time=50
			if(M.ByakuganMastery>=1500)
				Time+=10
			if(M.ByakuganMastery>=3000)
				Time+=10
			if(M.ByakuganMastery>=5000)
				Time+=10
			M<<"You strengthen your 8 trigrams stance to prepare for 128 Palms! You have [Time] seconds!";

			M.DoingPalms=5
			spawn(Time)
				if(M.DoingPalms==5)
					M.DoingPalms=0;M<<"You ran out of time to begin the jutsu!"
	TenketsuHagemi
		name="Chakra Point Rejuvenation"
		icon_state="TenketsuHagemi"
		BunshinAble=0
		Activate(mob/M)
			if(!M.bya)
				M<<"You must have Byakugan on!";src.DelayIt(15,M);return
			if(prob(15))
				M.StanceMastery+=0.5;if(M.StanceMastery>75) M.StanceMastery=75
			src.DelayIt(600,M,"Clan")
			src.Uses+=1
			M.TenketsuHagemi()
	PalmThrust
		name="Palm Thrust"
		icon_state="PalmThrust"
		Activate(mob/M)
			if(!M.bya)
				M<<"You must have Byakugan on!";src.DelayIt(15,M);return
			if(prob(15))
				M.StanceMastery+=0.5;if(M.StanceMastery>75) M.StanceMastery=75
			if(prob(20)&&M.bya)
				M.TaijutsuKnowledge+=pick(0.2,0.4,0.45,0.5)
			if(prob(20))
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			src.DelayIt(350,M,"Clan")
			src.Uses+=1
			M.PalmThrust()
	TenketsuStrike
		name="Jyuuken: Tenketsu Strike"
		icon_state="Kuusho"
		Activate(mob/M)
			if(!M.bya)
				M<<"You must have Byakugan on!";src.DelayIt(15,M);return
			if(prob(15))
				M.StanceMastery+=0.5;if(M.StanceMastery>75) M.StanceMastery=75
			if(prob(20)&&M.bya)
				M.TaijutsuKnowledge+=pick(0.2,0.4,0.45,0.5)
			if(prob(20))
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			src.DelayIt(1300,M,"Clan")
			for(var/obj/SkillCards/Rokujuu/A in M.LearnedJutsus)
				A.DelayIt(300,M,"Clan")
			src.Uses+=1
			M.TenketsuStrike()

	Kuusho
		name="Divine Air Palm"
		icon_state="Kuusho"
		Activate(mob/M)
			if(prob(15))
				M.StanceMastery+=0.5;if(M.StanceMastery>75) M.StanceMastery=75
	//		if(prob(20)&&M.bya)
	//			M.TaijutsuKnowledge+=pick(0.2,0.4,0.45,0.5)
	//		if(prob(20))
	//			M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			src.DelayIt(17,M,"Clan")
			src.Uses+=1
			M.Kuusho()
//Inuzuka///////////////
	Shikyaku
		name="Four-Legged Technique"
		icon_state="Shikyaku"
		Activate(mob/M)
			if(prob(30))
				M.Canine+=pick(0.1,0.2,0.3);if(M.Canine>50) M.Canine=50
			src.DelayIt(170,M,"Clan")
			src.Uses+=1
			M.Shikyaku()
	BeastClaws
		name="Man-Beast Claws"
		icon_state="BeastClaws2"
		Activate(mob/M)
			if(prob(30))
				M.Canine+=pick(0.1,0.2,0.3);if(M.Canine>50) M.Canine=50
	//		src.DelayIt(170,M)
			src.Uses+=1
			usr.ManBeastClaws();src.Uses+=1
	JuujinBunshin
		name="Man-Beast Clone"
		icon_state="JuujinBunshin"
		Activate(mob/M)
			if(prob(30))
				M.Training+=pick(0.1,0.2,0.3);if(M.Training>50) M.Training=50
			src.DelayIt(170,M,"Clan")
			src.Uses+=1
			M.JuujinBunshin()
	Tsuuga
		name="Piercing Fang"
		icon_state="Tsuuga"
		Activate(mob/M)
			if(prob(30))
				M.Training+=pick(0.1,0.2,0.3);if(M.Training>50) M.Training=50
			if(prob(30))
				M.Canine+=pick(0.1,0.2,0.3);if(M.Canine>50) M.Canine=50
			src.DelayIt(370,M,"Clan")
			src.Uses+=1
			M.Tsuuga()
	Gatsuuga
		name="Dual Piercing Fang"
		icon_state="Gatsuuga"
		Activate(mob/M)
			if(prob(30))
				M.Training+=pick(0.1,0.2,0.3);if(M.Training>50) M.Training=50
			if(prob(30))
				M.Canine+=pick(0.1,0.2,0.3);if(M.Canine>50) M.Canine=50
			if(prob(20))
				M.DogCompanionship+=pick(0.1,0.2,0.25);
			src.DelayIt(500,M,"Clan")
			src.Uses+=1
			M.Gatsuuga1()
	ExplodingPuppy
		name="Exploding Puppy Jutsu"
		icon_state="ExplodingPuppy"
		Activate(mob/M)
			if(prob(20))
				M.DogCompanionship+=pick(0.1,0.2)
			if(prob(30))
				M.Training+=pick(0.1,0.2,0.3);if(M.Training>50) M.Training=50
			src.DelayIt(825,M,"Clan")
			src.Uses+=1
			M.ExplodingPuppy()
	DoubleHeadedWolf
		name="Double-Headed Wolf"
		icon_state="DoubleHeadedWolf"
		Activate(mob/M)
			if(M.inso)
				M.inso=0;src.DelayIt(600,M,"Clan");return
			if(prob(30))
				M.Training+=pick(0.1,0.2,0.3);if(M.Training>50) M.Training=50
			if(prob(50))
				M.Canine+=pick(0.1,0.2,0.3);if(M.Canine>50) M.Canine=50
			src.Uses+=1
			M.Soutourou()
	Garouga
		name="Garouga"
		icon_state="Garouga"
		Activate(mob/M)
			if(prob(30))
				M.Training+=pick(0.1,0.2,0.3);if(M.Training>50) M.Training=50
			if(prob(30))
				M.Canine+=pick(0.1,0.2,0.3);if(M.Canine>50) M.Canine=50
			src.Uses+=1
			M.Garouga()
			src.DelayIt(750,M,"Clan")
	ScentCheck
		name="Check Scents"
		icon_state="Garouga"
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(250,M,"Clan")
			M.CheckScents()
	ScentGather
		name="Gather A Scent"
		icon_state="Garouga"
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(950,M,"Clan")
			M.ScentTrackStart()
	ScentLocate
		name="Location: Scent"
		icon_state="Garouga"
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(100,M,"Clan")
			M.TrackScent()
//Iwazuka////////////////
	Katsu
		name="Katsu"
		icon_state="Katsu"
		Activate(mob/M)
			if(prob(20))
				M.ExplosiveMastery+=rand(0.1,0.3);if(M.ExplosiveMastery>100) M.ExplosiveMastery=100
			src.DelayIt(60,M,"Clan")
			src.Uses+=1
			M.Katsu()

	SetLeftHand
		name="Set Left Hand"
		icon_state="SetLeftHand"
		Activate(mob/M)
			usr.SetLeftHand()
	SetRightHand
		name="Set Right Hand"
		icon_state="SetRightHand"
		Activate(mob/M)
			usr.SetRightHand()
	C1
		name="C1"
		icon_state="C1"
		Activate(mob/M)
			usr.C1()
	C2
		name="C2"
		icon_state="C2"
		Activate(mob/M)
			usr.C2()
	C3
		name="C3"
		icon_state="C3"
		Activate(mob/M)
			if(prob(35))
				M.ClayMastery+=1;if(M.ClayMastery>100) M.ClayMastery=100
			src.DelayIt(1200,M,"Clan")
			src.Uses+=1
			usr.CreateC3()
	C4
		name="C4"
		icon_state="C4"
		Activate(mob/M)
			if(prob(35))
				M.ClayMastery+=1;if(M.ClayMastery>100) M.ClayMastery=100
			src.DelayIt(600,M,"Clan")
			src.Uses+=1
			usr.CreateC4()
	C0
		name="C0"
		icon_state="C4"
		Activate(mob/M)
			if(prob(35))
				M.ClayMastery+=1;if(M.ClayMastery>100) M.ClayMastery=100
				M.ExplosiveMastery+=0.1;if(M.ExplosiveMastery>100) M.ExplosiveMastery=100
			src.DelayIt(1000,M,"Clan")
			src.Uses+=1
			usr.CreateC0()

	Clay_Carrier
		icon_state="IwazukaCarrierBird"
		Activate(mob/M)
			if(prob(35))
				M.ClayMastery+=1;if(M.ClayMastery>100) M.ClayMastery=100
			src.DelayIt(600,M,"Clan")
			src.Uses+=1
			usr.CreateFlyingBird()

	Spikes
		name="Spikes"
		icon_state="C3"
		Activate(mob/M)
			if(prob(35))
				M.ClayMastery+=1;if(M.ClayMastery>100) M.ClayMastery=100
			src.DelayIt(300,M,"Clan")
			src.Uses+=1
			usr.CreateExposiveSpike()

	ClayKunai
		name="Clay: Kunai"
		icon_state="Ninken"
		Activate(mob/M)
			if(prob(35))
				M.ClayMastery+=1;if(M.ClayMastery>100) M.ClayMastery=100
			if(usr.CSet=="C1")
				src.DelayIt(10,M,"Clan")
			if(usr.CSet=="C2")
				src.DelayIt(100,M,"Clan")
			src.Uses+=1
			usr.CreateClayKunai()

	ClaySenbon
		name="Clay: Senbon"
		icon_state="SenbonDice"
		Activate(mob/M)
			if(prob(35))
				M.ClayMastery+=1;if(M.ClayMastery>100) M.ClayMastery=100
			if(usr.CSet=="C1")
				src.DelayIt(200,M,"Clan")
			if(usr.CSet=="C2")
				src.DelayIt(400,M,"Clan")
			src.Uses+=1
			usr.CreateClaySenbon()

	ClayWall
		name="Clay: Wall"
		icon_state="Wall"
		Activate(mob/M)
			if(prob(35))
				M.ClayMastery+=1;if(M.ClayMastery>100) M.ClayMastery=100
			if(usr.CSet=="C1")
				src.DelayIt(50,M,"Clan")
			if(usr.CSet=="C2")
				src.DelayIt(100,M,"Clan")
			src.Uses+=1
			usr.CreateClayWall()
	ClaySpider
		name="Clay: Spider"
		icon_state="Spider"
		Activate(mob/M)
			if(prob(35))
				M.ClayMastery+=1;if(M.ClayMastery>100) M.ClayMastery=100
			if(usr.CSet=="C1")
				src.DelayIt(10,M,"Clan")
			if(usr.CSet=="C2")
				src.DelayIt(100,M,"Clan")
			src.Uses+=1
			usr.CreateClaySpider()
	ClayFlower
		name="Clay: Flower"
		icon_state="Flower"
		Activate(mob/M)
			if(prob(35))
				M.ClayMastery+=1;if(M.ClayMastery>100) M.ClayMastery=100
			if(usr.CSet=="C1")
				src.DelayIt(300,M,"Clan")
			if(usr.CSet=="C2")
				src.DelayIt(600,M,"Clan")
			src.Uses+=1
			usr.CreateClayFlower()
	ClayBird
		name="Clay: Bird"
		icon_state="Bird2"
		Activate(mob/M)
			if(prob(35))
				M.ClayMastery+=1;if(M.ClayMastery>100) M.ClayMastery=100
			if(usr.CSet=="C1")
				src.DelayIt(100,M,"Clan")
			if(usr.CSet=="C2")
				src.DelayIt(150,M,"Clan")
			src.Uses+=1
			usr.CreateClayBird()
	ClayMine
		name="Clay: Mine"
		icon_state="Mine"
		Activate(mob/M)
			if(prob(35))
				M.ClayMastery+=1;if(M.ClayMastery>100) M.ClayMastery=100
			if(usr.CSet=="C1")
				src.DelayIt(30,M,"Clan")
			if(usr.CSet=="C2")
				src.DelayIt(80,M,"Clan")
			src.Uses+=1
			usr.CreateClayMine()
	ClaySpear
		name="Clay: Spear"
		icon_state="PaperSpear"
		Activate(mob/M)
			if(prob(35))
				M.ClayMastery+=1;if(M.ClayMastery>100) M.ClayMastery=100
			if(usr.CSet=="C1")
				src.DelayIt(250,M,"Clan")
			if(usr.CSet=="C2")
				src.DelayIt(600,M,"Clan")
			src.Uses+=1
			usr.CreateClaySpear()
	ClayGrasshopper
		name="Clay: Grasshopper"
		icon_state="Grasshoper"
		Activate(mob/M)
			if(prob(35))
				M.ClayMastery+=1;if(M.ClayMastery>100) M.ClayMastery=100
			if(usr.CSet=="C1")
				src.DelayIt(30,M,"Clan")
			if(usr.CSet=="C2")
				src.DelayIt(80,M,"Clan")
			src.Uses+=1
			usr.CreateClayGrasshopper()

//Kaguya////////////////
	Yanagi
		name="Dance of the Willow"
		icon_state="Yanagi"
		BunshinAble=0
		Activate(mob/M)
			if(prob(15))
				M.DanceMastery+=pick(0.1,0.01);if(M.DanceMastery>30) M.DanceMastery=30
			if(prob(15))
				M.BoneMastery+=pick(0.01,0.1);if(M.BoneMastery>100) M.BoneMastery=100
			src.DelayIt(150,M,"Clan")
			src.Uses+=1
			M.YanagiZ()
	TenshiSendan
		name="Bone Bullets"
		icon_state="TenshiSendan"
		BunshinAble=0
		Activate(mob/M)
			if(prob(15))
				M.DanceMastery+=pick(0.1,0.01);if(M.DanceMastery>30) M.DanceMastery=30
			if(prob(15))
				M.BoneMastery+=pick(0.01,0.1);if(M.BoneMastery>100) M.BoneMastery=100
			src.DelayIt(15,M,"Clan")
			src.Uses+=1
			M.TenshiSendanAttack()
	Tsubaki
		name="Dance of the Camellia"
		icon_state="Tsubaki"
		BunshinAble=0
		Activate(mob/M)
			if(prob(15))
				M.DanceMastery+=pick(0.1,0.01);if(M.DanceMastery>30) M.DanceMastery=30
			if(prob(15))
				M.BoneMastery+=pick(0.01,0.1);if(M.BoneMastery>100) M.BoneMastery=100
			src.DelayIt(150,M,"Clan")
			src.Uses+=1
			M.TsubakiZ()
	Karamatsu
		name="Dance of the Larch"
		icon_state="Karamatsu"
		BunshinAble=0
		Activate(mob/M)
			if(prob(15))
				M.DanceMastery+=pick(0.1,0.01);if(M.DanceMastery>30) M.DanceMastery=30
			if(prob(15))
				M.BoneMastery+=pick(0.01,0.1);if(M.BoneMastery>100) M.BoneMastery=100
			src.DelayIt(150,M,"Clan")
			src.Uses+=1
			M.KaramatsuNoMai()
	Ibara
		name="Ibara"
		icon_state="Ibara"
		BunshinAble=0
		Activate(mob/M)
			if(M.KagDance!="Karamatsu")
				M<<"You need to be in Karamatsu No Mai!";return
			if(prob(15))
				M.DanceMastery+=pick(0.1,0.01);if(M.DanceMastery>30) M.DanceMastery=30
			src.DelayIt(150,M,"Clan")
			src.Uses+=1
			M.Ibara()
	BoneMembrane
		name="Bone Membrane"
		icon_state="Karamatsu"
		Activate(mob/M)
			if(M.BoneMembrane)
				M<<"You turn off the Membrane."
				M.BoneMembrane=0
				if(prob(4))
					M.BoneArmor+=pick(0.03,0.1)
				if(prob(15))
					M.DanceMastery+=pick(0.01,0.1);if(M.DanceMastery>30) M.DanceMastery=30
				if(prob(15))
					M.BoneMastery+=pick(0.01,0.1);if(M.BoneMastery>100) M.BoneMastery=100
				if(M.BoneArmor>=3)
					M.BoneArmor=3
				if(M.SageMode!="Bone")
					src.DelayIt(300,M,"Clan")
				return
			src.Uses+=1
			M.BoneMembrane()
	Tessenka
		name="Dance of the Clematis"
		icon_state="Tessenka"
		BunshinAble=0
		Activate(mob/M)
			if(prob(15))
				M.DanceMastery+=pick(0.1,0.01);if(M.DanceMastery>30) M.DanceMastery=30
			if(prob(15))
				M.BoneMastery+=pick(0.01,0.1);if(M.BoneMastery>100) M.BoneMastery=100
			src.DelayIt(150,M,"Clan")
			src.Uses+=1
			M.TessenkaNoMai()
	ArmBone
		name="Clematis: Flower"
		icon_state="Drill"
		BunshinAble=0
		Activate(mob/M)
			if(M.KagDance!="Tessenka")
				M<<"You need to be in Tessenka No Mai!";return
			if(prob(15))
				M.DanceMastery+=pick(0.1,0.01);if(M.DanceMastery>30) M.DanceMastery=30
			src.DelayIt(300,M,"Clan")
			src.Uses+=1
			M.ArmB()
	Sawarabi
		name="Dance of Seedling Ferns"
		icon_state="Sawarabi"
		BunshinAble=0
		Activate(mob/M)
			if(prob(15))
				M.DanceMastery+=pick(0.1,0.01);if(M.DanceMastery>30) M.DanceMastery=30
			if(prob(15))
				M.BoneMastery+=pick(0.01,0.1);if(M.BoneMastery>100) M.BoneMastery=100
			if(prob(10))
				M.SawaMaster+=pick(0.01,0.1,0.2,0.25);if(M.SawaMaster>5) M.SawaMaster=5
			src.DelayIt(1200,M,"Clan")
			src.Uses+=1
			M.Sawarabi(Control=0)
	SawarabiAdvanced
		name="Dance of Seedling Ferns: Control"
		icon_state="Sawarabi"
		BunshinAble=0
		Activate(mob/M)
			if(M.ControllingSawa)
				M<<"You stop controlling the Sawarabi"
				M.ControllingSawa=0
				src.DelayIt(1450,M,"Clan")
				return
			if(prob(15))
				M.DanceMastery+=pick(0.1,0.01);if(M.DanceMastery>30) M.DanceMastery=30
			if(prob(15))
				M.BoneMastery+=pick(0.01,0.1);if(M.BoneMastery>100) M.BoneMastery=100
			if(prob(10))
				M.SawaMaster+=pick(0.01,0.1,0.2,0.25);if(M.SawaMaster>5) M.SawaMaster=5
			src.Uses+=1
			M.Sawarabi(Control=1)
	Kochou
		name="Dance of the Butterfly"
		icon_state="WeakBones"
		BunshinAble=0
		Activate(mob/M)
			if(prob(15))
				M.DanceMastery+=pick(0.1,0.01);if(M.DanceMastery>30) M.DanceMastery=30
			if(prob(15))
				M.BoneMastery+=pick(0.01,0.1);if(M.BoneMastery>100) M.BoneMastery=100
			src.DelayIt(1300,M,"Clan")
			src.Uses+=1
			M.Kochou()



//Kiro////////////////
	ShurikenSoujuu
		name="Shuriken Control Jutsu"
		icon_state="ShurikenSoujuu"
		Activate(mob/M)
			if(M.ShurikenMode)
				if(prob(20))
					M.ShurikenMastery+=pick(0.1,0.2)
				src.DelayIt(250,M,"Clan")
				src.Uses+=1
				M.ShurikenSoujuu()
			else
				M.ShurikenSoujuu()
	ChakraShuriken
		name="Chakra Shuriken Jutsu"
		icon_state="ChakraShuriken"
		Activate(mob/M)
			if(prob(20))
				M.ShurikenMastery+=pick(0.1,0.2)
			src.DelayIt(600,M,"Clan")
			src.Uses+=1
			M.ChakraShuriken()
	SpiralStar
		name="Spiraling Star Jutsu"
		icon_state="SpiralStar"
		Activate(mob/M)
			var/RasenHoshi=0
			for(var/obj/Jutsu/Kiro/ShurikenStar/A in M.JutsuList)
				RasenHoshi=1
				del(A)
			if(RasenHoshi)
				M.Frozen=0
				src.DelayIt(150,M,"Clan")
				return
			if(prob(20))
				M.ShurikenMastery+=pick(0.1,0.2)
			src.DelayIt(50,M,"Clan")
			src.Uses+=1
			M.RasenHoshi()
	ChakraShurikenShield
		name="Shield of Shurikens"
		icon_state="SpiralStar"
		Activate(mob/M)
//			var/RasenHoshi=0
//			for(var/obj/Jutsu/Kiro/ShurikenStar/A in M.JutsuList)
//				RasenHoshi=1
//				del(A)
//			if(RasenHoshi)
//				M.Frozen=0
//				src.DelayIt(150,M,"Clan")
//				return
			if(prob(20))
				M.ShurikenMastery+=pick(0.1,0.2)
			src.Uses+=1
			src.DelayIt(1000,M,"Clan")
			M.ChakraShurikenShield()
	VoidStar
		name="Void Star: Chakra Star Creation"
		icon_state="SpiralStar"
		Activate(mob/M)
			if(prob(20))
				M.ShurikenMastery+=pick(0.1,0.2)
			src.Uses+=1
			src.DelayIt(1650,M,"Clan")
			M.VoidStar()

	SpiralStarProjectile
		name="Spiraling Projectile"
		icon_state="SpiralStar"
		Activate(mob/M)
			if(prob(20))
				M.ShurikenMastery+=pick(0.1,0.2)
			src.Uses+=1
			src.DelayIt(15,M,"Clan")
			M.RasenHoshiProjectile()
	ShurikenSmithyJutsu
		name="Shuriken Smithy Jutsu"
		icon_state="ChakraShuriken"
		Activate(mob/M)
			if(prob(20))
				M.ShurikenMastery+=pick(0.1,0.2)
			src.Uses+=1
			src.DelayIt(750,M,"Clan")
			M.ShurikenSmithyJutsu()



//Ketsueki//////////////
	firstSeal
		name="1st Seal"
		icon_state="1stSeal"
		Deactivate(mob/M)
			if(usr.UsingSealOne)
				usr.UsingSealOne=0
			usr<<"The Seal Deactivates..."
			src.TurnedOn=0
			src.DelayIt(600,M,"Clan")
		Activate(mob/M)
			src.TurnedOn=1
			if(prob(15))
				M.SealMastery+=1;if(M.SealMastery>100) M.SealMastery=100
			src.Uses+=1
			M.FirstSeal()
		//	src.DelayIt(600,M,"Clan")

	secondSeal
		name="2nd Seal"
		icon_state="2ndSeal"
		Deactivate(mob/M)
			if(usr.Banpaia)
				usr.Banpaia=0
			usr<<"You deactivate the second seal, your muscles tighten up, and your movement returns to normal.."
			src.TurnedOn=0
		Activate(mob/M)
			if(prob(15))
				M.SealMastery+=1;if(M.SealMastery>100) M.SealMastery=100
			src.Uses+=1
			src.TurnedOn=1
			src.DelayIt(600,M,"Clan")
			M.SecondSeal()
	thirdSeal
		name="3rd Seal"
		icon_state="3rdSeal"
		BunshinAble=0
		Activate(mob/M)
			if(prob(15))
				M.SealMastery+=1;if(M.SealMastery>100) M.SealMastery=100
			if(prob(15))
				M.BloodManipulation+=pick(0.1,0.2);if(M.BloodManipulation>100) M.BloodManipulation=100
			src.Uses+=1
			src.DelayIt(600,M,"Clan")
			M.ThirdSeal()
	fourthSeal
		name="4th Seal"
		icon_state="4thSeal"
		Target_Required=1
		Activate(mob/M)
			if(prob(15))
				M.SealMastery+=1;if(M.SealMastery>100) M.SealMastery=100
			if(prob(15))
				M.BloodManipulation+=pick(0.1,0.2);if(M.BloodManipulation>100) M.BloodManipulation=100
			src.Uses+=1
			src.DelayIt(1200,M,"Clan")
			M.FourthSeal()
	fifthSeal
		name="5th Seal"
		icon_state="5thSeal"
		Target_Required=1
		Activate(mob/M)
			if(prob(15))
				M.SealMastery+=1;if(M.SealMastery>100) M.SealMastery=100
			if(prob(15))
				M.BloodManipulation+=pick(0.1,0.2);if(M.BloodManipulation>100) M.BloodManipulation=100
			src.Uses+=1
			src.DelayIt(1200,M,"Clan")
			M.FifthSeal()
	sixthSeal
		name="6th Seal"
		icon_state="6thSeal"
		Target_Required=1
		Activate(mob/M)
			if(prob(15))
				M.SealMastery+=1;if(M.SealMastery>100) M.SealMastery=100
			if(prob(15))
				M.BloodManipulation+=pick(0.1,0.2);if(M.BloodManipulation>100) M.BloodManipulation=100
			src.Uses+=1
			src.DelayIt(1200,M,"Clan")
			M.SixthSeal()
	SeventhSeal
		name="7th Seal"
		icon_state="8thSeal"
		BunshinAble=0
		Activate(mob/M)
			if(prob(15))
				M.SealMastery+=1;if(M.SealMastery>100) M.SealMastery=100
			if(prob(15))
				M.BloodManipulation+=pick(0.1,0.2);if(M.BloodManipulation>100) M.BloodManipulation=100
			src.Uses+=1
			src.DelayIt(1800,M,"Clan")
			M.SeventhSeal()
	KetsuekiBunshin
		name="Blood Clone Jutsu"
		icon_state="KetsuekiBunshin"
		Activate(mob/M)
			if(prob(15))
				M.SealMastery+=1;if(M.SealMastery>100) M.SealMastery=100
			if(prob(15))
				M.BloodManipulation+=pick(0.1,0.2);if(M.BloodManipulation>100) M.BloodManipulation=100
			src.Uses+=1
			src.DelayIt(250,M,"Clan")
			M.KetsuekiBunshin()
	Feast
		icon_state="Feast"
		BunshinAble=0
		Activate(mob/M)
			if(prob(15))
				M.ThirstHold+=pick(0.1,0.2);if(M.ThirstHold>3) M.ThirstHold=3
			if(prob(15))
				M.BloodManipulation+=pick(0.1,0.2);if(M.BloodManipulation>100) M.BloodManipulation=100
			src.Uses+=1
			src.DelayIt(600,M,"Clan")
			M.BloodDrain()
//Kumojin///////////////
	Kumosouiki
		name="Spider Cobweb Region"
		icon_state="Kumosouiki"
		Activate(mob/M)
			if(prob(15))
				M.WebMastery+=pick(0.5,1); if(M.WebMastery>50) M.WebMastery=50
			if(prob(3))
				M.WebStrength+=0.1;if(M.WebStrength>5) M.WebStrength=5
			src.Uses+=1
			src.DelayIt(350,M,"Clan")
			M.Kumosouiki()
	SpiderSummon
		name="SpiderSummon"
		icon_state="SpiderSummon"
		Activate(mob/M)
			if(prob(15))
				M.SpiderMastery+=pick(0.5,1); if(M.SpiderMastery>100) M.SpiderMastery=100
			src.Uses+=1
			src.DelayIt(10,M,"Clan")
			M.SpiderSummon()

	GiantWebMaze
		name="Spider Bind: Giant Web Maze"
		icon_state="Kumoshibari"
		Activate(mob/M)
			if(prob(15))
				M.WebMastery+=pick(0.5,1); if(M.WebMastery>50) M.WebMastery=50
			if(prob(3))
				M.WebStrength+=0.1;if(M.WebStrength>5) M.WebStrength=5
			src.Uses+=1
			src.DelayIt(6000,M,"Clan")
			M.GiantWebMaze()

	Kumoshibari
		name="Spider Bind"
		icon_state="Kumoshibari"
		Activate(mob/M)
			if(prob(15))
				M.WebMastery+=pick(0.5,1); if(M.WebMastery>50) M.WebMastery=50
			if(prob(3))
				M.WebStrength+=0.1;if(M.WebStrength>5) M.WebStrength=5
			src.Uses+=1
			src.DelayIt(475,M,"Clan")
			for(var/obj/SkillCards/Kumosouka/A in M.LearnedJutsus)
				A.DelayIt(450,M,"Clan")
			M.KumoshibariZ()
	Kumosouka
		name="Spider Cobweb Flower"
		icon_state="Kumosouka"
		Activate(mob/M)
			if(prob(15))
				M.WebMastery+=pick(0.5,1); if(M.WebMastery>50) M.WebMastery=50
			if(prob(3))
				M.WebStrength+=0.1;if(M.WebStrength>5) M.WebStrength=5
			src.Uses+=1
			src.DelayIt(450,M,"Clan")
			for(var/obj/SkillCards/Kumoshibari/A in M.LearnedJutsus)
				A.DelayIt(370,M,"Clan")
			M.KumosoukaZ()
	NenkinYoroi
		name="Armor of Sticky Gold"
		icon_state="NenkinYoroi"
		Activate(mob/M)
			if(prob(10))
				M.GoldnowDiamond+=pick(0.1,0.2,0.3,0.5); if(M.GoldnowDiamond>5) M.GoldnowDiamond=5
			if(prob(15))
				M.SpiderMastery+=pick(0.5,1); if(M.SpiderMastery>100) M.SpiderMastery=100
			if(prob(15)&&M.GoldenSpike<10)
				M.GoldenSpike+=pick(0.1,0.2);if(M.GoldenSpike>10) M.GoldenSpike=10
			src.Uses+=1
			src.DelayIt(300,M,"Clan")
			M.NenkinNoYoroi()
	Nenkin
		name="Spider Sticky Gold(Kunai)"
		icon_state="Nenkin"
		Activate(mob/M)
			if(prob(15))
				M.SpiderMastery+=pick(0.5,1); if(M.SpiderMastery>100) M.SpiderMastery=100
			if(prob(15)&&M.GoldenSpike<10)
				M.GoldenSpike+=pick(0.1,0.2);if(M.GoldenSpike>10) M.GoldenSpike=10
			src.Uses+=1
			src.DelayIt(30,M,"Clan")
			M.NenkinShoot()

	DaiKumoshibariZ
		name="Flowering Web"
		icon_state="Kumoshibari"
		Activate(mob/M)
			if(prob(15))
				M.WebMastery+=pick(0.5,1); if(M.WebMastery>50) M.WebMastery=50
			if(prob(3))
				M.WebStrength+=0.1;if(M.WebStrength>5) M.WebStrength=5
			src.Uses+=1
			for(var/obj/SkillCards/Kumoshibari/A in M.LearnedJutsus)
				A.DelayIt(370,M,"Clan")
			for(var/obj/SkillCards/Kumosouka/A in M.LearnedJutsus)
				A.DelayIt(270,M,"Clan")
			src.DelayIt(1250,M,"Clan")
			M.DaiKumoshibariZ()

	Kumosenkyuu
		name="Spider War Bow"
		icon_state="Kumosenkyuu"
		Activate(mob/M)
			if(prob(15))
				M.SpiderMastery+=pick(0.5,1); if(M.SpiderMastery>100) M.SpiderMastery=100
			if(prob(15)&&M.GoldenSpike<10)
				M.GoldenSpike+=pick(0.1,0.2);if(M.GoldenSpike>10) M.GoldenSpike=10
			src.Uses+=1
			src.DelayIt(30,M,"Clan")
			M.Kumosenkyuu()
//Kusakin///////////////
	Kamisoriha
		name="Seasonal-Edged Leaf Jutsu"
		icon_state="Kamisoriha"
		Activate(mob/M)
			if(prob(15))
				M.GrassMastery+=pick(0.5,1);if(M.GrassMastery>100) M.GrassMastery=100
			if(prob(10))
				M.SturdyComposition+=pick(0.01,0.05,0.1);if(M.SturdyComposition>20) M.SturdyComposition=20
			if(M.TypeLearning=="Mokuton")
				M.exp+=rand(300,375)
			src.Uses+=1
			src.DelayIt(110,M,"Clan")
			M.kamisoriha()
	Tsutakei
		name="Ivy-Whip Jutsu"
		icon_state="Tsutakei"
		Activate(mob/M)
			if(prob(15))
				M.GrassMastery+=pick(0.5,1);if(M.GrassMastery>100) M.GrassMastery=100
			if(prob(10))
				M.SturdyComposition+=pick(0.01,0.05,0.1);if(M.SturdyComposition>20) M.SturdyComposition=20
			if(M.TypeLearning=="Mokuton")
				M.exp+=rand(225,300)
			src.Uses+=1
			src.DelayIt(210,M,"Clan")
			M.Tsutakei()
	VineFieldJutsu
		name="Vine Field Jutsu"
		icon_state="Kusahayashi"
		Activate(mob/M)
			if(prob(15))
				M.GrassMastery+=pick(0.5,1);if(M.GrassMastery>100) M.GrassMastery=100
			if(prob(10))
				M.SturdyComposition+=pick(0.01,0.05,0.1);if(M.SturdyComposition>20) M.SturdyComposition=20
			if(M.TypeLearning=="Mokuton")
				M.exp+=rand(225,300)
			src.Uses+=1
			src.DelayIt(300,M,"Clan")
			M.VineField()

	KusaBushi
		name="Grass-Knot Jutsu"
		icon_state="KusaBushi"
		Target_Required=1
		Activate(mob/M)
			if(prob(15))
				M.GrassMastery+=pick(0.5,1);if(M.GrassMastery>100) M.GrassMastery=100
			if(prob(10))
				M.SturdyComposition+=pick(0.01,0.05,0.1);if(M.SturdyComposition>20) M.SturdyComposition=20
			if(M.TypeLearning=="Mokuton")
				M.exp+=rand(225,300)
			src.Uses+=1
			src.DelayIt(500,M,"Clan")
			M.KusaBushi()
	Kusahayashi
		name="Ivy-Forest Jutsu"
		icon_state="Kusahayashi"
		Activate(mob/M)
			if(prob(15))
				M.GrassMastery+=pick(0.5,1);if(M.GrassMastery>100) M.GrassMastery=100
			if(prob(10))
				M.SturdyComposition+=pick(0.01,0.05,0.1);if(M.SturdyComposition>20) M.SturdyComposition=20
			if(M.TypeLearning=="Mokuton")
				M.exp+=rand(225,300)
			src.Uses+=1
			src.DelayIt(1200,M,"Clan")
			M.Kusahayashi()
	MokuShouheki
		name="Wood Barrier Jutsu"
		icon_state="MokuShouheki"
		Activate(mob/M)
			if(prob(15))
				M.Senju+=pick(0.5,1,2);if(M.Senju>100) M.Senju=100
			if(prob(10))
				M.SturdyComposition+=pick(0.01,0.05,0.1);if(M.SturdyComposition>20) M.SturdyComposition=20
			if(M.TypeLearning=="Mokuton")
				M.exp+=rand(450,500)
			src.Uses+=1
			src.DelayIt(100,M,"Clan")
			M.MokuShouheki()
	TreeMelding
		name="Wood Style: Tree Melding"
		icon_state="MokuShouheki"
		Activate(mob/M)
			if(prob(15))
				M.Senju+=pick(0.5,1,2);if(M.Senju>100) M.Senju=100
			if(prob(10))
				M.SturdyComposition+=pick(0.01,0.05,0.1);if(M.SturdyComposition>20) M.SturdyComposition=20
			if(M.TypeLearning=="Mokuton")
				M.exp+=rand(450,500)
			src.Uses+=1
			src.DelayIt(200,M,"Clan")
			M.TreeMeld()
	JukaiKoutan
		name="Birth of Dense Woodland Jutsu"
		icon_state="JukaiKoutan"
		Activate(mob/M)
			if(prob(15))
				M.Senju+=pick(0.5,1,2);if(M.Senju>100) M.Senju=100
			if(prob(10))
				M.SturdyComposition+=pick(0.01,0.05,0.1);if(M.SturdyComposition>20) M.SturdyComposition=20
			if(M.TypeLearning=="Mokuton")
				M.exp+=rand(650,1300)
			src.Uses+=1
			src.DelayIt(1100,M,"Clan")
			M.JukaiKoutan()
	WoodSpikes
		name="Wood Spikes Jutsu"
		icon_state="WoodSpikes"
		Activate(mob/M)
			if(prob(15))
				M.Senju+=pick(0.5,1,2);if(M.Senju>100) M.Senju=100
			if(prob(10))
				M.SturdyComposition+=pick(0.01,0.05,0.1);if(M.SturdyComposition>20) M.SturdyComposition=20
			if(M.TypeLearning=="Mokuton")
				M.exp+=rand(650,700)
			src.Uses+=1
			src.DelayIt(450,M,"Clan")
			M.WoodSpikes()




//Kyomou////////////////
	Akametsuki
		name="Akametsuki"
		icon_state="Akametsuki"
		Activate(mob/M)
			src.DelayIt(100,M,"Clan")
			if(M.knockedout)
				return
			M.Akametsuki()
			src.Uses+=1
	AkametsukiSearch
		name="Akametsuki Search"
		icon_state="Akametsuki"
		Activate(mob/M)
			if(!M.Akametsuki)
				M << "You need to activate Akametsuki first!"
				return
			if(M.knockedout)
				return
			src.Uses+=1
			src.DelayIt(100,M,"Clan")
			M.AkametsukiSearch2(Uses)

	AkametsukiIlluminate
		name="Akametsuki Illuminate"
		icon_state="Akametsuki"
		Activate(mob/M)
			if(!M.Akametsuki)
				M << "You need to activate Akametsuki first!"
				return
			if(M.knockedout)
				return
			src.Uses+=1
			src.DelayIt(100,M,"Clan")
			M.AkametsukiIllumin(Uses)
	Particle_Punch
		name="Particle Punch"
		icon_state="ParticleField"
		BunshinAble=0
		Activate(mob/M)
			if(!M.Akametsuki)
				M << "You need to activate Akametsuki first!";return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.Uses+=1
			src.DelayIt(100,M,"Clan")
			M.ParticleConduction()
	Particle_Gate
		name="Particle Gate"
		icon_state="ParticleField"
		BunshinAble=0
		Activate(mob/M)
			if(!M.Akametsuki)
				M << "You need to activate Akametsuki first!";return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.Uses+=1
			src.DelayIt(200,M,"Clan")
			M.ParticleGate()
	Particle_Mine
		name="Particle Mine"
		icon_state="ParticleField"
		BunshinAble=0
		Activate(mob/M)
			if(M.ParticleMineCount>0)
				if(!M.Akametsuki)
					M << "You need to activate Akametsuki first!";return
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				src.Uses+=1
				src.DelayIt(10,M,"Clan")
				M.ParticleMineCount-=1
				M.ParticleMine()
				M<<"You placed a Mine!"
			else
				M<<"You have no mines stored up!"
				return
	Particle_Field
		name="Particle Field"
		icon_state="ParticleField"
		BunshinAble=0
		Activate(mob/M)
			if(!M.Akametsuki)
				M << "You need to activate Akametsuki first!";return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.Uses+=1
			src.DelayIt(200,M,"Clan")
			M.ParticleField()
	Particle_Waves
		name="Particle Waves"
		icon_state="ParticleWaves"
		BunshinAble=0
		Activate(mob/M)
			if(!M.Akametsuki)
				M << "You need to activate Akametsuki first!";return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.Uses+=1
			src.DelayIt(100,M,"Clan")
			M.ParticleWaves()
	Particle_Bullet
		name="Particle Bullet"
		icon_state="ParticleBullet"
		BunshinAble=0
		Activate(mob/M)
			if(!M.Akametsuki)
				M << "You need to activate Akametsuki first!";return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.Uses+=1
			src.DelayIt(150,M,"Clan")
			M.ParticleBullet()

	Akametsuki_Rejuvination
		name="Akametsuki Rejuvination"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Rejuvination"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Blind
		name="Akametsuki Blind"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Blind"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Burn
		name="Akametsuki Burn"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Burn"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Clones
		name="Particle Clones"
		icon_state="ParticleEffect"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(200,M,"Nin")
			src.Uses+=1
			M.AkametsukiClones()
	Akametsuki_Migrane
		name="Akametsuki Migrane"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Migrane"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Chakra_Drain
		name="Akametsuki Chakra Drain"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Chakra Drain"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Doujutsu_Counter
		name="Akametsuki Doujutsu Counter"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Doujutsu Counter"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Anorexiation
		name="Akametsuki Anorexiation"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Anorexiation"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Chakra_Restore
		name="Akametsuki Chakra Restore"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Chakra Restore"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Daze
		name="Akametsuki Daze"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Daze"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Stamina_Damage
		name="Akametsuki Stamina Damage"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Stamina"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Reservoir_Absorbtion
		name="Akametsuki Reservoir Absorbtion"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Reservoir Absorbtion"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Stun
		name="Akametsuki Stun"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Stun"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Vitality
		name="Akametsuki Vitality Damage"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Vitality"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Disruption
		name="Akametsuki Disruption"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Disruption"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Sleep
		name="Akametsuki Sleep"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Sleep"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Life_Absorb
		name="Akametsuki Absorb"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Life Absorbtion"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Life_Restore
		name="Akametsuki Restore"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Life Restore"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Constraint
		name="Akametsuki Constraint"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Constraint"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Particle_Return
		name="Akametsuki Particle Return"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Particle Return"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"
	Akametsuki_Genjutsu_Shatter
		name="Akametsuki Genjutsu Shatter"
		icon_state="ParticleEffect"
		Activate(mob/M)
			M.ParticleAffect = "Genjutsu Shatter"
			M << "You are now useing the \"[M.ParticleAffect]\" particle effect!"


	MajesticEyes
		name="Majestic Eyes"
		icon_state="GoldEye"
		Activate(mob/M)
			if(M.knockedout)
				return
			M.MajesticEyes()
			src.DelayIt(100,M,"Nin")
			src.Uses+=1
	MajesticIlluminate
		name="Majestic Illuminate"
		icon_state="GoldenIlluminate"
		Activate(mob/M)
			if(M.knockedout)
				return
			M.GoldenIlluminate()
			src.DelayIt(50,M,"Nin")
			src.Uses+=1
	IndigoEyes
		icon_state="GoldEye"
		Activate(mob/M)
			if(M.Indigo)
				M.IndigoEyes()
				src.DelayIt(100,M,"Clan")
				return
			if(M.knockedout)
				return
			M.IndigoEyes()
			src.Uses+=1
	IndigoIlluminate
		name="Illuminating Indigo"
		icon_state="GoldenIlluminate"
		Activate(mob/M)
			if(M.knockedout)
				return
			M.IndigoIlluminate()
			src.DelayIt(50,M,"Nin")
			src.Uses+=1
	Conversusin
		name="Conversusin: Bestialis Anguis"
		icon_state="GoldEye"
		Activate(mob/M)
			if(M.ConversusinEye)
				src.DelayIt(250,M,"Nin")
				M.ConversusinBestialisAnguis()

				return
			if(M.knockedout)
				return
			M.ConversusinBestialisAnguis()
			src.Uses+=1
	ConversusinSecond
		name="Bestialis Anguis: Secondary Transformation"
		icon_state="GoldEye"
		Activate(mob/M)
			if(M.ConversusinSecondStage)
			//	M.ConversusinBestialisAnguisSecondStage()
				src.DelayIt(750,M,"Nin")
				M.ConversusinBestialisAnguisSecondStage()
				return
			if(M.knockedout)
				return
			M.ConversusinBestialisAnguisSecondStage()
			src.Uses+=1
			//SemideusChakraArmReach

	SemideusChakraArm
		name="Semideus Chakra Arm"
		icon_state="KageShibari"
		Activate(mob/M)
			if(M.knockedout)
				return
			src.DelayIt(250,M,"Nin")
			src.Uses+=1
			M.SemideusChakraArmReach()
	SemideusChakraArmReaching
		name="Semideus Chakra Arm Reflection"
		icon_state="KageShibari"
		Activate(mob/M)
			if(M.knockedout)
				return
			src.DelayIt(400,M,"Nin")
			src.Uses+=1
			M.SemideusChakraArmPush()





//Nara//////////////////
	KageShibari
		name="Shadow Possession Jutsu"
		icon_state="KageShibari"
		Activate(mob/M)
			src.Uses+=1
			M.kageshibari()
			src.DelayIt(30,M,"Clan")
	KageMane
		name="Shadow Mimic Jutsu"
		icon_state="KageMane"
		Deactivate(mob/M)
			if(M.InKageMane)
				M.InKageMane=0
			src.DelayIt(60,M,"Clan")
		Activate(mob/M)
			if(M.InKageMane)
				src.Deactivate(M)
			else
				src.Uses+=1
				M.KageMane()
	KageKubiShibari
		name="Shadow Neck-Bind Jutsu"
		icon_state="KageKubiShibari"
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(110,M,"Clan")
			M.KageKubiShibaru()
	KageNui
		name="Shadow Sewing Jutsu"
		icon_state="KageNui"
		Target_Required=1
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(400,M,"Clan")
			for(var/obj/SkillCards/ForrbiddenShadowArtMassiveNuiOnslaught/S in usr.LearnedJutsus)
				if(!S.Delay)
					S.DelayIt(850,M,"Clan")
			M.KageNuiI()

	KageHara
		name="Shadow-Field Jutsu"
		icon_state="KageHara"
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(90,M,"Clan")
			M.KageHara()
	KageNuiField
		name="Shadow Sewing Field"
		icon_state="KageNui"
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(400,M,"Clan")
			M.KageNuiField()
	ForrbiddenShadowArtMassiveNuiOnslaught
		name="Shadow Art: Shadow Sewing Onslaught"
		icon_state="KageNui"
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(950,M,"Clan")
			for(var/obj/SkillCards/KageNui/S in usr.LearnedJutsus)
				if(!S.Delay)
					S.DelayIt(450,M,"Clan")
			M.ForrbiddenShadowArtMassiveNuiOnslaught()
//Sabaku////////////////
	SunaTate
		name="Shield Of Sand"
		icon_state="SunaTate"
		Activate(mob/M)
			if(prob(20))
				M.SandMastery+=pick(0.01,0.2,0.21,0.22,0.23,0.24,0.25);if(M.SandMastery>100) M.SandMastery=100
			src.Uses+=1
			src.DelayIt(50,M,"Clan")
			M.SunaNoTate()
	Sandeye
		name="The Third Eye"
		icon_state="Sandeye"
		Activate(mob/M)
			if(prob(15))
				M.SandMastery+=pick(0.01,0.2);if(M.SandMastery>100) M.SandMastery=100
			src.Uses+=1
			src.DelayIt(50,M,"Clan")
			M.Sandeye()
	SunaBunshin
		name="Sand Clone Jutsu"
		icon_state="SunaBunshin"
		BunshinAble=0
		Activate(mob/M)
			if(prob(15))
				M.SandMastery+=pick(0.01,0.2);if(M.SandMastery>100) M.SandMastery=100
			src.Uses+=1
			src.DelayIt(170,M,"Clan")
			M.SunaBunshin()
	SunaSoujou
		name="Sand Manipulation"
		icon_state="SunaSoujou"
		Activate(mob/M)
			if(M.SunaMode)
				if(M&&M.SunaMode)
					M<<"You release the sand!"
					src.DelayIt(100,M,"Clan")
					M.SunaMode=0
					M.firing=0
					M.controlled=null
					M.client.perspective=MOB_PERSPECTIVE
					M.client.eye=usr
					for(var/mob/Sand/Suna/P in world) if(P.Owner == M) del(P)
					for(var/obj/Jutsu/Sand/Suna2/MM in world) if(MM.Owner == M) del(MM)
					return
			else
				if(prob(15))
					M.SandMastery+=pick(0.01,0.1);if(M.SandMastery>100) M.SandMastery=100
				M.Sunasoujuu()
				src.Uses+=1
	SabakuKyuu
		name="Desert Coffin"
		icon_state="SabakuKyuu"
		Target_Required=1
		Activate(mob/M)
			if(prob(15))
				M.SandMastery+=pick(0.01,0.2);if(M.SandMastery>100) M.SandMastery=100
			src.Uses+=1
			src.DelayIt(475,M,"Clan")
			for(var/obj/SkillCards/SabakuSousou/S in usr.LearnedJutsus)
				if(!S.Delay)
					S.DelayIt(30,M,"Clan")
			M.SabakuKyuu()

				//This is to keep people from Kyuu+Sousouing instantly when 1 tile away from the target.
				//It gives the target a CHANCE to struggle out.
	SabakuSousou
		name="Desert Funeral"
		icon_state="SabakuSousou"
		Activate(mob/M)
			if(prob(15))
				M.SandMastery+=pick(0.01,0.2);if(M.SandMastery>100) M.SandMastery=100
			src.Uses+=1
			src.DelayIt(500,M,"Clan")
			M.SabakuSousou()
	SabakuSandField
		name="SandField"
		icon_state="SandWall2"
		Activate(mob/M)
			if(prob(15))
				M.SandMastery+=pick(0.01,0.2);if(M.SandMastery>100) M.SandMastery=100
			src.Uses+=1
			src.DelayIt(900,M,"Clan")
			for(var/obj/SkillCards/SabakuSandFieldBurial/S in usr.LearnedJutsus)
				if(!S.Delay)
					S.DelayIt(15,M,"Clan")
			M.Sabaku_SandField()
	SabakuSandFieldBurial
		name="SandField Burial"
		icon_state="BakuryuRyusaBurial"
		Activate(mob/M)
			if(prob(15))
				M.SandMastery+=pick(0.01,0.2);if(M.SandMastery>100) M.SandMastery=100
			src.Uses+=1
			src.DelayIt(700,M,"Clan")
			M.Sabaku_SandFieldBurial()
	BakuryuRyusa
		name="Quicksand Waterfall Current"
		icon_state="BakuryuRyusa"
		Activate(mob/M)
			if(prob(15))
				M.SandMastery+=pick(0.01,0.2);if(M.SandMastery>100) M.SandMastery=100
			src.Uses+=1
			src.DelayIt(600,M,"Clan")
			M.Bakuryu_Ryusa()
	SunaShuriken
		name="Sand Shuriken"
		icon_state="SunaShuriken"
		Activate(mob/M)
			if(prob(15))
				M.SandMastery+=pick(0.01,0.2);if(M.SandMastery>100) M.SandMastery=100
			src.Uses+=1
			src.DelayIt(30,M,"Clan")
			M.SunaShuriken(src.Uses)
	SabakuTaisou
		name="Desert Imperial Funeral"
		icon_state="SabakuTaisou"
		Activate(mob/M)
			if(prob(15))
				M.SandMastery+=pick(0.01,0.2);if(M.SandMastery>100) M.SandMastery=100
			src.Uses+=1
			src.DelayIt(1250,M,"Clan")
			M.Sabaku_Taisou()
	SunaWhip
		name="Sand Whip"
		icon_state="SandWhip"
		Activate(mob/M)
			if(prob(15))
				M.SandMastery+=pick(0.01,0.2);if(M.SandMastery>100) M.SandMastery=100
			src.Uses+=1
			src.DelayIt(80,M,"Clan")
			M.SunaWhip()
	SandErosion
		name="Erosion"
		icon_state="SabakuTaisou"
		Activate(mob/M)
			if(prob(15))
				M.SandMastery+=pick(0.01,0.2);if(M.SandMastery>100) M.SandMastery=100
			src.Uses+=1
			src.DelayIt(1250,M,"Clan")
			M.Erosion()
	SandArm
		name="Sand Arm"
		icon_state="SandArm"
		Activate(mob/M)
			if(prob(15))
				M.SandMastery+=pick(0.01,0.2);if(M.SandMastery>100) M.SandMastery=100
			src.Uses+=1
			src.DelayIt(550,M,"Clan")
			M.SandArm()
	SandSphere
		name="Sand Sphere"
		icon_state="SandSphere"
		BunshinAble=0
		Activate(mob/M)
			if(M.sphere)
				M.SandSphere(Uses)
				src.DelayIt(250,M,"Clan")
				return
			else
				if(prob(15))
					M.SandMastery+=pick(0.01,0.2);if(M.SandMastery>100) M.SandMastery=100
				src.Uses+=1
				M.SandSphere(Uses)
////////////////
//Kieru
///////////////
	FloatingSpeck
		name="Jinton: Floating Speck"
		icon_state="Floating Specks"//Gonna have to find a skillcard icon for this one
		BunshinAble=0
		Activate(mob/M)
			if(prob(15))
				if(M.JintonControl<5)
					M.JintonControl+=pick(0.03,0.04)
			if(prob(15))
				if(M.JintonIntensity<5)
					M.JintonIntensity+=pick(0.04,0.05)
			src.DelayIt(15,M,"Clan")
			src.Uses+=1
			M.FloatingSpeck()
	JintonHakuri
		name="Jinton: Hakuri"
		icon_state="Jinton: Hakuri"
		BunshinAble=0
		Activate(mob/M)
			if(prob(20))
				M.JintonControl+=pick(0.04,0.07)
				if(M.JintonControl>5) M.JintonControl=5
			if(prob(20))
				M.JintonIntensity+=pick(0.02,0.08)
				if(M.JintonIntensity>5) M.JintonIntensity=5
			src.DelayIt(300,M,"Clan")
			src.Uses+=1
			M.JintonHakuri()
	JintonGenkaiHakuri
		name="Jinton: Genkai Hakuri"
		icon_state="Floating Speck"
		BunshinAble=0//JintonGenkaiHakuri()
		Activate(mob/M)
			if(prob(20))
				M.JintonControl+=pick(0.09,0.11)
				if(M.JintonControl>5) M.JintonControl=5
			if(prob(25))
				M.JintonIntensity+=pick(0.08,0.12)
				if(M.JintonIntensity>5) M.JintonIntensity=5
			src.DelayIt(1300,M,"Clan")
			src.Uses+=1
			M.JintonGenkaiHakuri()
////////////////
//Jashinism
///////////////
	IngestBlood
		name="Ingest Blood"
		icon_state="SelfHarm"
		Activate(mob/M)
			src.DelayIt(50,M,"Clan")
			M.IngestBlood()
	RelinquishRitual
		name="Exit Blood Bind"
		icon_state="JashinCircle"
		BunshinAble=0
		Activate(mob/M)
			M.CancelRitual()
	Masochism
		name="Sadistic Pleasure"
		icon_state="Sharingan"
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(1200,M,"Clan")
			M.SadisticPleasure()
	TrueZombie
		name="Living Zombie"
		icon_state="JashinMode"
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(1200,M,"Clan")
			M.TrueZombie()
	HarmSelf
		name="Self Harm: Blood Connection"
		icon_state="SelfHarm"
		BunshinAble=0
		Activate(mob/M)
			M.SelfHarm()
	CreateCircle
		name="Jashin Ritual"
		icon_state="JashinCircle"
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(50,M,"Clan")
			M.JashinRitual()

//Uchiha//////////////
	Sharingan
		icon_state="Sharingan"
		Activate(mob/M)
			src.DelayIt(100,M,"Clan")
			if(M.knockedout)
				return
			M.Sharingan()
			src.Uses+=1
	SharinganIlluminate
		name ="Sharingan Illuminate"
		icon_state="SharIlluminate"
		BunshinAble=0
		NonKeepable=1
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(250,M,"Clan")
			M.SharinganIlluminate()
	SharinganFocus
		name ="Sharingan Focus"
		icon_state="SharIlluminate"
		BunshinAble=0
		NonKeepable=1
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(250,M,"Clan")
			M.SharinganFocus()

	SharinganCopy
		name="Sharingan Copy"
		icon_state="SharCopy"
		BunshinAble=0
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(100,M,"Clan")
			M.Sharingancopy()
	GenjutsuCounter
		name="Genjutsu Counter"
		icon_state="GenjutsuCounter"
		BunshinAble=0
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(300,M,"Clan")
			M.GenjutsuCounter()
	Kasegui
		name="Demonic Illusion: Shackling Stakes"
		icon_state="Kasegui"
		BunshinAble=0
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(600,M,"Clan")
			M.Kasegui()
	Konsui
		name="Demonic Illusion: Hypnosis"
		icon_state="Sleep"
		BunshinAble=0
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(600,M,"Clan")
			M.Konsui()
	Mangekyo
		name="Mangekyo Sharingan"
		icon_state="Mangekyo"
		BunshinAble=0
		Activate(mob/M)
			if(M.knockedout)
				return
			src.Uses+=1
			M.MangekyouPrep()
			if(!M.mangekyou)
				src.DelayIt(700,M,"Clan")
				src.Uses+=1
	OneMangekyo
		name="One Eyed Mangekyo Sharingan"
		icon_state="Mangekyo2"
		BunshinAble=0
		Activate(mob/M)
			if(M.knockedout)
				return
			src.Uses+=1
			M.OneMangekyou()
			if(!M.mangekyou)
				src.DelayIt(700,M,"Clan")
				src.Uses+=1
	OneEternalMangekyo
		name="One Eyed Eternal Mangekyo Sharingan"
		icon_state="Mangekyo3"
		BunshinAble=0
		Activate(mob/M)
			if(M.knockedout)
				return
			src.Uses+=1
			M.OneMangekyouShisui()
			if(!M.mangekyou)
				src.DelayIt(700,M,"Clan")
				src.Uses+=1
	EternalMangekyo
		name="Mangekyo Sharingan"
		icon_state="EternalMangekyo"
		BunshinAble=0
		Activate(mob/M)
			if(M.knockedout)
				return
			src.Uses+=1
			M.EMS()
			if(!M.mangekyou)
				src.DelayIt(700,M,"Clan")
				src.Uses+=1
	//MangAttacks
	FieldOfBlackFlames
		name="Field of Black Flames"
		icon_state="Amaterasu2"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.mangekyou&&M.key!="")
				M<<"Mangekyo Sharingan needs to be on!";return
			else
				src.DelayIt(900,M,"Clan")
				src.Uses+=1
				M.FieldOfBlackFlames()
	Amateratsu
		name="Amateratsu"
		icon_state="Amaterasu2"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			if(M.UsingAmaterasu)
				src.DelayIt(1800,M,"Clan")
				M.UsingAmaterasu=0
			else
				src.Uses+=1
				M.Amateratsu()
	AmateratsuExplosion
		name="Amateratsu Explode"
		icon_state="Amaterasu"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.mangekyou)
				M<<"Mangekyou Sharingan needs to be on!";return
			if(M.UsingAmaterasuExplosion)
				src.DelayIt(900,M,"Clan")
				M.UsingAmaterasuExplosion=0
			else
				src.Uses+=1
				M.AmaterasuExplosion()
				src.DelayIt(900,M,"Clan")
	AmateratsuProjectile
		name="Amateratsu(Projectile)"
		icon_state="Amaterasu"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			src.DelayIt(1200,M,"Clan")
			src.Uses+=1
			M.ProjectileAmaterasu()
	WhiteAmateratsuProjectile
		name="White Flames"
		icon_state="WhiteAmateratsu"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			src.DelayIt(900,M,"Clan")
			src.Uses+=1
			M.WhiteProjectileAmaterasu()
	WhiteAmaterasu360
		name="White Flames: Spread Shot"
		icon_state="WhiteAmateratsuSmall"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			src.DelayIt(600,M,"Clan")
			src.Uses+=1
			M.WhiteFireShot()
	Susanoo
		name="Susanoo"
		icon_state="Susanoo"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(M.SusanooIn)
				M.SusanooHealth=0
				M.SusanooDeleteCheck()
				/*for(var/obj/Jutsu/Uchiha/Susanoo/A in world)
					if(A.Owner==M)
						del(A)
				M.SusanooIn=0*/
				//src.DelayIt(1200,M,"Clan")
				return
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			else
				var/b=15000/M.NinSkill
				if(b<=1200)
					b=1200
				src.Uses+=1
				M.Susanoo(M.mangekyouC,"Perfect",b,M.SusanooMastery,M.chakra)
	XeidusCreation
		name="Xeidus Creation"
		icon_state="Xeidus Creation"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(M.InXeidus)
				for(var/obj/Jutsu/Deviant/Xeidus/A in world)
					if(A.Owner==M)
						M.nin=M.Mnin
						M.tai=M.Mtai
						M.gen=M.Mgen
						del(A)
				M.InXeidus=0
				src.DelayIt(1200,M,"Clan")
				return
			src.Uses+=1
			M.XeidusCreation(src.Uses)

	SusanooAmatDefence
		name="Susanoo: Light Enton Defence"
		icon_state="Susanoo"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.SusanooIn)
				src.DelayIt(200,M,"Clan")
				M<<"You need to be in Susanoo to use this!";return
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			else
				src.Uses+=1
				M.SasukeAmatDefence("Light")
	SusanooAmatDefence2
		name="Susanoo: Enton Defence"
		icon_state="Susanoo"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.SusanooIn)
				src.DelayIt(200,M,"Clan")
				M<<"You need to be in Susanoo to use this!";return
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			else
				src.Uses+=1
				M.SasukeAmatDefence("Medium")
	SusanooAmatDefence3
		name="Susanoo: Strong Enton Defence"
		icon_state="Susanoo"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.SusanooIn)
				src.DelayIt(200,M,"Clan")
				M<<"You need to be in Susanoo to use this!";return
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			else
				src.Uses+=1
				M.SasukeAmatDefence("Heavy")
	Tsukiyomi
		name="Tsukuyomi"
		icon_state="Tsukiyomi"
		Target_Required=1
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			src.DelayIt(600,M,"Clan")
			src.Uses+=1
			for(var/obj/SkillCards/Kamui/A in M.LearnedJutsus)
				A.DelayIt(300,M,"Clan")
			M.Tsukiyomi()
	Kamui
		name="God's Majesty"
		icon_state="GodsMajesty"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(PermDeath)
				M<<"Disabled during Permanent death mode!"
				return
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			src.DelayIt(600,M,"Clan")
			src.Uses+=1
			for(var/obj/SkillCards/Tsukiyomi/A in M.LearnedJutsus)
				A.DelayIt(300,M,"Clan")
			M.Kamui()
	TimeCollaboration
		name="Time Collaboration"
		icon_state="TimeCollaboration"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			src.DelayIt(150,M,"Clan")
			src.Uses+=1
			for(var/obj/SkillCards/Kamui/A in M.LearnedJutsus)
				A.DelayIt(300,M,"Clan")
			M.TimeCollaboration()

	Phase
		name="Phase"
		icon_state="Phase"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			else
				src.Uses+=1
				M.Phase()
	GhostParasite//Takashi's Custom
		name="Ghost Parasite"
		icon_state="Phase"
		BunshinAble=0
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(600,M,"Nin")
			M.GhostParasite()
	NonExistance
		name="Non-Existance"
		icon_state="Phase"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			src.Uses+=1
			M.NonExist()
	MindGenjutsu
		name="KotoAmatsukami 1"
		icon_state="Mind"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			src.Uses+=1
			M.Mind_Genjutsu()
	Invisibility
		name="KotoAmatsukami 2"
		icon_state="Invisibility"
		NonKeepable=1
		BunshinAble=0
		Deactivate(mob/M)
			if(M.invisibility==100)
				M.Invisibility()
			src.TurnedOn=0
			src.DelayIt(600,M,"Clan")
		Activate(mob/M)
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			src.Uses+=1
			src.TurnedOn=1
			M.Invisibility()
	FalseBunshin
		name="KotoAmatsukami 3"
		icon_state="FalseBunshin"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			src.Uses+=1
			spawn()
				src.DelayIt(200,M,"Clan")
			var/mob/A = input(usr,"Which mob?") as mob in world
			M.False_Bunshin(A)
	GenjutsuBunshin
		name="KotoAmatsukami 4"
		icon_state="GenjutsuBunshin"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			src.Uses+=1
			spawn()
				src.DelayIt(200,M,"Clan")
			M.Bunshin_MindFuck()
	UchihaAura
		name="Increase Chakra Aura"
		icon_state="EternalMangekyo"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.mangekyou)
				M<<"Mangekyo Sharingan needs to be on!";return
			src.Uses+=1
			spawn()
				src.DelayIt(200,M,"Clan")
			M.CreateUchihaAura()
	UchihaAuraOff
		name="Decrease Chakra Aura"
		icon_state="EternalMangekyo"
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			src.Uses+=1
			spawn()
				src.DelayIt(50,M,"Clan")
			M.RemoveUchihaAura()



////////////////////////////////////////
//Taijutsu
/////////////////////
	KonohaReppu
		name="Leaf Violent Wind"
		icon_state="Reppu"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] moves their legs to form [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(150,usr,"Tai")
			src.Uses+=1
			M.Reppu()
	KonohaSenpuu
		name="Leaf Whirlwind"
		icon_state="Senpuu"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to move their body for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(630,usr,"Tai")
			src.Uses+=1
			M.Senpuu()
	KonohaShofuu
		name="Leaf Rising Wind"
		icon_state="Shofuu"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(590,usr,"Tai")
			src.Uses+=1
			M.KonohaShofuu()
	KonohaGenkurikiSenpuu
		name="Leaf Strong Whirlwind"
		icon_state="GenkurikiSenpuu"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(580,usr,"Tai")
			src.Uses+=1
			M.KonohaGenkurikiSenpuu()
	KonohaDaiSenpuu
		name="Leaf Great Whirlwind"
		icon_state="DaiSenpuu"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(650,usr,"Tai")
			src.Uses+=1
			M.KonohaDaiSenpuu()
	KonohaDaiSenkou
		name="Leaf Great Light Rotation"
		icon_state="DaiSenkou"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(400,usr,"Tai")
			src.Uses+=1
			M.KonohaDaiSenkou()
	FingerPush
		icon_state="FingerPush"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(150,usr,"Tai")
			src.Uses+=1
			M.TheFingerPush()
	Choke
		icon_state="Choke"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1


			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to raise their Hands torwards your neck for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(300,usr,"Tai")
			src.Uses+=1
			M.Choke()
	ChokeSlam//ChokeSlamProc
		icon_state="Choke Slam"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(650,usr,"Tai")
			src.Uses+=1
			M.ChokeSlamProc()

	HiddenLotus
		icon_state="Gate2"//LotusProc()
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
//			for(var/mob/A in oview(10))
//				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(2000,usr,"Tai")
			src.Uses+=1
			M.LotusProc()

	GateAssault//GateAssaultProc
		icon_state="Gate1"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
//			for(var/mob/A in oview(10))
//				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(1500,usr,"Tai")
			src.Uses+=1
			M.GateAssaultProc()
	Lariat
		name="Lariat"
		icon_state="ReflexPunch"
		Activate(mob/M)
			if(M.key=="FireSSS")
				M.Lariat()
				return
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1


			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to charge at you with a fast paced kick called [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(225,usr,"Tai")
			src.Uses+=1
			M.Lariat()
	GuillotineDrop
		name="Guillotine Drop"
		icon_state="AxeKick"
		Activate(mob/M)
			if(M.key=="FireSSS")
				M.Guillotine_Drop()
				return
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(450,usr,"Tai")
			src.Uses+=1
			M.Guillotine_Drop()
	HorizontalChop
		name="Oppression Horrizontal Chop"
		icon_state="ReflexPunch"
		Activate(mob/M)
			if(M.key=="FireSSS")
				M.Oppression_Horrizontal_Chop()
				return
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1


			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] appears behind you as they attempt to land [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(250,usr,"Tai")
			src.Uses+=1
			M.Oppression_Horrizontal_Chop()
	LigerBomb
		name="Liger Bomb"
		icon_state="ReflexPunch"//Liger_Bomb()
		Activate(mob/M)
			if(M.key=="FireSSS")
				M.Liger_Bomb()
				return
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1


			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] appears behind you as they attempt to land [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(900,usr,"Tai")
			src.Uses+=1
			M.Liger_Bomb()
	Axe_Kick
		name="Axe Kick"
		icon_state="AxeKick"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1


			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to charge at you with a fast paced kick called [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(225,usr,"Tai")
			src.Uses+=1
			M.Axe_Kick()
	Lion_Punch
		name="Lion's Punch"
		icon_state="ReflexPunch"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1


			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] appears behind you as they attempt to land [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(200,usr,"Tai")
			src.Uses+=1
			M.LionPunch()
	Shishi
		name="Lions Barrage"
		icon_state="Shi-shi"
		Target_Required=1
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(600,usr,"Tai")
			src.Uses+=1
			M.Shishi()
	CalmMind
		name="Calm Mind"
		icon_state="Asshou"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(200,usr,"Tai")
			src.Uses+=1
			M.CalmingMind()
	SoothingSlam
		name="Soothing Slam"
		icon_state="Asshou"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);
				if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(250,usr,"Tai")
			src.Uses+=1
			M.SoothingSlam(Uses)
	ReactionAbove
		name="Cautionary Reaction Above"
		icon_state="Asshou"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(250,usr,"Tai")
			src.Uses+=1
			M.CautionaryReactionAbove(Uses)
	ReactionBelow
		name="Cautionary Reaction Below"
		icon_state="Asshou"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(250,usr,"Tai")
			src.Uses+=1
			M.CautionaryReactionBelow(Uses)
	Asshou
		name="Crumbling Palm"
		icon_state="Asshou"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to charge at you to land [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(200,usr,"Tai")
			src.Uses+=1
			M.Asshou()
	ChouAsshou
		name="Wide Open Crumbling Palm"
		icon_state="CAsshou"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to charge at you to land [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(250,usr,"Tai")
			src.Uses+=1
			M.CAsshou()
	DroppingKick
		name="Drop Kick"
		icon_state="Asshou"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] raises their leg above your head to hit you with [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(500,usr,"Tai")
			src.Uses+=1
			M.DropKick()
	Hoshou
		name="Pressure Palm"
		icon_state="Hoshou"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(250,usr,"Tai")
			src.Uses+=1
			M.DownwardPalm()
	Shoushitzu
		name="High Leaping Slam"
		icon_state="Shoushitzu"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1


			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] raises their leg above your head to hit you with [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(800,usr,"Tai")
			src.Uses+=1
			M.Shoushitzu()
	FlashKick
		name="Flash Kick"
		icon_state="Flash Kick"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(550,usr,"Tai")
			src.Uses+=1
			M.L_Kick()
	KageBuyou
		name="Shadow Dance"
		icon_state="KageBuyou"
		Target_Required=1
		Activate(mob/M)
			//M<<"Disabled";return
			if(prob(15))
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1


			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(2000,usr,"Tai")
			src.Uses+=1
			M.KageBuyou()
	QuickFeet
		icon_state="QuickFoot"
		Activate(mob/M)
			if(M.QuickFeet)
				M<<output("You get out of the Quick Feet fighting stance!","Attack");M.QuickFeet=0;M.Normal()
				src.DelayIt(300,usr,"Tai")
			else
				M<<output("You enter the Quick Feet fighting stance!","Attack");M.QuickFeet=1;src.Uses+=1;M.Face()
				spawn(50)
					M.QuickFeet=0;M.Normal()
				for(var/mob/A in oview(10))
					if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

	SoundSpinningKick
		name="Sound Spinning Kick"
		icon_state="Soundspinningkick"
		Deactivate(mob/M)
			src.DelayIt(250,M,"Tai");M.icon_state=""
			M.SoundSpinningKick=0
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=pick(0.1,0.2)
			for(var/mob/A in oview(10))
				if(A.CopyMode)A.SharinganCopy(src.type,src.Uses)
			src.TurnedOn=1
			M.SoundSpinningKick()
			src.Uses+=1

	LeapingSoundSpinKick//LeapingSoundSpinKickProc()
		name="Sound Leaping Spin Kick"
		icon_state="SilentStep"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(250,usr,"Tai")
			src.Uses+=1
			M.LeapingSoundSpinKickProc()
	SoundWhirlwindKick
		name="Sound Whirlwind Kick"
		icon_state="SoundGreatWhirlwindkick"
		Target_Required=1
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(250,usr,"Tai")
			src.Uses+=1
			M.SoundWhirlwindKick()
	RapidPunch
		name="Rapid Punch"
		icon_state="RapidPunch"
		Activate(mob/M)
			if(prob(15)&&M.TaijutsuMastery<10)
				M.TaijutsuMastery+=pick(0.01,0.1);if(M.TaijutsuMastery>10) M.TaijutsuMastery=10
			if(prob(15))
				M.TaijutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(300,usr,"Tai")
			src.Uses+=1
			M.RapidPunchProc()




	Karakuri
		icon_state="Stealth"
		Activate(mob/M)
			for(var/mob/A in oview(10))
				if(A.CopyMode)A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(50,M,"Tai")
			M.Karakuri()
			src.Uses+=1

////////////////////////////////////////
//Genjutsu
/////////////////////
	FalseBugSwarm
		name="False Bug Swarm"
		icon_state="FalseBugSwarm"
		Target_Required=1
		Activate(mob/M)
			if(M.CastingGenjutsu)
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/25)<30)
				M<<output("You can't manipulate chakra well enough to use this.","Attack");return
			if(prob(15))
				M.GenjutsuMastery+=0.1;if(M.GenjutsuMastery>10) M.GenjutsuMastery=10
			if(prob(15))
				M.GenjutsuKnowledge+=1
			if(prob(3))
				M.MentalDamage+=0.1;if(M.MentalDamage>10) M.MentalDamage=10
			src.DelayIt(600,M,"Gen")
			M.GenjutsuProc("HekiKonchuu Ishuu","Affect","Target",300,30,15,50,(usr.gen+(usr.GenjutsuMastery*20)),0)
			src.Uses+=1
	FearofProjectiles
		name="Fear Of Projectiles"
		icon_state="FireMode"
		Activate(mob/M)
			if(M.CastingGenjutsu)
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
		//	if(M.GenSkill+(usr.ChakraC/25)<22)
		//		M<<output("The jutsu failed.","Attack");return
			if(prob(15))
				M.GenjutsuMastery+=0.1
				if(M.GenjutsuMastery>10) M.GenjutsuMastery=10
			if(prob(7*(M.ChakraManipulator+1)))
				M.GenjutsuKnowledge+=1
			else if(M.GenjutsuKnowledge<200&&prob(5))
				M.GenjutsuKnowledge+=1
			if(prob(3))
				M.MentalDamage+=0.1;if(M.MentalDamage>10) M.MentalDamage=10
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(1250,M,"Gen")
			src.Uses+=1
			M.FearofProjectiles()
	GazeOfFear
		name="Gaze Of Fear"
		icon_state="FireMode"
		Activate(mob/M)
			if(M.CastingGenjutsu)
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/25)<15)
				M<<output("You can't manipulate chakra well enough to use this.","Attack");return
			if(prob(15))
				M.GenjutsuMastery+=0.1
				if(M.GenjutsuMastery>10) M.GenjutsuMastery=10
			if(prob(7*(M.ChakraManipulator+1)))
				M.GenjutsuKnowledge+=1
			else if(M.GenjutsuKnowledge<200&&prob(5))
				M.GenjutsuKnowledge+=1
			if(prob(3))
				M.MentalDamage+=0.1;if(M.MentalDamage>10) M.MentalDamage=10
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(1250,M,"Gen")
			src.Uses+=1
			M.GyoushinoKigi()
	DrainingVortex
		name="Draining Vortex"
		icon_state="FireMode"
		Activate(mob/M)
			if(M.CastingGenjutsu)
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/25)<15)
				M<<output("You can't manipulate chakra well enough to use this.","Attack");return
			if(prob(15))
				M.GenjutsuMastery+=0.1
				if(M.GenjutsuMastery>10) M.GenjutsuMastery=10
			if(prob(7*(M.ChakraManipulator+1)))
				M.GenjutsuKnowledge+=1
			else if(M.GenjutsuKnowledge<200&&prob(5))
				M.GenjutsuKnowledge+=1
			if(prob(3))
				M.MentalDamage+=0.1;if(M.MentalDamage>10) M.MentalDamage=10
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(1250,M,"Gen")
			src.Uses+=1
			M.GenjutsuProc("Vortex","Affect","Target",300,10,20,110,M.GenjutsuMastery+(M.gen/1.5),1)


	BlazingBurn
		name="Blazing Burn"
		icon_state="FireMode"
		Target_Required=1
		Activate(mob/M)
			if(M.CastingGenjutsu)
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/25)<15)
				M<<output("You can't manipulate chakra well enough to use this.","Attack");return
			if(prob(15))
				M.GenjutsuMastery+=0.1
				if(M.GenjutsuMastery>10) M.GenjutsuMastery=10
			if(prob(7*(M.ChakraManipulator+1)))
				M.GenjutsuKnowledge+=1
			else if(M.GenjutsuKnowledge<200&&prob(50))
				M.GenjutsuKnowledge+=1
			if(prob(3))
				M.MentalDamage+=0.1;if(M.MentalDamage>10) M.MentalDamage=10
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(600,M,"Gen")
			src.Uses+=1
			M.GenjutsuProc("Blazing Burn","Affect","Target",300,30,15,50,(M.gen+(M.GenjutsuMastery*10)),0)


	Kokuangyo
		name="Bringer of Darkness"
		icon_state="Kokuangyo"
		Target_Required=1
		Activate(mob/M)
			if(M.CastingGenjutsu)
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/25)<15)
				M<<output("You can't manipulate chakra well enough to use this.","Attack");return
			if(prob(15))
				M.GenjutsuMastery+=0.1
				if(M.GenjutsuMastery>10) M.GenjutsuMastery=10
			if(prob(7*(M.ChakraManipulator+1)))
				M.GenjutsuKnowledge+=1
			else if(M.GenjutsuKnowledge<200&&prob(50))
				M.GenjutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			if(prob(3))
				M.MentalDamage+=0.1;if(M.MentalDamage>10) M.MentalDamage=10
			src.DelayIt(600,M,"Gen")
			src.Uses+=1
			M.GenjutsuProc("Kokuangyo","Affect","Target",500,10,15,25,M.GenjutsuMastery,1)

	Burizado
		name="Blizzard Storm Illusion"
		icon_state="Buriza-do"
		Target_Required=1
		Activate(mob/M)
			if(M.CastingGenjutsu)
				src.DelayIt(350,M,"Gen")
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/25)<=9)
				M<<output("You can't manipulate chakra well enough to use this.","Attack");return
			if(prob(15))
				M.GenjutsuMastery+=0.1
				if(M.GenjutsuMastery>10) M.GenjutsuMastery=10
			if(prob(7*(M.ChakraManipulator+1)))
				M.GenjutsuKnowledge+=1
			else if(M.GenjutsuKnowledge<200&&prob(50))
				M.GenjutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			if(prob(3))
				M.MentalDamage+=0.1;if(M.MentalDamage>10) M.MentalDamage=10
			src.DelayIt(350,M,"Gen")
			src.Uses+=1
			M.GenjutsuProc("Burizado","Affect","Target",300,10,10,75,M.GenjutsuMastery+(M.gen/2),1)

	GravityDestruction
		name="Intense Gravitational Destruction"
		icon_state="Buriza-do"
		Target_Required=1
		Activate(mob/M)
			if(M.CastingGenjutsu)
				src.DelayIt(350,M,"Gen")
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/25)<20)
				M<<output("You can't manipulate chakra well enough to use this.","Attack");return
			if(prob(15))
				M.GenjutsuMastery+=0.1
				if(M.GenjutsuMastery>10) M.GenjutsuMastery=10
			if(prob(7*(M.ChakraManipulator+1)))
				M.GenjutsuKnowledge+=1
			else if(M.GenjutsuKnowledge<200&&prob(5))
				M.GenjutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			if(prob(3))
				M.MentalDamage+=0.1;if(M.MentalDamage>10) M.MentalDamage=10
			src.DelayIt(350,M,"Gen")
			src.Uses+=1
			M.GenjutsuProc("Gravity","Affect","Target",300,10,10,75,M.GenjutsuMastery+(M.gen/2)+20,1)

	Kasumi
		name="Mist Servant Technique"
		icon_state="Bunshin"
		Activate(mob/M)
			if(M.CastingGenjutsu)
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/25)<15)
				M<<output("You can't manipulate chakra well enough to use this.","Attack");return
			if(prob(15))
				M.GenjutsuMastery+=0.1
				if(M.GenjutsuMastery>10) M.GenjutsuMastery=10
			if(prob(15))
				M.GenjutsuKnowledge+=1
			if(prob(3))
				M.MentalDamage+=0.1;if(M.MentalDamage>10) M.MentalDamage=10
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(550,M,"Gen")
			src.Uses+=1
			M.GenjutsuProc("Kasumi",,"Area",250,,,,,)

	AOEBurizado
		name="Blizzard Storm Illusion(AOE)"
		icon_state="Buriza-do"
		BunshinAble=0
		Activate(mob/M)
			if(M.CastingGenjutsu)
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/25)<18)
				M<<output("You can't manipulate chakra well enough to use this.","Attack");return
			if(prob(15))
				M.GenjutsuMastery+=0.1
				if(M.GenjutsuMastery>10) M.GenjutsuMastery=10
			if(prob(15))
				M.GenjutsuKnowledge+=1
			if(M.GenjutsuKnowledge<200)
				M.GenjutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			if(prob(3))
				M.MentalDamage+=0.1;if(M.MentalDamage>10) M.MentalDamage=10
			src.DelayIt(550,M,"Gen")
			src.Uses+=1
			M.GenjutsuProc("BurizadoAOE",,"Area",50,,,,,)
	AOEKokuangyo
		name="Bringer of Darkness(AOE)"
		icon_state="Kokuangyo"
		BunshinAble=0
		Activate(mob/M)
			if(M.CastingGenjutsu)
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/25)<19)
				M<<output("You can't manipulate chakra well enough to use this.","Attack");return
			if(prob(15))
				M.GenjutsuMastery+=0.1
				if(M.GenjutsuMastery>10) M.GenjutsuMastery=10
			if(prob(8*(M.ChakraManipulator+1)))
				M.GenjutsuKnowledge+=1
				M.GenjutsuKnowledge+=1
			if(M.GenjutsuKnowledge<200)
				M.GenjutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			if(prob(3))
				M.MentalDamage+=0.1;if(M.MentalDamage>10) M.MentalDamage=10
			src.DelayIt(550,M,"Gen")
			src.Uses+=1
			M.GenjutsuProc("KokuangyoAOE",,"Area",50,,,,,)
	Nemurihane
		name="Temple of Nirvana"
		icon_state="Nemurihane"
		BunshinAble=0
		Activate(mob/M)
			if(M.CastingGenjutsu)
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/25)<15)
				M<<output("You can't manipulate chakra well enough to use this.","Attack");return
			if(prob(15))
				M.GenjutsuMastery+=0.1
				if(M.GenjutsuMastery>10) M.GenjutsuMastery=10
			if(prob(7*(M.ChakraManipulator+1)))
				M.GenjutsuKnowledge+=1
			else if(M.GenjutsuKnowledge<200)
				M.GenjutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			if(prob(3))
				M.MentalDamage+=0.1;if(M.MentalDamage>10) M.MentalDamage=10
			src.DelayIt(550,M,"Gen")
			src.Uses+=1
			M.GenjutsuProc("Nemurihane",,"Area",50,,,,,)
	Kiga
		name="Hunger"
		icon_state="Kiga"
		Target_Required=1
		Activate(mob/M)
			if(M.CastingGenjutsu)
				src.DelayIt(350,M,"Gen")
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/10)<5)
				M<<output("You can't manipulate chakra well enough to use this.","Attack");return
			if(prob(15))
				M.GenjutsuMastery+=0.1
				if(M.GenjutsuMastery>10) M.GenjutsuMastery=10
			if(prob(7*(M.ChakraManipulator+1)))
				M.GenjutsuKnowledge+=1
			else if(M.GenjutsuKnowledge<200&&prob(50))
				M.GenjutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			if(prob(3))
				M.MentalDamage+=0.1;if(M.MentalDamage>10) M.MentalDamage=10
			src.DelayIt(350,M,"Gen")
			src.Uses+=1
			M.GenjutsuProc("Kiga","Affect","Target",100,10,10,25,((M.gen/3)+M.GenjutsuMastery),1)


	FalseDeath
		name="False Death Jutsu"
		icon_state="FuuinjutsuChakra"
		Activate(mob/M)
			if(M.PlayingDead)
				M.PlayingDead=0
				return
			if(M.knockedout && (Uses<500 || M.NinjutsuKnowledge<1000))
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.Uses+=1
	//		M.FalseDeath(src.Uses)
			src.DelayIt(1250,M,"Nin")

	NodonoKawaki
		name="Thirst"
		icon_state="NodonoKawaki"
		Target_Required=1
		Activate(mob/M)
			if(M.CastingGenjutsu)
				src.DelayIt(350,M,"None")
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/10)<5)
				M<<output("You can't manipulate chakra well enough to use this.","Attack");return
			if(prob(15))
				M.GenjutsuMastery+=0.1
				if(M.GenjutsuMastery>10) M.GenjutsuMastery=10
			if(prob(7*(M.ChakraManipulator+1)))
				M.GenjutsuKnowledge+=1
			else if(M.GenjutsuKnowledge<500&&prob(80))
				M.GenjutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			if(prob(3))
				M.MentalDamage+=0.1;if(M.MentalDamage>10) M.MentalDamage=10
			src.DelayIt(350,M,"Gen")
			src.Uses+=1
			M.GenjutsuProc("Nodono Kawaki","Affect","Target",100,10,10,25,((M.gen/3)+M.GenjutsuMastery),1)
	GyakuBijon
		name="Daze"
		icon_state="GyakuBijon"
		Target_Required=1
		Activate(mob/M)
			if(M.CastingGenjutsu)
				src.DelayIt(350,M,"None")
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/25)<10)
				M<<output("You can't manipulate chakra well enough to use this.","Attack");return
			if(prob(15))
				M.GenjutsuMastery+=0.1
				if(M.GenjutsuMastery>10) M.GenjutsuMastery=10
			if(prob(7*(M.ChakraManipulator+1)))
				M.GenjutsuKnowledge+=1
			else if(M.GenjutsuKnowledge<200&&prob(5))
				M.GenjutsuKnowledge+=1
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			if(prob(3))
				M.MentalDamage+=0.1;if(M.MentalDamage>10) M.MentalDamage=10
			src.DelayIt(350,M,"Gen")
			src.Uses+=1
			M.GenjutsuProc("Gyaku Bijon","Affect","Target",250,10,10,25,((M.gen/2)+M.GenjutsuMastery),1)
////////////////////////////////////////
//Fuuinjutsu
/////////////////////
	FuuinjutsuHandseal
		name="Fuuinjutsu: Handseal"
		icon_state="FuuinjutsuHandseal"
		Target_Required=1
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(100,M,"Nin")
			src.Uses+=1
			M.FuuinjutsuHandseal()
	FuuinjutsuChakra
		name="Fuuinjutsu: Chakra"
		icon_state="FuuinjutsuChakra"
		Target_Required=1
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(100,M,"Nin")
			src.Uses+=1
			M.FuuinjutsuChakra()
	FuuinjutsuControl
		name="Fuuinjutsu: Control"
		icon_state="FuiinjutsuControl"
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.GenSkill<17)
				M<<output("The jutsu failed due to lack of Natural Control.","Attack");return
			src.DelayIt(100,M,"Nin")
			src.Uses+=1
			M.FuuinjutsuControl()
	FuuinjutsuCurseSealOfParalysis
		name="Cursed Seal Of Paralysis"
		icon_state="FuuinjutsuChakra"
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.GenSkill<20&&M.key!="Marcus55")
				M<<output("The jutsu failed due to lack of Natural Control.","Attack");return
			src.DelayIt(300,M,"Nin")
			src.Uses+=1
			M.CurseSealOfParalysis()
	ReverseFourSymbols
		name="Reverse Four Symbols Sealing Technique"
		icon_state="FuuinjutsuChakra"
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.GenSkill<23&&M.key!="Marcus55")
				M<<output("The jutsu failed due to lack of Natural Control.","Attack");return
			src.DelayIt(3600,M,"Nin")
			src.Uses+=1
			M.ReverseFourSymbolsTechnique()
	UpperCloathingRemoval
		name="Take Off Upper Cloathing"
		icon_state="FuuinjutsuChakra"
		Activate(mob/M)
			src.DelayIt(3600,M,"Nin")
			M.RemoveUpperCloathing()
	FiveElementSeal
		name="Fuuinjutsu: Five Elemental Sealing"
		icon_state="FuiinjutsuControl"
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.GenSkill<23)
				M<<output("The jutsu failed due to lack of Natural Control.","Attack");return
			src.DelayIt(100,M,"Nin")
			src.Uses+=1
			M.FuuinjutsuFiveElementSeal()
	FuuinjutsuHellSent
		name="Fuuinjutsu: HellSent Seal"
		icon_state="FuiinjutsuControl"
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.GenSkill<21.5)
				M<<output("The jutsu failed due to lack of Natural Control.","Attack");return
			src.DelayIt(100,M,"Nin")
			src.Uses+=1
			M.FuuinjutsuHellSentRestoration()
	MindControlJutsu
		name="Fuuinjutsu: Mind Control Jutsu"
		icon_state="FuuinjutsuControl"
		BunshinAble=0
		Activate(mob/M)
			return
//		Deactivate(mob/M)
//			M.MindControlJutsu()
//			DelayIt(600,M,"Nin")
//		Activate(mob/M)
//			src.Uses++
//			src.TurnedOn=1
//			M.CastingMindControl=1
//			M<<"Click on someone that you wish to control to place a chakra seal, then press Z to activate the seal!"
////////////////////////////////////////
////////////////////////////////////////
//
/////////////////////
	Puppet_Master_Jutsu
		name="Puppet Master"
		icon_state="FuumaTeleportation"
		BunshinAble=0
		Activate(mob/M)
			src.Uses+=1
			M.PuppetMasterJutsu()
	Unsummon_Puppet_One
		name="Unsummon Puppet(1)"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
			src.Uses+=1
			M.ReturnPuppet("Keyboard")
	Unsummon_Puppet_Two
		name="Unsummon Puppet(2)"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
			src.Uses+=1
			M.ReturnPuppet("Mouse")
	Hawk_Change_Mode
		name="Change Hawk Movement"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
			src.Uses+=1
			M.ChooseHawkMode()
			src.DelayIt(100,M,"Clan")
	Puppet_Body_Swap
		name="Body/Puppet Swap"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
			src.Uses+=1
			M.PositionSwap()
			src.DelayIt(250,M,"Clan")
	Puppet_Body_View
		name="Body/Puppet View"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
			src.Uses+=1
			M.PuppetView()
	Puppet_Return
		name="Puppet Return"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
			src.Uses+=1
			M.PuppetReturn()
	PuppetPoisonSpread
		name="Puppet Poisonous Spread Beginner"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(300)
			M.PoisonRelease("Light")
	PuppetPoisonSpreadMedium
		name="Puppet Poisonous Spread Moderate"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(500)
			M.PoisonRelease("Medium")
	PuppetPoisonSpreadHeavy
		name="Puppet Poisonous Spread Strong"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
			src.Uses+=1
			src.DelayIt(600)
			M.PoisonRelease("Heavy")
	SpreadingSmokeScreenLight
		name="Hawk: Smoke Screen Spread Beginner"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
			if(istype(M,/mob/Puppet/Hawk))
				//var/mob/A=M.Owner
				src.Uses+=1
				src.DelayIt(450)
				M.HawkSmokeScreen("Light")
	SpreadingSmokeScreenMedium
		name="Hawk: Smoke Screen Spread Moderate"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
			if(istype(M,/mob/Puppet/Hawk))
				//var/mob/A=M.Owner
				src.Uses+=1
				src.DelayIt(500)
				M.HawkSmokeScreen("Medium")
	SpreadingSmokeScreenHeavy
		name="Hawk: Smoke Screen Spread Strong"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
			if(istype(M,/mob/Puppet/Hawk))
				//var/mob/A=M.Owner
				src.Uses+=1
				src.DelayIt(650)
				M.HawkSmokeScreen("Heavy")
	SenbonLauncherLight
		name="Talon: Senbon Launcher Beginner"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
	//		world<<"Test. [M] is the mob/M"
			//var/mob/A
			if(istype(M,/mob/Puppet/Talon))
		//		world<<"Type Identified."
				A=M
				src.Uses+=1
				src.DelayIt(300)
				M.SenbonLauncher(5,5)


////////////////////////////////////////
//Ninjutsu
/////////////////////


////////////////////////////////////////
//Space Time Jutsu - Sorta >_> xD
/////////////////////
	SetLeftHandSpaceTime
		name="Space Time Ninjutsu - Left"
		icon_state="SetLeftHand"
		Activate(mob/M)
			usr.SetLeftHandSpaceTime()
	SetRightHandSpaceTime
		name="Space Time Ninjutsu - Right"
		icon_state="SetRightHand"
		Activate(mob/M)
			usr.SetRightHandSpaceTime()
	SpaceTimeFreezeTimeSelect
		name="Space Time Ninjutsu - Freeze Select"
		icon_state="SetRightHand"
		Activate(mob/M)
			M.FreezeTimeSelect()
	SpaceTimeFreeze
		name="Space Time Ninjutsu - Freeze"
		icon_state="SetRightHand"
		Activate(mob/M)
			M.FreezeTime(M.FreezeTime)
//	FreezeHands
//	FreezeLegs
//	FreezeTime
//	VoidInhale
//	VoidExhale
//	VoidDevour
//	VoidTransport

	BunshinJutsu
		name="Clone Jutsu"
		icon_state="Bunshin"
		Activate(mob/M)
			if(!M.premium_pack)
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
			src.DelayIt(100,M,"Nin")
			if(M.SageMode=="Toad")
				src.DelayIt(800,M,"Nin")
			src.Uses+=1
			M.BunshinTechniques(src.Uses/2)
	BunshinSubsitutionJutsu
		name="Clone Trick"
		icon_state="BunshinTrick2"
		Activate(mob/M)
			if(M.premium_pack < 2)
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
			src.DelayIt(100,M,"Nin")
			src.Uses+=1
			M.BunshinSubsitutionTechniques(src.Uses/2)
	ToadSageBunshinTrap
		name="Toad Sage: Bunshin Trapping Technique"
		icon_state="BunshinTrick2"
		Activate(mob/M)
			src.DelayIt(1200,M,"Nin")
			src.Uses+=1
			M.ToadSageBunshinTrap(src.Uses/2)


	Henge
		BunshinAble=0
		name="Transformation Jutsu"
		icon_state="Henge"
		Deactivate(mob/M)
			if(M.InHenge)
				M.HengeJutsu()
		Activate(mob/M)
			if(!M.premium_pack)
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
			src.DelayIt(250,M,"Nin")
			src.Uses+=1
			src.TurnedOn=1
			M.HengeJutsu()
	Kawarimi
		BunshinAble=0
		name="Substitution Jutsu"
		icon_state="Kawarimi"
		Deactivate(mob/M)
			if(M.invisibility>1)
				M.invisibility=1
				M.firing=0
		Activate(mob/M)
			if(!M.premium_pack)
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
			src.DelayIt(300,M,"Nin")
			src.Uses+=1
			src.TurnedOn=1
			for(var/obj/SkillCards/ExpKawarimi/A in M.LearnedJutsus)
				A.DelayIt(300,M,"Nin")
			M.Kawa(src.Uses)
	ExpKawarimi
		BunshinAble=0
		name="Exploding Substitution Jutsu"
		icon_state="ExpKawarimi"
		Activate(mob/M)
			if(M.premium_pack < 3)
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
			src.DelayIt(300,M,"Nin")
			src.Uses+=1
			for(var/obj/SkillCards/Kawarimi/A in M.LearnedJutsus)
				A.DelayIt(300,M,"Nin")
			M.Kawa2(src.Uses)
	Shushin
		name="Body Flicker"
		icon_state="Shushin"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.UchihaMastery!=100)
				var/Delay=35-(M.BodyFlickerRepetition*10)
				src.DelayIt(max(5,Delay),M,"Tai")
			src.Uses+=1
			if(src.Uses>5000)
				if(!M.BodyFlickerDistanceTrained)
					if(M.BodyFlickerDistance<4)
						M.BodyFlickerDistanceTrained=1
						M.BodyFlickerDistance++
						M<<"Because of your rigorous training with Body Flicker your body has learned a bit to increase the distance of your body flicker naturally."
						if(M.BodyFlickerDistance>=5)
							M.BodyFlickerDistance=4
						M.AutoSave()
				if(!M.BodyFlickerRepetitionTrained)
					if(M.BodyFlickerRepetition<4)
						M.BodyFlickerRepetitionTrained=1
						M.BodyFlickerRepetition++
						M<<"Because of your rigorous training with Body Flicker your body has learned a bit to increase the repetition of your body flicker naturally."
						if(M.BodyFlickerRepetition>=5)
							M.BodyFlickerRepetition=4
						M.AutoSave()
			if(src.Uses>7500)
				if(!M.BodyFlickerMasterTrained)
					if(M.BodyFlickerMaster<3)
						M.BodyFlickerMasterTrained=1
						M.BodyFlickerMaster++
						if(M.BodyFlickerMaster>=4)
							M.BodyFlickerMaster=3
						M<<"Because of your rigorous training with Body Flicker your body has learned to naturally use less chakra when using Body Flicker."
						M.AutoSave()

			if(M.Trait=="Speedy")
				if(prob(40))
					src.Uses+=1
			M.AbleToMoonsplitter=1
			spawn(50)
				M.AbleToMoonsplitter=0
			M.ShushinnoJutsu(src.Uses)


	Nawanuke
		name="Escaping Skill"
		icon_state="Nawanuke"
		Activate(mob/M)
			if(M.premium_pack < 3)
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
			src.DelayIt(50,M,"None")
			src.Uses+=1
			M.Nawanuke()
	ExplodingFormation
		name="Exploding Formation"
		icon_state="ExplodingTagFormation"
		Activate(mob/M)
			if(M.premium_pack < 3)
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
			src.DelayIt(80,M,"None")
			src.Uses+=1
			M.TagExplosion()
	RainingTags
		name="Raining Tags"
		icon_state="ExplodingTagFormation"
		Activate(mob/M)
			if(M.premium_pack < 3)
				for(var/obj/SkillCards/ExplodingFormation/P in usr.LearnedJutsus)
					if(!P.Delay)
						P.DelayIt(30,M,"None")
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
			src.DelayIt(1200,M,"Nin")
			src.Uses+=1
			M.RainOfTags()
	HariganeGappei
		name="Meld Wire"
		icon_state="HariganeGappei"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(90,M,"None")
			src.Uses+=1
			M.HariganeGappei()
	FuumaTeleportation
		name="Fuuma Teleportation"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
			if(M.Village!="Rain")
				M<<"Your Rain Village Pride is gone..This doesn't belong to you.."
				del(src)
				return
			if(M.Jailed)
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(1000,M,"Nin")
			src.Uses+=1
			M.FuumaTeleport()
	SatakeTeleportation
		name="Satake Teleportation"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
			if(M.Village!="Sound")
				M<<"Your Sound Village Pride is gone..This doesn't belong to you.."
				del(src)
				return
			if(M.Jailed)
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(1000,M,"Nin")
			src.Uses+=1
			M.SatakeTeleport()
	UzumakiTeleportation
		name="Uzumaki Teleportation"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
			if(M.Village!="Leaf")
				M<<"Your Leaf Village Pride is gone..This doesn't belong to you.."
				del(src)
				return
			if(M.Jailed)
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(1000,M,"Nin")
			src.Uses+=1
			M.UzumakiTeleport()
	RendenTeleportation
		name="Renden Teleportation"
		icon_state="FuumaTeleportation"
		Activate(mob/M)
			if(M.Village!="Rock")
				M<<"Your Rock Village Pride is gone..This doesn't belong to you.."
				del(src)
				return
			if(M.Jailed)
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(1000,M,"Nin")
			src.Uses+=1
			M.RendenTeleport()
	CrimsonTeleportation
		name="Crimson Teleportation"
		icon_state="FuumaTeleportation"
		Activate(mob/M)

			src.DelayIt(1000,M,"Nin")
			src.Uses+=1
			M.CrimsonTeleport()
	Ikusenhari
		name="Rain of Needles"
		icon_state="Ikusenhari"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(600,M,"Nin")
			src.Uses+=1
			M.Ikusenhariz()
	Kirigakure
		name="Hidden Mist Jutsu"
		icon_state="Kirigakure"
		BunshinAble=0
		Activate(mob/M)
			if(M.KirigakureOn)
				M<<"You release the mist."
				for(var/obj/Jutsu/kriga/S2 in world)
					if(S2.Owner==M)
						del(S2)
				for(var/mob/C in OnlinePlayers)
					if(C.key=="DemonicK")
						C<<"[M] is activating Hidden Mist Jutsu."
				M.KirigakureOn=0;
				src.DelayIt(300,M,"Nin")
				return
			else
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				for(var/mob/A in oview(10))
					if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
					if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				src.DelayIt(300,M,"Nin")
				src.Uses+=1
				M.Kirigakure()

	SilentKilling
		name="Silent Killing: Assassination"
		icon_state="SwiftSlash"
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(950,M,"Tai")
			src.Uses+=1
			M.SilentKilling()

	Kiriame
		name="Mist Rain"
		icon_state="Kiriame"
		BunshinAble=0
		Activate(mob/M)
			if(M.KiriameOn)
				M.KiriameOn=0;
				M<<"You release the rain."
				for(var/obj/Jutsu/Kiriame/S2 in world)
			//		sleep(1)
					if(S2.Owner==M)
						del(S2)

				src.DelayIt(200,M,"Nin")
				return
			else
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				src.DelayIt(10,M,"Nin")
				src.Uses+=1
				M.Kiriame()
	RavelRain
		name="Raveling Rain"
		icon_state="Kiriame"
		BunshinAble=0
		Activate(mob/M)
			if(M.RavelOn)
				M<<"You release the rain."
				for(var/obj/Jutsu/Ravel/S2 in world)
					sleep(1)
					if(S2.Owner==M)
						del(S2)
				M.RavelOn=0;return
			else
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				src.DelayIt(1250,M,"Nin")
				src.Uses+=1
		//		M.RavelingRain()
	PoisonRain
		name="Poisoning Rain"
		icon_state="Kiriame"
		BunshinAble=0
		Activate(mob/M)
			if(M.PoisonRainOn)
				M<<"You release the rain."
				for(var/obj/Jutsu/PoisoningRain/S2 in world)
					sleep(1)
					if(S2.Owner==M)
						del(S2)
				M.PoisonRainOn=0;return
			else
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				for(var/mob/C in OnlinePlayers)
					if(C.key=="Marcus55")
						C<<"[M] is activating Poison Rain Jutsu."
				src.DelayIt(1250,M,"Nin")
				if(prob(20))
					M.PoisonKnowledge++
				src.Uses+=1
		//		M.PoisoningRain()


	MurderCrows
		name="Massacre of Crows Cloaking Jutsu"
		icon_state="MurderCrows"
		BunshinAble=0
		Activate(mob/M)
			if(M.usemurderofcrows)
				M<<"You call back the crows!"
				for(var/mob/Jutsu/MurderCrows/S2 in world)
					if(S2.Owner==M)
						del(S2)
				M.usemurderofcrows=0
				return
			else
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				for(var/mob/P in OnlinePlayers)
					if(P.key=="Marcus55")
						P<<"[M] is using Crows."
				src.DelayIt(300,M,"Nin")
				src.Uses+=1
				usr.MurderofCrows(src.Uses)
	CrowVoid
		name="Dark Void of Man Eating Crows"
		icon_state="MurderCrows"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(300,M,"Nin")
			src.Uses+=1
			spawn(3)
			usr<<"Just hope who ever has been spamming this realizes they've been causing lag for a while. .-.";return
		//	usr.CrowVoidGenjutsu()

	OvenGenjutsu
		name="Oven Hallucinatory Melt"
		icon_state="Hikibou"
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/25)<21)
				M<<output("The jutsu failed.","Attack");return
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(900,M,"Nin")
			src.Uses+=1
			spawn(3)
			usr.OvenGenjutsu()

	HallucinatoryDrowningOcean
		name="Hallucinatory Drowning Ocean"
		icon_state="OceanGen"
		BunshinAble=0
		Activate(mob/M)
			if(M.CastingGenjutsu)
				return
			if(src.Uses<100&&M.Trait!="Speedy")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Speedy"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/25)<21)
				M<<output("The jutsu failed.","Attack");return
			if(prob(15))
				usr.GenjutsuMastery+=0.1
				if(M.Clan=="Basic"&&usr.GenjutsuMastery>20) usr.GenjutsuMastery=20
				else if(M.Clan!="Basic"&&usr.GenjutsuMastery>10) usr.GenjutsuMastery=10
			if(prob(15))
				M.GenjutsuKnowledge+=1

			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(750,M,"Gen")
			src.Uses+=1
			var/S=((M.MentalDamage/10)+1)*M.GenSkill
			M.GenjutsuProc("Ocean",,"Area",50,,,,S,)

	HallucinatoryMeltingOvan
		name="Hallucinatory Melting Ovan"
		icon_state="Hikibou"
		BunshinAble=0
		Activate(mob/M)
			if(M.CastingGenjutsu)
				return
			if(src.Uses<100&&M.Trait!="Speedy")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Speedy"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.GenSkill+(usr.ChakraC/25)<20)
				M<<output("The jutsu failed.","Attack");return
			if(prob(15))
				usr.GenjutsuMastery+=0.1
				if(M.Clan=="Basic"&&usr.GenjutsuMastery>20) usr.GenjutsuMastery=20
				else if(M.Clan!="Basic"&&usr.GenjutsuMastery>10) usr.GenjutsuMastery=10
			if(prob(15))
				M.GenjutsuKnowledge+=1

			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(550,M,"Gen")
			src.Uses+=1
			var/S=((M.MentalDamage/10)+1)*M.GenSkill
			M.GenjutsuProc("Ovan",,"Area",50,,,,S,)

	Haruno
		name="Hand of Nature Jutsu"
		icon_state="Haruno"
		Target_Required=1
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(600,M,"Nin")
			src.Uses+=1
			M.LeafBind()
	KageBunshin
		name="Shadow Clone Jutsu"
		icon_state="KageBunshin"
		BunshinAble=0
		Deactivate(mob/M)
			//M<<output("This jutsu is disabled");return
			if(M.KBunshinOn)
				M.firing=0;M.KBunshinOn=0;M.client.perspective=MOB_PERSPECTIVE
				M.client.eye=M;M.controlled=null
		Activate(mob/M)
			//M<<output("This jutsu is disabled");return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			if(src.Uses<5000) src.DelayIt(350,M,"Nin")
			src.Uses+=1
			src.TurnedOn=1
			M.KageBunshin(src.Uses)

	PoisonClone
		name="Medical Style: Bunshin Gas Release"
		icon_state="PoisonClone3"
		BunshinAble=0
		Deactivate(mob/M)
			//M<<output("This jutsu is disabled");return
			if(M.KBunshinOn)
				M.firing=0;M.KBunshinOn=0;M.client.perspective=MOB_PERSPECTIVE
				M.client.eye=M;M.controlled=null
		Activate(mob/M)
			//M<<output("This jutsu is disabled");return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			if(src.Uses<5000) src.DelayIt(350,M,"Nin")
			src.Uses+=1
			src.TurnedOn=1
			M.PoisonClone(src.Uses)

	KageBunshinSubstitute
		name="Shadow Clone Substitute"
		icon_state="KageBunshin"
		BunshinAble=0
		Deactivate(mob/M)
			M.CloneSubstituteMode=0
			if(M.KBunshinOn)
				M.firing=0;M.KBunshinOn=0;M.client.perspective=MOB_PERSPECTIVE
				M.client.eye=M;M.controlled=null
		Activate(mob/M)
			if(src.Uses<5000) src.DelayIt(350,M,"Nin")
			src.Uses+=1
			src.TurnedOn=1
			M.CloneSubstituteMode=1
			M<<"You're activated Shadow Clone Substitution. Click on a turf to flicker there and you'll leave a controlled Shadow Clone in your place."
	KageBunshinAttack
		name="Shadow Clone Attack"
		icon_state="KageBunshin"
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(src.Uses<5000) src.DelayIt(350,M,"Nin")
			src.Uses+=1
			M.ShadowCloneTackle(src.Uses)
	WindmillCloneAttack
		name="Windmill Clone Attack"
		icon_state="WindmilClone"
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(src.Uses<5000) src.DelayIt(150,M,"Nin")
			src.Uses+=1
			M.WindmillCloneAttack(src.Uses)
	WindmillCloneAttack
		name="Windmill Clone Attack"
		icon_state="KageBunshin"
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(src.Uses<5000) src.DelayIt(150,M,"Nin")
			src.Uses+=1
			M.WindmillCloneAttack(src.Uses)
	ShadowClonePunch
		name="Shadow Clone Punch"
		icon_state="KageBunshin"
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(src.Uses<5000) src.DelayIt(150,M,"Nin")
			src.Uses+=1
			M.Shadow_Clone_Punch(src.Uses)


	TKageBunshin
		name="Mass Shadow Clone Jutsu"
		icon_state="TKageBunshin"
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(2000,M,"Nin")
			src.Uses+=1
			M.Multi_Shadow_Clone(src.Uses)
	BakuretsuBunshin
		name="Shadow Clone Explosion"
		icon_state="BakuretsuBunshin"
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.Uses+=1
			M.Shadow_Clone_Explosion()
			src.DelayIt(600,M,"Nin")
	KageShuriken
		name="Shadow Shuriken"
		icon_state="KageShuriken"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(300,M,"Nin")
			src.Uses+=1
			M.KageShuriken()
	KageKunai
		name="Shadow Kunai"
		icon_state="ShadowKunai"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(800,M,"Nin")
			src.Uses+=1
			M.KageKunai()
	ControllingWindmill
		name="Controlling Windmill"
		icon_state="KageShuriken"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(1050,M,"Nin")
			src.Uses+=1
			M.ControllingWindmill(Uses)
	ChakraBarrier
		name="Chakra Barrier"
		icon_state="Rasengan"
		Activate(mob/M)
			if(M.Rasenganon)
				M<<output("You're already using Rasengan!","Attack");return
			else
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				src.DelayIt(150,M,"Clan")
				src.Uses+=1
				M.BarrierBlock()
	ChakraBarrierBig
		name="Strengthened Chakra Barrier"
		icon_state="Rasengan"
		Activate(mob/M)
			if(M.Rasenganon)
				M<<output("You're already using Rasengan!","Attack");return
			else
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				src.DelayIt(250,M,"Clan")
				src.Uses+=1
				M.BarrierWall()
	ChakraBarrierTrap
		name="Chakra Barrier Entrapment"
		icon_state="Rasengan"
		Activate(mob/M)
			if(M.Rasenganon)
				M<<output("You're already using Rasengan!","Attack");return
			else
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				src.DelayIt(250,M,"Clan")
				src.Uses+=1
				M.BarrierTrap()
	ChakraBarrierShield
		name="Chakra Barrier Shielding"
		icon_state="Rasengan"
		Activate(mob/M)
			if(M.Rasenganon)
				M<<output("You're already using Rasengan!","Attack");return
			else
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				src.DelayIt(250,M,"Clan")
				src.Uses+=1
				M.BarrierShield()
	ChakraBarrierContainment
		name="Chakra Barrier Containment"
		icon_state="Rasengan"
		Activate(mob/M)
			if(M.Rasenganon)
				M<<output("You're already using Rasengan!","Attack");return
			else
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				src.DelayIt(600,M,"Clan")
				src.Uses+=1
				M.BarrierContainment()
	ChakraBarrierDestructiveContainment
		name="Chakra Barrier Destructive Containment"
		icon_state="Rasengan"
		Activate(mob/M)
			if(M.Rasenganon)
				M<<output("You're already using Rasengan!","Attack");return
			else
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				src.DelayIt(450,M,"Clan")
				src.Uses+=1
				M.DestructiveBarrierContainment()
	ChakraBarrierRisingTrail
		name="Chakra Barrier Rising Trail"
		icon_state="Rasengan"
		Activate(mob/M)
			if(M.Rasenganon)
				M<<output("You're already using Rasengan!","Attack");return
			else
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				src.DelayIt(150,M,"Clan")
				src.Uses+=1
				M.BarrierProtection()


	Rasengan
		icon_state="Rasengan"
		Activate(mob/M)
			if(M.Rasenganon)
				M<<output("You're already using Rasengan!","Attack");return
			else
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				src.DelayIt(1000,M,"Nin")
				src.Uses+=1
				if(src.Uses>=3500&&M.KatonKnowledge>=2000)
					if(!(locate(/obj/SkillCards/KatonRasengan) in M.LearnedJutsus))
						M.LearnedJutsus+= new/obj/SkillCards/KatonRasengan
				if(src.Uses>=3500&&M.FuutonKnowledge>=2000)
					if(!(locate(/obj/SkillCards/FuutonRasengan) in M.LearnedJutsus))
						M.LearnedJutsus+= new/obj/SkillCards/FuutonRasengan
				/*for(var/obj/SkillCards/FuutonRasengan/P in M.LearnedJutsus)
					P.DelayIt(1000,M,"Nin")
				for(var/obj/SkillCards/KatonRasengan/P in M.LearnedJutsus)
					P.DelayIt(1000,M,"Nin")*/
				M.Rasengan()
	RasenganBarrage
		icon_state="Rasengan"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(1800,M,"Nin")
			src.Uses+=1
			M.RasenganBarrageProc()
	Giant_Rasengan
		icon_state="OodamaRasengan"
		Activate(mob/M)
			if(!M.Rasenganon||M.RasenganCharge)
				M<<"You must have Rasengan on!"
				src.DelayIt(100,M,"Nin");return
			else
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				src.DelayIt(600,M,"Nin")
				src.Uses+=1
				M.Giant_Rasengan()
	Immediate_Giant_Rasengan
		icon_state="OodamaRasengan"
		Activate(mob/M)
		//	if(!M.Rasenganon||M.RasenganCharge)
		//		M<<"You must have Rasengan on!"
		//		src.DelayIt(100,M,"Nin");return
		//	else
	//		if(src.Uses<100&&M.Trait!="Genius")
	//			if(prob(95-src.Uses))
	//				M<<output("The jutsu failed.","Attack");return
	//		else if(M.Trait=="Genius"&&src.Uses<50)
	//			if(prob(50-src.Uses))
	//				M<<output("The jutsu failed.","Attack");return
			src.DelayIt(600,M,"Nin")
			src.Uses+=1
			M.Immediate_Giant_Rasengan()
				//Immediate_Giant_Rasengan()
	Rasenshuriken
		icon_state="OodamaRasengan"
		Activate(mob/M)
			src.DelayIt(1000,M,"Nin")
			src.Uses+=1
			M.RasenShuriken()
	Double_Rasengan
		icon_state="doublerasengan3"
		Activate(mob/M)
			if(!M.Rasenganon||M.RasenganCharge)
				M<<"You must have Rasengan on!"
				src.DelayIt(100,M,"Nin");return
			else
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				for(var/obj/SkillCards/Rasengan/P in M.LearnedJutsus)
					P.DelayIt(1000,M,"Nin")
				src.DelayIt(1000,M,"Nin")
				src.Uses+=1
				M.DoubleRasengan()

	ChakraEnhance
		name="Chakra Enhance"
		icon_state="ChakraEnhance"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(50,M,"Nin")
			src.Uses+=1
			M.ChakraEnhance()
	ExpandingShuriken
		name="Expanding Shuriken"
		icon_state="ExpandingShuriken"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.ShurikenMastery<=50)
				M<<output("You don't know enough about Shurikens to utilize this jutsu.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(850,M,"Nin")
			src.Uses+=1
			M.ExpandingShurikenProj()
	HairNeedleSenbon
		name="Hair Needle Senbon"
		icon_state="GuidingWeapon"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(950,M,"Nin")
			src.Uses+=1
			M.KebariSenbon(src.Uses)
	WeaponSummoningKunai
		name="Weapon Summoning: Kunai"
		icon_state="Weapon Summon1"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.KunaiMastery<50)
				M<<"You don't have enough Kunai Mastery to use this jutsu.";return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(950,M,"Nin")
			src.Uses+=1
			M.WeaponSummoningKunai(src.Uses)
	KunaiBarrage
		name="Kunai Barrage"
		icon_state="GuidingWeapon"
		Activate(mob/M)
			var/Size=5;
			var/Rounds=1;
			var/Trained=round(src.Uses/200)
			var/Trained2=round(src.Uses/300)
			if(M.key=="")
				Rounds=10;
				Size=9;
				src.Uses=100;
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(1050,M,"Nin")
			src.Uses+=1
			M.KunaiBarrageProc(Size+Trained,Rounds+Trained2)
	WeaponReverse
		name="Weapon Reverse"
		icon_state="WeaponReverse"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(50,M,"Nin")
			src.Uses+=1
			M.WeaponReverse()
	GuidingWeapon
		name="Guiding Weapon"
		icon_state="GuidingWeapon"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(150,M,"Nin")
			src.Uses+=1
			M.GuidingWeapon()
	Shousen
		name="Mystical Hand"
		icon_state="Shousen3"
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.ARank=="Healer")
				src.DelayIt(100,M,"Nin")
			else
				src.DelayIt(120,M,"Nin")
			src.Uses+=1
			for(var/obj/SkillCards/ForbiddenShousen/A in M.LearnedJutsus)
				A.DelayIt(350,M,"Nin")
			M.Mystical_Hand_Technique(src.Uses)

	ForbiddenShousen
		name="Advanced Mystical Hand"
		icon_state="ShousenUpgrade"
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
	//		if(M.ARank=="Healer")
	//			src.DelayIt(50,M,"Nin")
			src.DelayIt(100,M,"Nin")
			src.Uses+=1
			for(var/obj/SkillCards/Shousen/A in M.LearnedJutsus)
				A.DelayIt(200,M,"Nin")
			M.Mystical_Hand_Technique_Advanced(src.Uses)

	ChakraNoMesu
		name="Chakra Scalpel"
		icon_state="ChakraNoMesu"
		BunshinAble=0
		Deactivate(mob/M)
			if(M.scalpel)
				M.scalpel=0;src.DelayIt(600,M,"Nin")
			src.TurnedOn=0
		Activate(mob/M)
			src.TurnedOn=1
			src.Uses+=1
			M.Chakra_Scapel()
	Muscle_Slice
		name="Muscle Slice"
		icon_state="ChakraNoMesu"
		Activate(mob/M)
			if(!M.scalpel)
				M<<"You need to turn on Chakra Scalpel first.";src.DelayIt(30,M,"None");return
			src.DelayIt(300,M,"Nin")
			M.Muscle_Slice()
			src.Uses+=1

	Neck_Slice
		name="Neck Slice"
		icon_state="ChakraNoMesu"
		Activate(mob/M)
			if(!M.scalpel)
				M<<"You need to turn on Chakra Scalpel first.";src.DelayIt(30,M,"None");return
			src.DelayIt(300,M,"Nin")
			M.Neck_Slice()
			src.Uses+=1
	Leg_Slice
		name="Leg Slice"
		icon_state="ChakraNoMesu"
		Activate(mob/M)
			if(!M.scalpel)
				M<<"You need to turn on Chakra Scalpel first.";
				src.DelayIt(30,M,"None");
				return
			src.DelayIt(300,M,"Nin")
			M.Leg_Slice()
			src.Uses+=1

	EyeExtract
		name="Eye Removal"
		icon_state="ChakraNoMesu"
		Activate(mob/M)
			if(!M.scalpel)
				M<<"You need to turn on Chakra Scalpel first.";src.DelayIt(30,M,"Nin");return
			M.ExtractEye()
			src.Uses+=1
			src.DelayIt(300,M,"Nin")
	Ranshinshou
		name="Chaotic Mental Collision"
		icon_state="Ranshinshou"
		Activate(mob/M)
			if(!M.scalpel)
				M<<"You need to turn on Chakra Scalpel first.";src.DelayIt(30,M,"Nin");return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(350,M,"Nin")
			src.Uses+=1
			M.Chaotic_Mental_Collision()
	Oukashou
		name="Cherry Blossom Collision"
		icon_state="NewChakraPunch"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			for(var/obj/SkillCards/ChakraKick/A in M.LearnedJutsus)
				A.DelayIt(1000,M,"Nin")
			src.DelayIt(1200,M,"Nin")
			src.Uses+=1
			M.ChakraPunch()
	ChakraKick
		name="Cherry Blossom Slam"
		icon_state="ChakraKick"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			for(var/obj/SkillCards/Oukashou/A in M.LearnedJutsus)
				A.DelayIt(1000,M,"Nin")
			src.DelayIt(1200,M,"Nin")
			src.Uses+=1
			M.ChakraKick()
	Chikatsu
		name="Healing Resuscitation Regeneration"
		BunshinAble=0
		icon_state="Chikatsu"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(1000,M,"Nin")
			src.Uses+=1
			M.ChikatsuTechnique()
	ChakraAbsorb
		name="Chakra Absorbtion Technique"
		icon_state="ChakraAbsorb"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(700,M,"Nin")
			src.Uses+=1
			M.Chakra_Absorbtion_Technique(Uses)
	SelfHeal
		name="Self Regeneration"
		icon_state="selfheal"
		Activate(mob/M)
			if(M.SelfHeal)
				src.DelayIt(2100,M,"Nin")
				M.SelfHeal=0
				M<<"You stop the regeneration Process..."
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(2100,M,"Nin")
			src.Uses+=1
			M.SelfHeal(Uses)
	ChakraMode
		name="Forbidden Medical Ninjutsu: Chakra Release"
		icon_state="ChakraMode"
		Activate(mob/M)
			if(M.ChakraMode)
				M.ChakraMode=0
				M<<"You stop the Forbidden Ninjutsu.....It begins to take it's toll on your body!"
				usr.deathcount++
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(5000,M,"Nin")
			src.Uses+=1
			M.ChakraMode(Uses)
	BodyShedding
		name="Body Shedding"
		icon_state="ChakraMode"
		Activate(mob/M)
			src.DelayIt(5000,M,"Nin")
			src.Uses+=1
	//		M.BodySheddingProc()
	EyeoftheKagura
		name="EyeoftheKagura"
		icon_state="ChakraMode"
		Activate(mob/M)
			src.DelayIt(100,M,"Nin")
			src.Uses+=1
			M.EyeoftheKagura()

	PoisonFog
		name="Medical Jutsu: Poison Fog"
		icon_state="PoisonFog"
		Activate(mob/M)
			if(M.knockedout)
				return
			if(M.firing||M.Frozen)
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(1350,M,"Nin")
			src.Uses+=1
			if(prob(20))
				M.PoisonKnowledge+=1
			M.Poisonfog(Uses)
	PoisonMist
		name="Medical Jutsu: Poison Mist"
		icon_state="PoisonMist"
		Activate(mob/M)
			if(M.knockedout)
				return
			if(M.firing||M.Frozen)
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.DelayIt(950,M,"Nin")
			src.Uses+=1
			if(prob(20))
				M.PoisonKnowledge+=1
			M.PoisonMistJutsu(Uses)



	Meimei
		name="Camouflage Concealment"
		icon_state="GansakuSuterusu"
		Deactivate(mob/M)
			M.inMei=0
			src.DelayIt(300,M,"Nin")
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.Uses+=1
			src.TurnedOn=1
			src.DelayIt(300,M,"Nin")//Remove this delay it whena ctually want to work on the jutsu again
		//	M.MieMie()
	BodySwitch
		name="Body Swap"
		icon_state="Reflex2"
		Target_Required=1
		Activate(mob/M)
			if(M.premium_pack < 3)
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)

			src.DelayIt(250,M,"Nin")
			src.Uses+=1
			M.PersonSwap()
///
	KujakuMyouhou
		name="Mysterious Peacock Method"
		icon_state="Kujaku2"
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(100,M,"Nin")
			src.Uses+=1
			M.KujakuMyouhou()
		//	while(M.KujakuMyouhouon)
		//		if(prob(50))
		//			src.Uses+=1
		//		sleep(100)
	StarShot
		name="Star of the Peacock"
		icon_state="Kujaku2"
	//	NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.KujakuMyouhouon)
				M<<"You must have Kujaku Myouhou on!";return

			src.DelayIt(100,M,"Nin")
			M.StarShot()
	StarBind
		name="Bind of the Peacock"
		icon_state="Kujaku2"
	//	NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.KujakuMyouhouon)
				M<<"You must have Kujaku Myouhou on!";return

			src.DelayIt(300,M,"Nin")
			M.StarBind()
	StarFeathers
		name="Feathers of the Peacock"
		icon_state="Kujaku2"
	//	NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.KujakuMyouhouon)
				M<<"You must have Kujaku Myouhou on!";return

			src.DelayIt(350,M,"Nin")
			M.StarFeathers(src.Uses)
	KujakuWall
		name="Wall of the Peacock"
		icon_state="Kujaku2"
	//	NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.KujakuMyouhouon)
				M<<"You must have Kujaku Myouhou on!";return

			src.DelayIt(450,M,"Nin")
			M.KujakuWall()
	KujakuCapture
		name="Capturing Peacock"
		icon_state="Kujaku2"
	//	NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			if(!M.KujakuMyouhouon)
				M<<"You must have Kujaku Myouhou on!";return

			src.DelayIt(450,M,"Nin")
			M.Kujaku_Capture()

///
	Zankuuha
		name="Decapitating Air Waves"
		icon_state="Zankuuha"
		Activate(mob/M)
			if(!M.ZankuuhaOn)
				M.ZankuuhaOn=1;
				M<<"You circulate the air vents through your hand!";
				return
			else
				M.ZankuuhaOn=0;M<<"You stop the air running through your hands."
	ZankuuSpiralingSphere
		name="Decapitating Air Sphere"
		icon_state="ZankuuhaSphere"
		Activate(mob/M)
			if(!M.ZankuuhaOn)
				M<<"You must have Zankuuha on!";return

			src.DelayIt(1200,M,"Nin")
			src.Uses+=1
			M.ZankuuSpiralingSphere()
	ZankuuKyomeisen
		name="Vibrating Sound Drill"
		Activate(mob/M)
			if(!M.ZankuuhaOn)
				M<<"You must have Zankuuha on!";return
			src.DelayIt(1300,M,"Nin")
			src.Uses+=1
			M.ZankuuSoundDrill()
///
//Paper
	Paper_Mode
		name="Paper Style Dance"
		icon_state="PaperMode"
		BunshinAble=0
		Deactivate(mob/M)
			M.PaperStyleDance()
			src.DelayIt(300,M,"Nin")
		Activate(mob/M)
			src.TurnedOn=1
			src.Uses+=1
			M.PaperStyleDance()
	Paper_Shuriken
		name="Paper Shuriken"
		icon_state="PaperShuriken"
		Activate(mob/M)
			if(!M.PaperStyleDance)
				M<<"You need to be in Paper Style Dance!";return
			src.DelayIt(120,M,"Nin")
			src.Uses+=1
			M.Paper_Shuriken(Uses)
	Paper_Butterfly
		name="Paper Butterflies"
		icon_state="PaperButterflies"
		var/ButterfliesAreOut=0
		Activate(mob/M)
			if(!M.PaperStyleDance)
				M<<"You need to be in Paper Style Dance!";return
			src.DelayIt(600,M,"Nin")
			src.Uses+=1
			M.Paper_Butterflies(src.Uses)

	Butterfly_Dance
		name="Butterfly Dance"
		icon_state="ButterflyDance"
		var/ButterfliesAreOut=0
		Activate(mob/M)
			if(!M.PaperStyleDance)
				M<<"You need to be in Paper Style Dance!";return
			src.Uses+=1
			src.DelayIt(600,M,"Nin")
			M.Butterfly_Dance()
	Paper_Spear
		name="Divine Spear"
		icon_state="PaperSpear"
		Activate(mob/M)
			if(!M.PaperStyleDance)
				M<<"You need to be in Paper Style Dance!";return
			src.Uses+=1
			M.Divine_Spear()
			src.DelayIt(600,M,"Nin")
	Paper_Person
		name="Paper Person Technique"
		icon_state="ExplodingPaper3"
		Activate(mob/M)
			if(!M.PaperStyleDance)
				M<<"You need to be in Paper Style Dance!";return
			src.Uses+=1
			src.DelayIt(1800,M,"Nin")
			M.Person_Explosion(src.Uses)








///////////////////////
//Sensory Jutsu

	ChakraSense
		name="Chakra Sense"
		icon_state="ChakraSense"
		Activate(mob/M)
			if(M.ChakraSense)
				M.ChakraSense=0
				M<<"You stop sensing Chakra nearby."
				src.DelayIt(500,M,"Nin")
				return
			M<<"You begin to relax as you begin to sense chakra nearby."
			src.Uses+=1
			M.Chakra_Sense()

	ChakraAuraRemoval
		name="Chakra Hide"
		icon_state="AuraRemoval"
		Activate(mob/M)
			M.ChakraAuraRemoval()
			src.DelayIt(100,M,"Nin")




////////////////////////
//Kenjutsu
	SwiftSlash
		name="Swift Slash"
		icon_state="SwiftSlash"
		var/Hand="Left"
		var/Hand2="Right"
	//	verb/SetHand()
	//		set src in usr.contents
	//		switch(input(src,"Which hand would you like to set Swift Slash too?",text)in list("Left","Right"))
	//			if("Left")
	//				Hand="Left"
	//			if("Right")
	//				Hand="Right"
		Activate(mob/M)
			var/AOk=0
			if(Hand=="Left")
				if(M.WeaponInLeftHand=="")
					M<<"You need a weapon in your left hand to use this!";return
				var/obj/WEAPONS/A=M.WeaponInLeftHand
				if(M.LeftHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(Hand2=="Right")
				var/obj/WEAPONS/A=M.WeaponInRightHand
				if(A!=""&&M.RightHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(M.Clan=="Kaguya"&&(M.KagDance=="Yanagi"||M.KagDance=="Tsubaki"))
				AOk=1
				Hand="Left"
			if(AOk)
				src.DelayIt(300,M,"Tai")
				src.Uses+=1
				M.SwiftSlashTechnique(Hand)
			else
				M<<"You need to have a Sword in your hand, unsheathed!"
				src.DelayIt(10,M,"Tai")

	Impale
		name="Impale"
		icon_state="Impale"
		var/Hand="Left"
		verb/SetHand()
			set src in usr.contents
			switch(input(src,"Which hand would you like to set Swift Slash too?",text)in list("Left","Right"))
				if("Left")
					Hand="Left"
				if("Right")
					Hand="Right"
		Activate(mob/M)
			var/AOk=0
			if(Hand=="Left")
				var/obj/WEAPONS/A=M.WeaponInLeftHand
				if(M.LeftHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(Hand=="Right")
				var/obj/WEAPONS/A=M.WeaponInRightHand
				if(M.RightHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(M.Clan=="Kaguya"&&(M.KagDance=="Yanagi"||M.KagDance=="Tsubaki"))
				AOk=1
				Hand="Left"
			if(AOk)
				src.DelayIt(300,M,"Tai")
				src.Uses+=1
				M.ImpaleTechnique(Hand)
			else
				M<<"You need to have a Sword in your hand, unsheathed!"
				src.DelayIt(10,M,"Tai")
	RapidStrike
		name="Rapid Strike"
		icon_state="RapidStrike"
		var/Hand="Left"
		verb/SetHand()
			set src in usr.contents
			switch(input(src,"Which hand would you like to set Swift Slash too?",text)in list("Left","Right"))
				if("Left")
					Hand="Left"
				if("Right")
					Hand="Right"
		Activate(mob/M)
			var/AOk=0
			if(Hand=="Left")
				if(M.WeaponInLeftHand=="")
					M<<"You need a weapon in your left hand to use this!";return
				var/obj/WEAPONS/A=M.WeaponInLeftHand
				if(M.LeftHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(Hand=="Right")
				var/obj/WEAPONS/A=M.WeaponInRightHand
				if(M.RightHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(M.Clan=="Kaguya"&&(M.KagDance=="Yanagi"||M.KagDance=="Tsubaki"))
				AOk=1
				Hand="Left"
			if(AOk)
				src.DelayIt(250,M,"Tai")
				src.Uses+=1
				M.RapidStrike(Hand)
			else
				M<<"You need to have a Sword in your hand, unsheathed!"
				src.DelayIt(10,M,"Tai")

	Moonsplitter
		name="MoonSplitter: Crescent Strike"
		icon_state="MoonSplitter"
		var/Hand="Left"
		var/Hand2="Right"
	//	verb/SetHand()
	//		set src in usr.contents
	//		switch(input(src,"Which hand would you like to set Swift Slash too?",text)in list("Left","Right"))
	//			if("Left")
	//				Hand="Left"
	//			if("Right")
	//				Hand="Right"
		Activate(mob/M)
			var/AOk=0
			if(Hand=="Left")
				var/obj/WEAPONS/A=M.WeaponInLeftHand
				if(M.LeftHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(Hand2=="Right")
				var/obj/WEAPONS/A=M.WeaponInRightHand
				if(M.RightHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(AOk)
				src.DelayIt(500,M,"Tai")
				src.Uses+=1
				M.Moonsplitter()
			else
				M<<"You need to have a Sword in your hand, unsheathed!"
				src.DelayIt(10,M,"Tai")

	DancingCrescent
		name="Dancing Slash"
		icon_state="SwiftSlash"
		var/Hand="Left"
		var/Hand2="Right"
		Activate(mob/M)
			var/AOk=0
			if(Hand=="Left")
				var/obj/WEAPONS/A=M.WeaponInLeftHand
				if(M.LeftHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(Hand2=="Right")
				var/obj/WEAPONS/A=M.WeaponInRightHand
				if(M.RightHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(M.Clan=="Kaguya"&&(M.KagDance=="Yanagi"||M.KagDance=="Tsubaki"))
				AOk=1
				Hand="Left"
			if(AOk)
		//		src.DelayIt(300,M,"Tai")
		//		src.Uses+=1
	//			M.DancingCrescentTechnique(Hand2)
			else
				M<<"You need to have a Sword in your right hand, unsheathed!"
	//			src.DelayIt(10,M,"Tai")
	Anarchist
		name="Anarchist"
		icon_state="SwiftSlash"
		var/Hand="Left"
		var/Hand2="Right"
		Activate(mob/M)
			var/AOk=0
			if(Hand=="Left")
				var/obj/WEAPONS/A=M.WeaponInLeftHand
				if(A!=""&&M.LeftHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(Hand2=="Right")
				var/obj/WEAPONS/A=M.WeaponInRightHand
				if(A!=""&&M.RightHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(M.Clan=="Kaguya"&&(M.KagDance=="Yanagi"||M.KagDance=="Tsubaki"))
				AOk=1
				Hand="Left"
			if(AOk)
				src.DelayIt(300,M,"Tai")
				src.Uses+=1
				M.AnarchistTechnique(Hand2)
			else
				M<<"You need to have a Sword in your right hand, unsheathed!"
				src.DelayIt(10,M,"Tai")
	DepartureInFlames
		name="DepartureInFlames"
		icon_state="SwiftSlash"
		var/Hand="Left"
		var/Hand2="Right"
		Activate(mob/M)
			var/AOk=0
			if(Hand=="Left")
				var/obj/WEAPONS/A=M.WeaponInLeftHand
				if(A!=""&&M.LeftHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(Hand2=="Right")
				var/obj/WEAPONS/A=M.WeaponInRightHand
				if(A!=""&&M.RightHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(M.Clan=="Kaguya"&&(M.KagDance=="Yanagi"||M.KagDance=="Tsubaki"))
				AOk=1
				Hand="Left"
			if(AOk)
				src.DelayIt(300,M,"Tai")
				src.Uses+=1
				M.DepartureInFlames(Hand2,Uses)
			else
				M<<"You need to have a Sword in your right hand, unsheathed!"
				src.DelayIt(10,M,"Tai")
	Kaitengiri
		name="Kaitengiri"
		icon_state="SwiftSlash"
		var/Hand="Left"
		var/Hand2="Right"
		Activate(mob/M)
			var/AOk=0
			if(Hand=="Left")
				var/obj/WEAPONS/A=M.WeaponInLeftHand
				if(A!=""&&M.LeftHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(Hand2=="Right")
				var/obj/WEAPONS/A=M.WeaponInRightHand
				if(A!=""&&M.RightHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(M.Clan=="Kaguya"&&(M.KagDance=="Yanagi"||M.KagDance=="Tsubaki"))
				AOk=1
				Hand="Left"
			if(AOk)
				src.DelayIt(300,M,"Tai")
				src.Uses+=1
				M.KaitengiriTechnique(Hand2)
			else
				M<<"You need to have a Sword in your right hand, unsheathed!"
				src.DelayIt(10,M,"Tai")
	AnzentaruEiketsu
		name="Anzentaru Eiketsu"
		icon_state="SwiftSlash"
		var/Hand="Left"
		var/Hand2="Right"
		Activate(mob/M)
			var/AOk=0
			if(Hand=="Left")
				var/obj/WEAPONS/A=M.WeaponInLeftHand
				if(A!=""&&M.LeftHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(Hand2=="Right")
				var/obj/WEAPONS/A=M.WeaponInRightHand
				if(A!=""&&M.RightHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(M.Clan=="Kaguya"&&(M.KagDance=="Yanagi"||M.KagDance=="Tsubaki"))
				AOk=1
				Hand="Left"
			if(AOk)
				src.DelayIt(300,M,"Tai")
				src.Uses+=1
				M.AnzentaruEiketsuTechnique(Hand2)
			else
				M<<"You need to have a Sword in your right hand, unsheathed!"
				src.DelayIt(10,M,"Tai")
	Sanjuuken
		name="Sanjuuken"
		icon_state="SwiftSlash"
		var/Hand="Left"
		var/Hand2="Right"
		Activate(mob/M)
			var/AOk=0
			if(Hand=="Left")
				var/obj/WEAPONS/A=M.WeaponInLeftHand
				if(M.LeftHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(Hand2=="Right")
				var/obj/WEAPONS/A=M.WeaponInRightHand
				if(M.RightHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(M.Clan=="Kaguya"&&(M.KagDance=="Yanagi"||M.KagDance=="Tsubaki"))
				AOk=1
				Hand="Left"
			if(AOk)
				src.DelayIt(300,M,"Tai")
				src.Uses+=1
				M.SanjuukenTechnique(Hand2)
			else
				M<<"You need to have a Sword in your hand, unsheathed!"
				src.DelayIt(10,M,"Tai")
	Taitari
		name="Taiatari"
		icon_state="SwiftSlash"
		var/Hand="Left"
		var/Hand2="Right"
		Activate(mob/M)
			var/AOk=0
			if(Hand=="Left")
				var/obj/WEAPONS/A=M.WeaponInLeftHand
				if(M.LeftHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(Hand2=="Right")
				var/obj/WEAPONS/A=M.WeaponInRightHand
				if(M.RightHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(M.Clan=="Kaguya"&&(M.KagDance=="Yanagi"||M.KagDance=="Tsubaki"))
				AOk=1
				Hand="Left"
			if(AOk)
				src.DelayIt(300,M,"Tai")
				src.Uses+=1
			//	M.TaitariTechnique()
			else
				M<<"You need to have a Sword in your hand, unsheathed!"
				src.DelayIt(10,M,"Tai")
	HasakiCounter
		name="Hasaki Counter"
		icon_state="SwiftSlash"
		var/Hand="Left"
		var/Hand2="Right"
		Activate(mob/M)
			var/AOk=0
			if(Hand=="Left")
				var/obj/WEAPONS/A=M.WeaponInLeftHand
				if(M.LeftHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(Hand2=="Right")
				var/obj/WEAPONS/A=M.WeaponInRightHand
				if(M.RightHandSheath&&A.WhatDoesItDo=="Slash")
					AOk=1
			if(M.Clan=="Kaguya"&&(M.KagDance=="Yanagi"||M.KagDance=="Tsubaki"))
				AOk=1
				Hand="Left"
			if(AOk)
				src.DelayIt(300,M,"Tai")
				src.Uses+=1
			//	M.HasakiCounterTechnique()
			else
				M<<"You need to have a Sword in your hand, unsheathed!"
				src.DelayIt(10,M,"Tai")
/////////////////////////////////////////////
///OverPowered Katon
////////////////////////////////////////////
	Metronome
		name="Metronome"
		icon_state="Hikibou"
		Activate(mob/M)
			view(M)<<"[M] wags their finger!"

			var/Rand=pick(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22)
			if(Rand==1)
				M.MassiveLavaOverFlowingJutsu(src.Uses)
			if(Rand==2)
				M.PainMechining()
			if(Rand==3)
				M.ChouHouka()
			if(Rand==4)
				M.BakuSuishouha()
			if(Rand==5)
				M.KazeGai()
			if(Rand==6)
				M.Sawarabi(Control=0)
			if(Rand==7)
				M.Sawarabi(Control=1)
			if(Rand==8)
				M.Gian()
			if(Rand==9)
				M.Gian()
			if(Rand==10)
				M.PainMechining()
			if(Rand==11)
				M.KatonRyuusenka()
			if(Rand==12)
				M.RenkuudanJutsu()
			if(Rand==13)
				M.FuutonVacuumSerialWaves()
			if(Rand==14)
				M.SuiryuudanZ()
			if(Rand==15)
				M.MizuTeppou()
			if(Rand==15)
				M.BakuSuishouha()
			if(Rand==16)
				M.Hinoko()
			if(Rand==17)
				M.DevineThunderRing()
			if(Rand==18)
				M.KirinWeakProc()
			if(Rand==19)
				M.SwampBrambles()
			if(Rand==20)
				M.DotonWall()
			if(Rand==21)
				M.SageMode(5,180,"Toad")
			if(Rand==22)
				M.ShinraTensei()
			src.DelayIt(200,M,"Nin")

	MassiveLavaOverFlowingJutsuOP
		name="Massive Lava Over Flowing Jutsu"
		icon_state="Ryuusenka"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(200,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.MassiveLavaOverFlowingJutsu(src.Uses)
	HeadMincingPain
		name="Head Mincing Pain"
		icon_state="Moesashi"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
			src.DelayIt(2000,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.PainMechining(src.Uses)
////////////////////////////////////////
//Katon
/////////////////////
	Hikibou
		name="Fire Trick"
		icon_state="Hikibou"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return

			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M,"Nin")
				return
			if(src.Uses>150)
				src.DelayIt(140,M,"Element")
			else
				src.DelayIt(100,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.Hikibou(src.Uses)
	Goukakyuu
		name="Great Fireball Jutsu"
		icon_state="Goukakyuu"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			src.DelayIt(200,M,"Element")
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1
			if(!M.client&&!M.Clone)
				M.HoldingR=1
				spawn(30)
					M.HoldingR=0
			M.GoukakyuuNoJutsu(src.Uses)

	PhoenixSageFlower
		name="Katon: Phoenix Sage Flower Nail Crimson"
		icon_state="Fire Shuriken"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			src.DelayIt(450,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.KatonHousenkaTsumabeniNoJutsu(src.Uses)

	FlameEmber
		name="Katon: Flame Ember"
		icon_state="FlameEmber"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			src.DelayIt(550,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.Kiritsuhi(src.Uses)


	SpinningFire
		name="Katon: Spinning Fire"
		icon_state="SpinningFire"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			src.DelayIt(620,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.KatonRaseKa(src.Uses)



	AshPileBurning
		name="Katon: Ash Pile Burning"
		icon_state="AshPile"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			src.DelayIt(200,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1
			if(!M.client)
				M.HoldingR=1
				spawn(30)
					M.HoldingR=0
			M.HaisekishoNoJutsu(src.Uses)

	GoukaMekkyakuNoJutsu
		name="Katon: Great Magestic Fire Annihilation"
		icon_state="Kaheki"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			src.DelayIt(1500,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1
			if(!M.client)
				M.HoldingR=1
				spawn(30)
					M.HoldingR=0
			M.GoukaMekkyakuNoJutsu(src.Uses)


	Housenka
		name="Mythical Fire Phoenix Jutsu"
		icon_state="Housenka"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			src.DelayIt(310,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1

			M.KatonHousenkaNoJutsu(src.Uses)
	KatonFlameBullet
		name="Katon Endan"
		icon_state="Housenka"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			src.DelayIt(175,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1

			M.FireSpit(src.Uses)

	KatonFlameBulletAdvance
		name="Katon Dai Endan"
		icon_state="FlameEmberAdvance"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			src.DelayIt(650,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1

			M.FireSpitBarrage(src.Uses)

	Ryuuka
		name="Dragon Fire Jutsu"
		icon_state="Ryuuka"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			src.DelayIt(600,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1

			M.KatonRyuuka()
	KaryuuEndan
		name="Fire Dragon Flame Projectile"
		icon_state="KaryuuEndan"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			src.DelayIt(900,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.KKE()

	KatonDragonWar
		name="Katon: Dragon War"
		icon_state="FireDragon"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			src.DelayIt(2500,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.KatonRyuusenka()

	KatonHouka
		name="Fire Rocket Jutsu"
		icon_state="Houka"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			src.DelayIt(700,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.KatonHouka(src.Uses)

	KatonHoukaAdvanced
		name="Katon: Gouenkyuu No Jutsu"
		icon_state="Houka"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			src.DelayIt(1000,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.GouenkyuuNoJutsu(src.Uses)

	ChouHouka
		name="Super Fire Rocket Jutsu"
		icon_state="ChouHouka"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			src.DelayIt(1500,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.ChouHouka(src.Uses)
	Gouryuuka
		name="Grand Dragon Fire"
		icon_state="Gouryuuka"
		BunshinAble=0
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.KatonKnowledge+=1
				if(src.Uses<100)
					M.KatonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.FireChakra<20)
				M.FireChakra+=pick(0.01,0.1)
				if(M.FireChakra>20)
					M.FireChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			src.DelayIt(1500,M,"Element")

			if(M.TypeLearning=="Katon")
				M.exp+=rand(25,100)
			src.Uses+=1

			M.Gouryuuka(src.Uses)
	KatonRasengan
		icon_state="KatonRasengan"
		Activate()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.Rasenganon)
				usr<<output("You're already using Rasengan!","Attack");return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				if(src.Uses<100&&usr.Trait!="Genius")
					if(prob(95-src.Uses))
						usr<<output("The jutsu failed.","Attack");return
				else if(usr.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						usr<<output("The jutsu failed.","Attack");return
				if(prob(15))
					usr.KatonKnowledge+=1
				/*for(var/obj/SkillCards/FuutonRasengan/P in usr.LearnedJutsus)
					P.DelayIt(1000,usr,"Nin")
				for(var/obj/SkillCards/Rasengan/P in usr.LearnedJutsus)
					P.DelayIt(1000,usr,"Nin")*/

				src.DelayIt(1000,usr,"Element")
				src.Uses+=1
				usr.KRasengan()
////////////////////////////////////////
//Fuuton
/////////////////////
	PressureDamage
		name="Whirling Tornado"
		icon_state="GreatCuttingWhirldwind"
		Activate(mob/M)
			M.Atsugai()
			src.DelayIt(400,M)
	WhirlingTornado
		name="Whirling Tornado"
		icon_state="GreatCuttingWhirldwind"
		Activate(mob/M)
			M.ShingerTornado()
			src.DelayIt(400,M)
	WindTrick
		name="Wind Trick"
		icon_state="WindTrick"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(25,100)
			src.DelayIt(400,M,"Element")
			src.Uses+=1
			M.WindTrick(Uses)
	SpinningWind
		name="Spinning Wind"
		icon_state="SpinningWind"
		Target_Required=1
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(25,100)
			src.DelayIt(250,M,"Element")
			src.Uses+=1
			M.SpinningWind(Uses)
	SenbonDice
		name="Senbon Dice"
		icon_state="SenbonDice"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(25,100)
			src.DelayIt(250,M,"Element")
			src.Uses+=1
			M.FuutonSenbonDice(src.Uses)
	Reppushou
		name="Gale Wind Palm"
		icon_state="Reppushou"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(25,100)
			src.DelayIt(420,M,"Element")
			src.Uses+=1
			if(!M.client)
				M.HoldingR=1
				spawn(30)
					M.HoldingR=0
			M.FuutonReppushou()
	BloodLust
		name="Blood Lust"
		icon_state="RapidPunch"
		Activate(mob/M)
			if(istype(usr.WeaponInRightHand,/obj/WEAPONS/OriginalKubikiriHoucho)&&istype(usr.WeaponInLeftHand,/obj/WEAPONS/OriginalKubikiriHoucho))
				if(usr.LeftHandSheath||usr.RightHandSheath)
					src.Uses+=1
					src.DelayIt(5000,usr,"Tai")
					spawn() M.BloodLust()
					M.deathcount+=0.5

				else
					usr<<"You need to unsheath the legendary blade first."
					return
			else
				usr<<"You need to equip the legendary blade first."
				return
	KazeDangan
		name="Thrusting Air"
		icon_state="KazeDangan"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(25,100)
			src.DelayIt(120,M,"Element")
			src.Uses+=1
			M.FuutonKazeDanganzz()
	Daitoppa
		name="Great Breakthrough Jutsu"
		icon_state="Daitoppa"
		Deactivate(mob/M)
			if(M.UsingDaitoppa)
				if(M.TypeLearning=="Fuuton")
					M.exp+=rand(25,100)
				M.Daitoppa()
				return
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(25,100)
			src.DelayIt(480,M,"Element")
			src.TurnedOn=1
			if(!M.client)
				M.HoldingR=1
				spawn(30)
					M.HoldingR=0
			M.Daitoppa()
			src.Uses+=1
	Yaiba
		name="Sword of the Wind"
		icon_state="Yaiba"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(250,1000)
			src.DelayIt(600,M,"Element")
			src.Uses+=1
			M.KazeNoYaibaJutsu()
	Renkuudan
		name="Drilling Air Projectile Jutsu"
		icon_state="Renkuudan"
		Activate(mob/M)
		//	if(M.ElementalCapacity!=1)
		//		M<<"You have the capacity for more than 1 nature. This jutsu is only for 1 nature users.";return

			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(550,2000)
			src.DelayIt(800,M,"Element")
			src.Uses+=1
			M.RenkuudanJutsu()
	KazeKiri
		name="Great Windcutter Jutsu"
		icon_state="Kazekiri"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"


			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(250,1500)
			src.DelayIt(700,M,"Element")
			src.Uses+=1
			M.FuutonKazeKiri()
	KazeGai
		name="Giant Windcutter Jutsu"
		icon_state="KazeGai"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(2500,3500)
			src.DelayIt(900,M,"Element")
			src.Uses+=1
			M.KazeGai()
	VacuumCannon
		name="Vacuum Cannon"
		icon_state="KazeNoSenbon"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(250,1500)
			src.DelayIt(330,M,"Element")
			src.Uses+=1
			M.FuutonVacuumCannon(src.Uses)
	VacuumSphere
		name="Vacuum Sphere"
		icon_state="KazeNoSenbon"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(250,1500)
			src.DelayIt(350,M,"Element")
			src.Uses+=1
			M.FuutonVacuumSphere(src.Uses)
	VacuumGreatSphere
		name="Vacuum Great Sphere"
		icon_state="KazeNoSenbon"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(250,1500)
			src.DelayIt(520,M,"Element")
			src.Uses+=1
			M.FuutonVacuumGreatSphere(src.Uses)
	VacuumWave
		name="Vacuum Wave"
		icon_state="KazeNoSenbon"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(250,1500)
			src.DelayIt(450,M,"Element")
			src.Uses+=1
			M.FuutonVacuumWave(src.Uses)

	VacuumSerialWaves
		name="Vacuum Serial Waves"
		icon_state="KazeNoSenbon"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(250,1500)
			src.DelayIt(500,M,"Element")
			src.Uses+=1
			M.FuutonVacuumSerialWaves(src.Uses)
	DaiKamaitachi
		name="Great Cutting Whirlwind"
		icon_state="CuttingWhirlwind"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(2500,3500)
			src.DelayIt(650,M,"Element")
			src.Uses+=1
			M.FuutonDaiKamaitachi()
	Kakeami
		name="Cast Net"
		icon_state="TornadoTrap"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(2500,3500)
			src.DelayIt(500,M,"Element")
			src.Uses+=1
			M.FuutonKakeami()
	FuutonRasengan
		icon_state="FuutonRasengan"
		Activate()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.Rasenganon)
				usr<<output("You're already using Rasengan!","Attack");return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				if(src.Uses<100&&usr.Trait!="Genius")
					if(prob(95-src.Uses))
						usr<<output("The jutsu failed.","Attack");return
				else if(usr.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						usr<<output("The jutsu failed.","Attack");return
				if(prob(15))
					usr.FuutonKnowledge+=1
				/*for(var/obj/SkillCards/Rasengan/P in usr.LearnedJutsus)
					P.DelayIt(1000,usr,"Nin")
				for(var/obj/SkillCards/KatonRasengan/P in usr.LearnedJutsus)
					P.DelayIt(1000,usr,"Nin")*/

				src.DelayIt(1000,usr,"Element")
				src.Uses+=1
				usr.WRasengan()
//Last Airbender
	Gust
		name="Gust"
		icon_state="MugenSaijinDaitoppa"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(250,1500)
			src.DelayIt(300,M,"Element")
			src.Uses+=1
			M.Gust()
	Whirlwind
		name="Whirlwind"
		icon_state="TornadoTrap"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(250,1500)
			src.DelayIt(340,M,"Element")
			src.Uses+=1
			M.Whirlwind()
	AirDash
		name="Air Dash"
		icon_state="Air Dash"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(250,1500)
			src.DelayIt(600,M,"Element")
			src.Uses+=1
			M.AirDash()
	AirBall
		name="Air Ball"
		icon_state="KazeDangan"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15))
				M.FuutonKnowledge+=1
				if(src.Uses<100)
					M.FuutonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WindChakra<20)
				M.WindChakra+=pick(0.01,0.1)
				if(M.WindChakra>20)
					M.WindChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Fuuton")
				M.exp+=rand(250,1500)
			src.DelayIt(250,M,"Element")
			src.Uses+=1
			M.FuutonAirBall()
//////////////////////////////
///Suiton
//////////////////////////
	WhirlPoolControl
		name="Destructive Torrents"
		icon_state="WaterPrison"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.WhirlPoolControlling()
	WaterPrison
		name="Water Prison"
		icon_state="Suirou"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.WaterPrison()
	HydroForm
		name="Hydro Form"
		icon_state="HydroMode2"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
		//	if(prob(Check))
		//		M.SuitonKnowledge+=1
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.HydroForm()
	Mizurappa
		name="Violent Water Wave"
		icon_state="Mizurappa"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.DelayIt(250,M,"Element")
			src.Uses+=1
			M.MizurappaNoJutsu()
	MizuameNabara
		name="Starch Syrup Capture Field"
		icon_state="StickySyrup"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.DelayIt(1200,M,"Element")
			src.Uses+=1
			M.Syrup_Capture()

	WaterCreation
		name="Water Creation"
		icon_state="WaterCreation"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(250,1000)
			src.DelayIt(600,M,"Element")
			src.Uses+=1
			M.CreateWater()
	Suijinheki
		name="Water Wall"
		icon_state="Suijinheki"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(250,1000)
			src.DelayIt(250,M,"Element")
			src.Uses+=1
			M.Suijinheki(Uses)


	Suiryuudan
		name="Water Dragon Jutsu"
		icon_state="Suiryuudan"
		BunshinAble=0
		Deactivate(mob/M)
			M.SuiryuudanZ()
			src.DelayIt(350,M,"Element")
		Activate(mob/M)
			for(var/obj/Jutsu/Elemental/Suiton/Suiryedan/K in world)
				if(K.Owner==M)
					src.Deactivate(M)
					return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(250,1000)
			src.DelayIt(350,M,"Element")
			src.Uses+=1
			M.SuiryuudanZ()
	Suikoudan
		name="Water Shark Jutsu"
		icon_state="Suikoudan2"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.DelayIt(650,M,"Element")
			src.Uses+=1
			M.SuikoudanZ(src.Uses)

	Daikoudan
		name="Great Shark Bullet"
		icon_state="GiantShark"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.DelayIt(650,M,"Element")
			src.Uses+=1
			M.Daikoudan(src.Uses)
	BubbleCapture
		name="Bubble Capture"
		icon_state="Suikoudan"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.DelayIt(550,M,"Element")
			src.Uses+=1
			M.BubbleCreation(src.Uses)
	BubbleBeam//BubbleBeamJutsu()
		name="Bubble Beam"
		icon_state="Suikoudan"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.DelayIt(550,M,"Element")
			src.Uses+=1
			M.BubbleBeamJutsu(src.Uses)

	Senjikizame
		name="Thousand Feeding Sharks"
		icon_state="SuikoudanLot"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.DelayIt(650,M,"Element")
			src.Uses+=1
			M.Senjikizame(src.Uses)

	MizuTeppou
		name="Suiton: Water Gun"
		icon_state="WaterGun"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.DelayIt(300,M,"Element")
			src.Uses+=1
			M.MizuTeppou(src.Uses)

	MizuBunshin
		name="Suiton: Water Clone"
		icon_state="SuitonBunshin"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.DelayIt(550,M,"Element")
			src.Uses+=1
			M.MizuBunshin(src.Uses)


	Daibakuryuu
		name="Suiton: Great Waterfall Flow"
		icon_state="Vortex"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.DelayIt(550,M,"Element")
			src.Uses+=1
			M.Daibakuryuu(src.Uses)
		//	M.WhirlPoolControlling()

	UnderSui
		name="Suiton: Rapid Pull"
		icon_state="Suigadan"
		Target_Required=1
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.DelayIt(250,M,"Element")
			src.Uses+=1
			M.UnderWaterPull()
	Suigadan
		name="Water Fang Jutsu"
		icon_state="Suigadan"
		Target_Required=1
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(25,100)
			src.DelayIt(250,M,"Element")
			src.Uses+=1
			M.Suigadan()
	Daibakufu
		name="Grand Waterfall Jutsu"
		icon_state="BakuSuishouha2"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(2650,3200)
			src.DelayIt(700,M,"Element")
			src.Uses+=1
	//		M<<"Will be reenabled soon"
			M.DaibakufuZ()
	BakuSuishouha
		name="Bursting Collision Waves"
		icon_state="BakuSuishouha"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=10
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(725,1500)
			src.DelayIt(1550,M,"Element")
			src.Uses+=1
			M.BakuSuishouha(src.Uses)
	Teppoudama
		name="Water Bullet"
		icon_state="Water Bullet"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Rain")
				Check+=8
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.SuitonKnowledge+=1
				if(src.Uses<100)
					M.SuitonKnowledge+=pick(1,1.2)
			if(prob(15)&&M.WaterChakra<20)
				M.WaterChakra+=pick(0.01,0.1)
				if(M.WaterChakra>20)
					M.WaterChakra=20

			if(M.TypeLearning=="Suiton")
				M.exp+=rand(750,2000)
			src.DelayIt(380,M,"Element")
			src.Uses+=1
			M.Teppoudama()
///////////////////////////////
///Raiton
//////////////////////////
	Yoroi
		name="Lightning Strike Armor"
		icon_state="RaitonYoroi"
		ElementType="Raiton"
		Deactivate(mob/M)
			src.TurnedOn=0
			M.RaiArmor=0
			M.overlays-='RaiArmor.dmi'
			M.overlays-='RaiArmor2.dmi'
			M.tempmix='ChakraAura.dmi';M.tempmix+=rgb(36,45,156)
			var/icon/Q=icon(M.tempmix);M.overlays-=Q
			M.Touei=0
			src.DelayIt(700,M,"Element")
			return

		Activate(mob/M)
		//	src.TurnedOn=1
			if(M.RaiArmor)
				M.overlays-='RaiArmor.dmi'
				M.overlays-='RaiArmor2.dmi'
				M.tempmix='ChakraAura.dmi';M.tempmix+=rgb(36,45,156)
				var/icon/Q=icon(M.tempmix);M.overlays-=Q
				M.RaiArmor=0
				M.Touei=0
				src.DelayIt(700,M,"Element")
				return


			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.05,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Raiton")
				M.exp+=rand(25,100)
			src.Uses+=1
			src.TurnedOn=1
			M.RaigekiYoroiz(src.Uses)

	FlashFlicker
		name="Flash Flicker"

		icon_state="RaiYoroi"
		ElementType="Raiton"
		Activate(mob/M)

			if(M.RaiArmor)
				M.overlays-='RaiArmor.dmi'
				M.overlays-='RaiArmor2.dmi'
				M.tempmix='ChakraAura.dmi';M.tempmix+=rgb(255,255,0)
				var/icon/Q=icon(M.tempmix);M.overlays-=Q
				M.RaiArmor=0;M.FlashFlicker=0
				src.DelayIt(10,M)
				return


			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			src.Uses+=1
			M.FlashFlicker(src.Uses)
	RaitonYoroi
		name="Advanced Lightning Style Armor"
		icon_state="LightningArmor"
		ElementType="Raiton"
		Activate(mob/M)
			if(M.RaiArmor)
				M.overlays-='RaiArmor2.dmi'
				M.overlays-='RaiArmor.dmi'
				M.overlays-='RaitonYoroi.dmi'
				M.RaiArmor=0;M.Touei=0
				M.tai=M.Mtai
				src.DelayIt(1200,M,"Element")
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20

			if(M.TypeLearning=="Raiton")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.Raiton_Armor(src.Uses)
	Touei
		name="Flicker of Light"
		icon_state="Touei"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode)
					if(A.SharinganMastery<1000)
						A<<"[M]'s handsigns were too fast for you to read.."
					else
						A.SharinganCopy(src.type,src.Uses)

			if(M.TypeLearning=="Raiton")
				M.exp+=rand(25,100)
			src.DelayIt(450,usr,"Element")
			src.Uses+=1
			M.Touei()
	Raikyuu
		name="Lightning Ball"
		icon_state="Raikyu"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Raiton")
				M.exp+=rand(25,100)

			src.DelayIt(300,M,"Element")
			src.Uses+=1
			M.Raikyuuz()
	Tatsumaki
		name="Lightning Dragon Tornado"
		icon_state="Tatsumaki"
		ElementType="Raiton"
		BunshinAble=0
		Deactivate(mob/M)

			src.DelayIt(350,M,"Element")

			M.Tatsumaki()

		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Raiton")
				M.exp+=rand(25,100)
		//	src.DelayIt(350,M,"Element")
			src.Uses+=1
			src.TurnedOn=1
			M.Tatsumaki()
	IkazuchiKiba
		name="Lightning Bolt Fang"
		icon_state="Ikazuchi"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Raiton")
				M.exp+=rand(25,100)

			src.DelayIt(600,M,"Element")

			src.Uses+=1
			M.IkazuchiKiba(src.Uses)
	Hinoko
		name="Lightning Cutter"
		icon_state="Hinoko"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Raiton")
				M.exp+=rand(25,100)

			src.DelayIt(600,M,"Element")
			src.Uses+=1
			M.Hinoko()
	RairyuuGarou
		name="Rotating Lightning"
		icon_state="Garou"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Raiton")
				M.exp+=rand(25,100)
			src.DelayIt(450,M,"Element")
			src.Uses+=1
			M.RairyuuGarou()
	Jibashi
		name="Electromagnetic Murder"
		icon_state="Jibashi"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Raiton")
				M.exp+=rand(250,1500)
			src.DelayIt(500,M,"Element")
			src.Uses+=1
			M.Jibashi()
	ThunderRing
		name="Devine Thunder Ring"
		icon_state="Jibashi"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Raiton")
				M.exp+=rand(250,1500)
			src.DelayIt(500,M,"Element")
			src.Uses+=1
			M.DevineThunderRing(Uses)
	OldGian//OldGian()
		name="Impaling Electrocution"
		icon_state="OldGian"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Raiton")
				M.exp+=rand(250,1500)
			src.DelayIt(500,M,"Element")
			src.Uses+=1
			M.OldGian()

	Gian
		name="False Darkness"
		icon_state="Gian"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20

			if(M.TypeLearning=="Raiton")
				M.exp+=rand(2500,3500)
			src.DelayIt(1200,M,"Element")
			src.Uses+=1
			M.Gian()
	Chidori
		icon_state="Chidori"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20
			if(M.TypeLearning=="Raiton")
				M.exp+=rand(25,100)
			if(M.RaitonKnowledge>3500&&src.Uses>10000)
				M.KirinCheck2=1
			src.DelayIt(600,M,"Element")
			src.Uses+=1
			M.Chidoriz(0)
	ChidoriNagashi
		icon_state="Nagashi2"
		name = "Lightning Current"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20
			for(var/obj/SkillCards/Chidori/T in usr.LearnedJutsus)
				if(T&&!T.Delay)
					T.DelayIt(150,M,"Element")
			if(M.TypeLearning=="Raiton")
				M.exp+=rand(350,1000)
			src.DelayIt(500,M,"Element")
			src.Uses+=1
			M.ChidoriNagashi()
	ChidoriSenbon
		icon_state="ChidoriSenbon"
		name = "Chidori Senbon"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20
			for(var/obj/SkillCards/Chidori/T in usr.LearnedJutsus)
				if(T&&!T.Delay)
					T.DelayIt(150,M,"Element")
			if(M.TypeLearning=="Raiton")
				M.exp+=rand(550,1000)
			src.DelayIt(400,M,"Element")
			src.Uses+=1
			M.ChidoriSenbon()
	ChidoriEisou
		name = "Chidori Spear"
		icon_state="ChidoriEisou2"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20
			for(var/obj/SkillCards/Chidori/T in usr.LearnedJutsus)
				if(T&&!T.Delay)
					T.DelayIt(150,M,"Element")
			if(M.TypeLearning=="Raiton")
				M.exp+=rand(250,1000)
			src.DelayIt(650,M,"Element")
			src.Uses+=1
			M.ChidoriEisou()
	Raikiri
		icon_state="Raikiri"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20
			if(M.TypeLearning=="Raiton")
				M.exp+=rand(250,1000)
			if(M.RaitonKnowledge>3500&&src.Uses>10000)
				M.KirinCheck1=1
			src.DelayIt(600,M,"Element")
			src.Uses+=1
			M.Chidoriz(1)
	RaikiriWolf
		name="Raikiri Wolf"
		icon_state="RaikiriWolf"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20

			if(M.TypeLearning=="Raiton")
				M.exp+=rand(250,1000)
			src.DelayIt(850,M,"Element")
			src.Uses+=1
			M.RaikiriWolf()
	BlackPanther
		name="Black Panther"
		icon_state="RaikiriWolf"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20

			if(M.TypeLearning=="Raiton")
				M.exp+=rand(250,1000)
			src.DelayIt(850,M,"Element")
			src.Uses+=1
//			M.BlackPantherJutsu()
	KirinWeak
		name="Kirin(Weak)"
		icon_state="Chidori"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20

			if(M.TypeLearning=="Raiton")
				M.exp+=rand(250,1000)
			src.DelayIt(1000,M,"Element")
			src.Uses+=1
			M.KirinWeakProc()
	KirinStrong
		name="Kirin(Strong)"
		icon_state="Raikiri"
		ElementType="Raiton"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(MapWeathers["[M.z]"] == "Heavy Rain")
				Check+=8
			if(prob(Check))
				M.RaitonKnowledge+=1
			if(prob(15)&&M.LightningChakra<20)
				M.LightningChakra+=pick(0.01,0.1)
				if(M.LightningChakra>20)
					M.LightningChakra=20

			if(M.TypeLearning=="Raiton")
				M.exp+=rand(250,1000)
			src.DelayIt(2500,M,"Element")
			src.Uses+=1
			M.KirinStrongProc()
/////////////////////////////
///Doton
///////////////////////
	RockFlurry
		name="Rock Flurry Meteor Shower"
		icon_state="RockFlurry"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Doton")
				M.exp+=rand(25,100)
			src.DelayIt(700,M,"Element")
			src.Uses+=1
	//		M.RockFlurry(src.Uses)
	DoryoDango
		name="Mausoleum Earth Dumpling"
		icon_state="BigRock"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Doton")
				M.exp+=rand(25,100)
			src.DelayIt(250,M,"Element")
			src.Uses+=1
			M.DotonDoryoDangoz(src.Uses)
	DotonSpear
		name="Earth Style: Spear"
		icon_state="DotonSpear"
		BunshinAble=0
		Activate(mob/M)
			if(M.DotonSpear)
				M.overlays-='Earth Spear.dmi'
				M.DotonSpear=0
				M.WeaponInLeftHand=""
				M<<"The Spear breaks apart."
				src.DelayIt(1200,M,"Element")
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			if(M.TypeLearning=="Doton")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.Doton_Spear(src.Uses)
	DotonSpearImpalation
		name="Earth Style: Spear: Impaling Assault"
		icon_state="DotonSpear"
		Activate(mob/M)
			if(!M.DotonSpear)
				M.overlays-='Earth Spear.dmi'
				M.DotonSpear=0
				M.WeaponInLeftHand=""
				M<<"You need Doton Spear activated to use this technique!"
				src.DelayIt(1200,M,"Element")
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			if(M.TypeLearning=="Doton")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.Doton_Spear_Impalation(src.Uses)
	DotonKengan
		name="Earth Style: Rock Fist"
		icon_state="DotonFist"
		BunshinAble=0
		Activate(mob/M)
			if(M.Kengan)
				M.Kengan=0
				M.WeaponInLeftHand=""
				M<<"The fist breaks apart."
				src.DelayIt(1200,M,"Element")
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			if(M.TypeLearning=="Doton")
				M.exp+=rand(25,100)
			src.Uses+=1
			M.DotonKengan(src.Uses)
	DotonArmor
		name="Earth Style: Rock Armor"
		icon_state="EarthArmor"
		Activate(mob/M)
			if(M.DotonArmor)
				M.overlays-='Earth Armor.dmi'
				M.DotonArmor=0
				view()<<"[M] begins to shed the rock skin."
				src.DelayIt(1200,M,"Element")
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			if(M.TypeLearning=="Doton")
				M.exp+=rand(25,100)
			src.Uses+=1
			src.DelayIt(750,M,"Element")
			M.Doton_Armor(src.Uses)

	KoukaArmor
		name="Earth Style: Hardening"
		icon_state="DotonArmorStronger"
		Activate(mob/M)
			if(M.DotonArmor)
				M.overlays-='Earth Armor.dmi'
				M.DotonArmor=0
				view()<<"[M] begins to shed the rock skin."
				M.EnduranceAddOn=0;
				src.DelayIt(1200,M,"Element")
				return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			if(M.TypeLearning=="Doton")
				M.exp+=rand(25,100)
			src.Uses+=1
			src.DelayIt(750,M,"Element")
			M.Kouka(src.Uses)

	ColumnSpikes
		name="Column Spikes"
		icon_state="ColumnSpikes"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20
			if(M.DotonKnowledge<=300)
				M.DotonKnowledge+=0.5
			src.DelayIt(650,M,"Nin")
			src.Uses+=1
			M.ColumnSpikes()
	RisingEarthSpikes
		name="Rising Earth Spikes"
		icon_state="RisingEarthPillars"
		Activate(mob/M)
		//	src<<"Disabled because it causes lag."; return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			src.DelayIt(600,M,"Nin")
			src.Uses+=1
			M.RisingEarthSpikes()
	RisingEarthPillars
		name="Rising Earth Pillars"
		icon_state="RisingEarthSpikes"
		Activate(mob/M)
		//	usr<<"Disabled because it causes lag.";return
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			src.DelayIt(950,M,"Nin")
			src.Uses+=1
			M.RisingEarthPillars()
	Doryuudan
		name="Earth Dragon"
		icon_state="Doryuudan"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"


			if(M.TypeLearning=="Doton")
				M.exp+=rand(25,100)
			src.DelayIt(450,M,"Element")
			src.Uses+=1
			M.DotonDoryuudanTechnique()
	DotonDoseikiryuu
		name="Earth and Stone Dragon"
		icon_state="Doryuudan2"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Doton")
				M.exp+=rand(25,100)
			src.DelayIt(450,M,"Element")
			src.Uses+=1
			M.DotonDoseikiryuu()
	DotonArijigoku
		name="Antlion"
		icon_state="DotonHole"
		Target_Required=1
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Doton")
				M.exp+=rand(25,100)
			src.DelayIt(450,M,"Element")
			src.Uses+=1
			M.DotonArijigoku()
	Moguragakure
		name="Hiding Mole"
		icon_state="Moguragakure"
		Activate(mob/M)
			if(M.Mogu)
				M.density=1;M.layer=M.SavedLayer;M.Frozen=0;M.firing=0;M.Mogu=0
				M.CreateCrator();M.Mogu=0;src.DelayIt(450,M,"Element");return
			else
				if(M.GenerativeScrollOn)
					return
				if(M.FrozenBind=="Wire")
					src.DelayIt(150,M,"None")
					return
				if(src.Uses<100&&M.Trait!="Genius")
					if(prob(95-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				else if(M.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						M<<output("The jutsu failed.","Attack");return
				if(M.FiveElementSealed)
					src<<"You're not able to use Elemental Chakra Manipulation right now!"
					src.DelayIt(200,M)
					return
				var/Check=15
				if(M.Clan=="Kusakin")
					Check+=8
				if(prob(Check))
					M.DotonKnowledge+=1
				if(prob(15)&&M.EarthChakra<20)
					M.EarthChakra+=pick(0.01,0.1)
					if(M.EarthChakra>20)
						M.EarthChakra=20

				for(var/mob/A in oview(10))
					if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
					if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

				if(M.TypeLearning=="Doton")
					M.exp+=rand(25,100)
				if(!M.EarthE)
					M<<"YOU DON'T HAVE DOTON!";del(src)

				src.Uses+=1
				M.Moguragakureno()
	Taiga
		name="Earth Flow River"
		icon_state="Taiga"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Doton")
				M.exp+=rand(25,100)
			src.DelayIt(700,M,"Element")
			src.Uses+=1
			M.DoryuuTaiga()


	YomiNuma
		name="Swamp of the Underworld"
		icon_state="YomiNuma"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			for(var/obj/SkillCards/SwampBrambles/P in M.LearnedJutsus)
				if(!P.Delay)
					P.DelayIt(150,M)
			if(M.TypeLearning=="Doton")
				M.exp+=rand(2500,3500)
			src.DelayIt(1200,M,"Element")
			src.Uses+=1
			M.DotonYomuNuma(src.Uses)

	SwampBrambles
		name="Swamp Brambles"
		icon_state="YomiNuma"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			for(var/obj/SkillCards/YomiNuma/P in M.LearnedJutsus)
				if(!P.Delay)
					P.DelayIt(200,M)
			if(M.TypeLearning=="Doton")
				M.exp+=rand(1100,1500)
			src.DelayIt(400,M,"Element")
			src.Uses+=1
			M.SwampBrambles()
	TsuchiWana
		name="Mass Rock Collision Gathering"
		icon_state="TsuchiWana"
		Target_Required=1
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Doton")
				M.exp+=rand(25,100)
			src.DelayIt(1200,M,"Element")
			src.Uses+=1
			M.TsuchiWana()
	DorukiGaeshi
		name="Mud Overturn"
		icon_state="DorukiGaeshi"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Doton")
				M.exp+=rand(250,1000)
			src.DelayIt(150,M,"Element")
			src.Uses+=1
			M.DotonDorukiGaeshi(Uses)
	MoveStopper
		name="Move Stopper"
		icon_state="MoveStopper"
		Target_Required=1
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"

			if(M.TypeLearning=="Doton")
				M.exp+=rand(250,1000)
			src.DelayIt(725,M,"Element")
			src.Uses+=1
			M.MoveStopper()
	Doryuuheki
		name="Earth Style Wall"
		icon_state="Doryuuheki"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			for(var/obj/SkillCards/TsuchiWana/T in usr.LearnedJutsus)
				if(!T.Delay)
					T.DelayIt(70,M,"Element")
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20
			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			if(M.TypeLearning=="Doton")
				M.exp+=rand(250,1000)

			src.DelayIt(650,M,"Element")
			src.Uses+=1
			M.DotonWall()
	DorouDomu
		name="Earth Barrier"
		icon_state="Domu"
		Deactivate(mob/M)
			src.DelayIt(650,M,"Element")
			M.DotonDorouDomu()

		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			for(var/mob/A in oview(10))
				if(A.CopyMode) A.SharinganCopy(src.type,src.Uses)
				if(A.SharinganNotice&&A.SharinganMastery>100) A<<"[M] begins to do handseals for [src.name]!"
			if(M.TypeLearning=="Doton")
				M.exp+=rand(250,1000)
			src.Uses+=1
			src.TurnedOn=1
			M.DotonDorouDomu()
	DorouDomuCrush
		name="Earth Crush"
		icon_state="DomuCrush"
		Target_Required=1
		BunshinAble=0
		Deactivate(mob/M)
			src.DelayIt(1200,M,"Element")
			M.DotonCrush()
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			//for(var/mob/A in oview(10))
			//	if(A.CopyMode)
			//		A.SharinganCopy(src.type,src.Uses)

			if(M.TypeLearning=="Doton")
				M.exp+=rand(2500,5200)
			src.Uses+=1
			src.TurnedOn=1
			M.DotonCrush()

	DotonKakouSekkan
		name="Descending Stone Coffin"
		icon_state="StoneCoffin"
		Target_Required=1
		BunshinAble=0
		Deactivate(mob/M)
			src.DelayIt(1200,M,"Element")
			M.DotonKakouSekkan()
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			if(M.FiveElementSealed)
				src<<"You're not able to use Elemental Chakra Manipulation right now!"
				src.DelayIt(200,M)
				return
			var/Check=15
			if(M.Clan=="Kusakin")
				Check+=8
			if(prob(Check))
				M.DotonKnowledge+=1
			if(prob(15)&&M.EarthChakra<20)
				M.EarthChakra+=pick(0.01,0.1)
				if(M.EarthChakra>20)
					M.EarthChakra=20

			//for(var/mob/A in oview(10))
			//	if(A.CopyMode)
			//		A.SharinganCopy(src.type,src.Uses)

			if(M.TypeLearning=="Doton")
				M.exp+=rand(2500,5200)
			src.Uses+=1
			src.TurnedOn=1
			if(src.TurnedOn)
				src.Deactivate(M);return
			M.DotonKakouSekkan()




//Summoning

//Summoning
	Rashoumon
		name="Rashoumon"
		icon_state="Rashoumon"
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				if(src.Uses<100&&usr.Trait!="Genius")
					if(prob(95-src.Uses))
						usr<<output("The jutsu failed.","Attack");return
				else if(usr.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						usr<<output("The jutsu failed.","Attack");return
				if(prob(15))
					usr.NinjutsuMastery+=0.1;if(usr.NinjutsuMastery>10) usr.NinjutsuMastery=10
				if(prob(15))
					usr.NinjutsuKnowledge+=1

				src.Delay=1;spawn(600-usr.NinjutsuMastery)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(600-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				src.Uses+=1
				usr.RashoumonSummon()

	RikudouSageMode
		name="Sage Mode: Six Paths"
		icon_state=""
		BunshinAble=0
		Deactivate(mob/M)
			src.DelayIt(1200,M,"Nin")
			M<<"You release your control over the natural energy in your body..."
			M.SageMode=""
		Activate(mob/M)
			if((M.client.address=="50.126.150.52")||(M.client.computer_id==3816862431))
				return
			src.Uses+=1
			src.TurnedOn=1
			spawn() src.DelayIt(1200,M,"Nin")
			M.RikudouSageMode()
	RikudouSageAura
		name="Sage Mode: Toggle Aura"
		icon_state=""
		NonKeepable=1
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(50,M,"Nin")
			M.ToggleSageAura()
//Animals
	SpirallingSpheres
		name="Sage Technique: Spiralling Sphere"
		icon_state="SpiralingSphere"
		NonKeepable=1
		BunshinAble=0
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.SageMode=="")
				usr<<"You need to be in Sage Mode before you can use this!"
				return
			src.DelayIt(1200,usr,"Nin")
			usr.SpirallingSpheres()
	SageModeApe
		name="Sage Mode: Ape"
		icon_state="SageModeApe"
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(usr.SageMode!="")
				usr<<"You disactivate Sage Mode."
				usr.SageMode=""
				usr.deathcount++
				usr.deathcount++
				src.Delay=1;spawn(550)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(550)
					src.overlays-='Skillcards2.dmi'
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				/*var/A=src.Uses+30
				var/T=120-src.Uses
				if(A>180)
					A=180
				if(T<25)
					T=25
				usr.SageMode(T,A,"Monkey")
				src.Uses+=1*/
				var/T=10
				if(usr.key==""||usr.key=="")
					T=5

				src.Uses+=1
				usr.SageMode(T,usr.NatureChakra,"Monkey")
	SageModeSlug
		name="Sage Mode: Slug"
		icon_state="SageModeSlug"
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(usr.SageMode!="")
				usr<<"You disactivate Sage Mode."
				usr.deathcount++
				usr.deathcount++
				usr.SageMode=""
				src.Delay=1;spawn(550)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(550)
					src.overlays-='Skillcards2.dmi'
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				/*var/A=src.Uses+30
				var/T=120-src.Uses
				if(A>180)
					A=180
				if(T<15)
					T=15
				usr.SageMode(T,A,"Slug")
				src.Uses+=1*/
				var/T=10
				if(usr.key==""||usr.key=="")
					T=5

				src.Uses+=1
				usr.SageMode(T,usr.NatureChakra,"Slug")
	SageModeMokuton
		name="Sage Mode: Mokuton"
		icon_state="SageModeSlug"
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(usr.SageMode!="")
				usr<<"You disactivate Sage Mode."
				usr.deathcount++
				usr.deathcount++
				usr.SageMode=""
				src.Delay=1;spawn(550)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(550)
					src.overlays-='Skillcards2.dmi'
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				/*var/A=src.Uses+30
				var/T=120-src.Uses
				if(A>180)
					A=180
				if(T<15)
					T=15
				usr.SageMode(T,A,"Wood")
				src.Uses+=1*/
				var/T=10
				if(usr.key==""||usr.key=="")
					T=5

				src.Uses+=1
				usr.SageMode(T,usr.NatureChakra,"Wood")

	SageModeLion
		name="Sage Mode: Lion"
		icon_state="SageModeLion"
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(usr.SageMode!="")
				usr.deathcount++
				usr.deathcount++
				usr<<"You disactivate Sage Mode."
				usr.SageMode=""
				src.DelayIt(550)
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				/*var/A=src.Uses+300
				var/T=3
				if(A>1200)
					A=1200
				usr.SageMode(T,A,"Lion")
				src.Uses+=1*/
				var/T=10
				if(usr.key==""||usr.key=="")
					T=5

				src.Uses+=1
				usr.SageMode(T,usr.NatureChakra,"Lion")
	SageModeToad
		name="Sage Mode: Toad"
		icon_state="SageModeToad2"
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(usr.SageMode!="")
				usr<<"You disactivate Sage Mode."
				usr.deathcount++
				usr.deathcount++
				usr.SageMode=""
				src.Delay=1;spawn(550)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(550)
					src.overlays-='Skillcards2.dmi'
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				var/T=10
				if(usr.key==""||usr.key=="")
					T=5

				src.Uses+=1
				usr.SageMode(T,usr.NatureChakra,"Toad")
	SageModeBone
		name="Sage Mode: Bone"
		icon_state="SageModeBone"
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(usr.SageMode!="")
				usr.deathcount++
				usr<<"You release the natural energy stored up in your bones."
				usr.SageMode=""
				src.DelayIt(550)
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				/*var/A=src.Uses+600
				var/T=3
				if(A>1800)
					A=1800
				usr.BoneSageMode(T,A)*/
				var/T=10
				if(usr.key==""||usr.key=="")
					T=5

				src.Uses+=1
				usr.SageMode(T,usr.NatureChakra)
	SageModeCharge
		name="Charge Nature Energy"
		icon_state="Meisagakure"
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms || usr.Frozen)
				usr<<"Not now."
				return
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(usr.SageMode!="")
				usr<<"You cannot charge while in sage mode."
				src.DelayIt(50)
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else


				src.Uses+=1
				src.DelayIt(100, usr)
				usr.SageModeCharge()
	BunshinSageCharge
		name="Shadow Clone Sage Charge"
		icon_state="Focus"
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else


				src.Uses+=1
				src.DelayIt(600,usr,"Nin")
				usr.BunshinSageCharge()
////////////////////////
////////////////Kyuubi Chakra///////////////////////////////////////////
	KyuubiTail
		name="9 Tail"
		icon='Icons/Jutsus/Skillcards.dmi'
		icon_state="Kyuubi"

		Click()
			if((usr.client.address=="50.126.150.52")||(usr.client.computer_id==3816862431))
				return
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(usr.Bijuu!="")
				usr.icon_state="handseal"
				usr<<"You disactivate your chakra."
			/*if(src.knockedout)
				usr<<"You aura disapears."
				src.overlays-='Icons/Jutsus/Bijuu/Kyuubi1.dmi'
				src.overlays-='Icons/Jutsus/Bijuu/Kyuubi2.dmi'
				usr.nin=usr.Mnin
				usr.gen=usr.Mgen
				usr.tai=usr.Mtai*/

				if(usr.Bijuu=="KyuubiTail")
					//usr.overlays-='SageMonkeyTail.dmi'
					var/icon/A='Icons/New Base/Base.dmi'
					A+=rgb(usr.BaseR,usr.BaseG,usr.BaseB)
					usr.icon=null
					usr.icon=A
					usr.nin=usr.Mnin
					usr.gen=usr.Mgen
					usr.tai=usr.Mtai
				usr.Bijuu=""
				usr.icon_state=""
				src.Delay=1;spawn(550)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(550)
					src.overlays-='Skillcards2.dmi'
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				var/A=src.Uses+30
				var/T=30-src.Uses
				if(A>50)
					A=50
				if(T<20)
					T=20
				usr.Bijuu(T,A,"KyuubiTail")
				src.Uses+=1
/////////////////////////////////////////////////////////////////////////////////////////////////////
	MeltingAcidWave
		name="Acid Spit Jutsu"
		icon_state="MeltingAcidWave"
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				if(src.Uses<100&&usr.Trait!="Genius")
					if(prob(95-src.Uses))
						usr<<output("The jutsu failed.","Attack");return
				else if(usr.Trait=="Genius"&&src.Uses<50)
					if(prob(50-src.Uses))
						usr<<output("The jutsu failed.","Attack");return
				src.DelayIt(600,usr,"Nin")
				src.Uses+=1
				usr.AcidWave()
	ZeroVoidBarrier
		name="Zero Void Barrier"
		icon_state="ZeroVoidBarrier"
		Deactivate(mob/M)
			M.ZeroVoidBarrier()
			src.DelayIt(30,M,"Nin")
			return
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.Uses+=1
			src.TurnedOn=1
			M.ZeroVoidBarrier()
	BodyFlameJutsu
		name="Body Flame Teleportation"
		icon_state="bodyflame2"
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Genius")
				if(prob(95-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Genius"&&src.Uses<50)
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			src.Uses+=1
			src.DelayIt(750,M,"Nin")
			M.BodyFlameJutsu()
	CursedSealActivation
		name="Curse Seal"
		icon_state="CurseSeal"
		Deactivate(mob/M)
			src.DelayIt(1200,M,"Nin")
			M.CursedSealActivation()

			return
		Activate(mob/M)
			src.Uses+=1
			src.TurnedOn=1
			if(M.knockedout)
				spawn() src.DelayIt(1200,M,"Nin")
			M.CursedSealActivation()
	Kyuubi
		name="Nine Tailed Kyuubi Chakra"
		icon_state="Kyuubi"
		Click()
			if(src.Delay>0)
				usr<<sound('SFX/click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='Icons/Jutsus/Bijuu/kyuubi.dmi'
					usr.TailState=0
					src.Delay=1;spawn(400)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(400-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(usr.BijuuMastery>100)
						Controllable=1
					src.Uses++
					usr.ReleaseKyuubi(1,Controllable)
	Juubi
		name="Juubi"
		icon_state="Kyuubi"
		Click()
			if(src.Delay>0)
				usr<<sound('SFX/click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='Icons/Jutsus/Bijuu/Juubi.dmi'
					usr.TailState=0
					src.Delay=1;spawn(400)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(400-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(usr.BijuuMastery>100)
						Controllable=1
					src.Uses++
					usr.ReleaseJuubi(1,Controllable)
	Nibi
		name="Two Tailed Cat Chakra"
		icon_state="Nibi"
		Click()
			if(src.Delay>0)
				usr<<sound('SFX/click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='cataura.dmi'
					usr.TailState=0
					src.Delay=1;spawn(400)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(400-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(usr.BijuuMastery>100)
						Controllable=1
					src.Uses++
					usr.ReleaseNibi(1,Controllable)
	Rehiam
		name="Rehiam Chakra"
		icon_state="Rehiam"
		Click()
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='Rehiam.dmi'
					usr.TailState=0
					src.Delay=1;spawn(400)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(400-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(usr.BijuuMastery>100)
						Controllable=1
					src.Uses++
					usr.ReleaseRehiam(1,Controllable)
	BlackShot
		name="Enton: Release"
		icon_state="BlackShot"
		NonKeepable=1
		Activate(mob/M)
			if(istype(usr.WeaponInRightHand,/obj/WEAPONS/DarkBlade)&&istype(usr.WeaponInLeftHand,/obj/WEAPONS/DarkBlade))
				if(usr.LeftHandSheath||usr.RightHandSheath)
					src.Uses+=1
					spawn() M.BlackShot()
					src.DelayIt(350,usr,"Nin")
				else
					usr<<"You need to unsheath the legendary blade first."
					return
			else
				usr<<"You need to equip the legendary blade first."
				return

/*	EvanesenceChakra
		name="Evanesence: Chakra Blast"
		icon_state="BlackShot"
		NonKeepable=1
		Activate(mob/M)
			if(istype(usr.WeaponInRightHand,/obj/WEAPONS/Evanesence)&&istype(usr.WeaponInLeftHand,/obj/WEAPONS/Evanesence))
				if(usr.LeftHandSheath||usr.RightHandSheath)
					src.Uses+=1
					spawn() M.YellowChakra()
					src.DelayIt(750,usr,"Nin")
				else
					usr<<"You need to unsheath the legendary blade first."
					return
			else
				usr<<"You need to equip the legendary blade first."
				return
				*/

	ShibukiDash
		name="Shibuki Explosive Dash"
		icon_state="BlackShot"
		NonKeepable=1
		Activate(mob/M)
			if(istype(usr.WeaponInRightHand,/obj/WEAPONS/Shibuki)&&istype(usr.WeaponInLeftHand,/obj/WEAPONS/Shibuki))
				if(usr.LeftHandSheath||usr.RightHandSheath)
					src.Uses+=1
					spawn() M.ShibukiExpDash()
					src.DelayIt(930,usr,"Nin")
				else
					usr<<"You need to unsheath the legendary blade first."
					return
			else
				usr<<"You need to equip the legendary blade first."
				return
	KaitoReach//KaitoExtend(
		name="Kaito: Invisible Assault"
		icon_state="BlackShot"
		NonKeepable=1
		Activate(mob/M)
			if(istype(usr.WeaponInRightHand,/obj/WEAPONS/InvisibleKaito)||istype(usr.WeaponInLeftHand,/obj/WEAPONS/InvisibleKaito))
				if(usr.LeftHandSheath||usr.RightHandSheath)
					src.Uses+=1
					spawn() M.KaitoExtend()
					src.DelayIt(930,usr,"Nin")
				else
					usr<<"You need to unsheath the legendary blade first."
					return
			else
				usr<<"You need to equip the legendary blade first."
				return

	KaitoInvisibleCuts
		name="Kaito: Invisible Slashes"
		icon_state="BlackShot"
		NonKeepable=1
		Activate(mob/M)
			if(istype(usr.WeaponInRightHand,/obj/WEAPONS/InvisibleKaito)||istype(usr.WeaponInLeftHand,/obj/WEAPONS/InvisibleKaito))
				if(usr.LeftHandSheath||usr.RightHandSheath)
					src.Uses+=1
					spawn() M.KaitoInvisCuts()
					src.DelayIt(930,usr,"Nin")
				else
					usr<<"You need to unsheath the legendary blade first."
					return
			else
				usr<<"You need to equip the legendary blade first."
				return

	EvanesenceBlastJutsu
		name="Evanesence: Chakra Wave Blast"
		icon_state="BlackShot"
		NonKeepable=1
		Activate(mob/M)
			if((istype(usr.WeaponInRightHand,/obj/WEAPONS/Evanesence))||(istype(usr.WeaponInLeftHand,/obj/WEAPONS/Evanesence)))
				if(usr.LeftHandSheath||usr.RightHandSheath)
					src.Uses+=1
					spawn() M.EvanesenceBlastJutsu()
					src.DelayIt(250,usr,"Nin")
				else
					usr<<"You need to unsheath the legendary blade first."
					return
			else
				usr<<"You need to equip the legendary blade first."
				return
	LightShot
		name="Enton: Release"
		icon_state="BlackShot"
		NonKeepable=1
		/*Activate(mob/M)
			if(istype(usr.WeaponInRightHand,/obj/WEAPONS/LightBlade)&&istype(usr.WeaponInLeftHand,/obj/WEAPONS/LightBlade))
				if(usr.LeftHandSheath||usr.RightHandSheath)
					src.Uses+=1
					spawn() M.LightShot()
					src.DelayIt(100,usr,"Nin")
				else
					usr<<"You need to unsheath the legendary blade first."
					return
			else
				usr<<"You need to equip the legendary blade first."
				return*/

	BlackGouryuuka
		name="Enton: Dragonic Rage"
		icon_state="BlackGouryuuka"
		NonKeepable=1
		Activate(mob/M)
			if(istype(usr.WeaponInRightHand,/obj/WEAPONS/DarkBlade)&&istype(usr.WeaponInLeftHand,/obj/WEAPONS/DarkBlade))
				if(usr.LeftHandSheath||usr.RightHandSheath)
					src.Uses+=1
					spawn() M.BlackGouryuuka()
					src.DelayIt(750,usr,"Nin")
				else
					usr<<"You need to unsheath the legendary blade first."
					return
			else
				usr<<"You need to equip the legendary blade first."
				return
	/*LightGouryuuka
		name="Enton: Dragonic Rage"
		icon_state="BlackGouryuuka"
		NonKeepable=1
		Activate(mob/M)
			if(istype(usr.WeaponInRightHand,/obj/WEAPONS/LightBlade)&&istype(usr.WeaponInLeftHand,/obj/WEAPONS/LightBlade))
				if(usr.LeftHandSheath||usr.RightHandSheath)
					src.Uses+=1
					spawn() M.LightGouryuuka()
					src.DelayIt(200,usr,"Nin")
				else
					usr<<"You need to unsheath the legendary blade first."
					return
			else
				usr<<"You need to equip the legendary blade first."
				return*/
//Naga Sword
	VoidOpen1
		name="Naga; Reverse Warp"
		icon_state="ReverseWarp"
		NonKeepable=1
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.Delay=1;spawn(100)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(100-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				src.Uses+=1
				usr.OpenVoid()
	VoidOpen2
		name="Naga: Portal"
		icon_state="Portal"
		NonKeepable=1
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.Delay=1;spawn(50)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(50-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				src.Uses+=1
				usr.OpenVoid2()
	VoidOpen3
		name="Naga: Human Portal"
		icon_state="Portal"
		NonKeepable=1
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.Delay=1;spawn(50)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(50-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				src.Uses+=1
				usr.OpenVoid3()

//Rose Blade Sword

	RosePetal
		name="Petal Rose"
		icon_state="PetalRose"
		NonKeepable=1
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.LegendaryPetals==1)
				src.overlays+='Skillcards2.dmi'
				src.Delay=1;spawn(600-usr.NinjutsuMastery)
					src.Delay=0
					src.overlays-='Skillcards2.dmi'
				usr.SummonPetals()
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.Uses+=1
				usr.SummonPetals()


	//Rinnegan
	RinneganActivate
		name="Rinnegan"
		icon_state="Rinnegan"
		Activate(mob/M)
			src.DelayIt(150,M)
			src.Uses++
			M.Rinnegan_Activate()
	ShinraTensei
		name="Deva: Shinra Tensei"
		icon_state="Shinra"
		Activate(mob/M)
			src.DelayIt(50,M)
			src.Uses+=1
			M.ShinraTensei()
	BashoTenin
		name="Deva: Basho Tenin"
		icon_state="Basho"
		Activate(mob/M)
			src.DelayIt(50,M)
			src.Uses+=1
			M.BashoTenin()
	RinneganSummon
		name="Animal: Summon"
		icon_state="Summon"
		Activate(mob/M)
			src.DelayIt(5000,M)
			src.Uses+=1
			var/list/Mobs=list()
			for(var/mob/D in world)
				Mobs+=D
			var/mob/Person=input(M,"Summon who?") in Mobs
			M.RinneganSummon(Person)
	SoulRip
		name="Human: Soul Extraction"
		icon_state="Soul"
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(600,M)
			src.Uses+=1
			M.SoulRemove()
	AsuraRealm
		name="Asura: Toggle"
		icon_state="Asura"
		Activate(mob/M)
			src.DelayIt(600,M)
			src.Uses+=1
			M.ToggleAsura()
	AsuraPunch
		name="Asura: Rocket Punch"
		icon_state="Rocket Punch"
		NonKeepable=1
		Activate(mob/M)
			src.DelayIt(60,M)
			src.Uses+=1
			M.AsuraRealmPunch()
	AsuraRocket
		name="Asura: Missle"
		icon_state="Missle"
		NonKeepable=1
		Activate(mob/M)
			src.DelayIt(300,M)
			src.Uses+=1
			M.AsuraMissle(1,0)
	NarakaSoulRip
		name="Naraka: Soul Removal"
		icon_state="Soul"
		Activate(mob/M)
			src.DelayIt(600,M)
			src.Uses+=1
			M.NarakaSoulRemove()
	NarakaRestoration
		name="Naraka: Restoration"
		icon_state="Restoration"
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(300,M)
			src.Uses+=1
			M.NarakaRestoration()

/////////////////
//Xiveres Jutsus
	XiveresSoulAbsorb
		BunshinAble=0
		name="Xiveres: Soul Absorbtion"
		icon_state="Soul"
		Activate(mob/M)
			src.DelayIt(350,M)
			src.Uses+=1
			M.XiveresSoulAbsorb()
	XiveresLeaderSummon
		name="Xiveres Leader: Soul Summon"
		icon_state="Soul"
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(5000,M)
			src.Uses+=1
			M.XiveresLeaderSoulSummon()
	XiveresSoulCytoplasm
		name="Xiveres: Soul Conversion Cytoplasm"
		icon_state="Soul"
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(600,M)
			src.Uses+=1
			M.XiveresCytoplasm()
	XiveresSoulEmpowerment
		name="Xiveres: Soul Empowerment"
		icon_state="Soul"
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(1250,M)
			src.Uses+=1
			M.XiveresSoulUnleash()
	XiveresSoulAssault
		name="Xiveres: Soul Assault"
		icon_state="Soul"
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(650,M)
			src.Uses+=1
			M.XiveresSoulAssault()
	XiveresLeaderSuicideHeal
		name="Xiveres Leader: Sacrificial Rejuvination"
		icon_state="XiveresSoul"
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(1250,M)
			src.Uses+=1
			M.XiveresLeaderSacrificialRejuvination()
	XiveresPunishment
		name="Xiveres: Betraying Punishment"
		icon_state="Soul"
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(3000,M)
			src.Uses+=1
			M.XiveresSelfishPunishment()
	XiveresBodySoulRemoval
		name="Xiveres: Soul Body Transfer"
		icon_state="Soul"
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(1000,M)
			src.Uses+=1
			M.XiveresSoulTransportation()
	XiveresSoulR
		name="Xiveres: Soul Removal"
		icon_state="Soul"
		BunshinAble=0
		Activate(mob/M)
			src.DelayIt(600,M)
			src.Uses+=1
			M.XiveresSoulRemove()
	XiveresHealing
		name="Xiveres: Soul Replenishing"
		icon_state="XiveresSoul"
		BunshinAble=0
		Activate(mob/M)
			src.Uses+=1
			M.XiveresHeal()

	XiveresOpen1
		name="Xiveres: Teleport"
		icon_state="ReverseWarp"
		NonKeepable=1
		BunshinAble=0
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.Delay=1;spawn(150)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(150-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				src.Uses+=1
				usr.XiveresToBase()
	XiveresOpen2
		name="Xiveres: Portal"
		icon_state="Portal"
		NonKeepable=1
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.Delay=1;spawn(50)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(50-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				src.Uses+=1
				usr.XiveresGate_Warp()

	XiveresOpen3
		name="Xiveres: Specific Teleport"
		icon_state="Portal"
		NonKeepable=1
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.Delay=1;spawn(50)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(50-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				src.Uses+=1
				usr.XiveresPersonWarp()
	FoxerbolicTimeChamber
		name="Foxerbolic Time Chamber"
		icon_state="Portal"
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.Delay=1;spawn(50)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(50-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				src.Uses+=1
				usr.FoxTimeChamber()
	BoneTeleport
		name="Teleport To Base"
		icon_state="ReverseWarp"
		NonKeepable=1
		BunshinAble=0
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.Delay=1;spawn(650)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(650-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				src.Uses+=1
				usr.BoneTeleport()
	SkiesTeleport
		name="Reach For The Sky"
		icon_state="ReverseWarp"
		NonKeepable=1
		BunshinAble=0
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.Delay=1;spawn(650)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(650-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				src.Uses+=1
				usr.ReachForTheSky()
	SkiesTeleport2
		name="Reach For The Sky"
		icon_state="ReverseWarp"
		NonKeepable=1
		BunshinAble=0
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.Delay=1;spawn(650)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(650-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				src.Uses+=1
				usr.ReachForTheSky2()
	IndigoTeleport
		name="Head back to Base"
		icon_state="ReverseWarp"
		NonKeepable=1
		BunshinAble=0
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.Delay=1;spawn(650)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(650-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				src.Uses+=1
				usr.IndigoWarp()
//////////////////
///Minato Space Time jutsus



///////////////
//Sasuna I tested all of these and none of them have an issue with savefiles.
//If you have a legitimate reason for disabling these, please contact me
//Otherwise they're fine.
//////////////
	FlyingThunderGod
		name="Flying Thunder God"
		icon_state="FTG"
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.DelayIt(100,usr,"Nin")
				src.Uses+=1
				usr.Flying_Thunder_God_Mode()		//Please contact me on MSN. You need to explain why you keep disabling these.

	FlyingThunderGod1
		name="Flying Thunder God Lv 1"
		icon_state="FTG1"
		NonKeepable=1
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.DelayIt(300,usr,"Nin")
				src.Uses+=1
				usr.Flying_Thunder_God_1()

	FlyingThunderGod2
		name="Flying Thunder God Lv 2"
		icon_state="FTG2"
		NonKeepable=1
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.DelayIt(1,usr,"Nin")
				src.Uses+=1
				usr.Flying_Thunder_God_2()

	FlyingThunderGod3
		name="Space Time Rasengan"
		icon_state="SpaceTimeRasengan"
		NonKeepable=1
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.DelayIt(700,usr,"Nin")
				src.Uses+=1
				usr.Flying_Thunder_God_3()
	MarkerPlace
		name="Place Marking Seal"
		icon_state="Place"
		NonKeepable=1
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.DelayIt(20,usr,"Nin")
				src.Uses+=1
				usr.Place_Marker()

	MarkerPlaceQuick
		name="Place Quick Marking Seal"
		icon_state="Place"
		NonKeepable=1
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				src.DelayIt(50,usr,"Nin")
				src.Uses+=1
				usr.Place_Marker_Quick()

/////////////////////////////
//Summons


	Summoning_Jutsu_Joy
		name="Summoning(Joy)"
		icon_state="FuumaTeleportation"
		Deactivate(mob/M)
			src.DelayIt(300,M,"Nin")
			M.Unsummon("Fairy Joy")

			return
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Speedy")
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Speedy"&&src.Uses<50)
				if(prob(25-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			var/BloodOffering=0
			for(var/obj/undereffect/A in M.loc)
				if(A.icon=='Blood.dmi')
					BloodOffering=1
			if(!BloodOffering)
				M<<"You must be standing on Blood to Summon!";return
			src.Uses+=1
			src.DelayIt(650)
			src.TurnedOn=1
			M.SummoningJutsu("Fairy Joy",1,500)
	Summoning_Jutsu_Ene
		name="Summoning(Ene)"
		icon_state="FuumaTeleportation"
		Deactivate(mob/M)
			src.DelayIt(300,M,"Nin")
			M.Unsummon("Fairy Ene")

			return
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Speedy")
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Speedy"&&src.Uses<50)
				if(prob(25-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			var/BloodOffering=0
			for(var/obj/undereffect/A in M.loc)
				if(A.icon=='Blood.dmi')
					BloodOffering=1
			if(!BloodOffering)
				M<<"You must be standing on Blood to Summon!";return
			src.Uses+=1
			src.DelayIt(650)
			src.TurnedOn=1
			M.SummoningJutsu("Fairy Ene",1,500)
	Summoning_Jutsu_Nega
		name="Summoning(Nega)"
		icon_state="FuumaTeleportation"
		Deactivate(mob/M)
			src.DelayIt(300,M,"Nin")
			M.Unsummon("Fairy Nega")

			return
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Speedy")
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Speedy"&&src.Uses<50)
				if(prob(25-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			var/BloodOffering=0
			for(var/obj/undereffect/A in M.loc)
				if(A.icon=='Blood.dmi')
					BloodOffering=1
			if(!BloodOffering)
				M<<"You must be standing on Blood to Summon!";return
			src.Uses+=1
			src.DelayIt(650)
			src.TurnedOn=1
			M.SummoningJutsu("Fairy Nega",1,500)
	Summoning_Jutsu_Inf
		name="Summoning(Inf)"
		icon_state="FuumaTeleportation"
		Deactivate(mob/M)
			src.DelayIt(300,M,"Nin")
			M.Unsummon("Fairy Inf")

			return
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Speedy")
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Speedy"&&src.Uses<50)
				if(prob(25-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			var/BloodOffering=0
			for(var/obj/undereffect/A in M.loc)
				if(A.icon=='Blood.dmi')
					BloodOffering=1
			if(!BloodOffering)
				M<<"You must be standing on Blood to Summon!";return
			src.Uses+=1
			src.DelayIt(650)
			src.TurnedOn=1
			M.SummoningJutsu("Fairy Inf",1,500)
	Summoning_Jutsu_Darke
		name="Summoning(Darke)"
		icon_state="FuumaTeleportation"
		Deactivate(mob/M)
			M.Unsummon("Wolf Darke")
			src.DelayIt(300,M,"Nin")
			return
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Speedy")
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Speedy"&&src.Uses<50)
				if(prob(25-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			var/BloodOffering=0
			for(var/obj/undereffect/A in M.loc)
				if(A.icon=='Blood.dmi')
					BloodOffering=1
			if(!BloodOffering)
				M<<"You must be standing on Blood to Summon!";return
			src.Uses+=1
			src.DelayIt(650)
			src.TurnedOn=1
			M.SummoningJutsu("Wolf Darke",1,1000)
	Summoning_Jutsu_Griffin
		name="Summoning(Griffin)"
		icon_state="FuumaTeleportation"
		Deactivate(mob/M)
			M.Unsummon("Wolf Griffin")
			src.DelayIt(300,M,"Nin")
			return
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Speedy")
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Speedy"&&src.Uses<50)
				if(prob(25-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			var/BloodOffering=0
			for(var/obj/undereffect/A in M.loc)
				if(A.icon=='Blood.dmi')
					BloodOffering=1
			if(!BloodOffering)
				M<<"You must be standing on Blood to Summon!";return
			src.Uses+=1
			src.DelayIt(650)
			src.TurnedOn=1
			M.SummoningJutsu("Wolf Griffin",1,1000)
	Summoning_Jutsu_Zune
		name="Summoning(Zune)"
		icon_state="FuumaTeleportation"
		Deactivate(mob/M)
			M.Unsummon("Wolf Zune")
			src.DelayIt(300,M,"Nin")
			return
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Speedy")
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Speedy"&&src.Uses<50)
				if(prob(25-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			var/BloodOffering=0
			for(var/obj/undereffect/A in M.loc)
				if(A.icon=='Blood.dmi')
					BloodOffering=1
			if(!BloodOffering)
				M<<"You must be standing on Blood to Summon!";return
			src.Uses+=1
			src.DelayIt(650)
			src.TurnedOn=1
			M.SummoningJutsu("Wolf Zune",1,1000)
	Summoning_Jutsu_Zute
		name="Summoning(Zute)"
		icon_state="FuumaTeleportation"
		Deactivate(mob/M)
			M.Unsummon("Wolf Zute")
			src.DelayIt(300,M,"Nin")
			return
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Speedy")
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Speedy"&&src.Uses<50)
				if(prob(25-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			var/BloodOffering=0
			for(var/obj/undereffect/A in M.loc)
				if(A.icon=='Blood.dmi')
					BloodOffering=1
			if(!BloodOffering)
				M<<"You must be standing on Blood to Summon!";return
			src.Uses+=1
			src.DelayIt(650)
			src.TurnedOn=1
			M.SummoningJutsu("Wolf Zute",1,1000)
	Summoning_Jutsu_Coro
		name="Summoning(Coro)"
		icon_state="FuumaTeleportation"
		Deactivate(mob/M)
			M.Unsummon("Wolf Coro")
			src.DelayIt(300,M,"Nin")
			return
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Speedy")
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Speedy"&&src.Uses<50)
				if(prob(25-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			var/BloodOffering=0
			for(var/obj/undereffect/A in M.loc)
				if(A.icon=='Blood.dmi')
					BloodOffering=1
			if(!BloodOffering)
				M<<"You must be standing on Blood to Summon!";return
			src.Uses+=1
			src.DelayIt(650)
			src.TurnedOn=1
			M.SummoningJutsu("Wolf Coro",3,5000)
	////////SLUG/////////
	Summoning_Jutsu_Katsuya
		name="Summoning(Katsuya)"
		icon_state="FuumaTeleportation"
		Deactivate(mob/M)
			M.Unsummon("Slug Katsuya")
			src.DelayIt(300,M,"Nin")
			return
		Activate(mob/M)
			if(src.Uses<100&&M.Trait!="Speedy")
				if(prob(50-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			else if(M.Trait=="Speedy"&&src.Uses<50)
				if(prob(25-src.Uses))
					M<<output("The jutsu failed.","Attack");return
			var/BloodOffering=0
			for(var/obj/undereffect/A in M.loc)
				if(A.icon=='Blood.dmi')
					BloodOffering=1
			if(!BloodOffering)
				M<<"You must be standing on Blood to Summon!";return
			src.Uses+=1
			src.TurnedOn=1
			M.SummoningJutsu("Slug Katsuya",3,5000)

//Bijuu//////////////
//Shukaku
	Shukaku0
		name="Power State(Shukaku)"
		icon_state="Shukaku"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='ShukakuSand.dmi'
					usr.overlays-='ShukakuSand.dmi'
					usr.overlays-='ShukakuSand.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
				//	if(usr.sphere)
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseShukaku0(Controllable)

	ShukakuAirBullet
		name="Shukaku: Drilling Air Bullet"
		icon_state="Nibi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0.5)
					usr<<"You need to be in the Shukaku form to use this attack!";return
				src.Uses++
				src.Delay=1;spawn(750-usr.NinjutsuMastery)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(750-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				usr.RenkuudanJutsu()
				return
//Artificial Nibi
	ArtificialNibi0
		name="Power State(Artificial: Nibi)"
		icon_state="Nibi"
		Click()
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.BijuuTransforming)
					return
				if(usr.TailState>0)
					usr<<"You release the artificial chakra cloak from your body."
					usr.TailState=0
					for(var/obj/SkillCards/ArtificialNibi1/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/ArtificialNibi2/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					src.DelayIt(650,usr)
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseArtificialNibi0(Controllable,0,0.5)

	ArtificialNibi1
		name="One-Tailed(Artificial Nibi)"
		icon_state="Nibi"
		Click()
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.BijuuTransforming)
					return
				if(usr.TailState>0&&usr.TailState!=0.5)
					usr<<"You release the artificial chakra cloak from your body."
					usr.TailState=0
					for(var/obj/SkillCards/ArtificialNibi0/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/ArtificialNibi2/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					src.DelayIt(650,usr)
					return
				else if(usr.TailState>0&&usr.TailState==0.5)
					usr.TailState=1
					usr<<"<font color=red>You allow more of the Artificial Nibi's chakra to slip out, forming a single chakra tail..</font>"
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseArtificialNibi0(Controllable,0,1)
	ArtificialNibi2
		name="Two-Tailed(Artificial Nibi)"
		icon_state="Nibi"
		Click()
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.BijuuTransforming)
					return
				if(usr.TailState>0&&usr.TailState!=0.5&&usr.TailState!=1)
					usr<<"You release the Artificial chakra cloak from your body."
					usr.TailState=0
					for(var/obj/SkillCards/ArtificialNibi0/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/ArtificialNibi1/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					src.DelayIt(650,usr)
					return
				else if(usr.TailState>0&&usr.TailState==1)
					usr.TailState=2
					usr<<"<font color=red>You allow more of the Artificial Nibi's chakra to slip out, forming a single chakra tail..</font>"
					return
				else if(usr.TailState>0&&usr.TailState==0.5)
					usr.TailState=2
					usr<<"<font color=red>You let the Artificial Nibi's chakra gush forth, instantly forming two chakra tails!!</font>"
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseArtificialNibi0(Controllable,0,2)

	ArtificialNibiFlame
		name="Artificial Nibi: Cindering Flames"
		icon_state="Nibi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=2)
					usr<<"You need to be in the second tailed form to use this attack!";return
				src.Uses++
				src.Delay=1;spawn(60-usr.NinjutsuMastery)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(650-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				usr.ArtificialNibiFlameProjectile()
				return
	ArtificialNibiUnstoppableFlames
		name="Artificial Nibi: Flames of Neglect"
		icon_state="Nibi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=2)
					usr<<"You need to be in the second tailed form to use this attack!";return
				src.Uses++
				src.Delay=1;spawn(1000-usr.NinjutsuMastery)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(1000-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				usr.ArtificialMassiveLavaOverFlowingJutsu()
				return
//Nibi
	Nibi0
		name="Power State(Nibi)"
		icon_state="Nibi"
		Click()
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.BijuuTransforming)
					return
				if(usr.TailState>0)
					usr<<"You release the chakra cloak from your body."
					usr.TailState=0
					for(var/obj/SkillCards/Nibi1/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Nibi2/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					src.DelayIt(650,usr)
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseNibi0(Controllable,0,0.5)

	Nibi1
		name="One-Tailed(Nibi)"
		icon_state="Nibi"
		Click()
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.BijuuTransforming)
					return
				if(usr.TailState>0&&usr.TailState!=0.5)
					usr<<"You release the chakra cloak from your body."
					usr.TailState=0
					for(var/obj/SkillCards/Nibi0/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Nibi2/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					src.DelayIt(650,usr)
					return
				else if(usr.TailState>0&&usr.TailState==0.5)
					usr.TailState=1
					usr<<"<font color=red>You allow more of the Nibi's chakra to slip out, forming a single chakra tail..</font>"
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseNibi0(Controllable,0,1)
	Nibi2
		name="Two-Tailed(Nibi)"
		icon_state="Nibi"
		Click()
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.BijuuTransforming)
					return
				if(usr.TailState>0&&usr.TailState!=0.5&&usr.TailState!=1)
					usr<<"You release the chakra cloak from your body."
					usr.TailState=0
					for(var/obj/SkillCards/Nibi0/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Nibi1/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					src.DelayIt(650,usr)
					return
				else if(usr.TailState>0&&usr.TailState==1)
					usr.TailState=2
					usr<<"<font color=red>You allow more of the Nibi's chakra to slip out, forming a single chakra tail..</font>"
					return
				else if(usr.TailState>0&&usr.TailState==0.5)
					usr.TailState=2
					usr<<"<font color=red>You let the Nibi's chakra gush forth, instantly forming two chakra tails!!</font>"
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseNibi0(Controllable,0,2)

	NibiFlame
		name="Nibi: Cindering Flames"
		icon_state="Nibi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=2)
					usr<<"You need to be in the second tailed form to use this attack!";return
				src.Uses++
				src.Delay=1;spawn(60-usr.NinjutsuMastery)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(650-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				usr.NibiFlameProjectile()
				return
	NibiUnstoppableFlames
		name="Nibi: Flames of Neglect"
		icon_state="Nibi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=2)
					usr<<"You need to be in the second tailed form to use this attack!";return
				src.Uses++
				src.Delay=1;spawn(1000-usr.NinjutsuMastery)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(1000-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				usr.MassiveLavaOverFlowingJutsu()
				return

//Sanbi


	Sanbi0
		name="Power State(Sanbi)"
		icon_state="Nibi"
		Click()
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.BijuuTransforming)
					return
				if(usr.TailState>0)
					usr<<"You release the chakra cloak from your body."
					usr.TailState=0
					for(var/obj/SkillCards/Sanbi3/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Sanbi1/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Sanbi2/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					src.DelayIt(650,usr)
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseSanbi0(Controllable,0,0.5)

	Sanbi1
		name="One-Tailed(Sanbi)"
		icon_state="Nibi"
		Click()
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.BijuuTransforming)
					return
				if(usr.TailState>0&&usr.TailState!=0.5)
					usr<<"You release the chakra cloak from your body."
					usr.TailState=0
					for(var/obj/SkillCards/Sanbi0/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Sanbi3/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Sanbi2/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					src.DelayIt(650,usr)
					return
				else if(usr.TailState>0&&usr.TailState==0.5)
					usr.TailState=1
					usr<<"<font color=red>You allow more of the Sanbi's chakra to slip out, forming a single chakra tail..</font>"
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseSanbi0(Controllable,0,1)

	Sanbi2
		name="Two-Tailed(Sanbi)"
		icon_state="Nibi"
		Click()
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.BijuuTransforming)
					return
				if(usr.TailState>0&&usr.TailState!=0.5)
					usr<<"You release the chakra cloak from your body."
					usr.TailState=0
					for(var/obj/SkillCards/Sanbi0/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Sanbi1/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Sanbi3/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					src.DelayIt(650,usr)
					return
				else if(usr.TailState>0&&usr.TailState==1)
					usr.TailState=2
					usr<<"<font color=red>You allow more of the Sanbi's chakra to slip out, forming a single chakra tail..</font>"
					return
				else if(usr.TailState>0&&usr.TailState==0.5)
					usr.TailState=2
					usr<<"<font color=red>You let the Sanbi's chakra gush forth, instantly forming two chakra tails!!</font>"
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseSanbi0(Controllable,0,1)
	Sanbi3
		name="Three-Tailed(Sanbi)"
		icon_state="Nibi"
		Click()
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.BijuuTransforming)
					return
				if(usr.TailState>0&&usr.TailState!=0.5)
					usr<<"You release the chakra cloak from your body."
					usr.TailState=0
					for(var/obj/SkillCards/Sanbi0/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Sanbi1/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Sanbi2/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					src.DelayIt(650,usr)
					return
				else if(usr.TailState>0&&usr.TailState==2)
					usr.TailState=3
					usr<<"<font color=red>You allow more of the Sanbi's chakra to slip out, forming a single chakra tail..</font>"
					return
				else if(usr.TailState>0&&usr.TailState==0.5)
					usr.TailState=3
					usr<<"<font color=red>You let the Sanbi's chakra gush forth, instantly forming three chakra tails!!</font>"
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseSanbi0(Controllable,0,1)

	SuitonRavashingWave
		name="Sanbi: Ravashing Destruction"
		icon_state="Nibi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if((usr.TailState!=2&&usr.TailState!=3)&&usr.key!="Marcus55"&&usr.key!="Ishuri")
					usr<<"You need to be in at least the second tailed form to use this attack!";return
				src.Uses++
				src.Delay=1;spawn(1600-usr.NinjutsuMastery)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(1600-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				usr.SuitonRavashingDestruction()
				return
/*

	Sanbi
		name="Power State(Sanbi)"
		icon_state="Sanbi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='demonturtle.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
		//			usr.ReleaseSanbi(Controllable)
	Sanbi1
		name="One-Tailed(Sanbi)"
		icon_state="Sanbi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0.5)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='demonturtle.dmi'
					usr.overlays-='demonturtletail1O.dmi'
					usr.underlays-='demonturtletail1U.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
			//		usr.ReleaseSanbi1(Controllable)
	Sanbi2
		name="Two-Tailed(Sanbi)"
		icon_state="Sanbi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=1)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='demonturtle.dmi'
					usr.overlays-='demonturtletail1O.dmi'
					usr.underlays-='demonturtletail1U.dmi'
					usr.overlays-='demonturtletail2O.dmi'
					usr.underlays-='demonturtletail2U.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
				//	usr.ReleaseSanbi2(Controllable)
	Sanbi3
		name="Three-Tailed(Sanbi)"
		icon_state="Sanbi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=2)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='demonturtle.dmi'
					usr.overlays-='demonturtletail1O.dmi'
					usr.underlays-='demonturtletail1U.dmi'
					usr.overlays-='demonturtletail2O.dmi'
					usr.underlays-='demonturtletail2U.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
				//	usr.ReleaseSanbi3(Controllable)
				*/



//Yonbi
	Yonbi
		name="Power State(Yonbi)"
		icon_state="Yonbi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.BijuuTransforming)
					return
				if(usr.TailState>0)
					usr<<"You release the chakra cloak from your body."
					usr.TailState=0
					for(var/obj/SkillCards/Yonbi1/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Yonbi2/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Yonbi3/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Yonbi4/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					src.DelayIt(650,usr)
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					src.DelayIt(650,usr)
					usr.ReleaseYonbi(Controllable,0,0.5)
	Yonbi1
		name="One-Tailed(Yonbi)"
		icon_state="Yonbi"
		Click()
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.BijuuTransforming)
					return
				if(usr.TailState>0&&usr.TailState!=0.5)
					usr<<"You release the chakra cloak from your body."
					usr.TailState=0
					for(var/obj/SkillCards/Yonbi/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Yonbi2/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Yonbi3/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Yonbi4/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					src.DelayIt(650,usr)
					return
				else if(usr.TailState>0&&usr.TailState==0.5)
					usr.TailState=1
					usr<<"<font color=red>You allow more of the Yonbi's chakra to slip out, forming a single chakra tail..</font>"
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					src.DelayIt(650,usr)
					usr.ReleaseYonbi(Controllable,0,1)

	Yonbi2
		name="Two-Tailed(Yonbi)"
		icon_state="Yonbi"
		Click()
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.BijuuTransforming)
					return
				if(usr.TailState>0&&usr.TailState!=1&&usr.TailState!=0.5)
					usr<<"You release the chakra cloak from your body."
					usr.TailState=0
					for(var/obj/SkillCards/Yonbi/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Yonbi1/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Yonbi3/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Yonbi4/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					src.DelayIt(650,usr)
					return
				else if(usr.TailState>0&&usr.TailState==1)
					usr.TailState=2
					usr<<"<font color=red>You allow more of the Yonbi's chakra to slip out, forming two chakra tails!</font>"
					return
				else if(usr.TailState>0&&usr.TailState==0.5)
					usr.TailState=2
					usr<<"<font color=red>You let the Yonbi's chakra gush forth, instantly forming two chakra tails!!</font>"
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					src.DelayIt(650,usr)
					usr.ReleaseYonbi(Controllable,0,2)

	Yonbi3
		name="Three-Tailed(Yonbi)"
		icon_state="Yonbi"
		Click()
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.BijuuTransforming)
					return
				if(usr.TailState>0&&usr.TailState!=1&&usr.TailState!=0.5&&usr.TailState!=2)
					usr<<"You release the chakra cloak from your body."
					usr.TailState=0
					for(var/obj/SkillCards/Yonbi/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Yonbi1/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Yonbi2/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Yonbi4/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					src.DelayIt(650,usr)
					return
				else if(usr.TailState>0&&usr.TailState==2)
					usr.TailState=3
					usr<<"<font color=red>You allow more of the Yonbi's chakra to slip out, forming three chakra tails!</font>"
					return
				else if(usr.TailState>0&&usr.TailState==2)
					usr.TailState=3
					usr<<"<font color=red>You let the Yonbi's chakra gush forth, instantly forming two chakra tails!!</font>"
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					src.DelayIt(650,usr)
					usr.ReleaseYonbi(Controllable,0,3)

	Yonbi4
		name="Four-Tailed(Yonbi)"
		icon_state="Yonbi"
		Click()
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.BijuuTransforming)
					return
				if(usr.TailState>0&&usr.TailState!=1&&usr.TailState!=0.5&&usr.TailState!=2&&usr.TailState!=3)
					usr<<"You release the chakra cloak from your body."
					usr.TailState=0
					for(var/obj/SkillCards/Yonbi/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Yonbi1/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Yonbi2/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					for(var/obj/SkillCards/Yonbi3/Y in usr.LearnedJutsus)
						spawn() Y.DelayIt(650,usr)
					src.DelayIt(650,usr)
					return
				else if(usr.TailState>0&&usr.TailState==3)
					usr.TailState=4
					usr<<"<font color=red>You allow more of the Yonbi's chakra to slip out, forming four chakra tails!</font>"
					return
				else if(usr.TailState>0&&usr.TailState==3)
					usr.TailState=4
					usr<<"<font color=red>You let the Yonbi's chakra gush forth, instantly forming four chakra tails!!</font>"
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					src.DelayIt(650,usr)
					usr.ReleaseYonbi(Controllable,0,4)


	LavaStream
		name="Lava Stream"
		icon_state="Yonbi"
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				if(src.Uses<100&&usr.Trait!="Speedy")
					if(prob(95-src.Uses))
						usr<<output("The jutsu failed.","Attack");return
				else if(usr.Trait=="Speedy"&&src.Uses<50)
					if(prob(50-src.Uses))
						usr<<output("The jutsu failed.","Attack");return
				src.DelayIt(600,usr,"Nin")
				src.Uses+=1
				usr.Lavastream()
	LavaRiver
		name="Lava River"
		icon_state="Yonbi"
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				if(src.Uses<100&&usr.Trait!="Speedy")
					if(prob(95-src.Uses))
						usr<<output("The jutsu failed.","Attack");return
				else if(usr.Trait=="Speedy"&&src.Uses<50)
					if(prob(50-src.Uses))
						usr<<output("The jutsu failed.","Attack");return
				src.DelayIt(600,usr,"Nin")
				src.Uses+=1
				usr.LavaRiver(src.Uses)
	VolcanicLavaStream
		name="Volcanic Lava Stream"
		icon_state="Yonbi"
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				if(src.Uses<100&&usr.Trait!="Speedy")
					if(prob(95-src.Uses))
						usr<<output("The jutsu failed.","Attack");return
				else if(usr.Trait=="Speedy"&&src.Uses<50)
					if(prob(50-src.Uses))
						usr<<output("The jutsu failed.","Attack");return
				src.DelayIt(600,usr,"Nin")
				src.Uses+=1
				usr.VolcanicLavaSprout()
	VolcanicLavaCreation
		name="LavaCreation"
		icon_state="Yonbi"
		Click()
			if(usr.resting||usr.meditating)
				usr<<"You can't do this, you're resting or in chakra generation mode."
				return
			if(usr.Dead||usr.FrozenBind=="Dead"||usr.DoingPalms)
				usr<<"Not now."
				return
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<output("You must wait to use this technique.","Attack");return
			else
				if(src.Uses<100&&usr.Trait!="Speedy")
					if(prob(95-src.Uses))
						usr<<output("The jutsu failed.","Attack");return
				else if(usr.Trait=="Speedy"&&src.Uses<50)
					if(prob(50-src.Uses))
						usr<<output("The jutsu failed.","Attack");return
				src.DelayIt(600,usr,"Nin")
				src.Uses+=1
				usr.VolcanicLavaCreation()
//Gobi
	Gobi
		name="Power State(Gobi)"
		icon_state="Gobi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='kyuubi.dmi'
					usr.overlays-='kyuubi1.dmi'
					usr.overlays-='kyuubi2.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseGobi(Controllable)
//Gobi2
	GobiType2
		name="One-Tailed(Gobi)"
		icon_state="Gobi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0.5)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='kyuubi.dmi'
					usr.overlays-='kyuubi1.dmi'
					usr.overlays-='kyuubi2.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseGobiType2(Controllable)
	GobiType21
		name="Two-Tailed(Gobi)"
		icon_state="Gobi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=1)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='kyuubi.dmi'
					usr.overlays-='kyuubi1.dmi'
					usr.overlays-='kyuubi2.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseGobiType21(Controllable)
//Rokubi
	Rokubi
		name="Power State(Rokubi)"
		icon_state="Rokubi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='kyuubi.dmi'
					usr.overlays-='Bijuu1.dmi'
					usr.overlays-='Bijuu1.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					if(src.Uses==550)
						usr.LearnedJutsus+=new /obj/SkillCards/Rokubi1
					src.Uses++
					usr.ReleaseRokubi(Controllable)
	Rokubi1
		name="One-Tailed(Rokubi)"
		icon_state="Rokubi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0.5)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='kyuubi.dmi'
					usr.overlays-='Bijuu1.dmi'
					usr.overlays-='Bijuu1.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseRokubi1(Controllable)

	Rokubi2
		name="Two-Tailed(Rokubi)"
		icon_state="Rokubi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=1)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='kyuubi.dmi'
					usr.overlays-='kyuubi1.dmi'
					usr.overlays-='kyuubi2.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseRokubi2(Controllable)
//Shichibi
	Shichibi
		name="Power State(Shichibi)"
		icon_state="Nanabi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='kyuubi.dmi'
					usr.overlays-='kyuubi1.dmi'
					usr.overlays-='kyuubi2.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseShichibi(Controllable)
//Shichibi
	Shichibi1
		name="One-Tailed(Shichibi)"
		icon_state="Nanabi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0.5)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='DemonAura0.dmi'
					usr.overlays-='kyuubi1.dmi'
					usr.overlays-='kyuubi2.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseShichibi1(Controllable)


//Nanabi
	Nanabi
		name="Power State(Nanabi)"
		icon_state="Nanabi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='kyuubi.dmi'
					usr.overlays-='kyuubi1.dmi'
					usr.overlays-='kyuubi2.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseNanabi(Controllable)
//NanabiType2
	NanabiType2
		name="One-Tailed(Nanabi)"
		icon_state="Nanabi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0.5)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='DemonAura0.dmi'
					usr.overlays-='kyuubi1.dmi'
					usr.overlays-='kyuubi2.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseNanabiType2(Controllable)
	FlameFest
		name="Flame Fest(Nanabi)"
		icon_state="Nanabi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState<=0.5)
					usr<<"You need to be in the tail form!";return
				src.Uses++
				src.Delay=1;spawn(60-usr.NinjutsuMastery)
					src.Delay=0
				src.overlays+='Skillcards2.dmi'
				spawn(650-usr.NinjutsuMastery)
					src.overlays-='Skillcards2.dmi'
				usr.NanabiFlameFest()

	Doragon
		name="Power State(Doragon)"
		icon_state="Hachibi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='kyuubi.dmi'
					usr.overlays-='kyuubi1.dmi'
					usr.overlays-='kyuubi2.dmi'
					usr.TailState=0
					src.DelayIt(600,usr,"Nin")
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=1
					src.Uses++
					usr.ReleaseDoragon(Controllable)



//Hachibi
	Hachibi
		name="Power State(Hachibi)"
		icon_state="Hachibi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='kyuubi.dmi'
					usr.overlays-='kyuubi1.dmi'
					usr.overlays-='kyuubi2.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseHachibi(Controllable)
//Hachibi
	HachibiType2
		name="One-Tailed(Hachibi)"
		icon_state="Hachibi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0.5)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='kyuubi.dmi'
					usr.overlays-='kyuubi1.dmi'
					usr.overlays-='kyuubi2.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseHachibiType2(Controllable)
//Hachibi
	HachibiType3
		name="Two-Tailed(Hachibi)"
		icon_state="Hachibi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=1)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='kyuubi.dmi'
					usr.overlays-='kyuubi1.dmi'
					usr.overlays-='kyuubi2.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseHachibiType3(Controllable)
//Kyuubi
	Kyuubi0
		name="Power State(Kyuubi)"
		icon_state="Kyuubi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='kyuubi.dmi'
					usr.overlays-='kyuubi1.dmi'
					usr.overlays-='kyuubi2.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseKyuubi0(Controllable)
	Kyuubi1
		name="One-Tailed(Kyuubi)"
		icon_state="Kyuubi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=0.5)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='kyuubi.dmi'
					usr.overlays-='kyuubi1.dmi'
					usr.overlays-='kyuubi2.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseKyuubi1(Controllable)
	Kyuubi2
		name="Two-Tailed(Kyuubi)"
		icon_state="Kyuubi"
		Click()
			if(usr.KBunshinOn)
				var/A=usr.controlled
				usr=A
			else
				usr=usr
			if(src.Delay>0)
				usr<<sound('Click2.wav');return
			else
				if(usr.Bijuu=="")
					del(src)
				if(usr.TailState!=1)
					usr<<"You release the chakra cloak from your body."
					usr.overlays-='kyuubi.dmi'
					usr.overlays-='kyuubi1.dmi'
					usr.overlays-='kyuubi2.dmi'
					usr.TailState=0
					src.Delay=1;spawn(60-usr.NinjutsuMastery)
						src.Delay=0
					src.overlays+='Skillcards2.dmi'
					spawn(650-usr.NinjutsuMastery)
						src.overlays-='Skillcards2.dmi'
					return
				else
					var/Controllable=0
					if(src.Uses>100)
						Controllable=1
					src.Uses++
					usr.ReleaseKyuubi2(Controllable)
	Kurama
		name="Call On Kurama!"
		icon_state="Kurama"
		Click()
			usr<<sound('Click2.wav');return
	EdoTensei
		name="Impure World Resurrection"
		icon_state="EdoSummon"
		Deactivate(mob/M)
			usr.EdoTensei()
			src.DelayIt(300,M,"Nin")
		Activate(mob/M)
			src.Uses+=1
			usr.EdoTensei()
	FushiTensei
		name="Living Corpse Reincarnation"
		icon_state="FushiTensei"
		Activate(mob/M)
			return
	//	Activate(mob/M)
	//		src.DelayIt(3000,M)
	//		src.Uses+=1
	//		M.UseFushi=1
	//		M<<"You prepare the seal for Fushi Tensei. Click on a target within 2 tiles of you to activate it!"

	HideIdentity
		name="Hide Identity"
		icon_state="Henge"
		Activate(mob/M)
			src.DelayIt(300,M)
			src.Uses+=1
			M.HideIdentity()

	DNATransfer
		name="DNA Implant"
		icon_state="Implant"
		Activate(mob/M)
			src.DelayIt(300,M)
			src.Uses+=1
			M.ImplantDNA()




////////////////////////////////////////////////////////
mob/proc/SharinganCopy(Type,Uses)
	if(src.client)
		var/A = new Type
		if(A)
			if(!(locate(Type) in src.LearnedJutsus))
				src.LearnedJutsus+=A
				A:NonKeepable=1
				A:Copied=1
				A:Uses=Uses
				src<<"You have copied [A:name]!"
				src.CopyMode=0
////////////////////////////////////////////////////
//RosePetal Proc

mob/var/list/Petallist=new
mob/var/tmp/LegendaryPetals=0
mob/proc
	SummonPetals()
		if(src.LegendaryPetals==2)
			usr<<"You are already using Rose Petal Blade for something else!"
			return
		if(src.LegendaryPetals)
			usr.LegendaryPetals=0
			usr<<"You return the petals back into your sword!"
			usr.firing=0
			usr.controlled=null
			usr.client.perspective=MOB_PERSPECTIVE
			usr.client.eye=usr
			for(var/mob/RoseBlade/petals/P in world) if(P.Owner == usr) del(P)
		else
			var/mob/RoseBlade/petals/A=new()
			A.loc=src.loc
			A.Owner=src
			src.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
			src.client.eye=A
			src.chakra-=500
			src.controlled=A
			src.icon_state="Guard"
			src.firing=1
			src<<"You release a torrent of Rose Petals from your sword!"
			src.LegendaryPetals=1
			while(src.LegendaryPetals)
				src.chakra-=50
				sleep(50)



/////////////////////////////////////////////////////////
//Petal Objects

mob/RoseBlade/petals
	icon = 'Zanpakutou.dmi'
	icon_state = "Petals"
	density = 1
	health=10000000000000000000000000000
	//Running=1
	var
		Hit=0
	Move()
		var/obj/Jutsu/RoseBlade/Mpetal/L=new()
		L.loc = src.loc
		L.Owner = src.Owner
		..()
	Bump(A)
		if(ismob(A))
			var/mob/O = src.Owner
			var/mob/M = A
			if(M.Kaiten||M.sphere)
				return
			if(!src.Hit)
				src.Hit=1
				spawn(5)
					src.Hit=0
				var/damage=rand(125,500)
				M.DamageProc(damage,"Health",O)
				spawn()
					M.Bloody();M.Bloody();M.Bloody();M.Bloody();M.Bloody()
		if(istype(A,/turf/))
			var/turf/T = A
			if(T.density)
				return 0
		if(istype(A,/obj/Jutsu/RoseBlade/Mpetal/))
			var/obj/Jutsu/RoseBlade/Mpetal/B = A
			src.loc=B.loc
		if(istype(A,/obj/))
			return 0

obj/Jutsu
	RoseBlade/Mpetal
		icon='Zanpakutou.dmi'
		icon_state="Petals"
		density=1
		pixel_step_size=16
		New()
			..()
			spawn(60)
				del(src)

