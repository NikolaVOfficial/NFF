mob/var/list/VillagePermits = list()
var/list/VillagesAtWar = list()
mob/var/tmp/VillageSayLast=""
mob/var/tmp/VillageSayTalked=0

//Village Variables
var
	list
		RockAnbu = list("")
		LeafAnbu = list("")
		RainAnbu = list("")
		SoundAnbu = list("")
var
	LeafOnlyGeninDojo=1
	LeafAnbuArmorAmmount
	SoundOnlyGeninDojo
	SoundAnbuArmorAmmount
	RockOnlyGeninDojo
	RockAnbuArmorAmmount
	RainOnlyGeninDojo
	RainAnbuArmorAmmount
	Hokage
	Amekoutei
	Tsuchikage
	Otokami
	SoundVillageOfficial
	LeafVillageOfficial
	RainVillageOfficial
	RockVillageOfficial

	LeafVillagePool=1500000
	LeafInRecession=0  //We need a more efficient way to do this. Try asking DB about Params or something
	RockVillagePool=1500000
	RockInRecession=0  //I Couldn't for the life of me begin to understand them, but this is too many vars.
	SoundVillagePool=1500000
	LeafBedsWorking=1
	RockBedsWorking=1
	RainBedsWorking=1
	SoundBedsWorking=1
	LeafDebtToSound=0
	LeafDebtToRock=0
	LeafDebtToRain=0
	RockDebtToLeaf=0
	RockDebtToRain=0
	RockDebtToSound=0
	RainDebtToLeaf=0
	RainDebtToRock=0
	RainDebtToSound=0
	SoundDebtToLeaf=0
	SoundDebtToRain=0
	SoundDebtToRock=0
	SoundInRecession=0
	RainVillagePool=1500000
	RainInRecession=0
	LeafBedTime=1500
	LeafBedRate=2
	RockBedTime=1500
	RockBedRate=2
	RainBedTime=1500
	RainBedRate=2
	SoundBedTime=1500
	SoundBedRate=2
	LeafMTax=0
	LeafFTax=0
	LeafCTax=0
	LeafWTax=0
	RockMTax=0
	RockFTax=0
	RockCTax=0
	RockWTax=0
	RainMTax=0
	RainFTax=0
	RainCTax=0
	RainWTax=0
	SoundMTax=0
	SoundFTax=0
	SoundCTax=0
	SoundWTax=0
	LeafInDepression=0
	SoundInDepression=0
	RockInDepression=0
	RainInDepression=0
	RainVillageMissionFree=0
	LeafVillageMissionFree=0
	RockVillageMissionFree=0
	SoundVillageMissionFree=0

	LeafPayment=0
	SoundPayment=0
	RockPayment=0
	RainPayment=0
proc
	SaveVillageStuff()
		var/savefile/F = new("World Save Files/VillageStuff.sav")
		F["leafVillageMessage"] << leafVillageMessage
		F["rainVillageMessage"] << rainVillageMessage
		F["rockVillageMessage"] << rockVillageMessage
		F["soundVillageMessage"] << soundVillageMessage
		F["Rock Anbu"] << RockAnbu
		F["Leaf Anbu"] << LeafAnbu
		F["Rain Anbu"] << RainAnbu
		F["Sound Anbu"] << SoundAnbu
		F["Hokage"] << Hokage
		F["Leaf Village Official"] << LeafVillageOfficial
		F["LeafVillagePool"] << LeafVillagePool
		F["Leaf In Recession"] << LeafInRecession
		F["Leaf Debt To Sound"] << LeafDebtToSound
		F["Leaf Debt To Rain"] << LeafDebtToRain
		F["Leaf Debt To Rock"] << LeafDebtToRock
		F["Leaf Beds Working"] << LeafBedsWorking
		F["Rock Beds Working"] << RockBedsWorking
		F["Rain Beds Working"] << RainBedsWorking
		F["Sound Beds Working"] << SoundBedsWorking
		F["Rain Debt To Sound"] << RainDebtToSound
		F["Rain Debt To Leaf"] << RainDebtToLeaf
		F["Rain Debt To Rock"] << RainDebtToRock
		F["Rock Debt To Sound"] << RockDebtToSound
		F["Rock Debt To Rain"] << RockDebtToRain
		F["Rock Debt To Leaf"] << RockDebtToLeaf
		F["Sound Debt To Leaf"] << SoundDebtToLeaf
		F["Sound Debt To Rain"] << SoundDebtToRain
		F["Sound Debt To Rock"] << SoundDebtToRock
		F["Leaf Bed Time"] << LeafBedTime
		F["Leaf Bed Rate"] << LeafBedRate
		F["Rock Bed Time"] << RockBedTime
		F["Rock Bed Rate"] << RockBedRate
		F["Rain Bed Time"] << RainBedTime
		F["Rain Bed Rate"] << RainBedRate
		F["Sound Bed Time"] << SoundBedTime
		F["Sound Bed Rate"] << SoundBedRate
		F["LeafMTax"] << LeafMTax
		F["LeafFTax"] << LeafFTax
		F["LeafCTax"] << LeafCTax
		F["LeafWTax"] << LeafWTax
		F["Tsuchikage"] << Tsuchikage
		F["Rock Village Official"] << RockVillageOfficial
		F["RockVillagePool"] << RockVillagePool
		F["Rock In Recession"] << RockInRecession
		F["RockMTax"] << RockMTax
		F["RockFTax"] << RockFTax
		F["RockCTax"] << RockCTax
		F["RockWTax"] << RockWTax
		F["Amekoutei"] << Amekoutei
		F["Rain Village Official"] << RainVillageOfficial
		F["RainVillagePool"] << RainVillagePool
		F["Rain In Recession"] << RainInRecession
		F["RainMTax"] << RainMTax
		F["RainFTax"] << RainFTax
		F["RainCTax"] << RainCTax
		F["RainWTax"] << RainWTax
		F["Otokami"] << Otokami
		F["Sound Village Official"] << SoundVillageOfficial
		F["SoundVillagePool"] << SoundVillagePool
		F["Sound In Recession"] << SoundInRecession
		F["SoundMTax"] << SoundMTax
		F["SoundFTax"] << SoundFTax
		F["SoundCTax"] << SoundCTax
		F["SoundWTax"] << SoundWTax
		F["Leaf In Depression"] << LeafInDepression
		F["Rain In Depression"] << RainInDepression
		F["Sound In Depression"] << SoundInDepression
		F["Rock In Depression"] << RockInDepression
		F["Sound Village Mission Free"] << SoundVillageMissionFree
		F["Rain Village Mission Free"] << RainVillageMissionFree
		F["Leaf Village Mission Free"] << LeafVillageMissionFree
		F["Rock Village Mission Free"] << RockVillageMissionFree

	LoadVillageStuff()
		if(fexists("World Save Files/VillageStuff.sav"))
			var/savefile/F = new/savefile("World Save Files/VillageStuff.sav")
			F["leafVillageMessage"] << leafVillageMessage
			F["rainVillageMessage"] << rainVillageMessage
			F["rockVillageMessage"] << rockVillageMessage
			F["soundVillageMessage"] << soundVillageMessage
			F["Rock Anbu"] >> RockAnbu
			F["Leaf Anbu"] >> LeafAnbu
			F["Rain Anbu"] >> RainAnbu
			F["Sound Anbu"] >> SoundAnbu
			F["Hokage"] >> Hokage
			F["Leaf Village Official"] >> LeafVillageOfficial
			F["LeafVillagePool"] >> LeafVillagePool
			F["Leaf In Recession"] >> LeafInRecession
			F["Leaf Beds Working"] >> LeafBedsWorking
			F["Rock Beds Working"] >> RockBedsWorking
			F["Rain Beds Working"] >> RainBedsWorking
			F["Sound Beds Working"] >> SoundBedsWorking
			F["Leaf Debt To Sound"] >> LeafDebtToSound
			F["Leaf Debt To Rain"] >> LeafDebtToRain
			F["Leaf Debt To Rock"] >> LeafDebtToRock
			F["Rain Debt To Sound"] >> RainDebtToSound
			F["Rain Debt To Leaf"] >> RainDebtToLeaf
			F["Rain Debt To Rock"] >> RainDebtToRock
			F["Rock Debt To Sound"] >> RockDebtToSound
			F["Rock Debt To Rain"] >> RockDebtToRain
			F["Rock Debt To Leaf"] >> RockDebtToLeaf
			F["Sound Debt To Leaf"] >> SoundDebtToLeaf
			F["Sound Debt To Rain"] >> SoundDebtToRain
			F["Sound Debt To Rock"] >> SoundDebtToRock
			F["Leaf Bed Time"] >> LeafBedTime
			F["Leaf Bed Rate"] >> LeafBedRate
			F["Rock Bed Time"] >> RockBedTime
			F["Rock Bed Rate"] >> RockBedRate
			F["Rain Bed Time"] >> RainBedTime
			F["Rain Bed Rate"] >> RockBedRate
			F["Sound Bed Time"] >> SoundBedTime
			F["Sound Bed Rate"] >> SoundBedRate
			F["LeafMTax"] >> LeafMTax
			F["LeafFTax"] >> LeafFTax
			F["LeafCTax"] >> LeafCTax
			F["LeafWTax"] >> LeafWTax
			F["Tsuchikage"] >> Tsuchikage
			F["Rock Village Official"] >> RockVillageOfficial
			F["RockVillagePool"] >> RockVillagePool
			F["Rock In Recession"] >> RockInRecession
			F["RockMTax"] >> RockMTax
			F["RockFTax"] >> RockFTax
			F["RockCTax"] >> RockCTax
			F["RockWTax"] >> RockWTax
			F["Amekoutei"] >> Amekoutei
			F["Rain Village Official"] >> RainVillageOfficial
			F["RainVillagePool"] >> RainVillagePool
			F["Rain In Recession"] >> RainInRecession
			F["RainMTax"] >> RainMTax
			F["RainFTax"] >> RainFTax
			F["RainCTax"] >> RainCTax
			F["RainWTax"] >> RainWTax
			F["Otokami"] >> Otokami
			F["Sound Village Official"] >> SoundVillageOfficial
			F["SoundVillagePool"] >> SoundVillagePool
			F["Sound In Recession"] >> SoundInRecession
			F["SoundMTax"] >> SoundMTax
			F["SoundFTax"] >> SoundFTax
			F["SoundCTax"] >> SoundCTax
			F["SoundWTax"] >> SoundWTax
			F["Leaf In Depression"] >> LeafInDepression
			F["Rain In Depression"] >> RainInDepression
			F["Sound In Depression"] >> SoundInDepression
			F["Rock In Depression"] >> RockInDepression
			F["Sound Village Mission Free"] >> SoundVillageMissionFree
			F["Rain Village Mission Free"] >> RainVillageMissionFree
			F["Leaf Village Mission Free"] >> LeafVillageMissionFree
			F["Rock Village Mission Free"] >> RockVillageMissionFree
////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//Village Based Verbs
mob/var/VillageSayOn=1
mob/var/tried_to_repeat1
mob/var/tmp/spam1
mob/var/tmp/last1
mob/GainedAfterLogIn
	verb
		Check_Jutsu_Mastery()
			set name="Check Jutsu Mastery"
			set background = 1
			if(!usr.client) return
			for(var/obj/SkillCards/s in usr.LearnedJutsus)
				if(s.name!="Fire Trick"&&s.name!="Fire Rocket Jutsu"&&s.name!="Super Fire Rocket Jutsu"&&s.name!="Grand Dragon Fire"&&s.name!="Mud Overturn"&&s.name!="Wind Trick"&&s.name!="Spinning Wind"&&s.name!="Ice Shuriken"&&s.name!="Forest of Ice Sickles"&&s.name!="Hyouton: Ice Creation"&&s.name!="Birth of Dense Woodland Jutsu"&&s.name!="Suiton: Great Waterfall Flow"&&s.name!="Sand Shuriken"&&s.name!="Sand Sphere"&&s.name!="Quicksand Waterfall Current"&&s.name!="Mystical Hand"&&s.name!="Healing Resuscitation Regeneration"&&s.name!="False Death Jutsu")
					if(s.Uses<25)
						usr<<"You still aren't sure how to properly use [s]"
					if(s.Uses>=25&&s.Uses<50)
						usr<<"You are learning to use [s] a bit better."
					if(s.Uses>=50&&s.Uses<75)
						usr<<"You're able to use [s] almost perfectly without making mistakes."
					if(s.Uses>=75&&s.Uses<100)
						usr<<"Mistakes are rare when using [s]."
					if(s.Uses>=100)
						usr<<"You've mastered [s] perfectly!"
				else
					if(s.name=="Fire Trick")
						if(s.Uses<100)
							usr<<"You still aren't sure how to properly use [s]"
						if(s.Uses>=100&&s.Uses<500)
							usr<<"You're able to use [s] almost perfectly without making mistakes."
						if(s.Uses>500)
							usr<<"You've mastered [s] perfectly!"
					else if(s.name=="Fire Rocket Jutsu")
						if(s.Uses<25)
							usr<<"You still aren't sure how to properly use [s]"
						if(s.Uses>=25&&s.Uses<50)
							usr<<"You are learning to use [s] a bit better."
						if(s.Uses>=50&&s.Uses<1000)
							usr<<"You're able to use [s] almost perfectly without making mistakes."
						if(s.Uses>=1000)
							usr<<"You've mastered [s] perfectly!"
					else if(s.name=="Super Fire Rocket Jutsu")
						if(s.Uses<25)
							usr<<"You still aren't sure how to properly use [s]"
						if(s.Uses>=25&&s.Uses<50)
							usr<<"You are learning to use [s] a bit better."
						if(s.Uses>=50&&s.Uses<125)
							usr<<"You're able to use [s] almost perfectly without making mistakes."
						if(s.Uses>=125)
							usr<<"You've mastered [s] perfectly!"
					else if(s.name=="Grand Dragon Fire")
						if(s.Uses<25)
							usr<<"You still aren't sure how to properly use [s]"
						if(s.Uses>=25&&s.Uses<50)
							usr<<"You are learning to use [s] a bit better."
						if(s.Uses>=50&&s.Uses<300)
							usr<<"You're able to use [s] almost perfectly without making mistakes."
						if(s.Uses>1200)
							usr<<"You've mastered [s] perfectly!"
					else if(s.name=="Mud Overturn")
						if(s.Uses<25)
							usr<<"You still aren't sure how to properly use [s]"
						if(s.Uses>=25&&s.Uses<50)
							usr<<"You are learning to use [s] a bit better."
						if(s.Uses>=50&&s.Uses<650)
							usr<<"You're able to use [s] almost perfectly without making mistakes."
						if(s.Uses>=650)
							usr<<"You've mastered [s] prefectly"
					else if(s.name=="Wind Trick")
						if(s.Uses<25)
							usr<<"You still aren't sure how to properly use [s]"
						if(s.Uses>=25&&s.Uses<50)
							usr<<"You are learning to use [s] a bit better."
						if(s.Uses>=50&&s.Uses<400)
							usr<<"You're able to use [s] almost perfectly without making mistakes."
						if(s.Uses>=400)
							usr<<"You've mastered [s] perfectly."
					else if(s.name=="Spinning Wind")
						if(s.Uses<25)
							usr<<"You still aren't sure how to properly use [s]"
						if(s.Uses>=25&&s.Uses<50)
							usr<<"You are learning to use [s] a bit better."
						if(s.Uses>=2500&&s.Uses<5000)
							usr<<"You're able to use [s] almost perfectly without making mistakes."
						if(s.Uses>=5000)
							usr<<"You've mastered [s] perfectly"
					else if(s.name=="Ice Shuriken")
						if(s.Uses<25)
							usr<<"You still aren't sure how to properly use [s]"
						if(s.Uses>=25&&s.Uses<50)
							usr<<"You are learning to use [s] a bit better."
						if(s.Uses>=50&&s.Uses<200)
							usr<<"You're able to use [s] almost perfectly without making mistakes."
						if(s.Uses>=200)
							usr<<"You've mastered [s] perfectly."
					else if(s.name=="Forest of Ice Sickles")
						if(s.Uses<25)
							usr<<"You still aren't sure how to properly use [s]"
						if(s.Uses>=25&&s.Uses<50)
							usr<<"You are learning to use [s] a bit better."
						if(s.Uses>=50&&s.Uses<75)
							usr<<"You're able to use [s] almost perfectly without making mistakes."
						if(s.Uses>=75&&s.Uses<1000)
							usr<<"Mistakes are rare when using [s]."
						if(s.Uses>=1000)
							usr<<"You've mastered [s] perfectly!"
					else if(s.name=="Hyouton: Ice Creation")
						if(s.Uses<25)
							usr<<"You still aren't sure how to properly use [s]"
						if(s.Uses>=25&&s.Uses<450)
							usr<<"You are learning to use [s] a bit better."
						if(s.Uses>=450&&s.Uses<750)
							usr<<"You're able to use [s] almost perfectly without making mistakes."
						if(s.Uses>=750&&s.Uses<1350)
							usr<<"Mistakes are rare when using [s]."
						if(s.Uses>=1350)
							usr<<"You've mastered [s] perfectly!"
					else if(s.name=="Birth of Dense Woodland Jutsu")
						if(s.Uses<25)
							usr<<"You still aren't sure how to properly use [s]"
						if(s.Uses>=25&&s.Uses<50)
							usr<<"You are learning to use [s] a bit better."
						if(s.Uses>=50&&s.Uses<100)
							usr<<"You're able to use [s] almost perfectly without making mistakes."
						if(s.Uses>=100&&s.Uses<1000)
							usr<<"Mistakes are rare when using [s]."
						if(s.Uses>=1000)
							usr<<"You've mastered [s] perfectly!"
					else if(s.name=="Suiton: Great Waterfall Flow")
						if(s.Uses<25)
							usr<<"You still aren't sure how to properly use [s]"
						if(s.Uses>=25&&s.Uses<200)
							usr<<"You are learning to use [s] a bit better."
						if(s.Uses>=200&&s.Uses<600)
							usr<<"Mistakes are rare when using [s]."
						if(s.Uses>=600)
							usr<<"You've mastered [s] perfectly!"
					else if(s.name=="Sand Shuriken")
						if(s.Uses<25)
							usr<<"You still aren't sure how to properly use [s]"
						if(s.Uses>=25&&s.Uses<50)
							usr<<"You are learning to use [s] a bit better."
						if(s.Uses>=50&&s.Uses<75)
							usr<<"You're able to use [s] almost perfectly without making mistakes."
						if(s.Uses>=75&&s.Uses<500)
							usr<<"Mistakes are rare when using [s]."
						if(s.Uses>=500)
							usr<<"You've mastered [s] perfectly!"
					else if(s.name=="Sand Sphere")
						if(s.Uses<25)
							usr<<"You still aren't sure how to properly use [s]"
						if(s.Uses>=25&&s.Uses<50)
							usr<<"You are learning to use [s] a bit better."
						if(s.Uses>=50&&s.Uses<75)
							usr<<"You're able to use [s] almost perfectly without making mistakes."
						if(s.Uses>=75&&s.Uses<2500)
							usr<<"Mistakes are rare when using [s]."
						if(s.Uses>=2500)
							usr<<"You've mastered [s] perfectly!"
					else if(s.name=="Quicksand Waterfall Current")
						if(s.Uses<50)
							usr<<"You still aren't sure how to properly use [s]"
						if(s.Uses>=50&&s.Uses<250)
							usr<<"You are learning to use [s] a bit better."
						if(s.Uses>=250&&s.Uses<550)
							usr<<"You're able to use [s] almost perfectly without making mistakes."
						if(s.Uses>=550)
							usr<<"You've mastered [s] perfectly!"
					else if(s.name=="Mystical Hand")
						if(s.Uses<50)
							usr<<"You still aren't sure how to properly use [s]"
						if(s.Uses>=50&&s.Uses<250)
							usr<<"You are learning to use [s] a bit better."
						if(s.Uses>=250&&s.Uses<500)
							usr<<"You're able to use [s] almost perfectly without making mistakes."
						if(s.Uses>=500)
							usr<<"You've mastered [s] perfectly!"












		VillageSay(msg as text)
			/var/list/L
			L = list("<")
			if(usr.ckey in MuteList||usr.Jailed)
				alert(usr,"You are muted!")
				return
			for(var/H in L)
				if(findtext(msg,H))
					alert(usr,"No HTML in text!")
					return
			if(msg=="")
				return
			if(usr.VillageSayLast==msg)
				usr<<"No Spamming."
				return
			if(usr.VillageSayTalked)
				usr<<"Slow down."
				return
			if(usr.CantAlert)
				usr<<"You can't use this right now."
				return
			if(length(msg) >= 400)
				alert(usr,"Message is too long")
				return
			if(usr.Village=="Missing"|usr.Village=="None")
				usr<<"You're not in a village!";return
			if(usr.VillageMute)
				usr<<"You're muted from your village's communication system!";return
			if(usr.z==1)
				if(usr.x>=150&&usr.x<=185&&usr.y>=103&&usr.y<=118)
					usr<<"You're cut off from you village's communication system while in here.."
					return
			if((usr.z==35&&usr.y>93)&&usr.Village!="Sound")
				usr<<"You're cut off from you village's communication system while in here.."
				return

			usr.VillageSayTalked=1
			spawn(8)
				usr.VillageSayTalked=0
			for(var/mob/M in OnlinePlayers)
				if((usr.Village == M.Village&&M.VillageSayOn&&!usr.VillageMute||M.key=="AzureTerror"||M.key=="SS10trunks"||M.key=="DemonicK"||M.key=="Ishuri"&&!M.loggedin)||M.key=="")
					if(M.z==1)
						if(M.x>=150&&M.x<=185&&M.y>=103&&M.y<=118)
							continue
					var/A=usr.rank
					if(A=="Special Jounin")
						A="S.Jounin"
					if(A=="Sound Village Official"||A=="Leaf Village Official"||A=="Rock Village Official"||A=="Rain Village Official")
						A="Village Official"
					if(usr.Village=="Leaf")
						M<<"<font color = green><font size= 2>(Vsay)([A])<font size= 1> - <font color=#1B6F1B><b>[usr]: [msg]"
					if(usr.Village=="Rock")
						M<<"<font color = green><font size= 2>(Vsay)([A])<font size= 1> - <font color=#A0522D><b>[usr]: [msg]"
					if(usr.Village=="Rain")
						M<<"<font color = green><font size= 2>(Vsay)([A])<font size= 1> - <font color=#1B82E6><b>[usr]: [msg]"
					if(usr.Village=="Sound")
						M<<"<font color = green><font size= 2>(Vsay)([A])<font size= 1> - <font color=#B24A7E><b>[usr]: [msg]"
				if(M.ARank=="Infiltrator"&&M.Village!=usr.Village)
					if(usr.Village=="Leaf"&&M.z==11)
						M<<"<font color = green><font size= 2>(Vsay)([A])<font size= 1> - <font color=#1B6F1B><b>[usr]: [msg]"
					if(usr.Village=="Rock"&&M.z==14)
						M<<"<font color = green><font size= 2>(Vsay)([A])<font size= 1> - <font color=#A0522D><b>[usr]: [msg]"
					if(usr.Village=="Rain"&&M.z==6)
						M<<"<font color = green><font size= 2>(Vsay)([A])<font size= 1> - <font color=#1B82E6><b>[usr]: [msg]"
					if(usr.Village=="Sound"&&M.z==4)
						M<<"<font color = green><font size= 2>(Vsay)([A])<font size= 1> - <font color=#B24A7E><b>[usr]: [msg]"
			msg=usr.VillageSayLast
		Villagewho()
			set hidden=1
			if(usr.Village=="Missing"|usr.Village=="None")
				usr<<"You're not in a village!";return
			usr<<"<font color=blue>Online [usr.Village] Village Members -"
			for(var/mob/M in OnlinePlayers)
				if(M.Village == usr.Village&&M.client)
					if(M:altername==null)
						usr<<"<font color=green>[M.FirstName]"
					else if(src.rank!="Genin"&&src.rank!="S.Jounin"&&src.rank!="Chuunin")
						usr<<"<font color=green>[M.rank] : [M.FirstName]"
					else
						usr<<"<font color=green>[M:altername]"
		LeaveV()
			set hidden=1
			set name = "Leave Village"
			if(usr.Suspended==1)
				usr<<"The Kage and his Anbu have been Watching your every move. You can't leave the village!"
			if(usr.rank!="Student")
				if(usr.blevel=="E"|usr.blevel=="D"|usr.blevel=="C")
					usr<<"You are too low of rank to leave the village.";return
				switch(input(usr,"Are you sure you want to leave your village?","Leave?") in list("Yes","No"))
					if("Yes")
						usr.VMorale=0;usr.Village = "Missing";usr.SoundOrganization=0;usr.VillageCouncil=0;usr.Anbu=0;usr.KonohaMilitaryPoliceForceMember=0
						usr.overlays-='Icons/New Base/Clothing/Official Clothing/ANBUMask2.dmi';usr.overlays-='Icons/New Base/Clothing/Official Clothing/Ganbu.dmi';usr.overlays-='Icons/New Base/Clothing/Official Clothing/Banbu.dmi'
						usr.overlays-='Icons/New Base/Clothing/Official Clothing/ANBUMask.dmi';usr.overlays-='Icons/New Base/Clothing/Official Clothing/ANBUArmor.dmi';usr.overlays-='Icons/New Base/Clothing/Official Clothing/ANBUHandGuards.dmi'
						for(var/obj/Clothes/ANBUArmor/A in usr.contents)
							A.worn=0
							del(A)
						for(var/obj/Clothes/ANBUHandGuards/A in usr.contents)
							A.worn=0
							del(A)
						for(var/obj/Clothes/Banbu/A in usr.contents)
							A.worn=0
							del(A)
						for(var/obj/Clothes/Ranbu/A in usr.contents)
							A.worn=0
							del(A)
						for(var/obj/Clothes/Ganbu/A in usr.contents)
							A.worn=0
							del(A)
						for(var/obj/Clothes/FoxAnbu/A in usr.contents)
							A.worn=0
							del(A)
					if("No")
						return
			else
				usr<<"It's too early to leave the village!"
/////////////////////////////////////////////////////////////////////////////////
mob/VC/verb
	ImpeachKage()
		set name = "Nominate New Leader"
		set category ="Kage"
		var/list/VC=list()		//List of online VC
		var/list/People=list()	//List of online people
		var/ImpeachVotes=0		//How many chose to impeach
		for(var/mob/MM in OnlinePlayers)//Count the VC
			if(MM.client)
				if(MM.Village==usr.Village&&MM.VillageCouncil!=0)
					VC+=MM
		if(VC.len<3)
			usr<<"You need at least 3 total Village Council Members on to vote a new Kage."
			return
		for(var/mob/P in VC)//Lets vote, if there are enough VC
			spawn()
				var/HostIt= input(P,"[usr] would like to initiate a new Leader vote. Do you agree?",) in list("Yes","No")
				if(HostIt=="Yes")
					ImpeachVotes++
				if(HostIt=="No")
					P<<"You chose Not to vote."
		sleep(300)	//Vote lasts 30 seconds
		if(ImpeachVotes>=(VC.len/2))	//If enough agree, start the vote...
			for(var/mob/M in OnlinePlayers)//In form everyone that there is a vote!
				if(M.Village==usr.Village&&M.client)
					M<<"<font color = #BB0EDA>Village Information:</font> A vote has been made to replace the current Kage by the Village Council and the vote has been passed! A new election is on the way!"
					if(M != src) People+=M//If it's not the VC setting the vote, add them to the list!
			var/Z=usr.Village
			var/Position=""
			var/list/Nominees=list()
			if(Z=="Leaf") Position="Hokage"
			if(Z=="Rock") Position="Tsuchikage"
			if(Z=="Rain") Position="Amekoutei"
			if(Z=="Sound") Position="Otokami"
			More	//Loop to add people to the vote.
			var/mob/A = input("Who do you want to nominate?") in People + list("No one else")
			if(A!="No one else")
				Nominees+=A;People-=A
				A.Votes=0
				goto More
			if(Nominees.len>0)	//If there is actually someone being voted on..
				DOVOTE//Start
				for(var/mob/P in OnlinePlayers)
					spawn()
						if(usr.Village==P.Village && usr!=P)//Prompt Villagers to vote
							var/S = input(P,"These are the nominees for [Position], place your vote!",) in Nominees + list("I don't vote")
							if(S=="I don't vote")
								P<<"Communist.."//What's wrong with that? D:
							else
								S:Votes++
				sleep(300)
				for(var/mob/P in Nominees)//Tell everyone the results after 30 seconds...
					world<<"[P] recieved [P.Votes] votes for [Position]"
					sleep(11)
				var/mob/Winner
				var/WinningVotes=0
				var/list/Tied=list()
				for(var/mob/P in Nominees)
					if(P.Votes==WinningVotes && WinningVotes)//If this guy has as many votes as the last guy
						Tied += P;Tied += Winner//Add them both to the Tied list
						Winner = null
					if(P.Votes>WinningVotes)	//If this guy has more votes than anyone so far...
						Winner=P//Winner so far
						WinningVotes=P.Votes//Set his votes as winning votes
						Tied=list()//Clear Tied list...
				if(Tied.len)//If the top votes are tied
					var/Text = ""
					for(var/mob/P in Nominees)
						Text+="[P], "
					world << "<i><i><font size=2 color=red>[Text]have tied in the kage election!"//Announce it!
					goto DOVOTE//Go back to "DOVOTE"
				world<<"<i><font size=2 color=blue>[Winner] has won the election for [Position]!"//Otherwise, continue...
				Winner:rank="[Position]"
				if(Position=="Hokage")
					Hokage=Winner.key
				if(Position=="Amekoutei")
					Amekoutei=Winner.key
				if(Position=="Tsuchikage")
					Tsuchikage=Winner.key
				if(Position=="Otokami")
					Otokami=Winner.key
				Winner:verbs += typesof(/mob/Kage/verb)
				if(!Winner.GottenJounin)
					Winner.GottenJounin=1
					Winner.ElementalPoints+=15
				if(!Winner.GottenChuunin)
					Winner.GottenChuunin=1
					Winner.ElementalPoints+=10
				SaveVillageStuff()
		else
			for(var/mob/M in OnlinePlayers)
				if(M.Village==usr.Village&&M.client)
					M<<"<font color = #BB0EDA>Village Information:</font> A vote has been made by [src] to replace the current Leader by the Village Council and the vote has lost!"
					return
mob/var/Suspended=0
mob/Kage/verb/
	Upgrade_Hospital()
		set name="Upgrade Hospital"
		set category="Economics"
		var/Type=""
		var/TotalCost=0
		if(usr.Village=="Leaf") Type="Leaf"
		if(usr.Village=="Sound") Type="Sound"
		if(usr.Village=="Rain") Type="Rain"
		if(usr.Village=="Rock") Type="Rock"
		switch(input(usr,"What do you want to Purchase?",) in list("Beds","Medical Ninja","Nevermind"))
			if("Beds")
				switch(input(usr,"What type of Beds would you like?",) in list("Twin","Full","Queen","King"))
					if("Twin")
						if(Type=="Leaf")//24 Beds
							TotalCost=100000*24
							if(LeafVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										LeafVillagePool-=TotalCost
										LeafBedTime=1200
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							LeafVillagePool-=TotalCost
							LeafBedTime=1200
							usr<<"The Twin Beds costed [TotalCost] and now there is [LeafVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Twin Beds for the Hospital!"
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Sound")//18 Beds
							TotalCost=100000*18
							if(SoundVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										SoundVillagePool-=TotalCost
										SoundBedTime=1200
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							SoundVillagePool-=TotalCost
							usr<<"The Twin Beds costed [TotalCost] and now there is [SoundVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Twin Beds for the Hospital!"
							SoundBedTime=1200
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Rain")//9 Beds
							TotalCost=100000*9
							if(RainVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										RainVillagePool-=TotalCost
										RainBedTime=1200
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							RainVillagePool-=TotalCost
							usr<<"The Twin Beds costed [TotalCost] and now there is [RainVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Twin Beds for the Hospital!"
							RainBedTime=1200
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Rock")//20 Beds
							TotalCost=100000*20
							if(RockVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										RockVillagePool-=TotalCost
										RockBedTime=1200
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							RockVillagePool-=TotalCost
							usr<<"The Twin Beds costed [TotalCost] and now there is [RockVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Twin Beds for the Hospital!"
							RockBedTime=1200
							SaveVillageStuff()
							LoadVillageStuff()
					if("Full")
						if(Type=="Leaf")//24 Beds
							TotalCost=150000*24
							if(LeafVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										LeafVillagePool-=TotalCost
										LeafBedTime=900
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							LeafVillagePool-=TotalCost
							LeafBedTime=900
							usr<<"The Full Beds costed [TotalCost] and now there is [LeafVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Full Beds for the Hospital!"
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Sound")//18 Beds
							TotalCost=150000*18
							if(SoundVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										SoundVillagePool-=TotalCost
										SoundBedTime=900
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							SoundVillagePool-=TotalCost
							usr<<"The Full Beds costed [TotalCost] and now there is [SoundVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Full Beds for the Hospital!"
							SoundBedTime=900
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Rain")//9 Beds
							TotalCost=150000*9
							if(RainVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										RainVillagePool-=TotalCost
										RainBedTime=900
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							RainVillagePool-=TotalCost
							usr<<"The Full Beds costed [TotalCost] and now there is [RainVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Full Beds for the Hospital!"
							RainBedTime=900
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Rock")//20 Beds
							TotalCost=150000*20
							if(RockVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										RockVillagePool-=TotalCost
										RockBedTime=900
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							RockVillagePool-=TotalCost
							usr<<"The Full Beds costed [TotalCost] and now there is [RockVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Full Beds for the Hospital!"
							RockBedTime=900
							SaveVillageStuff()
							LoadVillageStuff()

					if("King")
						if(Type=="Leaf")//24 Beds
							TotalCost=175000*24
							if(LeafVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										LeafVillagePool-=TotalCost
										LeafBedTime=600
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							LeafVillagePool-=TotalCost
							LeafBedTime=600
							usr<<"The King Beds costed [TotalCost] and now there is [LeafVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy King Beds for the Hospital!"
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Sound")//18 Beds
							TotalCost=200000*18
							if(SoundVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										SoundVillagePool-=TotalCost
										SoundBedTime=600
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							SoundVillagePool-=TotalCost
							usr<<"The King Beds costed [TotalCost] and now there is [SoundVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy King Beds for the Hospital!"
							SoundBedTime=600
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Rain")//9 Beds
							TotalCost=200000*9
							if(RainVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										RainVillagePool-=TotalCost
										RainBedTime=600
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							RainVillagePool-=TotalCost
							usr<<"The Twin Beds costed [TotalCost] and now there is [RainVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy King Beds for the Hospital!"
							RainBedTime=600
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Rock")//20 Beds
							TotalCost=200000*20
							if(RockVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										RockVillagePool-=TotalCost
										RockBedTime=600
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							RockVillagePool-=TotalCost
							usr<<"The King Beds costed [TotalCost] and now there is [RockVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy King Beds for the Hospital!"
							RockBedTime=600
							SaveVillageStuff()
							LoadVillageStuff()
					if("Queen")
						if(Type=="Leaf")//24 Beds
							TotalCost=195000*24
							if(LeafVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										LeafVillagePool-=TotalCost
										LeafBedTime=300
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							LeafVillagePool-=TotalCost
							LeafBedTime=300
							usr<<"The Queen Beds costed [TotalCost] and now there is [LeafVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Queen Beds for the Hospital!"
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Sound")//18 Beds
							TotalCost=225000*18
							if(SoundVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										SoundVillagePool-=TotalCost
										SoundBedTime=300
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							SoundVillagePool-=TotalCost
							usr<<"The Queen Beds costed [TotalCost] and now there is [SoundVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Queen Beds for the Hospital!"
							SoundBedTime=300
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Rain")//9 Beds
							TotalCost=300000*9
							if(RainVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										RainVillagePool-=TotalCost
										RainBedTime=300
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							RainVillagePool-=TotalCost
							usr<<"The Queen Beds costed [TotalCost] and now there is [RainVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy King Beds for the Hospital!"
							RainBedTime=600
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Rock")//20 Beds
							TotalCost=225000*20
							if(RockVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										RockVillagePool-=TotalCost
										RockBedTime=300
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							RockVillagePool-=TotalCost
							usr<<"The Queen Beds costed [TotalCost] and now there is [RockVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Queen Beds for the Hospital!"
							RockBedTime=300
							SaveVillageStuff()
							LoadVillageStuff()
			if("Medical Ninja")
				switch(input(usr,"What type of Medical Ninja would you like to operate on your Villagers while they recover in the Beds?",) in list("Beginner","Moderate","Advanced","Expert"))
					if("Beginner")
						if(Type=="Leaf")//24 Beds
							TotalCost=100000*24
							if(LeafVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										LeafVillagePool-=TotalCost
										LeafBedRate=1.8
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							LeafVillagePool-=TotalCost
							LeafBedRate=1.8
							usr<<"The Beginner Medical Ninja costed [TotalCost] and now there is [LeafVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Beginner Medical Ninja for the Hospital!"
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Sound")//18 Beds
							TotalCost=100000*18
							if(SoundVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										SoundVillagePool-=TotalCost
										SoundBedRate=1.8
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							SoundVillagePool-=TotalCost
							usr<<"The Beginner Medical ninja costed [TotalCost] and now there is [SoundVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Beginner Medical Ninja for the Hospital!"
							SoundBedRate=1.8
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Rain")//9 Beds
							TotalCost=100000*9
							if(RainVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										RainVillagePool-=TotalCost
										RainBedRate=1.8
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							RainVillagePool-=TotalCost
							usr<<"The Beginner Medical Ninja costed [TotalCost] and now there is [RainVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Beginner Medical Ninja for the Hospital!"
							RainBedRate=1.8
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Rock")//20 Beds
							TotalCost=100000*20
							if(RockVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										RockVillagePool-=TotalCost
										RockBedRate=1.8
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							RockVillagePool-=TotalCost
							usr<<"The Beginner Medical Ninja costed [TotalCost] and now there is [RockVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Beginner Medical Ninja for the Hospital!"
							RockBedRate=1.8
							SaveVillageStuff()
							LoadVillageStuff()
					if("Moderate")
						if(Type=="Leaf")//24 Beds
							TotalCost=125000*24
							if(LeafVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										LeafVillagePool-=TotalCost
										LeafBedRate=1.6
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							LeafVillagePool-=TotalCost
							LeafBedRate=1.6
							usr<<"The Moderate Medical Ninja costed [TotalCost] and now there is [LeafVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Moderate Medical Ninja for the Hospital!"
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Sound")//18 Beds
							TotalCost=125000*18
							if(SoundVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										SoundVillagePool-=TotalCost
										SoundBedRate=1.6
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							SoundVillagePool-=TotalCost
							usr<<"The Moderate Medical ninja costed [TotalCost] and now there is [SoundVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Moderate Medical Ninja for the Hospital!"
							SoundBedRate=1.6
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Rain")//9 Beds
							TotalCost=125000*9
							if(RainVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										RainVillagePool-=TotalCost
										RainBedRate=1.6
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							RainVillagePool-=TotalCost
							usr<<"The Moderate Medical Ninja costed [TotalCost] and now there is [RainVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Moderate Medical Ninja for the Hospital!"
							RainBedRate=1.6
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Rock")//20 Beds
							TotalCost=125000*20
							if(RockVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										RockVillagePool-=TotalCost
										RockBedRate=1.6
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							RockVillagePool-=TotalCost
							usr<<"The Moderate Medical Ninja costed [TotalCost] and now there is [RockVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Moderate Medical Ninja for the Hospital!"
							RockBedRate=1.6
							SaveVillageStuff()
							LoadVillageStuff()
					if("Advanced")
						if(Type=="Leaf")//24 Beds
							TotalCost=140000*24
							if(LeafVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										LeafVillagePool-=TotalCost
										LeafBedRate=1
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							LeafVillagePool-=TotalCost
							LeafBedRate=1
							usr<<"The Advanced Medical Ninja costed [TotalCost] and now there is [LeafVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Advanced Medical Ninja for the Hospital!"
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Sound")//18 Beds
							TotalCost=140000*18
							if(SoundVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										SoundVillagePool-=TotalCost
										SoundBedRate=1
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							SoundVillagePool-=TotalCost
							usr<<"The Advanced Medical ninja costed [TotalCost] and now there is [SoundVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Advanced Medical Ninja for the Hospital!"
							SoundBedRate=1
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Rain")//9 Beds
							TotalCost=140000*9
							if(RainVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										RainVillagePool-=TotalCost
										RainBedRate=1
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							RainVillagePool-=TotalCost
							usr<<"The Advanced Medical Ninja costed [TotalCost] and now there is [RainVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Advanced Medical Ninja for the Hospital!"
							RainBedRate=1
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Rock")//20 Beds
							TotalCost=140000*20
							if(RockVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										RockVillagePool-=TotalCost
										RockBedRate=1
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							RockVillagePool-=TotalCost
							usr<<"The Advanced Medical Ninja costed [TotalCost] and now there is [RockVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Advanced Medical Ninja for the Hospital!"
							RockBedRate=1
							SaveVillageStuff()
							LoadVillageStuff()
					if("Expert")
						if(Type=="Leaf")//24 Beds
							TotalCost=175000*24
							if(LeafVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										LeafVillagePool-=TotalCost
										LeafBedRate=0.7
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							LeafVillagePool-=TotalCost
							LeafBedRate=0.7
							usr<<"The Expert Medical Ninja costed [TotalCost] and now there is [LeafVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)

								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Expert Medical Ninja for the Hospital!"
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Sound")//18 Beds
							TotalCost=179000*18
							if(SoundVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										SoundVillagePool-=TotalCost
										SoundBedRate=0.7
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							SoundVillagePool-=TotalCost
							usr<<"The Expert Medical ninja costed [TotalCost] and now there is [SoundVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Expert Medical Ninja for the Hospital!"
							SoundBedRate=0.7
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Rain")//9 Beds
							TotalCost=250000*9
							if(RainVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										RainVillagePool-=TotalCost
										RainBedRate=0.7
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							RainVillagePool-=TotalCost
							usr<<"The Expert Medical Ninja costed [TotalCost] and now there is [RainVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Expert Medical Ninja for the Hospital!"
							RainBedRate=0.7
							SaveVillageStuff()
							LoadVillageStuff()
						if(Type=="Rock")//20 Beds
							TotalCost=200000*20
							if(RockVillagePool<TotalCost)
								switch(input(src,"Are you sure you'd like to do this? It will put the village into depression!",) in list("Yes","No"))
									if("Yes")
										RockVillagePool-=TotalCost
										RockBedRate=0.7
										SaveVillageStuff()
										LoadVillageStuff()
										return
									if("No")
										return
							RockVillagePool-=TotalCost
							usr<<"The Expert Medical Ninja costed [TotalCost] and now there is [RockVillagePool] remaining for the Village."
							for(var/mob/X in OnlinePlayers)
								if(X.Village==usr.Village)
									X << "<font color = #BB0EDA>Village Information:</font> [usr] has used Village Funds to buy Expert Medical Ninja for the Hospital!"
							RockBedRate=0.7
							SaveVillageStuff()
							LoadVillageStuff()
	Pay_Off_Debt()
		set name="Pay Off Debt"
		set category="Kage"
		var/Type=""
		if(usr.Village=="Leaf") Type="Leaf"
		if(usr.Village=="Rock") Type="Rock"
		if(usr.Village=="Rain") Type="Rain"
		if(usr.Village=="Sound") Type="Sound"
		if(Type=="Leaf")
			switch(input(usr,"What Village would you like to pay off your debt too?",) in list("Rock","Rain","Sound"))
				if("Rock")
					if(LeafDebtToRock<=0)
						usr<<"You're not in Debt to Rock!";return
					var/A=input("How much do you wish to pay off?",) as num
					if(A>LeafVillagePool)
						usr<<"You don't have that much in the Village Pool!";return
					LeafVillagePool-=A
					LeafDebtToRock-=A
					if(LeafDebtToRock<=0) LeafDebtToRock=0
					RockVillagePool+=A
					SaveVillageStuff()
					LoadVillageStuff()
				if("Rain")
					if(LeafDebtToRain<=0)
						usr<<"You're not in Debt to Rain!";return
					var/A=input("How much do you wish to pay off?",) as num
					if(A>LeafVillagePool)
						usr<<"You don't have that much in the Village Pool!";return
					LeafVillagePool-=A
					LeafDebtToRain-=A
					if(LeafDebtToRain<=0) LeafDebtToRain=0
					RainVillagePool+=A
					SaveVillageStuff()
					LoadVillageStuff()
				if("Sound")
					if(LeafDebtToSound<=0)
						usr<<"You're not in Debt to Sound!";return
					var/A=input("How much do you wish to pay off?",) as num
					if(A>LeafVillagePool)
						usr<<"You don't have that much in the Village Pool!";return
					LeafVillagePool-=A
					LeafDebtToSound-=A
					if(LeafDebtToSound<=0) LeafDebtToSound=0
					SoundVillagePool+=A
					SaveVillageStuff()
					LoadVillageStuff()
		if(Type=="Rock")
			switch(input(usr,"What Village would you like to pay off your debt too?",) in list("Leaf","Rain","Sound"))
				if("Leaf")
					if(RockDebtToLeaf<=0)
						usr<<"You're not in Debt to Leaf!";return
					var/A=input("How much do you wish to pay off?",) as num
					if(A>RockVillagePool)
						usr<<"You don't have that much in the Village Pool!";return
					RockVillagePool-=A
					RockDebtToLeaf-=A
					if(RockDebtToLeaf<=0) RockDebtToLeaf=0
					LeafVillagePool+=A
					SaveVillageStuff()
					LoadVillageStuff()
				if("Rain")
					if(RockDebtToRain<=0)
						usr<<"You're not in Debt to Rain!";return
					var/A=input("How much do you wish to pay off?",) as num
					if(A>RockVillagePool)
						usr<<"You don't have that much in the Village Pool!";return
					RockVillagePool-=A
					RockDebtToRain-=A
					if(RockDebtToRain<=0) RockDebtToRain=0
					RainVillagePool+=A
					SaveVillageStuff()
					LoadVillageStuff()
				if("Sound")
					if(RockDebtToSound<=0)
						usr<<"You're not in Debt to Sound!";return
					var/A=input("How much do you wish to pay off?",) as num
					if(A>RockVillagePool)
						usr<<"You don't have that much in the Village Pool!";return
					RockVillagePool-=A
					RockDebtToSound-=A
					if(RockDebtToSound<=0) RockDebtToSound=0
					SoundVillagePool+=A
					SaveVillageStuff()
					LoadVillageStuff()
		if(Type=="Rain")
			switch(input(usr,"What Village would you like to pay off your debt too?",) in list("Leaf","Rock","Sound"))
				if("Leaf")
					if(RainDebtToLeaf<=0)
						usr<<"You're not in Debt to Leaf!";return
					var/A=input("How much do you wish to pay off?",) as num
					if(A>RainVillagePool)
						usr<<"You don't have that much in the Village Pool!";return
					RainVillagePool-=A
					RainDebtToLeaf-=A
					if(RainDebtToLeaf<=0) RainDebtToLeaf=0
					LeafVillagePool+=A
					SaveVillageStuff()
					LoadVillageStuff()
				if("Rock")
					if(RainDebtToRock<=0)
						usr<<"You're not in Debt to Rock!";return
					var/A=input("How much do you wish to pay off?",) as num
					if(A>RockVillagePool)
						usr<<"You don't have that much in the Village Pool!";return
					RainVillagePool-=A
					RainDebtToRock-=A
					if(RainDebtToRock<=0) RainDebtToRock=0
					RockVillagePool+=A
					SaveVillageStuff()
					LoadVillageStuff()
				if("Sound")
					if(RainDebtToSound<=0)
						usr<<"You're not in Debt to Sound!";return
					var/A=input("How much do you wish to pay off?",) as num
					if(A>RainVillagePool)
						usr<<"You don't have that much in the Village Pool!";return
					RainVillagePool-=A
					RainDebtToSound-=A
					if(RainDebtToSound<=0) RainDebtToSound=0
					SoundVillagePool+=A
					SaveVillageStuff()
					LoadVillageStuff()
		if(Type=="Sound")
			switch(input(usr,"What Village would you like to pay off your debt too?",) in list("Leaf","Rock","Rain"))
				if("Leaf")
					if(SoundDebtToLeaf<=0)
						usr<<"You're not in Debt to Leaf!";return
					var/A=input("How much do you wish to pay off?",) as num
					if(A>SoundVillagePool)
						usr<<"You don't have that much in the Village Pool!";return
					SoundVillagePool-=A
					SoundDebtToLeaf-=A
					if(SoundDebtToLeaf<=0) SoundDebtToLeaf=0
					LeafVillagePool+=A
					SaveVillageStuff()
					LoadVillageStuff()
				if("Rock")
					if(SoundDebtToRock<=0)
						usr<<"You're not in Debt to Rock!";return
					var/A=input("How much do you wish to pay off?",) as num
					if(A>RockVillagePool)
						usr<<"You don't have that much in the Village Pool!";return
					SoundVillagePool-=A
					SoundDebtToRock-=A
					if(SoundDebtToRock<=0) SoundDebtToRock=0
					RockVillagePool+=A
					SaveVillageStuff()
					LoadVillageStuff()
				if("Rain")
					if(SoundDebtToRain<=0)
						usr<<"You're not in Debt to Rain!";return
					var/A=input("How much do you wish to pay off?",) as num
					if(A>SoundVillagePool)
						usr<<"You don't have that much in the Village Pool!";return
					SoundVillagePool-=A
					SoundDebtToRain-=A
					if(SoundDebtToRain<=0) SoundDebtToRain=0
					RainVillagePool+=A
					SaveVillageStuff()
					LoadVillageStuff()




	Loan_Out_VillagePool()
		set name="Loan Village Pool"
		set category="Kage"
		var/Type=""
		var/mob/ReceivingLoan
		var/list/OnlineKages=list("")
		if(usr.Village=="Leaf") Type="Leaf"
		if(usr.Village=="Rock") Type="Rock"
		if(usr.Village=="Rain") Type="Rain"
		if(usr.Village=="Sound") Type="Sound"
		switch(input(usr,"Would you like to loan some of your Village Funds?",) in list("Yes","No"))
			if("Yes")
				for(var/mob/M in OnlinePlayers)
					if(M.client&&(M.rank=="Hokage"||M.rank=="Amekoutei"||M.rank=="Otokami"||M.rank=="Tsuchikage"))
						OnlineKages+=M
				if(OnlineKages.len<=1)
					usr<<"There are no other Kages online to loan Village Pool to."
					return
			//	switch(input(usr,"Which person do you want to loan money too?",) in OnlineKages)
				var/A = input("Who do you want to loan Village Funds too?") in OnlineKages + ("I've Changed my Mind.")
				if(A=="I've Changed my mind.")
					usr<<"You decide not to loan Village Funds too anyone."
					return
				if(A!="I've Changed my mind.")
					ReceivingLoan=A
				if(ReceivingLoan!=0)
					var/Amount = input("How much Village Funds do you want to loan to [ReceivingLoan]?",) as num
					if(Type=="Leaf")

						if(Amount>LeafVillagePool)
							usr<<"You can't loan more than you have!";return
						LeafVillagePool-=Amount
						if(ReceivingLoan.Village=="Rain")
							RainVillagePool+=Amount
							RainDebtToLeaf+=Amount
						if(ReceivingLoan.Village=="Rock")
							RockVillagePool+=Amount
							RockDebtToLeaf+=Amount
						if(ReceivingLoan.Village=="Sound")
							SoundVillagePool+=Amount
							SoundDebtToLeaf+=Amount
						for(var/mob/X in OnlinePlayers)
							if(X.Village==usr.Village)
								X << "<font color = #BB0EDA>Village Information:</font> [usr] has loaned [Amount] Yen from the Village Pool to the [ReceivingLoan.Village]!"
							if(X.Village==ReceivingLoan.Village)
								X << "<font color = #BB0EDA>Village Information:</font> [usr] has loaned [Amount] to your Village!"
						SaveVillageStuff()
						LoadVillageStuff()
					if(Type=="Rock")
						if(Amount>RockVillagePool)
							usr<<"You can't loan more than you have!";return
						RockVillagePool-=Amount
						if(ReceivingLoan.Village=="Rain")
							RainVillagePool+=Amount
							RainDebtToRock+=Amount
						if(ReceivingLoan.Village=="Leaf")
							LeafVillagePool+=Amount
							RockDebtToLeaf+=Amount
						if(ReceivingLoan.Village=="Sound")
							SoundVillagePool+=Amount
							SoundDebtToRock+=Amount
						for(var/mob/X in OnlinePlayers)
							if(X.Village==usr.Village)
								X << "<font color = #BB0EDA>Village Information:</font> [usr] has loaned [Amount] Yen from the Village Pool to the [ReceivingLoan.Village]!"
							if(X.Village==ReceivingLoan.Village)
								X << "<font color = #BB0EDA>Village Information:</font> [usr] has loaned [Amount] to your Village!"
						SaveVillageStuff()
						LoadVillageStuff()
					if(Type=="Sound")
						if(Amount>SoundVillagePool)
							usr<<"You can't loan more than you have!";return
						SoundVillagePool-=Amount
						if(ReceivingLoan.Village=="Rain")
							RainVillagePool+=Amount
							RainDebtToSound+=Amount
						if(ReceivingLoan.Village=="Leaf")
							LeafVillagePool+=Amount
							LeafDebtToSound+=Amount
						if(ReceivingLoan.Village=="Rock")
							RockVillagePool+=Amount
							RockDebtToSound+=Amount
						for(var/mob/X in OnlinePlayers)
							if(X.Village==usr.Village)
								X << "<font color = #BB0EDA>Village Information:</font> [usr] has loaned [Amount] Yen from the Village Pool to the [ReceivingLoan.Village]!"
							if(X.Village==ReceivingLoan.Village)
								X << "<font color = #BB0EDA>Village Information:</font> [usr] has loaned [Amount] to your Village!"
						SaveVillageStuff()
						LoadVillageStuff()
					if(Type=="Rain")
						if(Amount>RainVillagePool)
							usr<<"You can't loan more than you have!";return
						RainVillagePool-=Amount
						if(ReceivingLoan.Village=="Rock")
							RockVillagePool+=Amount
							RockDebtToRain+=Amount
						if(ReceivingLoan.Village=="Leaf")
							LeafVillagePool+=Amount
							LeafDebtToRain+=Amount
						if(ReceivingLoan.Village=="Sound")
							SoundVillagePool+=Amount
							SoundDebtToRain+=Amount
						for(var/mob/X in OnlinePlayers)
							if(X.Village==usr.Village)
								X << "<font color = #BB0EDA>Village Information:</font> [usr] has loaned [Amount] Yen from the Village Pool to the [ReceivingLoan.Village]!"
							if(X.Village==ReceivingLoan.Village)
								X << "<font color = #BB0EDA>Village Information:</font> [usr] has loaned [Amount] to your Village!"
						SaveVillageStuff()
						LoadVillageStuff()
			if("No")
				return
	Remove_Village_Official()
		set name="Remove Village Official"
		set category="Kage"
		var/Position=""
		if(src.Village=="Leaf")
			Position=LeafVillageOfficial
			if(fexists("Saves/[copytext(ckey(LeafVillageOfficial), 1, 2)]/[ckey(LeafVillageOfficial)].sav"))
				var/savefile/F = new("Saves/[copytext(ckey(LeafVillageOfficial), 1, 2)]/[ckey(LeafVillageOfficial)].sav")
				F["FirstName"] >> Position	//Load this person's real first name!
		if(src.Village=="Rock")
			Position=RockVillageOfficial
			if(fexists("Saves/[copytext(ckey(RockVillageOfficial), 1, 2)]/[ckey(RockVillageOfficial)].sav"))
				var/savefile/F = new("Saves/[copytext(ckey(RockVillageOfficial), 1, 2)]/[ckey(RockVillageOfficial)].sav")
				F["FirstName"] >> Position
		if(src.Village=="Rain")
			Position=RainVillageOfficial
			if(fexists("Saves/[copytext(ckey(RainVillageOfficial), 1, 2)]/[ckey(RainVillageOfficial)].sav"))
				var/savefile/F = new("Saves/[copytext(ckey(RainVillageOfficial), 1, 2)]/[ckey(RainVillageOfficial)].sav")
				F["FirstName"] >> Position
		if(src.Village=="Sound")
			Position=SoundVillageOfficial
			if(fexists("Saves/[copytext(ckey(SoundVillageOfficial), 1, 2)]/[ckey(SoundVillageOfficial)].sav"))
				var/savefile/F = new("Saves/[copytext(ckey(SoundVillageOfficial), 1, 2)]/[ckey(SoundVillageOfficial)].sav")
				F["FirstName"] >> Position
		switch(input(src,"Do you wish to remove [Position]'s reign as Village Official?",) in list("Yes","No"))
			if("Yes")
				world<<"<i><font size=2 color=Yellow>[Position] has lost their spot as Village Official!"
				if(src.Village=="Leaf")	LeafVillageOfficial=""
				if(src.Village=="Rock") RockVillageOfficial=""
				if(src.Village=="Rain") RainVillageOfficial=""
				if(src.Village=="Sound") SoundVillageOfficial=""
				SaveVillageStuff()
			if("No")
				src<<"They must be doing a good job then...";return
	Nominate_Village_Official()
		set name="Nominate Village Official"
		set category="Kage"
		var/Position=""
		if(src.Village=="Leaf") Position="Leaf Village Official"
		if(src.Village=="Rock") Position="Rock Village Official"
		if(src.Village=="Rain") Position="Rain Village Official"
		if(src.Village=="Sound") Position="Sound Village Official"
		switch(input(src,"You wish to nominate a new [Position]?",) in list("Yes","No"))
			if("Yes")
				var/list/People=list()
				var/list/Nominees=list()
				for(var/mob/M in OnlinePlayers)
					if(M.client)
						if(src.Village==M.Village&&src!=M)
							if(Position=="Uchiha Clan Leader")
								if(src.Clan=="Uchiha"&&M.Clan=="Uchiha")
									People+=M
								else
									..()
							else
								People+=M
				More
				var/A = input("Who do you want to nominate?") in People + list("No one else")
				if(A!="No one else")
					Nominees+=A
					goto More
				if(Nominees.len>0)
					for(var/mob/P in People)
						spawn()
							var/S = input(P,"These are the nominees for [Position], place your vote.",) in Nominees + list("I don't vote")
							if(S=="I don't vote")
								P<<"Communist.."
							else
								for(var/mob/M in OnlinePlayers)
									if(M.name=="[S]")
										M.Votes++
					sleep(600)
					for(var/mob/P in Nominees)
						world<<"[P] recieved [P.Votes] votes for [Position]"
						sleep(11)
					var/mob/Winner
					var/WinningVotes=0
					for(var/mob/P in Nominees)
						if(P.Votes>WinningVotes)
							Winner=P
							WinningVotes=P.Votes
					world<<"<i><font size=2 color=Yellow>[Winner] has won the election for [Position]!"
					Winner:rank="[Position]"
					if(Position=="Leaf Village Official")
						LeafVillageOfficial=Winner.key
						LeafVillageOfficial[2]=Winner.savename
					if(Position=="Rain Village Official")
						RainVillageOfficial=Winner.key
						RainVillageOfficial[2]=Winner.savename
					if(Position=="Rock Village Official")
						RockVillageOfficial=Winner.key
						RockVillageOfficial[2]=Winner.savename
					if(Position=="Sound Village Official")
						SoundVillageOfficial=Winner.key
						SoundVillageOfficial[2]=Winner.savename
					Winner:verbs += typesof(/mob/VillageOfficial/verb)
					SaveVillageStuff()
	Set_Tax()
		set category="Kage"
		set desc="Determine taxes on certain things in the village"
		switch(input(usr,"What would you like to change the taxes on?") in list("Missions","Food","Clothing","Weapons"))
			if("Missions")
				var/I=input(usr,"What percentage of all mission earnings should go to the village pool?") as num
				if(I<0) I=0
				if(I>99) I=99
				usr<<"Mission Tax: [I]% of all mission income will be sent to the village's pool."
				//usr.[usr.Village]MTax=I //Wanted to do it this way..but didn't work. See if you can try?
				if(usr.Village=="Leaf") LeafMTax=I
				if(usr.Village=="Rock") RockMTax=I
				if(usr.Village=="Rain") RainMTax=I
				if(usr.Village=="Sound") SoundMTax=I
				SaveVillageStuff()
			if("Food")
				var/I=input(usr,"What percentage of all food earnings should go to the village pool?") as num
				if(I<0) I=0
				if(I>99) I=99
				usr<<"Food Tax: [I]% of all food income will be sent to the village's pool. This will also raise the standard price of food."
				//usr.[usr.Village]FTax=I
				if(usr.Village=="Leaf") LeafFTax=I
				if(usr.Village=="Rock") RockFTax=I
				if(usr.Village=="Rain") RainFTax=I
				if(usr.Village=="Sound") SoundFTax=I
				SaveVillageStuff()
			if("Clothing")
				var/I=input(usr,"What percentage of all clothing earnings should go to the village pool?") as num
				if(I<0) I=0
				if(I>99) I=99
				usr<<"Clothing Tax: [I]% of all icon from purchased clothing will be sent to the village's pool. This will also raise the standard price of clothing."
				//usr.[usr.Village]CTax=I
				if(usr.Village=="Leaf") LeafCTax=I
				if(usr.Village=="Rock") RockCTax=I
				if(usr.Village=="Rain") RainCTax=I
				if(usr.Village=="Sound") SoundCTax=I
				SaveVillageStuff()
			if("Weapons")
				var/I=input(usr,"What percentage of all weapon earnings should go to the village pool?") as num
				if(I<0) I=0
				if(I>99) I=99
				usr<<"Weapons Tax: [I]% of all weapons income will be sent to the village's pool. This will also raise the standard price of weapons."
				//usr.[usr.Village]WTax=I
				if(usr.Village=="Leaf") LeafWTax=I
				if(usr.Village=="Rock") RockWTax=I
				if(usr.Village=="Rain") RainWTax=I
				if(usr.Village=="Sound") SoundWTax=I
				SaveVillageStuff()
	Check_Economy()
		set category="Kage"
		set desc="Get Updates with your economical decisions."
		if(src.Village=="Leaf")
			src<<"Current Money: [LeafVillagePool]"
			src<<"Bills per Week: [LeafPayment]"
			src<<"Mission Tax: [LeafMTax]"
			src<<"Clothing Tax: [LeafCTax]"
			src<<"Weapons Tax: [LeafWTax]"
			src<<"Food Tax: [LeafFTax]"
		if(src.Village=="Rain")
			src<<"Current Money: [RainVillagePool]"
			src<<"Bills per Week: [RainPayment]"
			src<<"Mission Tax: [RainMTax]"
			src<<"Clothing Tax: [RainCTax]"
			src<<"Weapons Tax: [RainWTax]"
			src<<"Food Tax: [RainFTax]"
		if(src.Village=="Rock")
			src<<"Current Money: [RockVillagePool]"
			src<<"Bills per Week: [RockPayment]"
			src<<"Mission Tax: [RockMTax]"
			src<<"Clothing Tax: [RockCTax]"
			src<<"Weapons Tax: [RockWTax]"
			src<<"Food Tax: [RockFTax]"
		if(src.Village=="Sound")
			src<<"Current Money: [SoundVillagePool]"
			src<<"Bills per Week: [SoundPayment]"
			src<<"Mission Tax: [SoundMTax]"
			src<<"Clothing Tax: [SoundCTax]"
			src<<"Weapons Tax: [SoundWTax]"
			src<<"Food Tax: [SoundFTax]"
	GivePermission(mob/M in oview(5))
		set category="Kage"
		set name="Squad Creation Permission"
		set desc="Give village members the Permission to create Squads."
		if(M.Village==usr.Village)
			M.PermissionToStartSquad=1
			usr<<"[M] can now form a squad!"
			M<<"You can now form a squad."
		else
			usr<<"They're not in your village!"
			return
	TakePermission(mob/M in oview(5))
		set category="Kage"
		set name="Revoke Squad Creation Permission"
		set desc="Revoke village members' Permission to create Squads."
		if(M.Village==usr.Village)
			M.PermissionToStartSquad=0
			usr<<"[M] can no longer form a squad."
			M<<"You can no longer form a squad."
		else
			usr<<"They're not in your village!"
			return
	VillageLeaderAnnouncement(msg as text)
		set name="Village Leader Announce"
		set category="Kage"
		set desc = "Say something to every high official of the village."
		var/list/L = list("<")
		if(usr.ckey in MuteList)
			alert(usr,"You are muted!")
			return
		for(var/H in L)
			if(findtext(msg,H))
				alert(usr,"No HTML in text!")
				return
		if(length(msg)>=400)
			alert(usr,"Message is too long")
			return
		for(var/mob/M in OnlinePlayers)
			if(M.Village == usr.Village)
				M<<"<font face=verdana><font size=2><b><center>[usr] Village Announcement:<center><font color=silver size = 2>[msg]</font>"
	VillageLeaderSay(msg as text)
		set name="Village Leader Say"
		set category="Kage"
		set desc = "Say something to every high official of the village."
		var/list/L = list("<")
		if(usr.ckey in MuteList)
			alert(usr,"You are muted!")
			return
		for(var/H in L)
			if(findtext(msg,H))
				alert(usr,"No HTML in text!")
				return
		if(length(msg)>=400)
			alert(usr,"Message is too long")
			return
		for(var/mob/M in OnlinePlayers)
			if(M.Village == usr.Village&&M.VillageCouncil||M.Village==usr.Village&&M.ClanLeader)
				M<<"<font size=2><font face=trebuchet MS><font color=#CCFFFF>(LeaderSay)-<font size=1>[usr]<font color=#99CCCC>: [msg]</font>"
	GiveVillagePermit()
		set category = "Kage"
		set name = "Give Village Permit"
		var/list/Menu = list()
		for(var/mob/M in OnlinePlayers)
			if(!M.client) continue
			if(M.name != usr.name)
				if(!M.Village==usr.Village)
					Menu.Add(M)
		var/mob/M = input("Give who the Permit?","Village Permit") as null | anything in Menu
		if(!M)return
		if(istype(M,/mob))
			switch(alert("Would you like to give [M] a permit?","Village Permit","Yes","No"))
				if("Yes")
					if(usr.Village=="Leaf")
						if(M.VillagePermits.Find("Leaf"))
							M<<"You permit to enter the [usr.Village] Village was taken away."
							M.VillagePermits -= "Leaf"
						else
							M.VillagePermits += "Leaf"
							M<<"You were given a permit to enter the [usr.Village] Village."
					if(usr.Village=="Rock")
						if(M.VillagePermits.Find("Rock"))
							M<<"You permit to enter the [usr.Village] Village was taken away."
							M.VillagePermits -= "Rock"
						else
							M.VillagePermits += "Rock"
							M<<"You were given a permit to enter the [usr.Village] Village."
					if(usr.Village=="Sound")
						if(M.VillagePermits.Find("Sound"))
							M<<"You permit to enter the [usr.Village] Village was taken away."
							M.VillagePermits -= "Sound"
						else
							M.VillagePermits += "Sound"
							M<<"You were given a permit to enter the [usr.Village] Village."
					if(usr.Village=="Rain")
						if(M.VillagePermits.Find("Rain"))
							M<<"You permit to enter the [usr.Village] Village was taken away."
							M.VillagePermits -= "Rain"
						else
							M.VillagePermits += "Rain"
							M<<"You were given a permit to enter the [usr.Village] Village."
				if("No")
					usr<<"You decided not to give [M] a permit";return
	VillageCouncilwho()
		set category = "Kage"
		set name = "Village Council Who"
		usr<<"<font color=blue>Online [usr.Village] Village Council Members -"
		for(var/mob/M in OnlinePlayers)
			if(M.Village == usr.Village&&M.client&&M.ClanLeader){usr<<"<font color=green>[M.Clan] Leader - [M.FirstName]"}
		for(var/mob/M in OnlinePlayers)
			if(M.Village == usr.Village&&M.client&&M.VillageCouncil){usr<<"<font color=green>[M.FirstName]"}
	Suspend_Village_Rights()
		set category = "Kage"
		set desc = "This strips away a person's ability to vote, leave prison even from your own village, or do missions"
		var/list/People=list()
		for(var/mob/M in OnlinePlayers)
			if(M.client&&M.Village==usr.Village)
				People.Add(M)
		var/mob/Lala=input(usr,"Suspend who? Note: This strips away temporarily a person's ability to vote, leave prison, even from your own village, or do missions.","Suspension") in People
		Lala.Suspended=1
		for(var/mob/X in OnlinePlayers)
			if(X.Village==usr.Village)
				X << "<font color = #BB0EDA>Village Information:</font> [Lala] has been Suspended of their Village Rights!"
		usr<<"[Lala] has been put on suspension."
		Lala<<"The leader of the village has put your rights on suspension..You are now no longer able to do missions, or Vote."
		Lala.SaveK()
	Reinstate_Village_Rights(mob/M in OnlinePlayers)
		set category = "Kage"
		if(M.Village==usr.Village&&M.Suspended)
			M<<"The leader of your village has lifted your suspension!"
			for(var/mob/X in OnlinePlayers)
				if(X.Village==usr.Village)
					X << "<font color = #BB0EDA>Village Information:</font> [M] has earned back their Village Rights!"
			usr<<"Suspension on [M] was lifted."
			M.Suspended=0
			M.SaveK()
		else
			usr<<"They're either not suspended or not within your jurisdiction.."
	Boot()
		set category = "Kage"
		set name = "Boot Member"
		var/list/Menu = list()
		var/list/BootVote = list()

		for(var/mob/M in OnlinePlayers)
			if(!M.client) continue
			if(M.key != usr.key)
				if(M.Village== usr.Village)
					Menu.Add(M)
		var/mob/M = input("Boot Who?","Village Boot") as null | anything in Menu
		if(!M)return
		if(istype(M,/mob))
			if(findtext(M.rank,"kage")||findtext(M.rank,"koutei")||findtext(M.rank,"kami"))
				alert("You cannot boot the Kage!");return
			if(M.VillageCouncil==1&&usr.VillageCouncil==1)
				for(var/mob/X in OnlinePlayers)
					if(X.Village==usr.Village)
						X << "<font color = #BB0EDA>Village Information:</font> [usr] has attempted to boot [M] when they are both Village Councils! This information has been logged so the Kage may see it."
						return
			switch(alert("Would you like to Boot [M] from the Village?","Village Boot","Yes","No"))

				if("Yes")

					if(usr.rank!="Hokage"&&usr.rank!="Amekoutei"&&usr.rank!="Otokami"&&usr.rank!="Tsuchikage")
						var/AgainstBoot=0
						var/ForBoot=0
						for(var/mob/A in OnlinePlayers)
							if(A.client)
								BootVote+=A
						for(var/mob/C in BootVote)
							spawn()
								switch(input(C,"[usr] wants to boot [M]. Do you agree with [usr]'s decision to boot?") in list("Yes","No"))
									if("Yes")
										ForBoot+=1
									if("No")
										AgainstBoot+=1
						sleep(300)
						for(var/mob/X in OnlinePlayers)
							if(X.Village==usr.Village)
								X<<"<font color = #BB0EDA>Village Information:</font> [M] recieved [AgainstBoot] votes against being booted."
								X<<"<font color = #BB0EDA>Village Information:</font> [M] recieved [ForBoot] votes for being booted."
								if(AgainstBoot>ForBoot)
									X << "<font color = #BB0EDA>Village Information:[M] has not been booted from the village</font> ."
									return


			//		spawn()
					for(var/mob/D in OnlinePlayers)
						if(D.Village==usr.Village&&D!=usr)
							D << "<font color = #BB0EDA>Village Information:</font> [M] has been Booted from the Village!"
					M.Village="Missing";M<<"You've been booted from your village, you're now a Missing Ninja!";M.VillageCouncil=0;M.Anbu=0
					M.Anbu=0
					M.overlays-='Icons/New Base/Clothing/Official Clothing/ANBUMask2.dmi';M.overlays-='Icons/New Base/Clothing/Official Clothing/Ganbu.dmi';M.overlays-='Icons/New Base/Clothing/Official Clothing/Banbu.dmi'
					M.overlays-='Icons/New Base/Clothing/Official Clothing/ANBUMask.dmi';M.overlays-='Icons/New Base/Clothing/Official Clothing/ANBUArmor.dmi';M.overlays-='Icons/New Base/Clothing/Official Clothing/ANBUHandGuards.dmi'
					for(var/obj/Clothes/ANBUArmor/A in M.contents)
						A.worn=0
						del(A)
					for(var/obj/Clothes/ANBUHandGuards/A in M.contents)
						A.worn=0
						del(A)
					for(var/obj/Clothes/Banbu/A in M.contents)
						A.worn=0
						del(A)
					for(var/obj/Clothes/Ranbu/A in M.contents)
						A.worn=0
						del(A)
					for(var/obj/Clothes/Ganbu/A in M.contents)
						A.worn=0
						del(A)
					for(var/obj/Clothes/FoxAnbu/A in M.contents)
						A.worn=0
						del(A)
					M.verbs-=typesof(/mob/ANBU/verb)
				if("No")
					usr<<"You decided not to Boot [M]";return
	BootVillageCouncilMember()
		set category = "Kage"
		set name = "Boot Village Council Member"
		var/list/Menu = list()
		for(var/mob/M in OnlinePlayers)
			if(!M.client) continue
			if(M.key != usr.key)
				if(M.Village== usr.Village&&M.VillageCouncil)
					Menu.Add(M)
		var/mob/M = input("Boot Who?","Village Council Boot") as null | anything in Menu
		if(!M)return
		if(istype(M,/mob))
			if(M.rank=="Kage")
				alert("You cannot boot the Kage!");return
			switch(alert("Would you like to Boot [M] from the Village?","Village Boot","Yes","No"))
				if("Yes")
					for(var/mob/X in OnlinePlayers)
						if(X.Village==usr.Village)
							X << "<font color = #BB0EDA>Village Information:</font> [M] has last power in the Village Council!"
					M.VillageCouncil=0
				if("No")
					usr<<"You decided not to Boot [M]";return
	MakeVillageCouncil()
		set category = "Kage"
		set name = "Make Village Council"
		var/list/Menu = list()
		for(var/mob/M in OnlinePlayers)
			if(!M.client) continue
			if(M.key != usr.key)
				if(M.Village==usr.Village&&M.VMorale>=125)
					Menu.Add(M)
		var/mob/M = input("Make who a village council?","Village Council") as null | anything in Menu
		if(!M)return
		if(istype(M,/mob))
			if(M.rank=="Kage")
				alert("You cannot make the Kage a Village Council!");return
			switch(alert("Would you like to give [M] some of your power?","Village Council","Yes","No"))
				if("Yes")
					for(var/mob/X in OnlinePlayers)
						if(X.Village==usr.Village)
							X << "<font color = #BB0EDA>Village Information:</font> [M] is now apart of the Village Council!"

					switch(input(usr,"You can either make them a Military Council or a Political Council. Choose.", text) in list ("Military","Political"))
						if("Military")
							M.VillageCouncil=2
						if("Political")
							M.VillageCouncil=3
				if("No")
					usr<<"You decided not to give powers to [M]";return
	Make_Jounin(mob/M in OnlinePlayers)
		set category = "Kage"
		if(M.Village==usr.Village)
			if(M.blevel=="A"||M.blevel=="S")
				if(M.rank!="S.Jounin")
					usr<<"They need to be a Special Jounin first!";return
				if(M.TaijutsuKnowledge+M.NinjutsuKnowledge+M.GenjutsuKnowledge<150)
					usr<<"They don't fit the stat requirements for Jounin. They need to have Strength, Agility, Intelligence, and Capacity all equaling 150 together.";return
				if(M.TaijutsuKnowledge<40)
					usr<<"A Jounin must be skilled in every stat. All Knowledge passives must be at least 40.";return
				if(M.NinjutsuKnowledge<40)
					usr<<"A Jounin must be skilled in every stat. All Knowledge passives must be at least 40.";return
				if(M.GenjutsuKnowledge<40)
					usr<<"A Jounin must be skilled in every stat. All Knowledge passives must be at least 40.";return
				if(M.VMorale<150)
					usr<<"They need at least 150 Village Morale!";return
				M<<"You have been promoted to the rank of Jounin by the kage!"
				for(var/mob/X in OnlinePlayers)
					if(X.Village==usr.Village)
						X << "<font color = #BB0EDA>Village Information:</font> [M] has been appointed a Jounin!"
				M.rank="Jounin"
				if(!M.GottenJounin)
					M.GottenJounin=1
					M.ElementalPoints+=15
				if(src.Village=="Leaf")
					var/obj/Clothes/LJouninsuit/B=new()
					B.loc=M
				if(src.Village=="Rock"||src.Village=="Leaf")
					var/obj/Clothes/RJouninsuit/B=new()
					B.loc=M
				if(src.Village=="Rain")
					var/obj/Clothes/RaJouninsuit/B=new()
					B.loc=M
				if(src.Village=="Sound")
					var/obj/Clothes/SJouninsuit/B=new()
					B.loc=M
			else
				usr<<"They don't meet the rank requirements for Jounin.";return
		else
			usr<<"You can not edit some one's rank from another villages."
	MakeMember(mob/M in OnlinePlayers)
		set category = "Kage"
		set name = "Invite"
		if(M.Village=="Missing")
			var/I = input(M,"Would you like to join [usr.Village]?","New Village") in list("Yes","No")
			if(I=="Yes")
				M.VMorale=0
				if(M.rank=="Missing-Nin")
					if(M.blevel=="A"|M.blevel=="S")
						M.rank="Chuunin"
						M<<"The kage has invited you into the village..he has his eye on you.."
			//			var/obj/Clothes/Chuunin_Vest/A=new() //Why would you get Chuunin Vest..the Kage already probably doesn't trust you as it is..
			//			A.loc=M
			//			if(usr.Village=="Sound")
			//				var/X=rand(1,3)
			//				if(X==1)
			//					var/obj/Clothes/SoundBeltPurple/C=new()
			///					C.loc=M
				///			if(X==2)
					//			var/obj/Clothes/SoundBeltBlack/C=new()
					//			C.loc=M
					//		if(X==3)
					//			var/obj/Clothes/SoundBeltWhite/C=new()
					//			C.loc=M
					else
						M.rank="Genin"
						var/obj/Clothes/Headband/A=new()
						A.loc=M
				M.Village = usr.Village
				usr<<"[M] has joined your village!"
			if(I=="No")
				return
		else
			var/I = input(M,"Would you like to leave [M.Village] to join [usr.Village]?","New Village") in list("Yes","No")
			if(I == "Yes")
				M.VMorale=0
				M.Village=usr.Village;M.SoundOrganization=0;M.VillageCouncil=0;M.Anbu=0;M.HunterNinMember=0;M.ClanLeader=0
				usr<<"[M] has joined your village!"
			if(I=="No")
				return


//Elect me a village leader!!
//
mob/var
	list
		Yes=list()
		No=list()
	tmp/Votes=0
//We could use this thing for Chuunins. Multiple people watch and vote on if they get Chuunin based on preformance. Not a bias GM.

var/list/tmp/CantSuggest=list()

mob/owner/verb
	Disable_Suggestions(mob/M in OnlinePlayers)
		set name="Disable Suggestions"
		if(!M.client)
			return
		else
			if(M in CantSuggest)
				usr<<"They're already not allowed to suggest or add additional thoughts!"
			else
				if(!(M in CantSuggest))
					CantSuggest+=M
				usr<<"[M] can no longer suggest or add additional thoughts when you suggest something."
	Discuss_Suggestions(msg as text)
		set name="Update Suggestions"
		set category="Staff"
		var/Agreed=0
		var/Disagreed=0
		var/list/Additions()
		for(var/mob/M in OnlinePlayers&&!(M in CantSuggest))
			spawn()
				M<<"The suggestion that [usr] suggests is the following."
				spawn(20)
					M<<"[msg]"
					spawn(30)
						switch(input(M,"Do you agree with the suggestion?",) in list("Yes","No","Here is something I would change/add"))
							if("Yes")
								Agreed++
							if("No")
								Disagreed++
							if("Here is something I would change/add")
								var/Suggest=input(M,"What would you like to suggest or add along with the current suggestion?","Suggestion/Addition",) as text
								Additions+=Suggest


	//		sleep(300)
			spawn(300)
				world<<"[Agreed] people agreed with [usr]'s decision of [msg]."
			//	sleep(20)
				spawn(20)
					world<<"[Disagreed] people disagreed with [usr]'s decision of [msg]."
				spawn(40)
					world<<"These are the suggestions you were given."
					world<<"[Additions]"

	Check_Anbu_Lists()
		set name = "Check Village Anbus"
		usr<<"[RockAnbu] Rock"
		usr<<"[LeafAnbu] Leaf"
		usr<<"[SoundAnbu] Sound"
		usr<<"[RainAnbu] Rain"
		usr<<"Those are the Anbu for each village"
	Reset_Anbu_Lists()
		set name = "Reset Village Anbus"
		RockAnbu = list("")
		LeafAnbu = list("")
		RainAnbu = list("")
		SoundAnbu = list("")
		usr<<"Anbu's for each village have been reset"
	Nominate_Village_Leader()
		set name = "Nominate A Village Leader"
		var/list/Villages = list("Leaf","Rock","Rain","Sound")
		var/Z = input(src,"Which village do you want to nominate a kage for?") in Villages
		if(Z=="Uchiha Clan Leader")
			src.Village="Missing"
			src.Clan="Uchiha"
		else
			src.Village=Z
		var/Position=""
		if(src.Village=="Leaf") Position="Hokage"
		if(src.Village=="Rock") Position="Tsuchikage"
		if(src.Village=="Rain") Position="Amekoutei" //Rain Emperor..Ameookami looked stupid.
		if(src.Village=="Sound") Position="Otokami"
		switch(input(src,"You wish to nominate a new [Position]?",) in list("Yes","No"))
			if("Yes")
				var/list/People=list()
				var/list/Nominees=list()
				for(var/mob/M in OnlinePlayers)
					if(M.client)
						if(src.Village==M.Village&&src!=M&&M.Suspended==0)
							if(Position=="Uchiha Clan Leader")
								if(src.Clan=="Uchiha"&&M.Clan=="Uchiha")
									People+=M
								else
									..()
							else
								People+=M
				More
				var/A = input("Who do you want to nominate?") in People + list("No one else")
				if(A!="No one else")
					Nominees+=A
					goto More
				if(Nominees.len>0)
					for(var/mob/P in People)
						spawn()
							var/S = input(P,"These are the nominees for [Position], place your vote.",) in Nominees + list("I don't vote")
							if(S=="I don't vote")
								P<<"Communist.."
							else
								for(var/mob/M in OnlinePlayers)
									if(M.name=="[S]")
										M.Votes++
					sleep(600)
					for(var/mob/P in Nominees)
						world<<"[P] recieved [P.Votes] votes for [Position]"
						sleep(11)
					var/mob/Winner
					var/WinningVotes=0
					for(var/mob/P in Nominees)
						if(P.Votes>WinningVotes)
							Winner=P
							WinningVotes=P.Votes
					world<<"<i><font size=2 color=blue>[Winner] has won the election for [Position]!"
					Winner:rank="[Position]"
					if(Position=="Hokage")
						Hokage=Winner.key
					if(Position=="Amekoutei")
						Amekoutei=Winner.key
					if(Position=="Tsuchikage")
						Tsuchikage=Winner.key
					if(Position=="Otokami")
						Otokami=Winner.key
					if(!Winner.GottenJounin)
						Winner.GottenJounin=1
						Winner.ElementalPoints+=15
					if(!Winner.GottenChuunin)
						Winner.GottenChuunin=1
						Winner.ElementalPoints+=10
					Winner:verbs += typesof(/mob/Kage/verb)
					SaveVillageStuff()

	Nominate_Village_Official()
		set name = "Nominate A Village Official"
		var/list/Villages = list("Leaf","Rock","Rain","Sound")
		var/Z = input(src,"Which village do you want to nominate an official for?") in Villages
		if(Z=="Uchiha Clan Leader")
			src.Village="Missing"
			src.Clan="Uchiha"
		else
			src.Village=Z
		var/Position=""
		if(src.Village=="Leaf") Position="Leaf Village Official"
		if(src.Village=="Rock") Position="Rock Village Official"
		if(src.Village=="Rain") Position="Rain Village Official" //Rain Emperor..Ameookami looked stupid.
		if(src.Village=="Sound") Position="Sound Village Official"
		switch(input(src,"You wish to nominate a new [Position]?",) in list("Yes","No"))
			if("Yes")
				var/list/People=list()
				var/list/Nominees=list()
				for(var/mob/M in OnlinePlayers)
					if(M.client)
						if(src.Village==M.Village&&src!=M&&M.Suspended==0)
							if(Position=="Uchiha Clan Leader")
								if(src.Clan=="Uchiha"&&M.Clan=="Uchiha")
									People+=M
								else
									..()
							else
								People+=M
				More
				var/A = input("Who do you want to nominate?") in People + list("No one else")
				if(A!="No one else")
					Nominees+=A
					goto More
				if(Nominees.len>0)
					for(var/mob/P in People)
						spawn()
							var/S = input(P,"These are the nominees for [Position], place your vote.",) in Nominees + list("I don't vote")
							if(S=="I don't vote")
								P<<"Communist.."
							else
								for(var/mob/M in OnlinePlayers)
									if(M.name=="[S]")
										M.Votes++
					sleep(600)
					for(var/mob/P in Nominees)
						world<<"[P] recieved [P.Votes] votes for [Position]"
						sleep(11)
					var/mob/Winner
					var/WinningVotes=0
					for(var/mob/P in Nominees)
						if(P.Votes>WinningVotes)
							Winner=P
							WinningVotes=P.Votes
					world<<"<i><font size=2 color=Yellow>[Winner] has won the election for [Position]!"
					Winner:rank="[Position]"
					if(Position=="Leaf Village Official")
						LeafVillageOfficial=Winner.key
					if(Position=="Rain Village Official")
						RainVillageOfficial=Winner.key
					if(Position=="Rock Village Official")
						RockVillageOfficial=Winner.key
					if(Position=="Sound Village Official")
						SoundVillageOfficial=Winner.key
					Winner:verbs += typesof(/mob/VillageOfficial/verb)
					SaveVillageStuff()


//Db's God Like Shyt We Can Barely Begin To Understand...
var/list/Leaders = list("Hokage","Mizukage","Tsuchikage","Raikage","Kazekage","Amekoutei","Otokami","Kusakami","Uchiha Clan Leader","Tousoukuro") //List containing the names of all the different Kage ranks
proc/LoadLeaders() //Proc to load the Leaders into their lists
	if(fexists("Kages.sav")) //If the Kage list is actually there
		var/savefile/F = new("Kages.sav") //Load it, cos we need it :)
		F["KageList"] >> Leaders //Export its contents to our list so we can use it =D

proc/UpdateLeaders() //Proc to save our Leaders to their save file =P
	var/savefile/F = new("Kages.sav") //Make a new one if it doesn't exist, if it does, use it =P
	F["KageList"] << Leaders //Save our list to the save file =P

mob/var/VillageMute=0
mob/Kage/verb
	VillageMute()
		set category = "Kage"
		set name = "Village Mute"
		var/list/Menu = list()
		for(var/mob/M in OnlinePlayers)
			if(!M.client) continue
			if(M.key != usr.key)
				if(M.Village== usr.Village)
					Menu.Add(M)
		var/mob/M = input("Who do you wish to mute from Village Say?","Mute") as null | anything in Menu
		if(!M)return
		if(istype(M,/mob))
			if(M.rank=="Hokage"||M.rank=="Tsuchikage"||M.rank=="Amekoutei"||M.rank=="Otokami")
				M<<"You can't mute the Kage!";return
			M<<"You have been muted!"
			for(var/mob/A in OnlinePlayers)
				if(A.Village==M.Village)
					A<<"<font color = #BB0EDA>Village Information:</font> [M] is now muted!"
			M.VillageMute=1
	VillageUnMute()
		set category = "Kage"
		set name = "Village Unmute"
		var/list/Menu = list()
		for(var/mob/M in OnlinePlayers)
			if(!M.client) continue
			if(M.key != usr.key)
				if(M.Village== usr.Village&&M.VillageMute)
					Menu.Add(M)
		var/mob/M = input("Who do you wish to mute from Village Say?","Mute") as null | anything in Menu
		if(!M)return
		if(istype(M,/mob))
			M<<"You have been unmuted!"
			for(var/mob/A in OnlinePlayers)
				if(A.Village==M.Village)
					A<<"<font color = #BB0EDA>Village Information:</font> [M] is now unmuted!"
			M.VillageMute=0
	MakeANBU()
		set category = "Kage"
		set name = "Make ANBU"
		var/list/Menu = list()
		if(usr.Village=="Leaf")
			if(LeafAnbu.len>=5)
				usr<<"You already have enough Anbus!"
				usr<<"Your current anbus are: [LeafAnbu]"
				return
		if(usr.Village=="Rock")
			if(RockAnbu.len>=5)
				usr<<"You already have enough Anbus!"
				return
		if(usr.Village=="Sound")
			if(SoundAnbu.len>=5)
				usr<<"You already have enough Anbus!"
				return
		if(usr.Village=="Rain")
			if(RainAnbu.len>=5)
				usr<<"You already have enough Anbus!"
				return
		for(var/mob/M in OnlinePlayers)
			if(!M.client) continue
			if(M.Village==usr.Village&&(M.rank=="S.Jounin"||M.rank=="Jounin"||M.rank=="Hokage"||M.rank=="Otokami"||M.rank=="Tsuchikage"||M.rank=="Amekoutei")&&M.VMorale>=115)
				Menu.Add(M)
		var/mob/M = input("Who do you wish to make ANBU?","ANBU") as null | anything in Menu
		if(!M)
			return
		if(istype(M,/mob))
//			if(M.Village=="Leaf")
//				LeafAnbu+=M
//				SaveVillageStuff()
//				LoadVillageStuff()
//			if(M.Village=="Rock")
//				RockAnbu+=M
//				SaveVillageStuff()
//				LoadVillageStuff()
//			if(M.Village=="Sound")
//				SoundAnbu+=M
//				SaveVillageStuff()
//				LoadVillageStuff()
//			if(M.Village=="Rain")
//				RainAnbu+=M
//				SaveVillageStuff()
//				LoadVillageStuff()
			M.Anbu=1
			M<<"You have been given the rank of Anbu!"
			var/obj/Clothes/ANBUArmor/A=new()
			A.loc=M
			var/obj/Clothes/ANBUHandGuards/C=new()
			C.loc=M
			M.verbs+=typesof(/mob/ANBU/verb)
			var/random=rand(1,3)
			if(random==1)
				var/obj/Clothes/Banbu/B=new()
				B.loc=M
			if(random==2)
				var/obj/Clothes/Ranbu/R=new()
				R.loc=M
			if(random==3)
				var/obj/Clothes/Ganbu/G=new()
				G.loc=M
			if(random==4)
				var/obj/Clothes/FoxAnbu/H=new()
				H.loc=M
			for(var/mob/E in OnlinePlayers)
				if(E.Anbu)
					E<<"<font color = #BB0EDA>Village Information:</font>[M] joins you in the rank as an ANBU..."
				if(E.Village==M.Village)
					E<<"<font color = #BB0EDA>Village Information:</font> [M] is now an ANBU!"

	TakeANBU()
		set category = "Kage"
		set name = "Remove ANBU"
		var/list/Menu = list()
		for(var/mob/M in OnlinePlayers)
			if(!M.client) continue
			if(M.key != usr.key)
				if(M.Village== usr.Village)
					Menu.Add(M)
		var/mob/M = input("Who do you wish to Remove ANBU from?","ANBU") as null | anything in Menu
		if(!M)return
		if(istype(M,/mob))
			M<<"You have been demoted from ANBU!"
			for(var/mob/A in OnlinePlayers)
				if(A.Village==M.Village)
					A<<"<font color = #BB0EDA>Village Information:</font> [M] is no longer an ANBU!"
			M.Anbu=0
			M.overlays-='Icons/New Base/Clothing/Official Clothing/ANBUMask2.dmi';M.overlays-='Icons/New Base/Clothing/Official Clothing/Ganbu.dmi';M.overlays-='Icons/New Base/Clothing/Official Clothing/Banbu.dmi'
			M.overlays-='Icons/New Base/Clothing/Official Clothing/ANBUMask.dmi';M.overlays-='Icons/New Base/Clothing/Official Clothing/ANBUArmor.dmi';M.overlays-='Icons/New Base/Clothing/Official Clothing/ANBUHandGuards.dmi'
			for(var/obj/Clothes/ANBUArmor/A in M.contents)
				A.worn=0
				del(A)
			for(var/obj/Clothes/ANBUHandGuards/A in M.contents)
				A.worn=0
				del(A)
			for(var/obj/Clothes/Banbu/A in M.contents)
				A.worn=0
				del(A)
			for(var/obj/Clothes/Ranbu/A in M.contents)
				A.worn=0
				del(A)
			for(var/obj/Clothes/Ganbu/A in M.contents)
				A.worn=0
				del(A)
			for(var/obj/Clothes/FoxAnbu/A in M.contents)
				A.worn=0
				del(A)
			M.verbs-=typesof(/mob/ANBU/verb)
			if(M.Village=="Leaf")
				LeafAnbu-=M
				SaveVillageStuff()
				LoadVillageStuff()
			if(M.Village=="Rock")
				RockAnbu-=M
				SaveVillageStuff()
				LoadVillageStuff()
			if(M.Village=="Sound")
				SoundAnbu-=M
				SaveVillageStuff()
				LoadVillageStuff()
			if(M.Village=="Rain")
				RainAnbu-=M
				SaveVillageStuff()
				LoadVillageStuff()
	Nominate_Village_Leader()
		set name = "Nominate A Clan Leader"
		var/list/LeafClans = list("Aburame","Akimichi","Hyuuga","Inuzuka","Kusakin","Nara")
		var/list/RainClans = list("Fuuma","Shiroi","Hoshigaki","Kiri","Ketsueki","Kyomou")
		var/list/RockClans = list("Kiro","Satou","Sabaku","Iwazuka")
		var/list/SoundClans = list("Kaguya","Kumojin","Uchiha","Yotsuki")
		var/Z
		if(src.rank=="Hokage")
			Z = input(src,"Which Clan?") in LeafClans
		if(src.rank=="Tsuchikage")
			Z = input(src,"Which Clan?") in RockClans
		if(src.rank=="Otokami")
			Z = input(src,"Which Clan?") in SoundClans
		if(src.rank=="Amekoutei")
			Z = input(src,"Which Clan?") in RainClans
		var/Clan=Z
		var/Position="[Z] Clan Leader"
		switch(input(src,"You wish to nominate a new [Position]?",) in list("Yes","No"))
			if("Yes")
				var/list/People=list()
				for(var/mob/M in OnlinePlayers)
					if(M.client)
						if(Clan==M.Clan&&M.Village==src.Village&&M.Suspended==0)
							People+=M
				var/mob/A = input("Who do you want to nominate?") in People + list("Cancel")
				if(A != "Cancel")

					var/Y=0
					var/N=0

					for(var/mob/P in People)
						spawn()
							P<<"[src] has nominated [A] for the position of [Position]. Everyone take your time voting for the next 60 seconds. Then the votes will be tallied."
							switch(input(P,"Do you agree and want to elect [A] to [Position]?","[Position]?") in list("Yes","No","I Won't Vote"))
								if("Yes")
									P.Yes+=A
								if("No")
									P.No+=A
								else
									P<<"Communist."
					sleep(600)
					for(var/mob/P in People)
						if(A in P.Yes)
							Y++
							P.Yes-=A
						if(A in P.No)
							N++
							P.No-=A
					var/TotalP = People.len
					TotalP-=Y
					TotalP-=N
					if(Y>N)
						A.ClanLeader=1 //In our leaders list, let whatever the rank is equal the rankholders key, so the element Raikage in the leaders file now contains DarkBelthazor =D
						world<<"[A] was elected as the new [Position]! "
						for(var/mob/X in OnlinePlayers)
							if(X.Village==A.Village)
								X << "<font color = #BB0EDA>Village Information:</font> [A] has been elected as the new [Position]! (Vote Results:[Y] Yes - [N] No: [TotalP] did not vote."


						//else
							//Something else later for other leaders?
					if(N>=Y)
						for(var/mob/X in OnlinePlayers)
							if(X.Village==A.Village)
								X << "<font color = #BB0EDA>Village Information:</font> [A] lost the election for the new [Position]! (Vote Results:[Y] Yes - [N] No: [TotalP] did not vote."
						return
	Nominate_New_Ninja()
		set name = "Vote Invite"
		switch(input(src,"You wish to invite someone to the village?",) in list("Yes","No"))
			if("Yes")
				var/list/People=list()
				var/list/VC=list()
				var/mob/Nominee
				for(var/mob/M in OnlinePlayers)
					if(M.client)
						if(src.Village!=M.Village&&src!=M)
							People+=M
				for(var/mob/MM in OnlinePlayers)
					if(MM.client)
						if(src.Village==MM.Village&&MM.VillageCouncil!=0)
							VC+=MM
				if(VC.len<3)
					src<<"You need at least 3 total Village Council Members on to vote someone into the village."
					return
				var/A = input("Who do you want to nominate?") in People + list("Cancel")
				if(A!="Cancel")
					Nominee=A
				var/Choice=input(Nominee,"Do you want to join the [src.Village] Village?") in list("Yes","No")
				if(Choice=="No")
					src<<"[Nominee] does not want to join.";return
				Nominee.Votes=0
				for(var/mob/P in VC)
					spawn()
						var/S = input(P,"[src] would like to invite [Nominee] to the village. What do you think?",) in list("Yes","No","I don't vote")
						if(S=="I don't vote")
							P<<"Communist."
						if(S=="Yes")
							Nominee.Votes++
						if(S=="No")
							Nominee.Votes--
				sleep(300)
				for(var/mob/X in OnlinePlayers)
					spawn()
						if(X.Village==src.Village)
							X << "<font color = #BB0EDA>Village Information:</font> Inviting [Nominee] vote results! (Vote Results:[Nominee.Votes] out of [VC.len]. At least [round(VC.len/2)] was needed.</font>"
						if(Nominee.Votes>=round(VC.len/2))
							X<<"<font color = #BB0EDA>Village Information:</font> [Nominee] is now a member of the Village!</font>"
							Nominee.Village=src.Village
//Leaf Village Org
mob/Hokage/verb/
	OpenLeafDojo()
		set category = "Kage"
		set name = "Allow Public Access to Leaf Dojo"
		if(LeafOnlyGeninDojo)
			usr<<"You have closed outside entrance to the Dojo!";LeafOnlyGeninDojo=1;
			SaveVillageStuff();LoadVillageStuff()
			return
		else
			usr<<"You have allowed outside entrance to the Dojo!";LeafOnlyGeninDojo=0;
			SaveVillageStuff();LoadVillageStuff()
			return
	MakePoliceForce()
		set category = "Kage"
		set name = "Make Police Force"
		var/list/Menu = list()
		for(var/mob/M in OnlinePlayers)
			if(!M.client) continue
			if(M.key != usr.key)
				if(M.Village== usr.Village)
					Menu.Add(M)
		var/mob/M = input("Who do you wish to make Konoha Military Police Force Member?","Police Force") as null | anything in Menu
		if(!M)return
		if(istype(M,/mob))
			M<<"You have been promoted to the rank of Military Police Force by the kage!"
			for(var/mob/A in OnlinePlayers)
				if(A.Village==M.Village)
					A<<"<font color = #BB0EDA>Village Information:</font> [M] is now a member of the Police Force!"
			M.KonohaMilitaryPoliceForceMember=1
			var/obj/Clothes/KonohaMilitaryCap/A=new()
			A.loc=M
			M.verbs+=typesof(/mob/KonohaMilitaryPoliceForceMember/verb)
	TakePoliceForce()
		set category = "Kage"
		set name = "Remove Police Force"
		var/list/Menu = list()
		for(var/mob/M in world)
			if(!M.client) continue
			if(M.key != usr.key)
				if(M.Village== usr.Village)
					Menu.Add(M)
		var/mob/M = input("Who do you wish to Remove Military Police Force Member from?","Military Police Force Member") as null | anything in Menu
		if(!M)return
		if(istype(M,/mob))
			M<<"You have been demoted from Military Police Force Member!"
			for(var/mob/A in world)
				if(A.Village==M.Village)
					A<<"<font color = #BB0EDA>Village Information:</font> [M] is no longer a Police Force Member!"
			M.KonohaMilitaryPoliceForceMember=0
			M.overlays-='MilitaryCaps.dmi'
			for(var/obj/Clothes/KonohaMilitaryCap/A in src.contents)
				A.worn=0
				del(A)
			M.verbs-=typesof(/mob/KonohaMilitaryPoliceForceMember/verb)
//Police Force
mob/KonohaMilitaryPoliceForceMember/verb/TalkWithMembers(msg as text)
	set category="Official"
	set name="Police Say"
	var/list/L = list("<")
	for(var/H in L)
		if(findtext(msg,H))
			alert(usr,"No HTML in text!");return
		if(length(msg)>=400)
			alert(usr,"Message is too long");return
	for(var/mob/M in world)
		if(M.KonohaMilitaryPoliceForceMember&&M.client&&M.Village==usr.Village||findtext(M.rank,"kage")&&M.client&&M.Village==usr.Village||findtext(M.rank,"kami")&&M.client&&M.Village==usr.Village||findtext(M.rank,"koutei")&&M.client&&M.Village==usr.Village)
			M<<"<font size=2><font face=trebuchet MS><font color=#CCFFFF>(M.P.F. Say)-<font size=1>[usr.oname]<font color=#eee8aa>: [msg]</font>"
mob/KonohaMilitaryPoliceForceMember/verb/MembersWho()
	set category="Official"
	set name="M.P.F. Who"
	usr<<"<font color=#eee8aa>Online [usr.Village] Konoha Military Police Force Members -"
	for(var/mob/M in world)
		if(M.KonohaMilitaryPoliceForceMember&&M.client&&M.Village==usr.Village){usr<<"<font color=green>[M.oname]"}
//ANBU
mob/ANBU/verb/TalkWithANBU(msg as text)
	set category="Official"
	set name="ANBU Say"
	set desc = "Say something to every high official of the village."
	var/list/L = list("<")
	for(var/H in L)
		if(findtext(msg,H))
			alert(usr,"No HTML in text!");return
		if(length(msg)>=400)
			alert(usr,"Message is too long");return
	for(var/mob/M in world)
		if(M.Anbu&&M.client&&M.Village==usr.Village||findtext(M.rank,"kage")&&M.client&&M.Village==usr.Village||findtext(M.rank,"kami")&&M.client&&M.Village==usr.Village||findtext(M.rank,"koutei")&&M.client&&M.Village==usr.Village)
			M<<"<font size=2><font face=trebuchet MS><font color=#CCFFFF>(ANBU Say)-<font size=1>[usr.oname]<font color=#eee8aa>: [msg]</font>"
mob/ANBU/verb/ANBUWho()
	set category="Official"
	set name="ANBU Who"
	usr<<"<font color=#eee8aa>Online [usr.Village] ANBU Members -"
	for(var/mob/M in world)
		if(M.Anbu&&M.client&&M.Village==usr.Village){usr<<"<font color=green>[M.oname]"}
//Rain Village Org
mob/Amekoutei/verb/
	MakeHunterNin()
		set category = "Kage"
		set name = "Make Hunter-Nin"
		var/list/Menu = list()
		for(var/mob/M in world)
			if(!M.client) continue
			if(M.key != usr.key)
				if(M.Village== usr.Village)
					Menu.Add(M)
		var/mob/M = input("Who do you wish to promote to Hunter-Nin?","Hunter-Nin") as null | anything in Menu
		if(!M)return
		if(istype(M,/mob))
			M<<"You have been promoted to the rank of Hunter-Nin by the Amekoutei!"
//			for(var/mob/A in world)
//				if(A.Village==M.Village)
//					A<<"<font color = #BB0EDA>Village Information:</font> [M] is now an ANBU!"
			M.HunterNinMember=1
			M.verbs+=typesof(/mob/HunterNin/verb)
			var/obj/Clothes/HunterNinClothing/B=new()
			B.loc=M
			var/random=(rand(1,3))
			if(random==1)
				var/obj/Clothes/HunterNinMask/A=new()
				A.loc=M
			if(random==2)
				var/obj/Clothes/HunterNinMask3/A=new()
				A.loc=M
			if(random==3)
				var/obj/Clothes/HunterNinMask3/A=new()
				A.loc=M
	TakeHunterNin()
		set category = "Kage"
		set name = "Remove Hunter-Nin"
		var/list/Menu = list()
		for(var/mob/M in world)
			if(!M.client) continue
			if(M.key != usr.key)
				if(M.Village== usr.Village)
					Menu.Add(M)
		var/mob/M = input("Who do you wish to Remove Hunter-Nin from?","Hunter-Nin") as null | anything in Menu
		if(!M)return
		if(istype(M,/mob))
			M<<"You have been demoted from Hunter-Nin!"
			M.HunterNinMember=0
			M.overlays-='Hunter-NinMask.dmi'
			M.overlays-='Hunter-NinClothing.dmi'
			for(var/obj/Clothes/HunterNinClothing/A in src.contents)
				A.worn=0
				del(A)
			for(var/obj/Clothes/HunterNinMask/A in src.contents)
				A.worn=0
				del(A)
			for(var/obj/Clothes/HunterNinMask2/A in src.contents)
				A.worn=0
				del(A)
			for(var/obj/Clothes/HunterNinMask3/A in src.contents)
				A.worn=0
				del(A)

			M.verbs-=typesof(/mob/HunterNin/verb)
mob/HunterNin/verb/TalkWithHunterNin(msg as text)
	set category="Official"
	set name="Hunter-Nin Say"
	var/list/L = list("<")
	for(var/H in L)
		if(findtext(msg,H))
			alert(usr,"No HTML in text!");return
		if(length(msg)>=400)
			alert(usr,"Message is too long");return
	for(var/mob/M in OnlinePlayers)
		if(M.HunterNinMember&&M.client&&M.Village==usr.Village||findtext(M.rank,"kage")&&M.client&&M.Village==usr.Village||findtext(M.rank,"kami")&&M.client&&M.Village==usr.Village||findtext(M.rank,"koutei")&&M.client&&M.Village==usr.Village)
			M<<"<font size=2><font face=trebuchet MS><font color=#CCFFFF>(Hunter-Nin Say)-<font size=1>[usr.oname]<font color=#eee8aa>: [msg]</font>"
mob/HunterNin/verb/HunterNinWho()
	set category="Official"
	set name="Hunter-Nin Who"
	usr<<"<font color=#eee8aa>Online [usr.Village] Hunter-Nin Members -"
	for(var/mob/M in OnlinePlayers)
		if(M.HunterNinMember&&M.client&&M.Village==usr.Village){usr<<"<font color=green>[M.oname]"}

//Sound Village Org
mob/Otokami/verb/
	GiveSoundOrganization()
		set category = "Kage"
		set name = "Make Sound Organization"
		var/list/Menu = list()
		for(var/mob/M in OnlinePlayers)
			if(!M.client) continue
			if(M.key != usr.key)
				if(M.Village== usr.Village)
					Menu.Add(M)
		var/mob/M = input("Make who a Sound Organization?","Sound Organization") as null | anything in Menu
		if(!M)return
		if(istype(M,/mob))
			if(M.rank=="Otokami")
				alert("You cannot make the Otokami a Sound Organization Member!");return
			switch(alert("Would you like to make [M] a Sound Organization member?","Sound Organization","Yes","No"))
				if("Yes")
					for(var/mob/X in OnlinePlayers)
						if(X.Village==usr.Village)
							X << "<font color = #BB0EDA>Village Information:</font> [M] is now apart of the Sound Organization!"
					M.SoundOrganization=1
					M.verbs += typesof(/mob/SoundOrganization/verb)
					var/obj/Clothes/SoundOutfit/A=new()
					A.loc=M
				if("No")
					usr<<"You decided not to give powers to [M]";return
	ChangeSoundOrganizationRank()
		set category = "Kage"
		set name = "Change SO Rank"
		var/list/Menu = list()
		for(var/mob/M in OnlinePlayers)
			if(!M.client) continue
			if(M.key != usr.key)
				if(M.Village== usr.Village&&M.SoundOrganization)
					Menu.Add(M)
		var/mob/M = input("Who's Rank Number do you want to adjust?","Sound Organization") as null | anything in Menu
		if(!M)return
		if(istype(M,/mob))
			if(M.SoundOrganizationRank>=5&&src.rank!="Otokami")
				alert("You cannot alter the first 5!");return
			var/Question=input(usr,"What rank would you like to set them as?","Rank") as num
			if(Question>1000)
				usr<<"You can only reach 1000 at highest, they'll be set to the highest of 1000."
				Question=1000
			M.SoundOrganizationRank=Question
			if(M.SoundOrganizationRank>=5)
				var/obj/Clothes/SoundOutfit/A=new()
				A.loc=M
			var/obj/Clothes/SoundOrganizationSuit/B=new()
			B.loc=M
mob/SoundOrganization/verb/TalkWithSO(msg as text)
	set category="Official"
	set name="Sound Organization Say"
	var/list/L = list("<")
	if(usr.CantAlert)
		usr<<"You can't use this right now."
		return
	for(var/H in L)
		if(findtext(msg,H))
			alert(usr,"No HTML in text!");return
		if(length(msg)>=400)
			alert(usr,"Message is too long");return
	for(var/mob/M in OnlinePlayers)
		if(M.SoundOrganization&&M.client&&M.Village==usr.Village||findtext(M.rank,"kage")&&M.client&&M.Village==usr.Village||findtext(M.rank,"kami")&&M.client&&M.Village==usr.Village||findtext(M.rank,"koutei")&&M.client&&M.Village==usr.Village)
			M<<"<font size=2><font face=trebuchet MS><font color=#33CCFF>(SO Say)([usr.SoundOrganizationRank])-<font size=1>[usr.oname]<font color=#eee8aa>: [msg]</font>"
mob/SoundOrganization/verb/SoundOrganizationWho()
	set category="Official"
	set name="Sound Organization Who"
	usr<<"<font color=#eee8aa>Online [usr.Village] Sound Organization Members -"
	for(var/mob/M in OnlinePlayers)
		if(M.SoundOrganization&&M.client&&M.Village==usr.Village){usr<<"<font color=green>([M.SoundOrganizationRank])[M.oname]"}


















world/New() //When the world begins :O
	..() //Let it do it's usual crap, THEN!
	spawn()
		LoadLeaders() //Load our leaders!