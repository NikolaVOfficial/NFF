var/global.AutoFreeForAllReward = 0
var/global.AutoFreeForAllCount = 0
var/tmp/list/AutoFreeForAll
var/global.AutoFreeForAllRewardBonus = 0
mob/var/tmp/FFAAttempt=0
mob/Staff/verb/StartFFA()
	set name = "Start Free For All"
	set category = "Staff"
	spawn()
		AutomateFFA()
	/*
	AutoFreeForAll = null
	AutoFreeForAll = list()
//	return
	if(global.AutoFreeForAllCount >= 1)
		usr<<"There is already a FFA in progress."
		return
	world<<"<b><font size=2 color=blue>[usr] has started a FFA you are able to join!</font></b>"
	global.AutoFreeForAllCount = 1
	world<<"<b><font size=2 color=blue>Press the Join FFA verb located in the events tab to join the FFA!</font></b>"
//	sleep(600)
//	world<<"<b><font size=2 color=blue>The FFA will start in 2 minutes!</font></b>"
	sleep(600)
	world<<"<b><font size=2 color=blue>The FFA will start in another minute!</font></b>"
	sleep(600)
	world<<"<b><font size=3 color=red>The FFA has started!"
	global.AutoFreeForAllCount = 2
	world<<"<b><font size=2 color=blue>There are [length(AutoFreeForAll)] fighters in the FFA.</font></b>"
	global.AutoFreeForAllRewardBonus = 0
	global.AutoFreeForAllReward = 0
	global.AutoFreeForAllReward = length(AutoFreeForAll) * 7500
	global.AutoFreeForAllNinjaCashReward= (length(AutoFreeForAll) * (2.5))
	world<<"<b><font size=2 color=green>Small Ninja cash and Ryo rewards are received upon every enemy knockout. The final reward for this tournament is [global.AutoFreeForAllReward] ryo, and [global.AutoFreeForAllNinjaCashReward] ninja cash!</font></b>"
//	if(length(AutoFreeForAll) > 10)
//		world<<"<b><font size=2 color=red>An additional reward of 150000 Ryo will be awarded for this FFA due to the amount of participants!</font></b>"
//		global.AutoFreeForAllRewardBonus = 1

	for(var/mob/A in AutoFreeForAll)
		A.loc = locate(rand(110,135),rand(165,175), 21)
		A.deathcount=0
		A.health=A.maxhealth
		A.chakra=A.Mchakra
		A.stamina=A.maxstamina
		A.ChakraPool=A.MaxChakraPool
//		contestants+=A
//	return
	while(AutoFreeForAll.len>0)
		FFAAutoRun()
		sleep(100)
		*/
mob/GainedAfterLogIn/verb/JoinFreeForFall()
	set name = "Join Free For All"
	set category = "Events"
	var/Kills = usr.kills
	//var/Deaths = usr.deaths
	//var/Req = Kills - Deaths
	if(usr.AgeTenImmunity)
		usr<<"Not with your age ten immunity."
		return
	if(Kills<1)
		usr<<"You need at least 1 kill to join this event."
		return
//	if(Req<1)
//		usr<<"You need at least 1 class level to join this event."
//		return
	if(AutoFreeForAll.len>40)
		usr<<"There's too many people in the FFA."
		return
	if(global.AutoFreeForAllCount == 1)
		if(usr in AutoFreeForAll)
			usr<<"You have already joined the FFA!"
			return
		else
			world<<"<b><font size=1 color=green>[usr] has joined the FFA!</font></b>"
			usr<<"You have joined the FFA."
			for(var/mob/M in AutoFreeForAll)
				M<<"[usr] has also joined the FFA"
			usr.FFAAttempt=0
			if(usr.Doubleninjacashscroll)
				usr.Doubleninjacashtime--
				usr<<"Your Double Ninja Cash scroll will work for [usr.Doubleninjacashtime] more events"
				if(usr.Doubleninjacashtime<=0)
					usr.Doubleninjacashtime=0
					usr.Doubleninjacashscroll=0
				usr.SaveK()
			AutoFreeForAll.Add(usr)
			if(!(usr in contestants))
				contestants+=usr
			return
	else
		usr<<"You can't join a tournament now....."
		return
mob/GainedAfterLogIn/verb/WhoIsInFFA()
	set name = "FFA Contestants"
	set category = "Events"
	if(global.AutoFreeForAllCount == 2||global.AutoFreeForAllCount == 1)
		for(var/mob/A in AutoFreeForAll)
			usr<<"[A] Rank: [A.blevel]"
	else
		usr<<"There is no FFA in current progress."

proc/AutomateFFA()
	AutoFreeForAll = null
	AutoFreeForAll = list()
	if(global.AutoFreeForAllCount >= 1)
	//	usr<<"There is already a FFA in progress."
		return
	world<<"<b><font size=2 color=blue>The automatic Free For All event is now being hosted!</font></b>"
	global.AutoFreeForAllCount = 1
	world<<"<b><font size=2 color=blue>Press the Join Free For All verb located in the events tab to join the Free For All!</font></b>"
//	sleep(600)
//	world<<"<b><font size=2 color=blue>The FFA will start in 2 minutes!</font></b>"
	sleep(600)
	world<<"<b><font size=2 color=blue>The Free For All will start in another minute!</font></b>"
	sleep(600)
	world<<"<b><font size=3 color=red>The Free For All has started!"
	global.AutoFreeForAllCount = 2
	world<<"<b><font size=2 color=blue>There are [length(AutoFreeForAll)] fighters in the Free For All.</font></b>"
	global.AutoFreeForAllRewardBonus = 0
	global.AutoFreeForAllReward = 0
	global.AutoFreeForAllReward = length(AutoFreeForAll) * 7500
	global.AutoFreeForAllNinjaCashReward= (length(AutoFreeForAll) * (10)) + 40
	world<<"<b><font size=2 color=green>Small Ninja cash and Ryo rewards are received upon every enemy knockout. The final reward for this Free For All is [global.AutoFreeForAllReward] ryo, and [global.AutoFreeForAllNinjaCashReward] ninja cash!</font></b>"
//	if(length(AutoFreeForAll) > 10)
//		world<<"<b><font size=2 color=red>An additional reward of 150000 Ryo will be awarded for this FFA due to the amount of participants!</font></b>"
//		global.AutoFreeForAllRewardBonus = 1
	if(AutoFreeForAll.len>25)
		for(var/mob/A in AutoFreeForAll)
			A.loc = locate(rand(110,135),rand(165,175), 21)
			A.deathcount=0
			A.NinjaCash+=4
			if(A.Doubleninjacashscroll)
				A.NinjaCash+=4
			A.health=A.maxhealth
			A.chakra=A.Mchakra
			A.stamina=A.maxstamina
			A.ChakraPool=A.MaxChakraPool
	//		contestants+=A
//	return
	if(AutoFreeForAll.len<=10)
		for(var/mob/A in AutoFreeForAll)
			A.loc = locate(rand(130,151),rand(155,163), 49)
			A.deathcount=0
			A.health=A.maxhealth
			A.chakra=A.Mchakra
			A.NinjaCash+=4
			if(A.Doubleninjacashscroll)
				A.NinjaCash+=4
			A.stamina=A.maxstamina
			A.ChakraPool=A.MaxChakraPool
	if(AutoFreeForAll.len>=11&&AutoFreeForAll.len<=25)
		for(var/mob/A in AutoFreeForAll)
			A.loc = locate(rand(35,52),rand(28,55), 49)
			A.deathcount=0
			A.health=A.maxhealth
			A.chakra=A.Mchakra
			A.stamina=A.maxstamina
			A.NinjaCash+=4
			if(A.Doubleninjacashscroll)
				A.NinjaCash+=4
			A.ChakraPool=A.MaxChakraPool
	FFAAutoRun()
	while(AutoFreeForAll.len>0)
		FFAAutoRun()
		sleep(100)
mob/owner/verb/CheckFFAList()
	set category="Events"
	usr<<"There are [AutoFreeForAll.len] people in the Free For All."
	for(var/i=0;AutoFreeForAll.len;i++)
		var/p=AutoFreeForAll[i]
		usr<<"[p]"

proc/FFAAutoRun()
	if(length(AutoFreeForAll)==1)
		for(var/mob/A in AutoFreeForAll)
			world<<"[A] has won the Free For All."
			A.Yen+=global.AutoFreeForAllReward
		//	if(global.AutoFreeForAllRewardBonus ==1)
		//		A.Yen+=150000
		//		world<<"[A] was given the Bonus 150000 prize!"
			A.NinjaCash+=global.AutoFreeForAllNinjaCashReward
			if(A.Doubleninjacashscroll)
				A.NinjaCash+=global.AutoFreeForAllNinjaCashReward
			global.AutoFreeForAllNinjaCashReward = 0
			global.AutoFreeForAllCount = 0
			contestants-=A
			AutoFreeForAll.Remove(A)
			AutoFreeForAll = null
			A.GotoVillageHospital()
		//	spawn(6000)
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
	else if(length(AutoFreeForAll)==0)
		world<<"No one won the Free For All."
		global.AutoFreeForAllNinjaCashReward = 0
		AutoFreeForAll = null
		global.AutoFreeForAllCount=0

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
