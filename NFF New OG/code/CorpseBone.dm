mob
	var
		BoneClubLeader=0
		BoneClubMember=0
		BoneCorpseRank=""
		SpawnChoice=0
mob/BoneClubMember
	verb/Choice()
		set name="Select Spawn"
		set category="Corpse Bone"
		if(!usr.SpawnChoice)
			usr.SpawnChoice=1
			usr<<"You will now spawn at the graveyard."
		else
			usr<<"You will now spawn at your villages hospital."
			usr.SpawnChoice=0
	verb/ClanSay(msg as text)
		set category="Corpse Bone"
		set name="Club Say"
		set desc = "Say something to every member of Bone Club"
		var/list/L = list("<")
		for(var/H in L)
			if(findtext(msg,H))
				alert(usr,"No HTML in text!");return
			if(length(msg)>=400)
				alert(usr,"Message is too long");return
		for(var/mob/M in OnlinePlayers)
			if(M.BoneClubMember||M.BoneClubLeader)
				M<<"<font face=trebuchet MS><font color=#551A8B size=2>(Bone Club Say)</font><font size=1> ([usr.BoneCorpseRank]) - [usr.name]</font><font face=trebuchet MS><font color=#deb887>: [msg]</font>"
	verb/ClanWho()
		set category="Corpse Bone"
		set name="Club Who"
		usr<<"<font color=green>Online Club Members -"
		for(var/mob/M in OnlinePlayers)
			if(M.BoneClubMember||M.BoneClubLeader&&M.client){usr<<"<font color =  #551A8B>[M.FirstName]</font>"}
mob/BoneClub
	verb/Announce(txt as text)
		set name = "Announce"
		set category = "Corpse Bone"
		for(var/mob/M in OnlinePlayers)
			if(M.BoneClubLeader||M.BoneClubMember)
				M << "<font face=verdana><font size=3><b><center>[usr] would like to announce:<center><font color=silver size = 2>[txt]</font>"
	verb/Invite(mob/M in world)
		set category="Corpse Bone"
		set name="Invite to Bone Club"
		if(BoneCorpseAmount>=12)
			usr<<"You already have enough members in the club."
			return
		switch(input(M,"Would you like to join The Bone Club?","Join?","") in list ("Yes","No"))
			if("Yes")
				if(!M.BoneClubLeader&&!M.BoneClubMember)
					M.BoneClubMember=1
					var/obj/Clothes/BoneMask/T = new();
					M.contents+=T
					M.verbs+=typesof(/mob/BoneClubMember/verb)
				else
					usr<<"Cannot be done, they're already in the club"
			if("No")
				usr<<"[M] denied your invite."
	verb/Boot(mob/M in world)
		set category="Corpse Bone"
		set name="Exile from the Club"
		if(M.BoneClubMember)
			M.BoneClubMember=0
			M.verbs-=typesof(/mob/BoneClubMember/verb)
			for(var/mob/X in OnlinePlayers)
				if(X.BoneClubMember||M.BoneClubLeader)
					X<<"<font color=#deb887>[M] has been Exiled from Bone Club!</font>"
	verb/Promote(mob/M in world)
		set category="Corpse Bone"
		set name="Promote Club Member"
		var/Choice=input(usr,"What rank do you want to assign [M]?",) in list("Co-Leader","Member")
		M.ARank=Choice
		for(var/mob/X in world)
			if(X.BoneClubLeader||X.BoneClubMember)
				X<<"<font size=2><font face=trebuchet MS><font color=#551A8B>[M] is now a [Choice] in the Club</font>"