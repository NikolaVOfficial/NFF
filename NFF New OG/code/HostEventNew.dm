var/list/BossGroup
var/list/OriginalBossGroup
var/list/EventBosses
var/BossEventOn
var/BossEventReward
var/BossEventRewardNinjaCash
var/BossEventJoin
mob/GainedAfterLogIn/verb/JoinBossEvent()
	set name = "Take Down Boss"
	set category = "Events"
	var/Kills = usr.kills
	//var/Deaths = usr.deaths
	//var/Req = Kills - Deaths
	if(usr.AgeTenImmunity)
		usr<<"Not with your age ten immunity."
		del Kills
		return
	if(!JoinBossEvent)
		usr<<"You are not able to join this event currently."
		del Kills
		return
	if(Kills<1)
		usr<<"You need at least 1 kill to join this event."
		del Kills
		return
//	if(Req<1)
//		usr<<"You need at least 1 class level to join this event."
//		return
	if(BossGroup.len>20)
		usr<<"There's too many people dispatched to take down the Ninja."
		del Kills
		return
	if(BossEventOn == 1 && BossEventJoin == 1)
		if(usr in BossGroup)
			usr<<"You have already joined the dispatch group!"
			del Kills
			return
		else
			world<<"<b><font size=1 color=green>[usr] has joined the squad!</font></b>"
			usr<<"You have joined the dispatch group."
			for(var/mob/M in BossGroup)
				M<<"[usr] has also joined the dispatched squad"
			if(usr.Doubleninjacashscroll)
				usr.Doubleninjacashtime--
				usr<<"Your Double Ninja Cash scroll will work for [usr.Doubleninjacashtime] more events"
				if(usr.Doubleninjacashtime<=0)
					usr.Doubleninjacashtime=0
					usr.Doubleninjacashscroll=0
				usr.SaveK()
			OriginalBossGroup.Add(usr)
			BossGroup.Add(usr)
			if(!(usr in contestants))
				contestants+=usr
			del Kills
			return
	else
		del Kills
		usr<<"You can't join a dispatched squad now....."
		return
mob/GainedAfterLogIn/verb/WhoIsInSquad()
	set name = "Boss Contestants"
	set category = "Events"
	if(BossEventOn)
		for(var/mob/A in BossGroup)
			usr<<"[A] Rank: [A.blevel]"
	else
		usr<<"There is no Boss located."
mob/owner/verb/TestBossEvent()
	set name = "Host Boss Event"
	spawn()
		AutomateBoss()
var/JoinBossEvent
proc/AutomateBoss()

	BossGroup = null
	OriginalBossGroup = null
	EventBosses = null
	EventBosses = list()
	BossGroup = list()
	OriginalBossGroup = list()
	JoinBossEvent=1
	BossEventJoin=1
	if(BossEventOn >= 1)
	//	usr<<"There is already a FFA in progress."
		return
	OnlinePlayers<<"<b><font size=2 color=blue>A legendary ninja from the past has been located in a forgotten temple!</font></b>"
	BossEventOn=1
	OnlinePlayers<<"<b><font size=2 color=blue>Press the Take Down Boss verb located in the events tab to join the squad and take him down!</font></b>"
//	sleep(600)
//	world<<"<b><font size=2 color=blue>The FFA will start in 2 minutes!</font></b>"
	sleep(600)
	world<<"<b><font size=2 color=blue>The squad will be dispatched in another minute!</font></b>"
	sleep(600)
	OnlinePlayers<<"<b><font size=3 color=red>The squad has started their dispatch!"
//	global.AutoFreeForAllCount = 2
	OnlinePlayers<<"<b><font size=2 color=blue>There are [length(BossGroup)] fighters that will take on the ninja.</font></b>"
	JoinBossEvent=0
	BossEventJoin=0
	BossEventReward=0
	BossEventRewardNinjaCash=0
	BossEventReward = length(BossGroup) * 7500
	BossEventRewardNinjaCash = 20 + (length(BossGroup)*5)//(length(BossGroup) * (10)) + 20
	OnlinePlayers<<"<b><font size=2 color=green>Everyone joining this event that helped to defeat this ninja will gain rewards. The final reward for defeating him is [BossEventReward] ryo, and [BossEventRewardNinjaCash] ninja cash!</font></b>"
//	if(length(AutoFreeForAll) > 10)
//		world<<"<b><font size=2 color=red>An additional reward of 150000 Ryo will be awarded for this FFA due to the amount of participants!</font></b>"
//		global.AutoFreeForAllRewardBonus = 1
	for(var/mob/NPC/BossEvent/A in world)
		del(A)
	for(var/mob/NPC/BossEvent2/B in world)
		del(B)

	var/mob/NPC/BossEvent2/P = new()//was BossEvent but I need to make it work somehow...
//	P.deathcount=7

	EventBosses+=P
	P.loc=locate(112,102,54)
	var/mob/NPC/BossEvent2/PP = new()
	EventBosses+=PP
	PP.loc=locate(110,102,54)
	var/mob/NPC/BossEvent2/PPP = new()
	EventBosses+=PPP
	PPP.loc=locate(114,102,54)
	var/mob/NPC/BossEvent2/PPPP = new()
	EventBosses+=PPPP
	PPPP.loc=locate(116,102,54)
	var/mob/NPC/BossEvent2/PPPPP = new()
	EventBosses+=PPPPP
	PPPPP.loc=locate(108,102,54)
	var/mob/NPC/BossEvent2/AAA = new()
	EventBosses+=AAA
	AAA.loc=locate(106,102,54)
	var/mob/NPC/BossEvent2/AAAE = new()
	EventBosses+=AAAE
	AAAE.loc=locate(104,102,54)
	var/mob/NPC/BossEvent2/AA = new()
	EventBosses+=AA
	AA.loc=locate(118,102,54)
	var/mob/NPC/BossEvent2/AAAA = new()
	EventBosses+=AAAA
	AAAA.loc=locate(120,102,54)
	for(var/mob/A in BossGroup)
		A.loc = locate(112,82, 54)
		A.deathcount=0
		A.NinjaCash+=4
		if(A.Doubleninjacashscroll)
			A.NinjaCash+=4
		A.health=A.maxhealth
		A.chakra=A.Mchakra
		A.stamina=A.maxstamina
		A.ChakraPool=A.MaxChakraPool
//		contestants+=A
	BossAutoRun()
	while(BossGroup.len>=0)
		BossAutoRun()
		sleep(100)
mob/owner/verb/CheckBossList()
	set category="Events"
	usr<<"There are [BossGroup.len] people in the dispatched squad."
	for(var/i=0;BossGroup.len;i++)
		var/p=BossGroup[i]
		usr<<"[p]"

proc/BossAutoRun()
	if(length(EventBosses)==0)
		OnlinePlayers<<"The Boss and his Henchman have been defeated!"
		for(var/mob/E in BossGroup)
			BossGroup.Remove(E)
		for(var/mob/A in OriginalBossGroup)
			spawn()
				OnlinePlayers<<"[A] was warped out of the event, there are [OriginalBossGroup.len] people left to be warped out"

				A.Yen+=BossEventReward
			//	if(global.AutoFreeForAllRewardBonus ==1)
			//		A.Yen+=150000
			//		world<<"[A] was given the Bonus 150000 prize!"
				A.NinjaCash+=BossEventRewardNinjaCash
				if(A.Doubleninjacashscroll)
					A.NinjaCash+=BossEventRewardNinjaCash

				BossEventOn=0
				contestants-=A
				if(A in BossGroup)
					BossGroup.Remove(A)
				OriginalBossGroup.Remove(A)
				del(BossGroup)
				del(OriginalBossGroup)
			//	OriginalBossGroup = null
				A.GotoVillageHospital()
		//	spawn(6000)
		spawn(36000)
			del(OriginalBossGroup)
		//	BossEventRewardNinjaCash=0
			var/Choose=rand(1,5)
			if(Choose==1)
				AutomateFFA()
			else if(Choose==2)
				AutomateBoss()
			else if(Choose==3)
				StartAutoTournament()
			else if(Choose==4)
				del CTS
				CTS = new
				CTS.StartCTS()
			else
				del TDM
				TDM = new
				TDM.StartTDM()
	else if(length(BossGroup)==0)
		world<<"No one was able to defeat the Boss and his Henchman..."
		global.AutoFreeForAllNinjaCashReward = 0
		del(BossGroup)
		del(EventBosses)
		del(OriginalBossGroup)
		//BossGroup = null
	//	EventBosses=null
		BossEventOn=0
//		OriginalBossGroup = null
		for(var/mob/NPC/BossEvent/A in world)
			del(A)
		for(var/mob/NPC/BossEvent2/B in world)
			del(B)

		spawn(36000)
			var/Choose=rand(1,5)
			if(Choose==1)
				AutomateFFA()
			else if(Choose==2)
				AutomateBoss()
			else if(Choose==3)
				StartAutoTournament()
			else if(Choose==4)
				del CTS
				CTS = new
				CTS.StartCTS()
			else
				del TDM
				TDM = new
				TDM.StartTDM()