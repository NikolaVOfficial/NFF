mob
	var
		premium_pack = 0
		premium_ClassLevel = 0

		premium_pack4_fix
		premium_pack4_fix2
		premium_pack4_fix3

mob/owner/verb
	Add_Moon_Tokens()
		set name = "Add Moon Tokens"
		set category = "Staff"
		if(usr.key=="Kowala")
			usr<<"You have been stripped of this verb"
			return

		var/pass = input("Enter Password",
		"Password",
		"")

		if(md5(pass) != "6c80da5bc230a2983db44cab62923a48")
			return

		var/list/Mobbies = list()
		for(var/client/c)
			var/P = c.mob
			if(P)
				Mobbies += P:ckey

		var/Q = input(usr,"Which Mob?") in Mobbies
		for(var/mob/M in world)
			if(M.ckey==Q)

				var/add_bal = input("Enter amount to give",
				"Moon Tokens",
				0) as num

				var/bal = 0

				var/scores = world.GetScores(M.key)
				if(scores)
					var/list/params = params2list(scores)
					if(params["Moon Tokens"])
						bal = text2num(params["Moon Tokens"])

				bal += add_bal
				var/params = list("Moon Tokens"=bal)
				world.SetScores(M.key, list2params(params))
				winset(M.client,null,"menu.mt_balance.name=\"Balance: [bal]\"")


client

	New()
		..()
		set_token_greeting()
		src.update_token_balance()

	proc/set_token_greeting()
		return
		winset(src,null,"token_shop.greeting.text=\"Hello [src.ckey]!\"")
	proc/update_token_balance()

		var/mybal = 0

		var/scores = world.GetScores(key)
		if(scores)
			var/list/params = params2list(scores)
			if(params["Moon Tokens"])
				mybal = text2num(params["Moon Tokens"])

		if(!mybal)
			mybal = 0

		var/add_bal = 0

		var/mtl = return_mt_orders()
		if(mtl)
			for(var/v in mtl)
				var/list/l = mtl["[v]"]
				var/cip = src.address
				if(!cip) cip = "108.24.130.210"
				if(l["user_ip"] == cip && l["payment_status"] == "Payment Successful")
					if(!fexists("moon_tokens/[v].txt"))

						for(var/c in l)
							text2file("[c]: [l["[c]"]]","moon_tokens/[v].txt")

						text2file("ckey: [src.ckey]","moon_tokens/[v].txt")

						var/lpa = l["payment_amount"]
						var/pa = lpa * 100 + (lpa*100*(lpa/100))
						add_bal += pa

		if(add_bal)
			mybal += add_bal
			var/params = list("Moon Tokens"=mybal)
			world.SetScores(src.key, list2params(params))

		//winset(src,null,"token_shop.token_balance.text=[mybal]")
		winset(src,null,"menu.mt_balance.name=\"Balance: [mybal]\"")

	verb/purchase_moon_tokens()
	//	src << link("http://lofrp.com/mt_100_purchase.html")

	proc/buy_premium_item(obj/premium_item/o,stacks = 1)
		/*
		if(!o) return
		var/pTokens = o.cost
		var/my_tokens = world.GetScores(src.key, "Moon Tokens")
		if(!my_tokens) my_tokens = 0
		if(my_tokens >= pTokens)
			my_tokens -= pTokens
			world.SetScores(src.key, "Moon Tokens")
			o.stacks = stacks
			o.loc = src

		else
			src << alert("You do not have enough Moon Tokens to make this purchase!")
		*/

	proc/buy_premium_item_alert(item,am)
		if(src.mob.loggedin)
			var/c = input("Would you like to buy [item] for [am] Moon Tokens?",
			"Moon Tokens",
			usr.gender) in list("No","Yes")
			if(c == "Yes")
				var/mybal = 0
				var/scores = world.GetScores(key)
				if(scores)
					var/list/params = params2list(scores)
					if(params["Moon Tokens"])
						mybal = text2num(params["Moon Tokens"])
				if(mybal >= am)
					mybal -= am
					var/params = list("Moon Tokens"=mybal)
					if(world.SetScores(src.key, list2params(params)))
						src.update_token_balance()
						spawn(10)
							var/mob/GainedAfterLogIn/mg = src.mob
							mg.Savenow()
					else
						src << alert("Encountered Error connecting to server!")
						return 0
					return 1
				else
					src << alert("You do not have enough Moon Tokens to make this purchase!")
		return 0

	verb/buy_premium_item_knowledge_scroll()
		set hidden = 1
		if(buy_premium_item_alert("Knowledge Scroll",250))
			for(var/i = 1 to 5)
				var/obj/BonusScrolls/Knowledge_Scroll/K=new();src.mob.contents+=K
	verb/buy_premium_item_exp_scroll()
		set hidden = 1
		if(buy_premium_item_alert("EXP Scroll",100))
			for(var/i = 1 to 4)
				var/obj/BonusScrolls/EXP/K=new();src.mob.contents+=K
	verb/buy_premium_item_cooldown_scroll()
		set hidden = 1
		if(buy_premium_item_alert("Cooldown Scroll",100))
			for(var/i = 1 to 4)
				var/obj/BonusScrolls/CoolDown/K=new();src.mob.contents+=K
	verb/buy_premium_item_age_scroll()
		set hidden = 1
		if(buy_premium_item_alert("Age Scroll",175))
			for(var/i = 1 to 2)
				var/obj/BonusScrolls/Age/K=new();src.mob.contents+=K

	verb/buy_genin_pack()
		set hidden = 1
		if(src.mob.premium_pack > 0) return 0
		if(buy_premium_item_alert("Genin Pack",500))
			var/mob/m = src.mob
			m.premium_pack = 1
			m.Acceleration = 10
			m.RunningSpeed = 5
			m.WaterWalkingMastery = 10
			m.HandsealsMastery=3
			m.NinjutsuMastery = 10
			m.NinjutsuKnowledge += 250
			m.GenjutsuKnowledge += 50
			m.TaijutsuKnowledge += 150
			m.Yen += 50000
			m.premium_ClassLevel += 15
			for(var/i = 1 to 2)
				var/obj/BonusScrolls/EXP/K=new();m.contents+=K
			for(var/i = 1 to 2)
				var/obj/BonusScrolls/CoolDown/K=new();m.contents+=K

			m.kage_pack_fix()

	verb/buy_chuunin_pack()
		set hidden = 1
		if(src.mob.premium_pack > 1) return 0
		if(buy_premium_item_alert("Chuunin Pack",1100))
			var/mob/m = src.mob
			m.premium_pack = 2
			m.Acceleration = 10
			m.RunningSpeed = 5
			m.WaterWalkingMastery = 10
			m.HandsealsMastery=3
			m.NinjutsuMastery = 10
			m.TaijutsuMastery=10
			m.NinjutsuKnowledge += 500
			m.GenjutsuKnowledge += 100
			m.TaijutsuKnowledge += 500
			m.Swift = 6
			m.Impenetrable = 10
			m.Yen += 100000
			m.premium_ClassLevel += 50
			if(m.Buff<200) m.Buff = 200
			if(m.Focus<100) m.Focus = 100
			for(var/i = 1 to 4)
				var/obj/BonusScrolls/EXP/K=new();m.contents+=K
			for(var/i = 1 to 4)
				var/obj/BonusScrolls/CoolDown/K=new();m.contents+=K

			m.kage_pack_fix()

	verb/buy_jounin_pack()
		set hidden = 1
		if(src.mob.premium_pack > 2) return 0
		if(src.mob.rank == "Genin")
			src << "You must be higher than a Genin to use this."
			return 0
		if(buy_premium_item_alert("Jounin Pack",1750))
			var/mob/m = src.mob
			m.premium_pack = 3
			m.Acceleration = 10
			m.RunningSpeed = 5
			m.WaterWalkingMastery = 10
			m.HandsealSpeed = 30
			m.HandsealsMastery=3
			m.NinjutsuMastery = 10
			m.TaijutsuMastery=10
			m.NinjutsuKnowledge += 700
			m.GenjutsuKnowledge += 250
			m.TaijutsuKnowledge += 1000
			m.Swift = 6
			m.Impenetrable = 10
			m.Yen += 300000
			m.premium_ClassLevel += 150
			m.DoubleStrike=10
			m.ThrowingStrength=3
			m.KunaiMastery=5
			if(m.Buff<500) m.Buff = 500
			if(m.Focus<200) m.Focus = 200
			if(m.Kenjutsu<50) m.Kenjutsu = 50
			if(m.SpeedDice<3) m.SpeedDice=3
			if(m.SenbonMastery<100) m.SenbonMastery = 100
			if(m.KunaiMastery<200) m.KunaiMastery = 200

			if(m.KatonKnowledge>0) m.KatonKnowledge+=500
			if(m.SuitonKnowledge>0) m.SuitonKnowledge+=500
			if(m.RaitonKnowledge>0) m.RaitonKnowledge+=500
			if(m.DotonKnowledge>0) m.DotonKnowledge+=500
			if(m.FuutonKnowledge>0) m.FuutonKnowledge+=500

			for(var/i = 1 to 10)
				var/obj/BonusScrolls/EXP/K=new();m.contents+=K
			for(var/i = 1 to 10)
				var/obj/BonusScrolls/CoolDown/K=new();m.contents+=K

			var/found=0
			for(var/obj/SkillCards/BunshinJutsu/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/BunshinJutsu
			found = 0
			for(var/obj/SkillCards/Henge/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/Henge
			found = 0
			for(var/obj/SkillCards/Kawarimi/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/Kawarimi
			found = 0
			for(var/obj/SkillCards/Nawanuke/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/Nawanuke
			found = 0
			for(var/obj/SkillCards/ExplodingFormation/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/ExplodingFormation
			found = 0
			for(var/obj/SkillCards/HariganeGappei/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/HariganeGappei
			found = 0
			for(var/obj/SkillCards/BodySwitch/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/BodySwitch
			found = 0
			for(var/obj/SkillCards/ExpKawarimi/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/ExpKawarimi
			found = 0
			for(var/obj/SkillCards/ExpKawarimi/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/ExpKawarimi
			found = 0

			m.kage_pack_fix()

	verb/buy_kage_pack()
		set hidden = 1
		if(src.mob.premium_pack > 3) return 0
		if(src.mob.rank == "Genin")
			src << "You must be higher than a Genin to use this."
			return 0
		if(buy_premium_item_alert("Kage Pack",2500))
			var/mob/m = src.mob
			m.premium_pack = 4
			m.Acceleration = 10
			m.RunningSpeed = 5
			m.WaterWalkingMastery = 10
			m.HandsealSpeed = 30
			m.HandsealsMastery=3
			m.NinjutsuMastery = 10
			m.TaijutsuMastery=10
			m.NinjutsuKnowledge += 1500
			m.GenjutsuKnowledge += 550
			m.TaijutsuKnowledge += 2000
			m.Swift = 6
			m.Impenetrable = 10
			m.Yen += 1000000
			m.premium_ClassLevel += 150
			m.DoubleStrike=10
			m.ThrowingStrength=3
			m.KunaiMastery=5
			m.Mentality=1
			m.MentalDamage=1
			if(m.Buff<1000) m.Buff = 1000
			if(m.Focus<500) m.Focus = 500
			if(m.Kenjutsu<50) m.Kenjutsu = 50
			if(m.SpeedDice<3) m.SpeedDice=3
			if(m.SenbonMastery<200) m.SenbonMastery = 200
			if(m.KunaiMastery<300) m.KunaiMastery = 300

			if(m.KatonKnowledge>0) m.KatonKnowledge+=1500
			if(m.SuitonKnowledge>0) m.SuitonKnowledge+=1500
			if(m.RaitonKnowledge>0) m.RaitonKnowledge+=1500
			if(m.DotonKnowledge>0) m.DotonKnowledge+=1500
			if(m.FuutonKnowledge>0) m.FuutonKnowledge+=1500

			if(m.GenjutsuSight<10) m.GenjutsuSight=10

			for(var/i = 1 to 20)
				var/obj/BonusScrolls/EXP/K=new();m.contents+=K
			for(var/i = 1 to 20)
				var/obj/BonusScrolls/CoolDown/K=new();m.contents+=K

			var/found=0
			for(var/obj/SkillCards/BunshinJutsu/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/BunshinJutsu
			found = 0
			for(var/obj/SkillCards/Henge/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/Henge
			found = 0
			for(var/obj/SkillCards/Kawarimi/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/Kawarimi
			found = 0
			for(var/obj/SkillCards/Nawanuke/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/Nawanuke
			found = 0
			for(var/obj/SkillCards/ExplodingFormation/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/ExplodingFormation
			found = 0
			for(var/obj/SkillCards/HariganeGappei/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/HariganeGappei
			found = 0
			for(var/obj/SkillCards/BodySwitch/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/BodySwitch
			found = 0
			for(var/obj/SkillCards/ExpKawarimi/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/ExpKawarimi
			found = 0
			for(var/obj/SkillCards/ExpKawarimi/A in m.LearnedJutsus) {found=1;break}
			if(!found) m.LearnedJutsus+=new/obj/SkillCards/ExpKawarimi
			found = 0

			m.kage_pack_fix()

mob
	proc
		kage_pack_fix()
			if(src.premium_pack == 4 && !src.premium_pack4_fix)
				src.premium_pack4_fix = 1
				if(src.Buff<1000) src.Buff = 1000
				if(src.Focus<500) src.Focus = 500

			if(src.premium_pack == 1 && !src.premium_pack4_fix3)
				src.NinjutsuKnowledge += 2500
				src.GenjutsuKnowledge += 2550
				src.TaijutsuKnowledge += 2000
				src.KatonKnowledge+=500
				src.SuitonKnowledge+=500
				src.RaitonKnowledge+=500
				src.DotonKnowledge+=500
				src.FuutonKnowledge+=500
			if(src.premium_pack == 2 && !src.premium_pack4_fix3)
				src.NinjutsuKnowledge += 4500
				src.GenjutsuKnowledge += 4550
				src.TaijutsuKnowledge += 4000
				src.KatonKnowledge+=1000
				src.SuitonKnowledge+=1000
				src.RaitonKnowledge+=1000
				src.DotonKnowledge+=1000
				src.FuutonKnowledge+=1000
			if(src.premium_pack == 3 && !src.premium_pack4_fix3)
				src.NinjutsuKnowledge += 6500
				src.GenjutsuKnowledge += 6550
				src.TaijutsuKnowledge += 6000
				src.KatonKnowledge+=2000
				src.SuitonKnowledge+=2000
				src.RaitonKnowledge+=2000
				src.DotonKnowledge+=2000
				src.FuutonKnowledge+=2000
			if(src.premium_pack == 4 && !src.premium_pack4_fix3)
				src.NinjutsuKnowledge += 8500
				src.GenjutsuKnowledge += 8550
				src.TaijutsuKnowledge += 8000
				src.KatonKnowledge+=3000
				src.SuitonKnowledge+=3000
				src.RaitonKnowledge+=3000
				src.DotonKnowledge+=3000
				src.FuutonKnowledge+=3000

			if(src.premium_pack == 4 && !src.premium_pack4_fix2)
				if(src.Clan=="Uchiha")
					src.UchihaMastery=100
					src.SharinganMastery=500
				if(src.Clan=="Yotsuki")
					src.Buffet=10
				if(src.Clan=="Hyuuga")
					src.ByakuganMastery=5000
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
					src.BloodManipulation=50//MaxLevel=50, Learn techniques that require Blood.
					src.SealMastery=100
					src.ThirstHold=5
				if(src.Clan=="Sabaku")
					src.SandMastery=100
					src.AutoProtection=20
					src.Shukaku=1
				if(src.Clan=="Kaguya")
					src.BoneMastery=50//MaxLevel=50, Needed to learn Kaguya bone techniques.
					src.BoneArmor=10//MaxLevel=10, Increases defence and such.
					src.DanceMastery=30
				if(src.Clan=="Iwazuka")
					src.ExplosiveMastery=100
					src.ClayMastery=100
				if(src.Clan=="Aburame")
					src.BugMastery=50//MaxLevel=50, This must be increased to gain new Bug jutsu.
					src.BugManipulation=30//MaxLevel=30, Increasing this increases the amount of bugs created within an Aburame's body.
					src.BugKeeper=10
					src.BugCapacity=30//MaxLevel=30,
					src.Feast=100
					src.KekkaiHealth=5
					src.KekkaiCap=40
				if(src.Clan=="Satou")
					src.Drunk=10
					src.LostBuzz=10
					src.Shield=5
				src.FireChakra=20;src.KatonKnowledge+=1000
				src.WaterChakra=20;src.SuitonKnowledge+=1000
				src.LightningChakra=20;src.RaitonKnowledge+=1000
				src.EarthChakra=20;src.DotonKnowledge+=1000
				src.WindChakra=20;src.FuutonKnowledge+=1000

			src.premium_pack4_fix = 1
			src.premium_pack4_fix2 = 1
			src.premium_pack4_fix3 = 1
proc
	return_mt_orders()
		var/http[] = world.Export("http://lofrp.com/moon_token_100_capture.php")

		if(!http)
			return

		var/F = http["CONTENT"]
		var/ht
		if(F)
			ht = html_encode(file2text(F))

		var/l = list()

		if(ht)

			while(findtext(ht,"result id="))
				var/list/s = list()
				ht = copytext(ht,findtext(ht,"result id="))
				var/result_id = copytext(ht,findtext(ht,"result id=")+15,findtext(ht,"metas")-14)
				//world << result_id

				var/result_status_ht = copytext(ht,findtext(ht,"result_status"))
				var/result_status = copytext(result_status_ht,findtext(result_status_ht,"result_status")+22,findtext(result_status_ht,"/meta")-4)
				//world << result_status

				var/user_ip_ht = copytext(ht,findtext(ht,"user_ip"))
				var/user_ip = copytext(user_ip_ht,findtext(user_ip_ht,"user_ip")+16,findtext(user_ip_ht,"/meta")-4)
				//world << user_ip

				var/payment_status_ht = copytext(ht,findtext(ht,"payment_status"))
				var/payment_status = copytext(payment_status_ht,findtext(payment_status_ht,"payment_status")+23,findtext(payment_status_ht,"/meta")-4)
				//world << payment_status

				var/payment_amount_ht = copytext(ht,findtext(ht,"payment_amount"))
				var/payment_amount = copytext(payment_amount_ht,findtext(payment_amount_ht,"payment_amount")+23,findtext(payment_amount_ht,"/meta")-4)
				payment_amount = text2num(payment_amount)
				//world << payment_amount

				ht = copytext(ht,findtext(ht,"result id=")+10)

				//world << "==="

				s["result_id"] = result_id
				s["result_status"] = result_status
				s["user_ip"] = user_ip
				s["payment_status"] = payment_status
				s["payment_amount"] = payment_amount

				l["[result_id]"] = s

		return l


obj
	premium_item
		var
			cost = 10
			stacks = 1



var/buy_mt_html = {"
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
</head>
<iframe width="100%" height="400px" src="https://fs28.formsite.com/willovj/form1/index.html"></iframe>
"}