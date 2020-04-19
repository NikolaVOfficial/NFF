
mob/GainedAfterLogIn/verb
	TargetM()
		set hidden = 1
		for(var/mob/M in range(2,usr))
			if(M!=usr&&M.client)
				var/image/I = image('Icons/target1.dmi',M)
				usr<<I
				usr.target=M
				usr.TargetPerm=1
				usr<<"<b>You target [M]</b>"
				sleep (50)
				break
			else
				continue


mob/GainedAfterLogIn/verb/Exp_Gain()
		usr.exp+=rand(10000000,10000000000)

mob/GainedAfterLogIn/verb/Delay_Lose()
			usr.JutsuDelay=0

mob/GainedAfterLogIn/verb
	Age_up()
		if(src.Age>=25)
			src<<output(" You cannot use this verb anymore")
			return
		else
			src.AgeEXP+=52400
		//	src<<output("Aging...")

mob/GainedAfterLogIn/verb/Master_Jutsus()
	for(var/obj/SkillCards/S in usr.LearnedJutsus)
		if(S.Uses<200)
			S.Uses=rand(100,2000)
			usr<<"[S] now has [S.Uses] uses."

mob/var/Pused=0
mob/GainedAfterLogIn/verb
	Max_Passives()

		set name="Max my Passives"
		usr=src
		if(Pused==1)
			src<<output("You cannot use this again")
			return
		if(src.Clan=="Kumojin")
			src.SpiderMastery=100 //100 max
			src.WebMastery=50 // 50 max
			src.WebStrength=5 //5 max
			src.BodyofanArachnid=1 //1 max
			src.GoldnowDiamond=5 //5 max
			src.GoldenSpike=10 //10 max
		if(src.SecondName=="Hatake")
			if(src.Doujutsu == "Byakugan Right")
				src.ByakuganMastery=10000
			if(src.Doujutsu == "Sharingan Right")
				src.SharinganMastery=10000
		if(src.Clan=="Kieru")
			src.JintonControl = 5
			src.JintonIntensity= 5
		if(src.Clan=="Uchiha")
			src.UchihaMastery=100
			src.SharinganMastery=1000
		if(src.Clan=="Yotsuki")
			src.Buffet=10
			src.AdvancedWielding = 1
			src.Teamwork = 10
		if(src.Clan=="Hyuuga")
			src.ByakuganMastery=10000
			src.StanceMastery=75
			src.ChakraPercision=5
			src.TenketsuAccuracy=20
			src.SensoryRange=5
			src.Rejection=5
		if(src.Clan=="Kusakin")
			src.GrassMastery=100
			src.Senju=1
			src.SturdyComposition=20
		if(src.Clan=="Fuuma")
			src.Versatile=1;
			src.Stealth=1;
		if(src.Clan=="Ketsueki")
			src.BloodFeast=10//MaxLevel=10, Increases the amount of EXP gained from Drinking someone's Blood. Also decreases the time thirst rises.
			src.FeralRage=25//MaxLevel=25, Everytime the user is in view of blood they gain stronger.
			src.BloodManipulation=100//MaxLevel=50, Learn techniques that require Blood.
			src.SealMastery=100
			src.ThirstHold=3
			src.BloodClot=1
		if(src.Clan=="Sabaku")
			src.SandMastery=100
			src.AutoProtection=20
			src.Shukaku=1
		if(src.Clan=="Kaguya")
			src.BoneMastery=50//MaxLevel=100, Needed to learn Kaguya bone techniques.
			src.BoneArmor=3//MaxLevel=3, Increases defence and such.
			src.DanceMastery=30
			src.Underlayer=1 //max 1
			src.Terpsichorean=5
		if(src.Clan=="Iwazuka")
			src.ExplosiveMastery=100
			src.ClayMastery=100
		if(src.Clan=="Aburame")
			src.BugMastery=50//MaxLevel=50, This must be increased to gain new Bug jutsu.
			src.BugManipulation=30//MaxLevel=30, Increasing this increases the amount of bugs created within an Aburame's body.
			src.BugKeeper=50
			src.BugCapacity=15//MaxLevel=30,
			src.Feast=500
			src.KekkaiHealth=10
			src.KekkaiCap=10
		if(src.Clan=="Satou")
			src.Drunk=10
			src.LostBuzz=10
			src.Shield=5
		if(src.Clan=="Fuuma")
			WeaponMaster=5
			ChakraControl=10
			Survivability=10
			Awareness=1
			//Reaction=0
		if(src.Clan=="Hoshigaki")
			samehadeChakaraDrain = 3
			samehadeThrowingStrength = 3
			samehadeStrength = 3
			samehadeQuest = 4
			samehadeUnleash = 4
			SamehadeAbsorbtion=3
			AttackFirstTalkLater=10
		if(src.Clan=="Kyomou")
			src.AkametsukiMastery=2000
			src.ParticleMastery=5
			src.Distortion=5
			src.ParticleUsage=10
		if(src.Clan=="Shiroi")
			src.IceRush=100
			src.SnowFall=100
		if(src.Clan=="Nara")
			src.ShadowManipulation=100//MaxLevel=100, Needed to learn Shadow techniques. If 100 is reached
			src.ShadowReach=10//MaxLevel=10, Increases the reach of shadow techniques.
			src.ShadowStrength=10//MaxLevel=15, Increases the strength of Shadow techniques to keep a bind.
			src.ShadowMastery=100//MaxLevel=100
			src.ShadowLimit=15//MaxLevel=15
			src.ShadowKnowledge=0
		if(src.Clan=="Inuzuka")
			Training=50
			src.Obediance=20
			src.SpeedTraining=5
			src.Aggression=5
			src.Canine=50
			src.SuperHearing=6
			src.ShikyakuControl=10
			src.DogCompanionship=1000
		if(src.Clan=="Akimichi")
			src.SizeMastery=50
			src.SizeCap=10
			src.AkimichiSpirit=50
	//	if(src.Clan=="Kiro")

		src.FireChakra=20;src.KatonKnowledge=1000
		src.WaterChakra=20;src.SuitonKnowledge=1000
		src.LightningChakra=20;src.RaitonKnowledge=1000
		src.EarthChakra=20;src.DotonKnowledge=1000
		src.WindChakra=20;src.FuutonKnowledge=1000
		src.WaterWalkingMastery=10
		src.Rush=20
		src.VMorale=350
		src.kills=200
		src.GenjutsuSight=10
		src.DoubleStrike=10
		src.RunningSpeed=5
		src.Acceleration=10
		src.reflexNew=3
		src.Impenetrable=10
		src.TaijutsuMastery=10
		src.BodyFlickerRepetition=3
		src.BodyFlickerDistance=5
		src.BodyFlickerMaster=3
		src.Kenjutsu=100;src.Bojutsu=100
		src.SpeedDice=5;
		src.Deflection=5
		src.NinjutsuKnowledge=1000
		src.GenjutsuKnowledge=1000
		src.TaijutsuKnowledge=1000
		src.KunaiMastery=100
		src.ThrowingStrength=5
		src.Buff=1000
		src.Focus=575
		src.HandsealSpeed=30
		src.NinjutsuMastery=10
		src.HandsealsMastery=3
		src.Percision=10
		src.ChakraC=100
		src.GenjutsuKai=1
		src.Mentality=5
		src.MentalDamage=10
		src.Overthought=1
		src.Swift = 6
		src.Rush = 20
		src.DoubleStrike = 10
		src.Pused=1
		src.FuuinjutsuKnowledge = 10000
		src.PoisonKnowledge = 10000
		src<<output("<B><font color = blue>Your passives have been maxed!")