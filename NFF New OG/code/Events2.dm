//Hell, Place Auto Events, or anything you can think of that can add more fun things to the game, Quests, Idc lol.
//var/list/TeamRedTDM
//var/list/TeamBlueTDM
//var/list/ParticipatorsInTDM
//var/list/TDMDLevel
//var/list/TDMCLevel
//var/list/TDMBLevel
//var/list/TDMALevel
//var/list/TDMSLevel
//var/list/OutCast
//var/TotalPlayersTDM
//mob/var/tmp/JoinedTDM = 0
//mob/var/tmp/WaitingtoTDM = 0
mob/var/DBLexpscroll=0
mob/var/DBLexptime=0
mob/var/Ageexptime=0
mob/var/Ageexpscroll=0
mob/var/Jutsumasteryscroll=0
mob/var/Jutsumasteryscrolltime=0
mob/var/tmp/AutoTourneyCD=0
mob/var/Doubleninjacashtime=0
mob/var/Doubleninjacashscroll=0
var/TDMHosted
var/CurrentEvent=""
/*
mob/owner/verb/HostTDM()//Should Also make it an Auto World/proc so it can be automated ;o
	set name="Host Team Death Match"
	set category="Staff"
	if(CurrentEvent!="")
		usr<<"You need to wait for the current event [CurrentEvent] to finish up before you can use this!";return
	CurrentEvent="Team Death Match"
	for(var/mob/M in OnlinePlayers)
		M.verbs += new/mob/Events/verb/JoinTDM()
	world<<"<font color = #D7DF01 size = 2>A Team DeathMatch is being hosted! Press the Join Team Death Match verb inside your Commands Tab to join!</font>"
	spawn(600)
		for(var/mob/A in ParticipatorsInTDM)
			A.health=A.maxhealth;
			A.stamina=A.maxstamina;
			A.deathcount=0
			A.ChakraPool=A.MaxChakraPool
			A.chakra=A.Mchakra;
			A.resting=0
			A<<"The Team Death Match will Start Soon."
	//	spawn(60)
		for(var/mob/C in OnlinePlayers)
			C.verbs -= new/mob/Events/verb/JoinTDM()
		SetTDM() //World Proc
mob/owner/verb/CheckTDMStuff()
	set name="Check Team Death Match Stuff"
	set category="Staff"
	usr<<"[ParticipatorsInTDM.len] are the amount of people in Team Death match."
	usr<<"[TDMDLevel.len] are D Rank."
	usr<<"[TDMCLevel.len] are C Rank."
	usr<<"[TDMBLevel.len] are B Rank."
	usr<<"[TDMALevel.len] are A Rank."
	usr<<"[TDMSLevel.len] are S Rank."
	usr<<"[TotalPlayersTDM] have been set into a proper Rank List"
	return
	*/
	/*
proc/HostingTDM()//Should Also make it an Auto World/proc so it can be automated ;o
//	set name="Host Team Death Match"
//	set category="Staff"
///	if(CurrentEvent!="")
	//	usr<<"You need to wait for the current event [CurrentEvent] to finish up before you can use this!";return
	CurrentEvent="Team Death Match"
	for(var/mob/M in OnlinePlayers)
		M.verbs += new/mob/Events/verb/JoinTDM()
	world<<"<font color = #D7DF01 size = 2>A Team DeathMatch is being hosted! Press the Join Team Death Match verb inside your Commands Tab to join!</font>"
	spawn(600)
		for(var/mob/A in ParticipatorsInTDM)
			A.health=A.maxhealth;
			A.stamina=A.maxstamina;
			A.deathcount=0
			A.ChakraPool=A.MaxChakraPool
			A.chakra=A.Mchakra;
			A.resting=0
			A<<"The Team Death Match will Start Soon."
	//	spawn(60)
		for(var/mob/C in OnlinePlayers)
			C.verbs -= new/mob/Events/verb/JoinTDM()
		SetTDM() //World Proc

*/




/*
mob/Events/verb/JoinTDM()
	set name="Join Team Death match"
	set category="Commands"
	if(usr.Frozen||usr.firing||usr.Mogu||usr.Dead||usr.knockedout)
		return
	if(usr.resting)
		usr<<"Unrest.";return
	if(ParticipatorsInTDM.len>=20)
		usr<<"The Team Death Match is full.";
		usr.verbs-=new/mob/Events/verb/JoinTDM()
		return
	if(usr in ParticipatorsInTDM)
		usr<<"You're already in the Event!";
		usr.verbs-=new/mob/Events/verb/JoinTDM();
		return
	usr<<"The Team Death Match will begin shortly! Sit Tight!"
	world<<"<TT><font color=blue>[usr] has joined the Team Death Match!</font></TT>"
	ParticipatorsInTDM+=usr









proc/SetTDM()//Places the people who chose to join in Groups according to their ranks for balancing purposes
	for(var/mob/M in ParticipatorsInTDM)
		if(M.blevel=="D")
			ParticipatorsInTDM-=M
			TDMDLevel+=M;

		if(M.blevel=="C")
			ParticipatorsInTDM-=M
			TDMCLevel+=M;
		//	ParticipatorsInTDM-=M
		if(M.blevel=="B")
			ParticipatorsInTDM-=M
			TDMBLevel+=M;
		//	ParticipatorsInTDM-=M
		if(M.blevel=="A")
			ParticipatorsInTDM-=M
			TDMALevel+=M;
		//	ParticipatorsInTDM-=M
		if(M.blevel=="S")
			ParticipatorsInTDM-=M
			TDMSLevel+=M;
		//	ParticipatorsInTDM-=M
	world<<"Setting up Teams..."
	spawn(30)
		SetTDMTeams()




proc/SetTDMTeams()
	var/list/SettingUpTDM=list()
	var/list/OutCastD=list()
	var/list/OutCastC=list()
	var/list/OutCastB=list()
	var/list/OutCastA=list()
	var/list/OutCastS=list()
	var/Number
	//var/NumberPerTeam
	var/mob/Out
	if(TDMDLevel%2==0)//==1)//==1)
		Out=null
		Out=pick(TDMDLevel)
		OutCastD+=Out
		TDMDLevel-=Out
		TotalPlayersTDM++
		world<<"For Balance Reasons, [Out] was placed into the Waiting Roster for D Rank Ninja. The remaining people in the D list are [TDMDLevel.len]"
	if(TDMCLevel%2==0)
		Out=null
		Out=pick(TDMCLevel)
		OutCastC+=Out
		TDMCLevel-=Out
		TotalPlayersTDM++
		world<<"For Balance Reasons, [Out] was placed into the Waiting Roster for C Rank Ninja. [TDMCLevel.len]"
	if(TDMBLevel%2==0)
		Out=null
		Out=pick(TDMBLevel)
		OutCastB+=Out
		TDMBLevel-=Out
		TotalPlayersTDM++
		world<<"For Balance Reasons, [Out] was placed into the Waiting Roster for B Rank Ninja. [TDMBLevel.len]"
	if(TDMALevel%2==0)
		Out=null
		Out=pick(TDMALevel)
		OutCastA+=Out
		TDMALevel-=Out
		TotalPlayersTDM++
		world<<"For Balance Reasons, [Out] was placed into the Waiting Roster for A Rank Ninja. [TDMALevel.len]"
	if(TDMSLevel%2==0)
		Out=null
		Out=pick(TDMSLevel)
		OutCastS+=Out
		TDMSLevel-=Out
		TotalPlayersTDM++
		world<<"For Balance Reasons, [Out] was placed into the Waiting Roster for S Rank Ninja. [TDMSLevel.len]"
	var/DPerTeam//=TDMDLevel.len/2
	var/CPerTeam//=TDMCLevel.len/2
	var/BPerTeam//=TDMBLevel.len/2
	var/APerTeam//=TDMALevel.len/2
	var/SPerTeam//=TDMSLevel.len/2
	DPerTeam=(TDMDLevel.len/2)
	CPerTeam=(TDMCLevel.len/2)
	BPerTeam=(TDMBLevel.len/2)
	APerTeam=(TDMALevel.len/2)
	SPerTeam=(TDMSLevel.len/2)
	for(var/mob/M in OnlinePlayers)
		if(M in TDMDLevel)
			TotalPlayersTDM++
			SettingUpTDM+=M
		if(M in TDMCLevel)
			TotalPlayersTDM++
			SettingUpTDM+=M
		if(M in TDMBLevel)
			TotalPlayersTDM++
			SettingUpTDM+=M
		if(M in TDMALevel)
			TotalPlayersTDM++
			SettingUpTDM+=M
		if(M in TDMSLevel)
			TotalPlayersTDM++
			SettingUpTDM+=M
	world<<"[DPerTeam] D Ranked Ninjas per team."
	sleep(15)
	world<<"[CPerTeam] C Ranked Ninjas per team"
	sleep(15)
	world<<"[BPerTeam] B Ranked Ninjas per team"
	sleep(15)
	world<<"[APerTeam] A Ranked Ninjas per team"
	sleep(15)
	world<<"[SPerTeam] S Ranked Ninjas per team"
	world<<"Total Number of Players in this Team Death Match are [TotalPlayersTDM]"//[SettingUpTDM.len]."
//	if(OutCast.len!=null)
	OutCast+=(OutCastD+OutCastC+OutCastB+OutCastA+OutCastS)
	world<<"Current Value of those awaiting a team for balance purposes: [OutCast.len]."
	Number=(DPerTeam+CPerTeam+BPerTeam+APerTeam+SPerTeam)
	world<<"There will be [Number] Members per each side!"
	for(var/i=0;i<=(Number-1);i++)
		for(var/p=0;p<=DPerTeam;p++)
			var/mob/A
			A=pick(TDMDLevel)
			TDMDLevel-=A
			TeamRedTDM+=A
			p++
		for(var/q=0;q<=CPerTeam;q++)
			var/mob/B
			B=pick(TDMCLevel)
			TDMCLevel-=B
			TeamRedTDM+=B
			q++
		for(var/r=0;r<=BPerTeam;r++)
			var/mob/C
			C=pick(TDMBLevel)
			TDMBLevel-=C
			TeamRedTDM+=C
			r++
		for(var/s=0;s<=APerTeam;s++)
			var/mob/D
			D=pick(TDMALevel)
			TDMALevel-=D
			TeamRedTDM+=D
			s++
		for(var/t=0;t<=SPerTeam;t++)
			var/mob/E
			E=pick(TDMSLevel)
			TDMSLevel-=E
			TeamRedTDM+=E
			t++
		i++
	for(var/u=0;u<=(Number-1);u++)
		for(var/p=0;p<=DPerTeam;p++)
			var/mob/AA
			AA=pick(TDMDLevel)
			TDMDLevel-=AA
			TeamBlueTDM+=AA
			p++
		for(var/q=0;q<=CPerTeam;q++)
			var/mob/BB
			BB=pick(TDMCLevel)
			TDMCLevel-=BB
			TeamBlueTDM+=BB
			q++
		for(var/r=0;r<=BPerTeam;r++)
			var/mob/CC
			CC=pick(TDMBLevel)
			TDMBLevel-=CC
			TeamBlueTDM+=CC
			r++
		for(var/s=0;s<=APerTeam;s++)
			var/mob/DD
			DD=pick(TDMALevel)
			TDMALevel-=DD
			TeamBlueTDM+=DD
			s++
		for(var/t=0;t<=SPerTeam;t++)
			var/mob/EE
			EE=pick(TDMSLevel)
			TDMSLevel-=EE
			TeamBlueTDM+=EE
			t++
		u++
	world<<"Current amount of people on Red Team: [TeamRedTDM.len]."
	world<<"Current amount of people on Blue Team: [TeamBlueTDM.len]."
	*/
var/global/AutoFreeForAllNinjaCashReward
var/global/BossEventNinjaCashReward
world/proc/StartFFA()
	if(global.AutoFreeForAllCount >= 1)
	//	usr<<"There is already a FFA in progress."
		return
	world<<"<b><font size=2 color=blue>A FFA is able to be joined!</font></b>"
	global.AutoFreeForAllCount = 1
	world<<"<b><font size=2 color=blue>Press the Join FFA verb located in the challenge tab to join the FFA!</font></b>"
	sleep(600)
	world<<"<b><font size=2 color=blue>The FFA will start in 2 minutes!</font></b>"
	sleep(600)
	world<<"<b><font size=2 color=blue>The FFA will start in another minute!</font></b>"
	sleep(600)
	world<<"<b><font size=3 color=red>The FFA has started!"
	world<<"<b><font size=2 color=blue>There are [length(AutoFreeForAll)] fighters in the FFA.</font></b>"
	global.AutoFreeForAllCount = 2
	global.AutoFreeForAllRewardBonus = 0
	global.AutoFreeForAllReward = 0
	global.AutoFreeForAllReward = length(AutoFreeForAll) * 7500
	global.AutoFreeForAllNinjaCashReward=(length(AutoFreeForAll) * (10)) + 40
	world<<"<b><font size=2 color=green>The reward for this tournament is [global.AutoFreeForAllReward] ryo and [global.AutoFreeForAllNinjaCashReward] ninja cash!.</font></b>"
//	if(length(AutoFreeForAll) > 10)
//		world<<"<b><font size=2 color=red>An additional reward of 150000 Ryo will be awarded for this FFA due to the amount of participants!</font></b>"
//		global.AutoFreeForAllRewardBonus = 1

	for(var/mob/A in AutoFreeForAll)
		A.loc = locate(rand(120,135),rand(170,171), 21)
		A.deathcount=0
		A.health=A.maxhealth
		A.chakra=A.Mchakra
		A.stamina=A.maxstamina
		A.ChakraPool=A.MaxChakraPool
		A.resting=0
		contestants+=A
	return
//////////////////////////////////////////////////////

//Assassin Mode :D!!

//////////////////////////////////

mob/owner/verb/HostAssassin()
	set name="Host Assasssin Event"
	set category="Commands"
	if(CurrentEvent!="")
		usr<<"Wait for the current event to end!";return
	for(var/mob/M in OnlinePlayers)
		M.verbs+=new/mob/Events/verb/JoinAssassin()
	world<<"<font size=2 color=blue> A Dangerous assassin has been located on the outskirts of a forest...Press the Hunt Down Assassin verb located in your commands tab to confront this Assassin!</font>"
	sleep(300)
	for(var/mob/C in OnlinePlayers)
		C.verbs-=new/mob/Events/verb/JoinAssassin()
	world.setAssassinEvent()

var/list/InAssassinEvent=list()
var/list/AssassinVictims=list()

mob/Events/verb/JoinAssassin()
	set name="Hunt Down Assassin"
	set category="Commands"
	if(usr.Frozen||usr.firing||usr.Mogu||usr.Dead||usr.knockedout)
		return
	if(usr.resting)
		usr<<"Unrest.";return
	if(InAssassinEvent.len>=20)
		usr<<"The max amount of Ninja have already been dispatched to hunt down the assassin!";usr.verbs-=new/mob/Events/verb/JoinAssassin()
		return
	if(usr in InAssassinEvent)
		usr<<"You're already in the Event!";usr.verbs-=new/mob/Events/verb/JoinAssassin();return
	InAssassinEvent+=usr
	usr<<"The Dispatch will begin shortly! Sit Tight!"
	world<<"<font color=blue>[usr] will be dispatched to hunt down the Assassin!</font>"

mob/var/tmp/TheAssassin=0

world/proc/setAssassinEvent()
	for(var/mob/M in InAssassinEvent)
		M.health=M.maxhealth
		M.stamina=M.maxstamina
		M.chakra=M.Mchakra
		M.deathcount=0
		M.ChakraPool=M.MaxChakraPool
		M.resting=0
		M<<"<font color=green>Get ready to head to the forest..</font>"
	sleep(150)
	for(var/mob/L in InAssassinEvent)
		spawn()
			L.FadeScreen()
			L.loc=locate(rand(86,174),rand(152,164),21)
	world.startAssassinEvent()

var/list/Assassin = list()
mob/var/tmp/CantAlert=0
var/PrizeForAssassin
var/PrizeForNinja
world/proc/startAssassinEvent()
	var/mob/Assassin2=""
	AssassinVictims=list("")

	for(var/mob/A in InAssassinEvent)
		Assassin2=pick(InAssassinEvent)
		Assassin+=Assassin2
		InAssassinEvent-=Assassin2
		break
	for(var/mob/L in Assassin)
		L<<"<font color=red> You are the Assassin..Your power has been Increased, along with your Willpower, and your increase in blood lust allows you to kill people within one knock out...Kill everyone in here and be the last one standing!</font>"
		L.TheAssassin=1
		L.CantAlert=1

	if(InAssassinEvent.len>=15)
		PrizeForAssassin="1 Elemental Points"
		PrizeForNinja="500k Yen"
	if(InAssassinEvent.len<15&&InAssassinEvent.len>9)
		PrizeForAssassin="1 Elemental Points"
		PrizeForNinja="750k Yen"
	if(InAssassinEvent.len<=9)
		PrizeForAssassin="1 Cooldown and EXP Scroll"
		PrizeForNinja="1 Million Yen"
	for(var/mob/Q in InAssassinEvent)
		Q<<"All sources of information are shut off...If you encounter the assassin there will be no way to alert anyone to help you..Trust No One!"
		Q<<"<font color=red> Killing the assassin will result in a prize for the Survivors and a prize for the Assassin if he's the last one standing.</font>"
		Q<<"<font color=red> Survivor Prize: [PrizeForNinja]. Assassin Prize: [PrizeForAssassin]."
		Q.CantAlert=1
	world.AssassinEvent()

world/proc/AssassinEvent()
	//Don't forget to make a check for if there is a chuunin exam currently
	CurrentEvent="Kill The Assassin"
	while(CurrentEvent=="Kill The Assassin")
		if(InAssassinEvent.len<=0)
			var/TestView=0
			for(var/mob/M in OnlinePlayers)
				if(M.TheAssassin)
					M=TestView
			world<<"<font size=2 color=blue> The Assassin, [TestView], has killed all of the Ninja that tried to stop him...</font>"

			for(var/mob/O in Assassin)
				if(PrizeForAssassin=="2 Elemental Points")
					O.ElementalPoints+=2
					O.CantAlert=0
					spawn()
						O.GotoVillageHospital()
				if(PrizeForAssassin=="1 Elemental Points")
					O.ElementalPoints+=1
					spawn()
						O.CantAlert=0
						O.GotoVillageHospital()
			for(var/mob/A in world)
				if(A in OnlinePlayers)
					if(A.CantAlert)
						A.CantAlert=0
			CurrentEvent=""
			return
		if(Assassin.len<=0)
			world<<"<font size=2 color=blue> The Assassin has been killed...</font>"
			for(var/mob/I in InAssassinEvent)
				if(PrizeForNinja=="1 Million Yen")
					I.Yen+=1000000
					spawn()
						I.GotoVillageHospital()
				if(PrizeForNinja=="750k Yen")
					I.Yen+=750000
					spawn()
						I.GotoVillageHospital()
				if(PrizeForNinja=="500k Yen")
					I.Yen+=500000
					spawn()
						I.GotoVillageHospital()
			for(var/mob/F in world)
				if(F in OnlinePlayers)
					if(F.CantAlert)
						F.CantAlert=0
			CurrentEvent=""
		//	return
				//Don't Forget the Cooldown Scroll prize!
		sleep(30)










////////////////////////////////
/////////////Auto Tournament////
/////////////////////////////////









//verb owner to start auto tournament

//gives people



/*
People need to be able to join the list
List needs to pick to random people from the list
Allow them to fight each other
When one dies it needs to remove him from the list/Add the winner to other list





VerbStartAutoTourny- click
	world announces the tournament
	sets the global.autotounry to 1
	sleep (time)
	announces
	sleeps(time)
	sets global.autotounry = 2




verbJoinAutoTourney - click
	if global.autoTourney = 1
		world announces they  joined tournament
		adds them to list 1
		global.autotournamentLength++
	else if globalautoTourny >= 2
		usr "tourny in progress"
	else
		usr "No tourny on at the moment"



verbFixautoTournament
	global.autoTournament = 0

proc/autotournament
	if global.autotournament >=2
		if list1.length + list2.length  == 1
			for mob in list1
			for mob in list2
			 world A/B is the winner of the tournamnet
			 remove A/B from list
			 global.autotournament
		else
			if autotounry pointer = 1
				if list1.legnth == 1 or 0
					for mob A in list1
						add to list2
					pointer = 2
				else
					randomly select 2 people from the list
					teleport them both to the arena
			if autotourny pointer = 2
				if list2.length == 1 or 0
					for mob A in list1
						add A to list 1
					point = 1
				else
					randomly select 2 people from the list
					teleport them both to area
	else
		return



// In death section
if src in list1
	remove src
	world src has been removed from the tournment

if src in list2
	remove src
	world src has been defeated from tournament


loggout
	if src in list1 or list 2
		src has logged out during the tournament
		src has been removed


check
	if global.autotournamnet > 1
		autotournament()











*/
var/global.AutoTournamentPointer = 1
var/global.AutoTournament = 0
var/global.AutoTournamentRound = 1
var/list/AutoTournamentList1 = list()
var/list/AutoTournamentList2 = list()
var/list/AutoTournamentFight = list()
var/global.AutoTournamentBattleON = 0
var/global.AutoTournamentRyoReward = 0
var/global.AutoTournamentNinjaCashReward = 0


/*
VerbStartAutoTourny- click
	world announces the tournament
	sets the global.autotounry to 1
	sleep (time)
	announces
	sleeps(time)
	sets global.autotounry = 2*/


mob/owner/verb/StartAutoTournament()
	set name = "Auto-Tournament"
	set category = "Staff"
	spawn()
		StartAutoTournament()
	/*
	if(global.AutoTournament > 1)
		usr<<"There is already a tournament in progress."
		return
	world<<"<b><font size=3 color=green>[usr] has started an Auto-Tournament!</font></b>"
	global.AutoTournament = 1
	world<<"<b><font size=3 color=green>Press Join Tournament in the challenge tab to join.</font></b>"
	sleep(600)
	world<<"<b><font size=3 color=green>The Tournament will start in 2 minutes.</font></b>"
	sleep(600)
	world<<"<b><font size=3 color=green>The Tournament will start in 1 minute.</font></b>"
	sleep(600)
//	world<<"<b><font size=3 color=green>The Tournament will start in 1 minute.</font></b>"
//	sleep(600)
	world<<"<b><font size=3 color=green>The Tournament has started!"
	global.AutoTournament = 2
	world<<"<b><font size=3 color=green>Now beginning round [global.AutoTournamentRound]</font></b>"
	world<<"<b><font size=3 color=green>There are [length(AutoTournamentList1) + length (AutoTournamentList2)] fighters in the tournament.</font></b>"
	global.AutoTournamentRyoReward = 0
	global.AutoTournamentRyoReward = length(AutoTournamentList1) + length(AutoTournamentList2) * 1000
	world<<"<b><font size=3 color=green>The reward for this tournament is [global.AutoTournamentRyoReward].</font></b>"
	return
*/

proc/StartAutoTournament()
	if(global.AutoTournament > 1)
		world<<"Debug Log: There is already a tournament in progress."
		return
	world<<"<b><font size=3 color=green>An Auto-Tournament is about to begin!</font></b>"
	global.AutoTournament = 1
	world<<"<b><font size=3 color=green>Press Join Tournament in the challenge tab to join.</font></b>"
	sleep(60)
	world<<"<b><font size=3 color=green>The Tournament will start in 2 minutes.</font></b>"
	sleep(600)
	world<<"<b><font size=3 color=green>The Tournament will start in 1 minute.</font></b>"
	sleep(600)
//	world<<"<b><font size=3 color=green>The Tournament will start in 1 minute.</font></b>"
//	sleep(600)
	world<<"<b><font size=3 color=green>The Tournament has started!"
	global.AutoTournament = 2
	world<<"<b><font size=3 color=green>Now beginning round [global.AutoTournamentRound]</font></b>"
	world<<"<b><font size=3 color=green>There are [length(AutoTournamentList1) + length (AutoTournamentList2)] fighters in the tournament.</font></b>"
	global.AutoTournamentRyoReward = 0
	global.AutoTournamentNinjaCashReward=0
	global.AutoTournamentNinjaCashReward = ((length(AutoTournamentList1) + length(AutoTournamentList2) ) * 10) + 50
	global.AutoTournamentRyoReward = (length(AutoTournamentList1) + length(AutoTournamentList2)) * 1000
	world<<"<b><font size=3 color=green>The reward for this tournament is [global.AutoTournamentRyoReward] Ryo and [global.AutoTournamentNinjaCashReward] Ninja Cash!</font></b>"
	return

mob/GainedAfterLogIn/verb/JoinTournament()
	set name = "Join Tournament"
	set category = "Challenge"
	if(usr.AgeTenImmunity)
		usr<<"Not with your age ten immunity."
		return
	if(usr.AutoTourneyCD)
		return
	if(global.AutoTournament == 1)
		if(usr in AutoTournamentList1)
			usr<<"You have already joined the Tournament"
			return
		else
			world<<"<b><font size=3 color=green>[usr] has joined the Tournament!</font></b>"
			if(usr.Doubleninjacashscroll)
				usr.Doubleninjacashtime--
				usr<<"Your Double Ninja Cash scroll will work for [usr.Doubleninjacashtime] more events"
				if(usr.Doubleninjacashtime<=0)
					usr.Doubleninjacashtime=0
					usr.Doubleninjacashscroll=0
				usr.SaveK()
			AutoTournamentList1.Add(usr)
			return

	else
		usr<<"You can't join a tournament now."
		return


mob/GainedAfterLogIn/verb/WhoIsInTournament()
	set name = "Tournament Contestants"
	set category = "Challenge"
	if(global.AutoTournament == 2||global.AutoTournament == 1)
		for(var/mob/A in AutoTournamentList1)
			usr<<"[A]"
	//	for(var/mob/B in AutoTournamentList1)
	//		usr<<"[B]"
		for(var/mob/C in AutoTournamentFight)
			usr<<"[C]"
	else
		usr<<"There is no Tournament in progress."


mob/GainedAfterLogIn/verb/LeaveAutoTournament()
	set name = "Leave Tournament"
	set category = "Challenge"
	if(global.AutoTournament == 2||global.AutoTournament == 1)
		if(usr in AutoTournamentList1)
			world<<"<b><font size=3 color=green>[usr] has quit the tournament.</font></b>"
			AutoTournamentList1.Remove(usr)
		else if(usr in AutoTournamentList1)
			world<<"<b><font size=3 color=green>[usr] has quit the tournament.</font></b>"
			AutoTournamentList2.Remove(usr)
		else if(usr in AutoTournamentFight)
			usr<<"You cant leave the tournament mid-fight."
		else
			usr<<"You are not in this tournament to join press Join Tournament."
		usr.AutoTourneyCD=1
		spawn(600)
			usr.AutoTourneyCD=0

			/*
			world<<"[usr] has quit the tournament."
			AutoTournamentFight.Remove(usr)
			usr.GotoVillageHospital()
			for(var/mob/A in AutoTournamentFight)
				AutoTournamentFight.Remove(A)
				if(global.AutoTournamentPointer == 1)
					AutoTournamentList1.Add(A)
				if(global.AutoTournamentPointer == 2)
					AutoTournamentList2.Add(A)
			global.AutoTournamentBattleON = 0	*/

	else
		usr<<"There is no Tournament in progress."


/*
proc/autotournament
	if global.autotournament >=2
		if list1.length + list2.length  == 1
			for mob in list1
			for mob in list2
			 world A/B is the winner of the tournamnet
			 remove A/B from list
			 global.autotournament
		else
			if autotounry pointer = 1
				if list1.legnth == 1 or 0
					for mob A in list1
						add to list2
					pointer = 2
				else
					randomly select 2 people from the list
					teleport them both to the arena
			if autotourny pointer = 2
				if list2.length == 1 or 0
					for mob A in list1
						add A to list 1
					point = 1
				else
					randomly select 2 people from the list
					teleport them both to area
	else
		return

*/

proc/AutoTournamentRUN()
	if((global.AutoTournament == 2)&&(global.AutoTournamentBattleON == 0))
		if(length(AutoTournamentList1) + length(AutoTournamentList2) + length(AutoTournamentFight) == 0)
			world<<"<b><font size=3 color=green>No players have joined this tournament.</font></b>"
			global.AutoTournament = 0
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
		//	return
		else if(length(AutoTournamentList1) + length(AutoTournamentList2) + length(AutoTournamentFight) == 1)
			if(length(AutoTournamentList1) == 1)
				for(var/mob/A in AutoTournamentList1)
					world<<"<b><font size=3 color=green>[A] has won the Tournament!</font></b>"
					A.Yen+=global.AutoTournamentRyoReward
					A.NinjaCash+=global.AutoTournamentNinjaCashReward
					if(A.Doubleninjacashscroll)
						A.NinjaCash+=global.AutoTournamentNinjaCashReward
					AutoTournamentList1.Remove(A)
			if(length(AutoTournamentList2) == 1)
				for(var/mob/A in AutoTournamentList2)
					world<<"<b><font size=3 color=green>[A] has won the Tournament!</font></b>"
					A.Yen+=global.AutoTournamentRyoReward
					A.NinjaCash+=global.AutoTournamentNinjaCashReward
					if(A.Doubleninjacashscroll)
						A.NinjaCash+=global.AutoTournamentNinjaCashReward
					AutoTournamentList2.Remove(A)
			global.AutoTournament = 0
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
//			return

		else
			if(global.AutoTournamentPointer == 1)
				if(length(AutoTournamentList1) == 0)
					global.AutoTournamentPointer = 2
					global.AutoTournamentRound++
					world<<"<b><font size=3 color=green>Now beginning round [global.AutoTournamentRound]!</font></b>"
					world<<"<b><font size=3 color=green>There are [length(AutoTournamentList1) + length(AutoTournamentList2)] fighters in the tournament.</font></b>"
				if(length(AutoTournamentList1) == 1)
					for(var/mob/A in AutoTournamentList1)
						AutoTournamentList2.Add(A)
						AutoTournamentList1.Remove(A)

						global.AutoTournamentPointer = 2
						global.AutoTournamentRound++
						world<<"<b><font size=3 color=green>Now beginning round [global.AutoTournamentRound]!</font></b>"
						world<<"<b><font size=3 color=green>There are [length(AutoTournamentList1) + length(AutoTournamentList2)] fighters in the tournament.</font></b>"
				if(length(AutoTournamentList1)>1)
					ReRoll
					var/mob/A = pick(AutoTournamentList1)
					var/mob/B = pick(AutoTournamentList1)
					if(A==B)
						goto ReRoll
					else

						AutoTournamentFight.Add(A)
						AutoTournamentFight.Add(B)
						AutoTournamentList1.Remove(A)
						AutoTournamentList1.Remove(B)
						world<<"<b><font size=3 color=green>[A] has been randomly selected to fight in the next battle!</font></b>"
						world<<"<b><font size=3 color=green>[B] has been randomly selected to fight in the next battle!</font></b>"
						world<<"<b><font size=3 color=green>Both players will be teleported to the arena in 20 seconds.</font></b>"
						global.AutoTournamentBattleON = 1
						sleep(200)
						A.client.eye=A
						A.client.perspective=MOB_PERSPECTIVE
						A<<"You have been teleported into the arena."
						A.loc = locate(176,97,52)
						A.deathcount=0
						A.health=A.maxhealth
						A.chakra=A.Mchakra
						A.stamina=A.maxstamina
						A.ChakraPool=A.MaxChakraPool
						contestants+=A
						B<<"You have been teleported into the arena."
						B.client.eye=B
						B.client.perspective=MOB_PERSPECTIVE
						B.loc = locate(186,97,52)
						B.deathcount=0
						B.health=B.maxhealth
						B.chakra=B.Mchakra
						B.stamina=B.maxstamina
						B.ChakraPool=B.MaxChakraPool
						contestants+=B
							//For 2
			if(global.AutoTournamentPointer == 2)
				if(length(AutoTournamentList2) == 0)
					global.AutoTournamentPointer = 1
					global.AutoTournamentRound++
					world<<"<b><font size=3 color=green>Now beginning round [global.AutoTournamentRound]!</font></b>"
					world<<"<b><font size=3 color=green>There are [length(AutoTournamentList1) + length(AutoTournamentList2)] fighters in the tournament.</font></b>"
				if(length(AutoTournamentList2) == 1)
					for(var/mob/A in AutoTournamentList2)
						AutoTournamentList1.Add(A)
						AutoTournamentList2.Remove(A)

						global.AutoTournamentPointer = 1
						global.AutoTournamentRound++
						world<<"<b><font size=3 color=green>Now beginning round [global.AutoTournamentRound]!</font></b>"
						world<<"<b><font size=3 color=green>There are [length(AutoTournamentList1) + length(AutoTournamentList2)] fighters in the tournament.</font></b>"
				if(length(AutoTournamentList2)>1)
					ReRoll
					var/mob/A = pick(AutoTournamentList2)
					var/mob/B = pick(AutoTournamentList2)
					if(A==B)
						goto ReRoll
					else

						AutoTournamentFight.Add(A)
						AutoTournamentFight.Add(B)
						AutoTournamentList2.Remove(A)
						AutoTournamentList2.Remove(B)
						world<<"<b><font size=3 color=green>[A] has been randomly selected to fight in the next battle!</font></b>"
						world<<"<b><font size=3 color=green>[B] has been randomly selected to fight in the next battle!</font></b>"
						world<<"<b><font size=3 color=green>Both players will be teleported to the arena in 20 seconds.</font></b>"
						global.AutoTournamentBattleON = 1
						sleep(200)
						A<<"You have been teleported into the arena."
						A.loc = locate(176,97,52)
						A.deathcount=0
						A.health=A.maxhealth
						A.chakra=A.Mchakra
						A.stamina=A.maxstamina
						A.ChakraPool=A.MaxChakraPool
						contestants+=A
						B<<"You have been teleported into the arena."
						B.loc = locate(186,97,52)
						B.deathcount=0
						B.health=B.maxhealth
						B.chakra=B.Mchakra
						B.stamina=B.maxstamina
						B.ChakraPool=B.MaxChakraPool
						contestants+=B

	else
		return








