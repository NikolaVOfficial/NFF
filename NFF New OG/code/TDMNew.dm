var/TeamDeathmatch/TDM

TeamDeathmatch
	var
		const
			TDMMapZ = 55

			TDMGroupOneSpawnX = 81
			TDMGroupOneSpawnY = 129

			TDMGroupTwoSpawnX = 192
			TDMGroupTwoSpawnY = 192

			RegistrationTimeInSeconds = 120

			SendToTDMMapMessage = "You have been sent to the team deathmatch map."

			RedTeamWinMessage = "<b><font size=2 color=red>Team Red has won the team deathmatch event.</font></b>"

			BlueTeamWinMessage = "<b><font size=2 color=blue>Team Blue has won the team deathmatch event.</font></b>"

			TeamWinMessage = "<b><font color=red>Your team has won.</font></b>"

			RegistrationFinishedMessage = "<b><font size=2 color=blue>The registration period for the team deathmatch event has ended.</font></b>"

			LackingPeopleMessage = "<b><font size=2 color=blue>There were not enough people to begin the team deathmatch event.</font></b>"

			AlreadyJoinedTeamMessage = "You have already joined the team deathmatch event."

			TeamsFullMessage = "Both team deathmatch teams are full."

			TDMJoinMessage = "You have joined the team deathmatch event."

			CannotJoinMessage = "You can't join the team deathmatch event now....."

			ForceEndTDMMessage = "<font size=2 color=red>The team deathmatch event has been forcibly ended.</font>"

			TDMDoubleNinjaCashMessagePartOne = "Your Double Ninja Cash scroll will work for "
			TDMDoubleNinjaCashMessagePartTwo = " more events."

			TDMWorldJoinMessagePartOne = "<b><font size=1 color=green>"
			TDMWorldJoinMessagePartTwo = " has joined the team deathmatch event!</font></b>"

			TDMStartMessagePartOne = "<b><font size=2 color=blue>A team deathmatch event is beginning in "
			TDMStartMessagePartTwo = " minutes.</font></b>"

			NinjaCashRewardMessagePartOne = "<b><font size=2 color=blue>The reward for the winning team is "
			NinjaCashRewardMessagePartTwo = " ninja cash.</font></b>"

			TeamCountMessagePartOne = "<b><font size=2 color=blue>There are "
			TeamCountMessagePartTwo = " people in the red team and "
			TeamCountMessagePartThree = " in the blue team.</font></b>"

			TDMTeamRedMessage = "TDM Red Team: "

			TDMTeamBlueMessage = "TDM Blue Team: "

		list
			TDMGroupBuffer = list()
			TDMGroupOne = list()
			TDMGroupTwo = list()

		Status

		TDMEventRewardNinjaCash


	proc
		DecideTDMTeams()
			if(TDMGroupBuffer.len == 2)
				TDMGroupOne.Add(TDMGroupBuffer[1])
				TDMGroupTwo.Add(TDMGroupBuffer[2])

			else
				var/TeamNumber = 0
				while(TDMGroupBuffer.len)
					var/mob/Random = pick(TDMGroupBuffer)
					if(TeamNumber == 0)
						TDMGroupOne.Add(Random)
						TeamNumber = 1
					else
						TDMGroupTwo.Add(Random)
						TeamNumber = 0
					TDMGroupBuffer.Remove(Random)

			TDMGroupBuffer = list()

		RemoveTeamOverlay(var/mob/M)
			if(M)
				var/image/TeamOne= image(icon = 'Icons/Hud/hudfade.dmi', icon_state = "Leaf")
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

		SendToTDMMap()
			for(var/mob/M in TDMGroupOne)
				AddTeamOverlay(M, 1)
				M.loc = locate(TDMGroupOneSpawnX, TDMGroupOneSpawnY, TDMMapZ)
				M.AutoRestore()
				M << "[SendToTDMMapMessage]"
				contestants.Add(M)

			for(var/mob/M in TDMGroupTwo)
				AddTeamOverlay(M, 2)
				M.loc = locate(TDMGroupTwoSpawnX, TDMGroupTwoSpawnY, TDMMapZ)
				M.AutoRestore()
				M << "[SendToTDMMapMessage]"
				contestants.Add(M)

		EndTDM()
			if(Status == "Finished")
				for(var/mob/M in TDMGroupOne)
					RemoveTeamOverlay(M)
					M.GotoVillageHospital()
					TDMGroupOne.Remove(M)

				for(var/mob/M in TDMGroupTwo)
					RemoveTeamOverlay(M)
					M.GotoVillageHospital()
					TDMGroupTwo.Remove(M)

				Del()

			else if(!TDMGroupTwo.len)
				OnlinePlayers << "[RedTeamWinMessage]"

				for(var/mob/M in TDMGroupOne)
					if(M.Doubleninjacashscroll)
						M.NinjaCash += TDMEventRewardNinjaCash * 2
					else
						M.NinjaCash += TDMEventRewardNinjaCash

					M << "[TeamWinMessage]"

				Status = "Finished"

				EndTDM()

			else if(!TDMGroupOne.len)
				OnlinePlayers << "[BlueTeamWinMessage]"

				for(var/mob/M in TDMGroupTwo)
					if(M.Doubleninjacashscroll)
						M.NinjaCash += TDMEventRewardNinjaCash * 2
					else
						M.NinjaCash += TDMEventRewardNinjaCash

					M << "[TeamWinMessage]"

				Status = "Finished"

				EndTDM()

		StartTDM()
			AutomateEvents()

			Status = "Registration"

			OnlinePlayers << "[TDMStartMessagePartOne][RegistrationTimeInSeconds/60][TDMStartMessagePartTwo]"

			sleep(RegistrationTimeInSeconds * 5)

			OnlinePlayers << "[TDMStartMessagePartOne]1[TDMStartMessagePartTwo]"

			sleep(RegistrationTimeInSeconds * 5)

			Status = "Ongoing"

			OnlinePlayers << "[RegistrationFinishedMessage]"

			if(TDMGroupBuffer.len >= 2)
				DecideTDMTeams()

				TDMEventRewardNinjaCash = 10 + round((TDMGroupOne.len + TDMGroupTwo.len) ** 1.6, 5)

				OnlinePlayers << "[TeamCountMessagePartOne][TDMGroupOne.len][TeamCountMessagePartTwo][TDMGroupTwo.len][TeamCountMessagePartThree]"

				OnlinePlayers << "[NinjaCashRewardMessagePartOne][TDMEventRewardNinjaCash][NinjaCashRewardMessagePartTwo]"

				SendToTDMMap()

			else
				OnlinePlayers << "[LackingPeopleMessage]"

		Register(var/mob/M)
			if(M)
				if(Status == "Registration")
					if(M in TDMGroupBuffer)
						M << "[AlreadyJoinedTeamMessage]"
					else if(TDMGroupBuffer.len >= 14)
						M << "[TeamsFullMessage]"
					else
						OnlinePlayers << "[TDMWorldJoinMessagePartOne][M][TDMWorldJoinMessagePartTwo]"
						M << "[TDMJoinMessage]"
						TDMGroupBuffer.Add(M)

						if(M.Doubleninjacashscroll)
							M.Doubleninjacashtime--
							M << "[TDMDoubleNinjaCashMessagePartOne][M.Doubleninjacashtime][TDMDoubleNinjaCashMessagePartTwo]"
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

					for(var/mob/MM in TDMGroupOne)
						TeamOneString += "[MM]    "
					for(var/mob/MM in TDMGroupTwo)
						TeamTwoString += "[MM]    "

					M << "[TeamOneString]"
					M << "[TeamTwoString]"

		TeamMessage(var/mob/M, var/msg)
			if(msg && M)
				if(M in TDMGroupOne)
					TDMGroupOne << "[TDMTeamRedMessage][M.name] - [msg]"
				else if(M in TDMGroupTwo)
					TDMGroupTwo << "[TDMTeamBlueMessage][M.name] - [msg]"

mob
	GainedAfterLogIn
		verb
			JoinTDMEvent()
				set name = "Team Deathmatch"
				set category = "Events"
				if(usr.AgeTenImmunity)
					usr << "Not with your age ten immunity."
				else if(TDM)
					TDM.Register(usr)

			TDMEventTeams()
				set name = "Team Deathmatch Teams"
				set category = "Events"
				if(TDM)
					TDM.PrintTeams(usr)

			TDMTeamChat(msg as text)
				set name = "TDM Team Chat"
				set category = "Events"
				if(TDM)
					TDM.TeamMessage(usr, msg)
/*
			StartTDM()
				if(usr.ckey == "45tt" || usr.ckey == "cobrat1337")
					if(!TDM)
						TDM = new
						TDM.StartTDM()

			EndTDM()
				if(usr.ckey == "45tt" || usr.ckey == "cobrat1337")
					if(TDM)
						OnlinePlayers << "[TDM.ForceEndTDMMessage]"
						TDM.Status = "Finished"
						TDM.EndTDM()
*/