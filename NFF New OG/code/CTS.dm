//world/Topic(T,Addr)
  //  world.log << T
    //world.log << Addr
    //..()

//client/control_freak = CONTROL_FREAK_ALL | CONTROL_FREAK_MACROS

var/CaptureTheScroll/CTS

CaptureTheScroll
	var
		const
			MinMapX = 125
			MaxMapX = 150

			MinMapY = 130
			MaxMapY = 185

			CTSMapZ = 55

			CTSGroupOneSpawnX = 81
			CTSGroupOneSpawnY = 129

			CTSGroupTwoSpawnX = 192
			CTSGroupTwoSpawnY = 192

			RegistrationTimeInSeconds = 120

			SendToCTSMapMessage = "You have been sent to the capture the scroll map."

			RedTeamAwardPointMessage = "<b><font size=2 color=blue>Team Red has been awarded one point.</font></b>"

			BlueTeamAwardPointMessage = "<b><font size=2 color=blue>Team Blue has been awarded one point.</font></b>"

			RedTeamWinMessage = "<b><font size=2 color=red>Team Red has won the capture the scroll event.</font></b>"

			BlueTeamWinMessage = "<b><font size=2 color=red>Team Blue has won the capture the scroll event.</font></b>"

			TeamWinMessage = "<b><font color=red>Your team has won.</font></b>"

			RegistrationFinishedMessage = "<b><font size=2 color=blue>The registration period for the capture the scroll event has ended.</font></b>"

			LackingPeopleMessage = "<b><font size=2 color=blue>There were not enough people to begin the capture the scroll event.</font</b>"

			AlreadyJoinedTeamMessage = "You have already joined a team."

			TeamsFullMessage = "Both capture the scroll teams are full."

			CTSJoinMessage = "You have joined the capture the scroll event."

			CannotJoinMessage = "You can't join capture the scroll now......"

			ForceEndCTSMessage = "<font size=2 color=red>CTS has been forcibly ended.</font>"

			CTSDoubleNinjaCashMessagePartOne = "Your Double Ninja Cash scroll will work for "
			CTSDoubleNinjaCashMessagePartTwo = " more events."

			CTSWorldJoinMessagePartOne = "<b><font size=1 color=green>"
			CTSWorldJoinMessagePartTwo = " has joined the capture the scroll event!</font></b>"

			CTSAbuseSneakMessagePartOne = "<b><font size=2 color=blue>"
			CTSAbuseSneakMessagePartTwo = " is abusing by sneaking into the CTS event.</font></b>"

			ScrollDeliveryMessagePartOne = "<b><font size=2 color=blue>"
			ScrollDeliveryMessagePartTwo = " has delivered the scroll.</font></b>"

			ScrollWrongDeliveryMessagePartOne = "<b><font size=2 color=blue>"
			ScrollWrongDeliveryMessagePartTwo = " has delivered the scroll to the opposite team's post.</font></b>"

			CTSStartMessagePartOne = "<b><font size=2 color=blue>A capture the scroll event is beginning in "
			CTSStartMessagePartTwo = " minutes.</font></b>"

			RedTeamPointsMessagePartOne = "<b><font size=2 color=blue>Team Red has "
			RedTeamPointsMessagePartTwo = " points.</font></b>"

			BlueTeamPointsMessagePartOne = "<b><font size=2 color=blue>There are "
			BlueTeamPointsMessagePartTwo = " points.</b></font>"

			NinjaCashRewardMessagePartOne = "<b><font size=2 color=blue>The reward for the winning team is "
			NinjaCashRewardMessagePartTwo = " ninja cash.</font></b>"

			TeamCountMessagePartOne = "<b><font size=2 color=blue>There are "
			TeamCountMessagePartTwo = " people in the red team and "
			TeamCountMessagePartThree = " in the blue team.</font></b>"

			CTSTeamRedMessage = "CTS Red Team: "

			CTSTeamBlueMessage = "CTS Blue Team: "


		list
			CTSGroupBuffer = list()
			CTSGroupOne = list()
			CTSGroupTwo = list()

		Status

		CTSEventRewardNinjaCash

		CTSGroupOnePoints

		CTSGroupTwoPoints

	proc
		RandomizeScrollSpawn(var/obj/CTS_Ninja_Scroll/Scroll)
			if(Scroll)
				var/turf/spawn_location
				do
					var/CTSMapX = rand(MinMapX, MaxMapX)
					var/CTSMapY = rand(MinMapY, MaxMapY)
					spawn_location = locate(CTSMapX, CTSMapY, CTSMapZ)
				while(spawn_location.density)

				Scroll.loc = spawn_location

				Scroll.CanBeCollected = 0

				spawn(50)
					Scroll.CanBeCollected = 1

		DecideCTSTeams()
			if(CTSGroupBuffer.len == 2)
				CTSGroupOne.Add(CTSGroupBuffer[1])
				CTSGroupTwo.Add(CTSGroupBuffer[2])

			else
				var/TeamNumber = 0
				while(CTSGroupBuffer.len)
					var/mob/Random = pick(CTSGroupBuffer)
					if(TeamNumber == 0)
						CTSGroupOne.Add(Random)
						TeamNumber = 1
					else
						CTSGroupTwo.Add(Random)
						TeamNumber = 0
					CTSGroupBuffer.Remove(Random)

			CTSGroupBuffer = list()

		RemoveTeamOverlay(var/mob/M)
			if(M)
				var/image/TeamOne = image(icon = 'Icons/Hud/hudfade.dmi', icon_state = "Leaf")
				TeamOne.pixel_y = 6

				var/image/TeamTwo = image(icon = 'Icons/Hud/hudfade.dmi', icon_state = "Rain")
				TeamTwo.pixel_y = 6

				M.overlays.Remove(TeamOne, TeamTwo)

		AddTeamOverlay(var/mob/M, var/TeamNumber)
			if(M && TeamNumber)
				switch(TeamNumber)
					if(1)
						var/image/TeamOne = image(icon = 'Icons/Hud/hudfade.dmi', icon_state = "Leaf")
						TeamOne.pixel_y = 6
						M.overlays.Add(TeamOne)
					if(2)
						var/image/TeamTwo = image(icon = 'Icons/Hud/hudfade.dmi', icon_state = "Rain")
						TeamTwo.pixel_y = 6
						M.overlays.Add(TeamTwo)

		SendToCTSMap()
			for(var/mob/M in CTSGroupOne)
				AddTeamOverlay(M, 1)
				M.loc = locate(CTSGroupOneSpawnX, CTSGroupOneSpawnY, CTSMapZ)
				M.AutoRestore()
				M << "[SendToCTSMapMessage]"
				contestants.Add(M)

			for(var/mob/M in CTSGroupTwo)
				AddTeamOverlay(M, 2)
				M.loc = locate(CTSGroupTwoSpawnX, CTSGroupTwoSpawnY, CTSMapZ)
				M.AutoRestore()
				M << "[SendToCTSMapMessage]"
				contestants.Add(M)

			var/obj/CTS_Ninja_Scroll/Scroll = new
			RandomizeScrollSpawn(Scroll)

		FixJutsuDelays(var/mob/M)
			if(M)
				M.LegSliced = 0
				M.Sliced = 0

				var/obj/SkillCards/secondSeal/SkillOne = locate(/obj/SkillCards/secondSeal) in M.LearnedJutsus
				var/obj/SkillCards/QuickFeet/SkillTwo = locate(/obj/SkillCards/QuickFeet) in M.LearnedJutsus
				var/obj/SkillCards/BodyFlameJutsu/SkillThree = locate(/obj/SkillCards/BodyFlameJutsu) in M.LearnedJutsus
				var/obj/SkillCards/Summoning_Jutsu_Griffin/SkillFour = locate(/obj/SkillCards/Summoning_Jutsu_Griffin) in M.LearnedJutsus
				var/obj/SkillCards/Nikudan/SkillFive = locate(/obj/SkillCards/Nikudan) in M.LearnedJutsus
				var/obj/SkillCards/Meimei/SkillSix = locate(/obj/SkillCards/Meimei) in M.LearnedJutsus
				var/obj/SkillCards/Touei/SkillSeven = locate(/obj/SkillCards/Touei) in M.LearnedJutsus
				var/obj/SkillCards/Phase/SkillEight = locate(/obj/SkillCards/Phase) in M.LearnedJutsus
				var/obj/SkillCards/Susanoo/SkillNine = locate(/obj/SkillCards/Susanoo) in M.LearnedJutsus

				if(SkillOne)
					SkillOne.DelayIt(1, M)
				if(SkillTwo)
					SkillTwo.DelayIt(1, M)
				if(SkillThree)
					SkillThree.DelayIt(1, M)
				if(SkillFour)
					SkillFour.DelayIt(1, M)
				if(SkillFive)
					SkillFive.DelayIt(1, M)
				if(SkillSix)
					SkillSix.DelayIt(1, M)
				if(SkillSeven)
					SkillSeven.DelayIt(1, M)
				if(SkillEight)
					SkillEight.DelayIt(1, M)
				if(SkillNine)
					SkillNine.DelayIt(1, M)

		RunCTSTeamOne(var/mob/M)
			if(M)
				var/obj/CTS_Ninja_Scroll/Scroll = locate(/obj/CTS_Ninja_Scroll) in M.contents

				if(Scroll)
					if(M in CTSGroupOne)
						CTSGroupOnePoints++
						OnlinePlayers << "[ScrollDeliveryMessagePartOne][M][ScrollDeliveryMessagePartTwo]"
						OnlinePlayers << "[RedTeamAwardPointMessage]"
						OnlinePlayers << "[RedTeamPointsMessagePartOne][CTSGroupOnePoints][RedTeamPointsMessagePartTwo]"
						EndCTS()
					else if(M in CTSGroupTwo)
						CTSGroupOnePoints++
						OnlinePlayers << "[ScrollWrongDeliveryMessagePartOne][M][ScrollWrongDeliveryMessagePartTwo]"
						OnlinePlayers << "[RedTeamAwardPointMessage]"
						OnlinePlayers << "[RedTeamPointsMessagePartOne][CTSGroupOnePoints][RedTeamPointsMessagePartTwo]"
						EndCTS()
					else
						OnlinePlayers << "[CTSAbuseSneakMessagePartOne][M][CTSAbuseSneakMessagePartTwo]"
						M.GotoVillageHospital()

					RandomizeScrollSpawn(Scroll)

					spawn(50)
						FixJutsuDelays(M)

		RunCTSTeamTwo(var/mob/M)
			if(M)
				var/obj/CTS_Ninja_Scroll/Scroll = locate(/obj/CTS_Ninja_Scroll) in M.contents

				if(Scroll)
					if(M in CTSGroupTwo)
						CTSGroupTwoPoints++
						OnlinePlayers << "[ScrollDeliveryMessagePartOne][M][ScrollDeliveryMessagePartTwo]"
						OnlinePlayers << "[BlueTeamAwardPointMessage]"
						OnlinePlayers << "[BlueTeamPointsMessagePartOne][CTSGroupTwoPoints][BlueTeamPointsMessagePartTwo]"
						EndCTS()
					else if(M in CTSGroupOne)
						CTSGroupTwoPoints++
						OnlinePlayers << "[ScrollWrongDeliveryMessagePartOne][M][ScrollWrongDeliveryMessagePartTwo]"
						OnlinePlayers << "[BlueTeamAwardPointMessage]"
						OnlinePlayers << "[BlueTeamPointsMessagePartOne][CTSGroupTwoPoints][BlueTeamPointsMessagePartTwo]"
						EndCTS()
					else
						OnlinePlayers << "[CTSAbuseSneakMessagePartOne][M][CTSAbuseSneakMessagePartTwo]"
						M.GotoVillageHospital()

					RandomizeScrollSpawn(Scroll)

					spawn(50)
						FixJutsuDelays(M)

		EndCTS()
			if(Status == "Finished")
				for(var/mob/M in CTSGroupOne)
					RemoveTeamOverlay(M)

					FixJutsuDelays(M)

					CTSGroupOne.Remove(M)

					M.GotoVillageHospital()

					var/obj/CTS_Ninja_Scroll/Scroll = locate(/obj/CTS_Ninja_Scroll) in M.contents

					if(Scroll)
						Scroll.loc = null

				for(var/mob/M in CTSGroupTwo)
					RemoveTeamOverlay(M)

					FixJutsuDelays(M)

					CTSGroupTwo.Remove(M)

					M.GotoVillageHospital()

					var/obj/CTS_Ninja_Scroll/Scroll = locate(/obj/CTS_Ninja_Scroll) in M.contents

					if(Scroll)
						Scroll.loc = null

				Del()

			else if(CTSGroupOnePoints >= 7)
				OnlinePlayers << "[RedTeamWinMessage]"

				for(var/mob/M in CTSGroupOne)
					if(M.Doubleninjacashscroll)
						M.NinjaCash += CTSEventRewardNinjaCash * 2
					else
						M.NinjaCash += CTSEventRewardNinjaCash

					M << "[TeamWinMessage]"

				Status = "Finished"

				EndCTS()

			else if(CTSGroupTwoPoints >= 7)
				OnlinePlayers << "[BlueTeamWinMessage]"

				for(var/mob/M in CTSGroupTwo)
					if(M.Doubleninjacashscroll)
						M.NinjaCash += CTSEventRewardNinjaCash * 2
					else
						M.NinjaCash += CTSEventRewardNinjaCash

					M << "[TeamWinMessage]"

				Status = "Finished"

				EndCTS()

		StartCTS()
			AutomateEvents()

			Status = "Registration"

			OnlinePlayers << "[CTSStartMessagePartOne][RegistrationTimeInSeconds/60][CTSStartMessagePartTwo]"

			sleep(RegistrationTimeInSeconds * 5)

			OnlinePlayers << "[CTSStartMessagePartOne]1[CTSStartMessagePartTwo]"

			sleep(RegistrationTimeInSeconds * 5)

			Status = "Ongoing"

			OnlinePlayers << "[RegistrationFinishedMessage]"

			if(CTSGroupBuffer.len >= 2)
				DecideCTSTeams()

				CTSEventRewardNinjaCash = 25 + round((CTSGroupOne.len + CTSGroupTwo.len) ** 1.8735, 5)

				CTSGroupOnePoints = 0

				CTSGroupTwoPoints = 0

				OnlinePlayers << "[TeamCountMessagePartOne][CTSGroupOne.len][TeamCountMessagePartTwo][CTSGroupTwo.len][TeamCountMessagePartThree]"

				OnlinePlayers << "[NinjaCashRewardMessagePartOne][CTSEventRewardNinjaCash][NinjaCashRewardMessagePartTwo]"

				SendToCTSMap()

			else
				OnlinePlayers << "[LackingPeopleMessage]"

		Register(var/mob/M)
			if(M)
				if(Status == "Registration")
					if(M in CTSGroupBuffer)
						M << "[AlreadyJoinedTeamMessage]"
					else if(CTSGroupBuffer.len >= 14)
						M << "[TeamsFullMessage]"
					else
						OnlinePlayers << "[CTSWorldJoinMessagePartOne][M][CTSWorldJoinMessagePartTwo]"
						M << "[CTSJoinMessage]"
						CTSGroupBuffer.Add(M)

						if(M.Doubleninjacashscroll)
							M.Doubleninjacashtime--
							M << "[CTSDoubleNinjaCashMessagePartOne][M.Doubleninjacashtime][CTSDoubleNinjaCashMessagePartTwo]"
							if(M.Doubleninjacashtime <= 0)
								M.Doubleninjacashtime = 0
								M.Doubleninjacashscroll = 0

							M.SaveK()
				else
					M << "[CannotJoinMessage]"

		PrintTeams(var/mob/M)
			if(M)
				if(Status == "Ongoing")
					var/TeamOneString = "<u>Team Red</u><br>"
					var/TeamTwoString = "<u>Team Blue</u><br>"

					for(var/mob/MM in CTSGroupOne)
						TeamOneString += "[MM]    "
					for(var/mob/MM in CTSGroupTwo)
						TeamTwoString += "[MM]    "

					M << "[TeamOneString]"
					M << "[TeamTwoString]"

		TeamMessage(var/mob/M, var/msg)
			if(msg && M)
				if(M in CTSGroupOne)
					CTSGroupOne << "[CTSTeamRedMessage]"
				else if(M in CTSGroupTwo)
					CTSGroupTwo << "[CTSTeamBlueMessage][M.name] - [msg]"


proc
	AutomateEvents()
		spawn(36000)
			var/Choose = rand(1,5)
			if(Choose == 1)
				AutomateFFA()
			else if(Choose == 2)
				AutomateBoss()
			else if(Choose == 3)
				StartAutoTournament()
			else if(Choose == 4)
				del CTS
				CTS = new
				CTS.StartCTS()
			else if(Choose == 5)
				del TDM
				TDM = new
				TDM.StartTDM()

mob
	GainedAfterLogIn
		verb
			JoinCTSEvent()
				set name = "Capture The Scroll"
				set category = "Events"
				if(usr.AgeTenImmunity)
					usr << "Not with your age ten immunity."
				else if(CTS)
					CTS.Register(usr)

			CTSEventTeams()
				set name = "Capture The Scroll Teams"
				set category = "Events"
				if(CTS)
					CTS.PrintTeams(usr)

			CTSTeamChat(msg as text)
				set name = "CTS Team Chat"
				set category = "Events"
				if(CTS)
					CTS.TeamMessage(usr, msg)

			/*
			StartCTS()
				if(usr.ckey == "45tt" || usr.ckey == "cobrat1337")
					if(!CTS)
						CTS = new
						CTS.StartCTS()

			EndCTS()
				if(usr.ckey == "45tt" || usr.ckey == "cobrat1337")
					if(CTS)
						OnlinePlayers << "[ForceEndCTSMessage]"
						CTS.Status = "Finished"
						CTS.EndCTS()
			*/

obj
	CTS_Ninja_Scroll
		icon = 'Icons/scrolls.dmi'
		icon_state = "Hidden Ninja Scroll"
		density = 1
		layer = MOB_LAYER + 1
		var/CanBeCollected

	CTSScrollPost
		icon = 'Map/Turfs/Post.dmi'
		icon_state = "1"
		layer = MOB_LAYER
		density = 1
		pixel_y = 32

		TeamOne
			name = "Team Red Post"

		TeamTwo
			name = "Team Blue Post"

	CTSScrollPostBottom
		icon = 'Map/Turfs/Post.dmi'
		icon_state = "2"
		density = 0
		layer = OBJ_LAYER


proc
	PickRandomRinneganWielder()
		var
			Winner

			list
				EnteredIDs = list()
				EnteredIPs = list()
				Entered = list()

			const
				RinneganEventSleepTimeInSeconds = 300
				RinneganEventMessagePartOne = "<font color=blue size=2>The rinnegan event will begin in </font>"
				RinneganEventMessagePartTwo = "<font color=blue size=2> minutes.</font>"
				RinneganEventBeginningMessage = "<font color=blue size=2>The rinnegan event will now begin.</font>"
				RinneganEventEligibleMessage = "<font color=red>You are eligible to receive rinnegan.</font>"
				RinneganEventEligibleWorldMessage = "<font color=blue size=2>If you are eligible to receive rinnegan, you have already been informed.</font>"
				RinneganEventDecisionMessage = "<font color=blue size=2>The winner will be decided in 1 minute.</font>"
				RinneganEventWinMessage = "<font color=red>You will receive the rinnegan.</font>"
				RinneganEventWorldWinMessage = "<font color=blue size=2>The winner of rinnegan is "

		OnlinePlayers << "[RinneganEventMessagePartOne][RinneganEventSleepTimeInSeconds/60][RinneganEventMessagePartTwo]"

		sleep(RinneganEventSleepTimeInSeconds * 2)

		OnlinePlayers << "[RinneganEventMessagePartOne]4[RinneganEventMessagePartTwo]"

		sleep(RinneganEventSleepTimeInSeconds * 2)

		OnlinePlayers << "[RinneganEventMessagePartOne]3[RinneganEventMessagePartTwo]"

		sleep(RinneganEventSleepTimeInSeconds * 2)

		OnlinePlayers << "[RinneganEventMessagePartOne]2[RinneganEventMessagePartTwo]"

		sleep(RinneganEventSleepTimeInSeconds * 2)

		OnlinePlayers << "[RinneganEventMessagePartOne]1[RinneganEventMessagePartTwo]"

		sleep(RinneganEventSleepTimeInSeconds * 2)

		OnlinePlayers << "[RinneganEventBeginningMessage]"

		for(var/mob/M in OnlinePlayers)
			if(!(M in Entered) && !(M.client.address in EnteredIPs) && !(M.client.computer_id in EnteredIDs))
				Entered.Add(M)
				EnteredIDs.Add(M.client.computer_id)
				EnteredIPs.Add(M.client.address)

		Entered << "[RinneganEventEligibleMessage]"

		OnlinePlayers << "[RinneganEventEligibleWorldMessage]"

		OnlinePlayers << "[RinneganEventDecisionMessage]"

		sleep(600)

		Winner = pick(Entered)

		Winner << "[RinneganEventWinMessage]"

		OnlinePlayers << "[RinneganEventWorldWinMessage][Winner]([Winner:key])."
mob
	owner
		verb
			RandomRinneganEvent()
				PickRandomRinneganWielder()