var/list/Winners
var/list/MatchUpList
var/list/CurrentFighters
var/Limit=0
var/AutomatedTournyOn=0//This is to not interfere with Chuunin Exams, and to check abusers who try to log out and log back in to attack those frozen while they're in the tournament



mob/proc/AutoRestore()//Handy for healing the opponents before a match starts
	src.health = src.maxhealth
	src.chakra = src.Mchakra
	src.stamina=src.maxstamina
	src.ChakraPool=src.MaxChakraPool
	src.deathcount=0

mob/owner/verb/ResetLists()//This is just to reset the Lists that are involved for the Tournament
	set name="Reset Tourny Lists"
	set category="Staff"
	Winners=null
	MatchUpList=null
	CurrentFighters=null
	contestants=list()
	SecondPartDeath=list()


mob/owner/verb/TestAutomaticTournament()
	set name="Test Tournament"
	set category="Staff"
	world<<"<font size=3><b>Automatic Tournament Test Hosting Commencing now. Join using the tournament tab."
	Limit=0
	for(var/mob/M in OnlinePlayers)
		M.verbs+=new /mob/Tournament/verb/Join
		spawn(300)
			M.verbs-=/mob/Tournament/verb/Join
	sleep(350)
	world<<"Test Tournament Commencing."
	AutomaticTournament()






mob/Tournament/verb/Join()
	set category="Tournament"
	if(Limit<7)
		src<<"This is a testing tournament and it may be a bit buggy but bear with us and please be patient. You are Frozen until your match starts."
		world<<"[src] joined the tournament."
		src.loc=locate(12,53,30)
		Limit+=1
		contestants+=src
		src.FrozenBind="WaitingForTournament"
		src.verbs-=/mob/Tournament/verb/Join
	else
		src<<"Sorry, because this is a testing tournament the limit is preset at 7(Will be 24 when testing is done) participants. You cannot join."
		src.verbs-=/mob/Tournament/verb/Join
		return











proc/AutomaticTournament()
	if(Limit<7)//If there are less than 4 people in the tournament then the tournament gets auto cancelled
		world<<"<font size=3><TT>Not enough participants in the Tournament. Tournament cancelled.</TT></font>"
		for(var/mob/M in OnlinePlayers)
			if(M.FrozenBind=="WaitingForTournament")
				spawn()
					M.GotoVillageHospital()
		contestants=list();
		return
	if(!Winners)//If the list Winners has nobody in it then it will start matching up players
		world<<"<font size=3><TT>Preparing Tournament set-up. Matching up players randomly.</TT></font>"
		var/list/L=list()//Making a List to put mobs that are in the list Contestants already
		Winners=list()//Defining the list Winners
		for(var/mob/C in contestants)//Just a check to make sure that the mob C isn't null, so everyone gets a human opponent
			if(C!=null)//Just added 9/19/2013
				L.Add(C);
		for(var/mob/M in L)//L is the list that the people that are going to fight are sent too
			if(!M.Opponent)//Checking to make sure that you're giving an Opponent to someone that doesn't have one
				if(L.len>1)//Making sure that the list L has enough mobs to give people opponents
					L.Remove(M);//Remove the mob that is getting an opponent out of the list L. (Also is a safety check so the Mob M can't be assigned to fight themself)
					var/mob/PickedOpponent=pick(L)//Picked Opponent is being chosen from the List L
					PickedOpponent.Opponent=M.ckey//Setting the Picked Opponent's opponent variable to Mob M's ckey var
					M.Opponent=PickedOpponent.ckey//Setting Mob M's opponent to the Picked Opponent's ckey var
					L.Remove(PickedOpponent);//After setting Mob M's and Picked Opponent's Opponent variables, remove Mob M's picked Opponent(from list L) out of List L
					world<<"<font size=1><TT>[M] vs [PickedOpponent]</TT></font>"
			//	else//9/3/2013//This section of the code is only accessed when Length of list L is = or <1, meaning there's one person who doesn't have an opponent
			//		if(M!=null&&M.client)//Just a check to make sure that the mob in L isn't null or not a player
			//			Winners.Add(M);//Add Mob M, who got to skip the round, to the list Winners
			//		contestants.Remove(M);//Remove mob M from Contestants list since they're not fighting
			//		world<<"<font size=1><TT>[M] has no opponent and will move on to the next round.</TT></font>"//Just letting the world know that they got a free pass to the next round
			sleep(1)
		world<<"<font size=3><TT>Tournament Start-Up complete.</TT></font>"//Tells the world setting up for the Tournament is complete
		AutomaticMatches()//Call the Automatic Matches proc
		return//Return Statement
	else if(Winners.len>=1)//If the Winners list is greater than or equal to 1 this part is called
		world<<"CheckMark5";
		if(Winners.len<=1)//If the List Winners has only 1 person in it, which would only happen after it comes down to the final tournament round 1 vs 1, and a tournament winner has been decided
			var/mob/Winner=pick(Winners)//Mob Winner will be picked from the Winners List
			if(Winner.client)//Just checking to make sure that the mob Winner is a client and not a null or somehow an NPC..
				world<<"<font size=3><TT>Tournament Completed. Congratulations to the winner, [Winner]. Prize: Ninja Cash(No Actual prize right now, as this is just being tested).</TT></font>"//Telling the world who won the tournament, and then giving a prize to the winner
		//		Winner.NinjaCash+=50
		else//This section of the code is called if there is more than one mob in the Winners list, which means there will be another round
			contestants=null//Setting list Contestants to value of Null
			contestants=list()//Redefining list Contestants to new empty list
			world<<"<font size=3><TT>Viewable Contestants Refreshed. Beginning Next Round.</TT></font>"//Letting the world know the next round is starting
			MatchUpList=list();//MatchUpList defining as empty new list
			world<<"Mark6";
			for(var/mob/W in Winners)//Mob W are people who have won their match or was that one lucky person who got a freebie and skipped the previous round
				if(!W.client)//Safety Check added 9/19/2013 - This will check to make sure that all mobs in list Winner are still active, and if not, they're automatically removed from the Winners list
					Winners.Remove(W)//Removes the Null mob or disconnected mob from the tournament to prevent screw ups
				contestants+=W;//Set mob W in Winners list into contestant list (make them a contestant)
				MatchUpList.Add(W);//Add mob W in Winners List into list MatchUpList
				Winners.Remove(W);//Remove W from the Winners list, as they now aren't winners and have to fight to advance in the tournament
			var/list/K=list()//Creating a new list K
			for(var/mob/C in contestants)//Setting mobs in list contestants to mob C
				if(!C.client)//Added 9/19/2013 - Just another safety check, if it's not a client remove them from the lists they were going to participate in the rest of the tourny
					if(C in contestants)//Check to see if mob C is a contestant, or was
						contestants.Remove(C)//If was contestant then remove from contestant list
					if(C in MatchUpList)//Check to see if Mob C was made as someone to fight in the next round
						MatchUpList.Remove(C)//If was made someone to fight in enxt round then remove
	//				Winners.Remove(C)
				else
					K.Add(C);//Adding mob C to list K, which was just created 2 lines up
			for(var/mob/M in MatchUpList)//mob M is now the people in matchuplist who are going to fight in the next round
				if(MatchUpList.len>=1)//If the length of people that are going to fight is more than or equal too one
					var/mob/PickedOpponent=pick(K)
					PickedOpponent.Opponent=M.ckey
					M.Opponent=PickedOpponent.ckey
					MatchUpList.Remove(M);
					MatchUpList.Remove(PickedOpponent);
					world<<"<font size=1><TT>[M] vs [PickedOpponent]</TT></font>"
				/*else
					MatchUpList=null;MatchUpList=list();
					Winners=null;Winners=list();
					contestants=null;contestants=list()
					world<<"<font size=1><TT>[M] has no opponent and will move on to the next round.</TT></font>"
					sleep(11)
					world<<"<font size=3><TT>Tournament Completed. Congratulations to the winner, [M]. Prize: 25,000 Ryo.</TT></font>"
					M.Yen+=25000
					return*/
			if(contestants.len>1)
				world<<"<font size=3><TT>Preparing for the next round of the tournament.</TT></font>"
				AutomaticMatches()
				return











proc/AutomaticMatches()//This is what starts the matches Automatic Matches
	world<<"<font size=3><TT>Randomly selecting next match.</TT></font>"//Tells the world randomly selecting next match
	if(contestants.len==0||!contestants.len)//if there are 0 contestants or contestants has not been declared and has no value at all
		if(Winners.len>=1)//If Winners is greater than or equal to 1
			AutomaticTournament()//Call the automatic tournament proc, which will keep the tournament going and onto the next rounds
			return
//	if(!contestants.len)//Lol? I don't think this is needed, since the above if statement is ||
//		world<<"<font size=3><TT>All contestants have vanished magically. The tournament is cancelled.</TT></font>"
//		return
	world<<"Mark1";
	var/mob/M=pick(contestants)//Picking a Mob from Contestants to start the tournament
	var/mob/O//Assuming that mob O is defined because he's going to be the opponent of M
	for(var/mob/Opponent in contestants)//Checking all mobs in contestants
		if(Opponent.Opponent==M.ckey)//Checking to see which mob has Mob M's ckey variable as Opponent
			O=Opponent//Setting mob O as M's opponent, since he had his ckey variable


/*
			//just added all this section right here 9/19/2013 as it's a safety check
		else//Just added this as I'm trying to add more safe checks 9/19/2013
			world<<"<font size=3><TT>[M]'s opponent, [M.Opponent], disconnected or logged off, disqualifying them! [M] will now automatically advance to the next round."//If none of the mobs in contestants had M as their opponent then M automatically advances
			var/mob/Winner=M//Setting M as the winner since their opponent that was assigned apparently logged off
			world<<"<font size=3><TT>[Winner] wins the match.</TT></font>"//Letting the world know that M won
			Winners.Add(Winner)//Add Winner to the list of Winners
			if(Winner in contestants)//If Winner is in contestants
				contestants.Remove(Winner);//Remove winner from contestants
			CurrentFighters=null//No more current fighters
		//	Winner.loc = locate(154,85,32)
			Winner.loc = locate(12,53,30)
			Winner.FrozenBind="WaitingForTournament"//Just added 9/19/2013
			world<<"<font size=3><TT>Moving onto next match.</TT></font>"
			AutomaticMatches()
			return
			*/


	world<<"Mark2";
	M.FrozenBind=""
	M.Frozen=0
	O.Frozen=0
	O.FrozenBind=""
	spawn()
		M.AutoRestore()//Just to heal both the opponents to full before the fight
	spawn()
		O.AutoRestore()//Just to heal both the opponents to full before the fight
	CurrentFighters=list();
	CurrentFighters.Add(M);
	CurrentFighters.Add(O);
	sleep(11)
	world<<"Mark3";
	world<<"<font size=3><TT>Match Selected. [M] vs [O]</TT></font>"
	sleep(25)

	//Selects an Arena for them
	world<<"<font size=3><TT>Randomly selecting Arena.</TT></font>"
	sleep(11)
	world<<"Mark4";
	if(prob(50))
		M.loc=locate(115,67,32)
		O.loc=locate(115,46,32)
	else
		M.loc=locate(141,67,32)
		O.loc=locate(141,46,32)


	world<<"<font size=3><TT>Arena Selected. Participants in place. Begin!</TT></font>"
	while(CurrentFighters.len>=2)//Will be greater than or equal to 2 if both fighters are still alive
		if(!M.client)
			world<<"<font size=3><TT>[M] is not found, match ended.</TT></font>"
			CurrentFighters.Remove(M)
		if(!O.client)
			world<<"<font size=3><TT>[O] is not found, match ended.</TT></font>"
			CurrentFighters.Remove(O)
		sleep(300)
	if(CurrentFighters.len<=1)
		var/mob/Winner=pick(CurrentFighters)
		world<<"<font size=3><TT>[Winner] wins the match.</TT></font>"
		Winners.Add(Winner)
		if(Winner in contestants)
			contestants.Remove(Winner);
		CurrentFighters=null
		Winner.loc = locate(154,85,32)
		Winner.FrozenBind="WaitingForTournament"//Just added 9/19/2013
		world<<"<font size=3><TT>Moving onto next match.</TT></font>"
		AutomaticMatches()
		return











//HONESTLY...I have no idea why this doesn't work.
//It will not go onto the next match even if someone wins when it should.
//I really don't get it. This constant loop in AutomaticMatches() proc should take care of everything
//regardless if someone loses/logs out/DCs/ or whatever. It doesn't though so I can't say for sure.
//
//You COULD always try calling Automatic Matches after someone wins in the Death Proc with a spawn() infront of it.
//But idk if that would work.