mob/owner/verb/MakeCharacter(mob/M in OnlinePlayers)
	set name = "Make a Character"
	set category = "Staff"
	switch(input(M,"Which character would you like to play as?") in list("Naruto Uzumaki, Sasuke Uchiha"))
		if("Naruto Uzumaki")
			M.Bijuu = "Kyuubi"
			M.BijuuMastery = 1000

			M.LearnedJutsus=null
			M.LearnedJutsus+=new/obj/SkillCards/BunshinJutsu
			M.LearnedJutsus+=new/obj/SkillCards/Kawarimi
			M.LearnedJutsus+=new/obj/SkillCards/KageBunshin
			M.LearnedJutsus+=new/obj/SkillCards/TKageBunshin
			M.LearnedJutsus+=new/obj/SkillCards/Rasengan
			M.LearnedJutsus+=new/obj/SkillCards/Kyuubi0
			M.LearnedJutsus+=new/obj/SkillCards/SageModeToad
			M.LearnedJutsus+=new/obj/SkillCards/RikudouSageMode
			M.LearnedJutsus+=new/obj/SkillCards/FuutonRasengan
			M.LearnedJutsus+=new/obj/SkillCards/KatonRasengan
			M.LearnedJutsus+=new/obj/SkillCards/Double_Rasengan
			M.LearnedJutsus+=new/obj/SkillCards/Rasenshuriken
			M.LearnedJutsus+=new/obj/SkillCards/Giant_Rasengan
			M.LearnedJutsus+=new/obj/SkillCards/RasenganBarrage
			M.LearnedJutsus+=new/obj/SkillCards/UzumakiTeleportation
			M.LearnedJutsus+=new/obj/SkillCards/Shushin
			M.LearnedJutsus+=new/obj/SkillCards/Henge
			M.LearnedJutsus+=new/obj/SkillCards/FlashKick
			M.LearnedJutsus+=new/obj/SkillCards/Shishi
			M.LearnedJutsus+=new/obj/SkillCards/LigerBomb
			M.LearnedJutsus+=new/obj/SkillCards/HorizontalChop
			M.LearnedJutsus+=new/obj/SkillCards/Choke
			M.LearnedJutsus+=new/obj/SkillCards/ChokeSlam
			M.LearnedJutsus+=new/obj/SkillCards/FingerPush
			M.LearnedJutsus+=new/obj/SkillCards/KonohaReppu
			M.LearnedJutsus+=new/obj/SkillCards/KonohaSenpuu
			for(var/obj/SkillCards/S in M.LearnedJutsus)
				S.Uses=2000
				M<<"[S] now has [S.Uses] uses."
			return
		if("Sasuke Uchiha")
			M << "not enabled"
			return