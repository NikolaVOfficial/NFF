/*I want to add a partial AI to the dogs based on the person's personality. I'd do like 4 different AI procs and base them
On different traits (ones in the beginning) and since your dog would act and learn from you it wouls probably share some
of your characteristics. So if someone picked Courage, their dog would be a direct straightforward attacker. Tough would
be similar to Courageous (probably in the same AI proc but I'd put an if() in there) it'd hit more often and dodge attacks
less often. Cowardly would be a dog that stays back and dodges most if not all attacks possible and attacks when commanded
to do so or when the target is within range and can't attack back. Aka src.firing==1 or src.FrozenBind!="". And so on.
Just wanted to give you a heads up and see what you thought. Also 3 new dog colors because someone requested them. x_x*/

mob/var/PetTrait=""
mob/var/DogCompanionship=0
mob/var/PetFavoriteFood=""
mob/var/tmp/PactProtect=0
mob/var/tmp/PactProtected=0
mob/var/PetDeclineAge=0
mob/var/ShikyakuControl=0
mob
	var
		tmp
			SitCD=0
			PickUpCD=0
			ComeCD=0
			HushCD=0
			PetCD=0
			TagCD=0
mob
	pet
		icon = 'Icons/NPCs/dog.dmi'
		MoveDelay=1
		tai=50
		Trait=""
		maxhealth=1500
		maxstamina=800
		density=1
		health=1500
		isdog=1
		var
			PlayingTag=0
			Wfight=0
			Speak=0
			sit=0
			protecting=""
		Speak=1
		New()
			..()
			var/list/X
			X=list('Icons/NPCs/dog.dmi','Icons/NPCs/dog2.dmi','Icons/NPCs/dog3.dmi','Icons/NPCs/dog4.dmi')
			src.icon=pick(X)
			spawn(1)
				while(src)
					var/mob/O = src.Owner
					var/mob/P
					if(src.Owner!="")
						if(src.PlayingTag==1)
							if(O.PetsAge<10)
								if(prob(70))
									walk_away(src,O,1)
								else
									walk(src,0)
							else if(O.PetsAge>=10&&O.PetsAge<35)
								if(O.DogCompanionship<=5)
									if(prob(15))
										walk_away(src,O,2)
									else if(prob(80))
										walk_away(src,O,1)
									else
										walk(src,0)
								else if(O.DogCompanionship>15&&O.DogCompanionship<=30)
									if(prob(30))
										walk_away(src,O,2)
									else if(prob(90))
										walk_away(src,O,1)
									else
										walk(src,0)
								else if(O.DogCompanionship>30)
									if(prob(42))
										walk_away(src,O,2)
									else if(prob(95))
										walk_away(src,O,1)
									else
										walk(src,0)
							else if(O.PetsAge>=35&&O.PetsAge<80)
								if(O.DogCompanionship<=30)
									if(prob(20))
										walk_away(src,O,2)
									else if(prob(30))
										walk_away(src,O,1)
									else
										walk(src,0)
								else if(O.DogCompanionship>30&&O.DogCompanionship<70)
									if(prob(40))
										walk_away(src,O,2)
									else if(prob(80))
										walk_away(src,O,1)
									else
										walk(src,0)
								else if(O.DogCompanionship>=70)
									if(prob(79))
										walk_away(src,O,2)
									else if(prob(80))
										walk_away(src,O,1)
									else
										walk(src,0)

						for(var/obj/Jutsu/Elemental/C in view(2,src))
							if(O.PetsAge<10)
								if(prob(12))
									if(C.JutsuLevel>0&&C.Owner!=src&&src.FrozenBind==""&&src.Stun<=0&&!src.Frozen&&!(istype(C,/obj/Jutsu/Elemental/Suiton/Owater)))
										if(prob(50))
											step_away(src,C,1)
							//			else
							//				step_away(src,C,2)
							else if(O.PetsAge>=10&&O.PetsAge<=20)
								if(O.DogCompanionship)
									if(prob(20))
										if(C.JutsuLevel>0&&C.Owner!=src&&src.FrozenBind==""&&src.Stun<=0&&!src.Frozen&&!(istype(C,/obj/Jutsu/Elemental/Suiton/Owater)))
											if(prob(35))
												step_away(src,C,1)
								//			else
								//				step_away(src,C,2)
							else if(O.PetsAge>20&&O.PetsAge<=35)
								if(O.DogCompanionship)
									if(prob(35))
										if(C.JutsuLevel>0&&C.Owner!=src&&src.FrozenBind==""&&src.Stun<=0&&!src.Frozen&&!(istype(C,/obj/Jutsu/Elemental/Suiton/Owater)))
											if(prob(25))
												step_away(src,C,2)
											else
												if(prob(30))
													step_away(src,C,1)
							else if(O.PetsAge>35&&O.PetsAge<80)
								if(O.DogCompanionship)
									if(prob(40))
										if(C.JutsuLevel>0&&C.Owner!=src&&src.FrozenBind==""&&src.Stun<=0&&!src.Frozen&&!(istype(C,/obj/Jutsu/Elemental/Suiton/Owater)))
											if(prob(45))
												step_away(src,C,2)
											else
												if(prob(30))
													step_away(src,C,1)

						if(src.Trait=="Territorial")
							for(var/mob/B in oview(4,src))
								if(!B)
									src.tai=src.Mtai
								if(B!=O)
									B=P
									src.tai++
									src.health++
									if(src.tai>(src.Mtai*1.2))
										src.tai=src.Mtai*1.2
									if(src.health>=src.maxhealth)
										src.health=src.maxhealth
						else if(src.Trait=="Hardenend")
							if(prob(8))
								src.health+=pick(3,5)
								if(src.health>=src.maxhealth)
									src.health=src.maxhealth
						else if(src.Trait=="Intimidating")
							for(var/mob/E in view(12,src))
								if(O==E.target)
									if(prob(2))//Bark gg OP
										src.SoundEngine('SFX/Bark.wav',30)
										E.target=null
										E.DeleteTarget()
										E.target=src;
										var/image/I = image('Icons/target1.dmi',src);
										E<<I
								//		break
						else if(src.Trait=="Keen-Eyes")
							if(O.InGenjutsu!="")
								if(prob(10))
						//			walk_towards(src,O)
									var/mob/AA = O.GenjutsuBy
									walk_towards(src,AA)


						//	if(!(P in oview(4,src)))
						//		src.tai=src.Mtai
					if(src.Stun>=1)
						src.Stun=0

					var/ForSleep=0
					if(src.Speak)
					//	src.SoundEngine('SFX/Bark.wav',30)
						sleep(1)
						var/ZZ=rand(1,2)
						if(ZZ==1)
							src.SoundEngine('SFX/Bark.wav',30);ZZ=rand(1,4)
					//		if(ZZ==1)
					//			src.SoundEngine('SFX/Bark.wav',30)
					if(prob(50))
						if(src.Owner=="")
							step_rand(src)
							var/A=rand(1,5)
							if(A==1)
								step_rand(src)
								A=rand(1,10)
								if(A==1)
									step_rand(src)
							ForSleep=rand(50,150)
						else
							if(src.PlayingTag)
								ForSleep=rand(10,11)
							else
								ForSleep=rand(10,20)
						//		ForSleep=rand(50,300)
					sleep(ForSleep)
		Move()
			if(src.Frozen)
				return
			..()
		Bump(mob/M)
			..()
			if(istype(M,/mob/))
				if(M==Owner||M.name==src.name||Wfight==0)
		//			if(M==Owner&&src.PlayingTag)
		//				var/mob/A=M
		//				A<<"You succesfully tagged [src.name]!"
		//				src.PlayingTag=0
					return
				else
					var/mob/A=src.Owner
					if(src.AttackDelay)
						return
					if(prob(1))
						A.Aggression+=0.1;if(A.Aggression>5) A.Aggression=5
					src.AttackDelay=1
					flick("Attack",usr)
					src.Attacking(M,10)
					if(prob(src.DoubleStrike*10))
						usr.Attacking(M,10)
					sleep(11-src.Swift)
					src.AttackDelay=0
					return
		proc
			RecoverTools()
				return
	/*
				set src in oview(1)
				if(istype(src,/obj/WEAPONS/Kunai))
					if(src.ammount==1)
						usr<<"You picked up a [src]"
					else
						usr<<"You picked up some [src]."
					src.icon_state="Kunai"
					var/counter=0
					for(var/obj/WEAPONS/Kunai/O in usr.contents)
						counter+=1
					if(counter<=0)
						Move(usr)
					else
						for(var/obj/WEAPONS/Kunai/O in usr.contents)
							O.ammount+=src.ammount
							O.CheckAmount()
							del(src)
				else if(istype(src,/obj/WEAPONS/Shuriken3))
					if(src.ammount==1)
						usr<<"You picked up a [src]"
					else
						usr<<"You picked up some [src]."
					src.icon_state="Shuriken"
					var/counter=0
					for(var/obj/WEAPONS/Shuriken3/O in usr.contents)
						counter+=1
					if(counter<=0)
						Move(usr)
					else
						for(var/obj/WEAPONS/Shuriken3/O in usr.contents)
							O.ammount+=src.ammount
							O.CheckAmount()
							del(src)
				else if(istype(src,/obj/WEAPONS/Shuriken))
					if(src.ammount==1)
						usr<<"You picked up a [src]"
					else
						usr<<"You picked up some [src]."
					src.icon_state="Shuriken"
					var/counter=0
					for(var/obj/WEAPONS/Shuriken/O in usr.contents)
						counter+=1
					if(counter<=0)
						Move(usr)
					else
						for(var/obj/WEAPONS/Shuriken/O in usr.contents)
							O.ammount+=src.ammount
							O.CheckAmount()
							del(src)
				else if(istype(src,/obj/WEAPONS/WindmillShuriken))
					src.icon_state=""

					if(src.ammount==1||src.ammount==0)
						usr<<"You picked up a [src]"
					else
						usr<<"You picked up some [src]."
					var/counter=0
					for(var/obj/WEAPONS/WindmillShuriken/O in usr.contents)
						counter+=1
					if(counter<=0)
						Move(usr)
					else
						for(var/obj/WEAPONS/WindmillShuriken/O in usr.contents)
							O.ammount+=src.ammount
							O.CheckAmount()
							del(src)
				//hoshigake New 1.8

				else
					usr<<"You picked up [src]."
					src.loc=usr

					*/
			PactProtection()
				var/mob/M = src.protecting
				walk_towards(src,M)
				if(M.knockedout)
					if(M in get_step(src,src.dir))
						src.Dragz(Dog=1)
				else
					var/mob/B = src.Owner
					B<<"[M] wasn't knocked out so your canine wasn't able to drag them away."

///////////////////////////////////////////////////////////
//Pet System
///////////////////////////////////////////////////////////
mob/var
	tmp/named=0
	tmp/isdog=0
mob/var/tmp/PetOut=0
mob/Mission
	verb
		Capture(mob/pet/P in oview(1))
			set category = "Attacks"
			if(src.CurrentMission=="Find Stray Dog")
				src<<"You grab the Stray Dog."
				src.MissionComplete()
				usr.verbs-= new /mob/Mission/verb/Capture
			else
				src<<"How do you have this...."
				usr.verbs-= new/mob/Mission/verb/Capture


mob/inuzuka
	verb
		Tame(mob/pet/P in oview(1))
			set category = "Attacks"
			if(P.isdog)
				if(!usr.hasdog)
					if(usr.Clan=="Inuzuka")
						if(!P.named&&!P.owned)
							usr.SavedPetIcon=P.icon
							del(P)
							/*
							var/Trait=rand(1,6)
							if(Trait==1)
								usr.PetTrait="Loyalty"
							else if(Trait==2)
								usr.PetTrait="Pact Protection"
							else if(Trait==3)
								usr.PetTrait="Territorial"
							else if(Trait==4)
								usr.PetTrait="Keen-Eyes"
							else if(Trait==5)
								usr.PetTrait="Intimidating"
							else if(Trait==6)
								usr.PetTrait="Hardened"
								*/
							usr.hasdog=1
							usr.PetName=input(usr,"Please select a name for your new canine companion.") as text
							usr.PetTrait=pick("Territorial","Intimidating","Hardenened","Keen-Eyes","Loyalty")
							usr.PetFavoriteFood=pick("Steak","Ribs","Riceball","Hamburger","Cheese Turkey Burger","Potato Chips","Healthy Potato Chips")
							usr.PetsStamina=(usr.PetsAge+1)*120
							usr.PetsMStamina=(usr.PetsAge+1)*120
							usr.PetsHealth=2250//Was 1500
							usr.PetsMHealth=3000//Was 1500
							usr.PetsChakra=(usr.PetsAge+1)*130
							usr.PetsMChakra=(usr.PetsAge+1)*130
							usr.PetDeclineAge=rand(80,120)
							if(usr.PetTrait=="Loyalty")
								usr.PetDeclineAge=rand(140,180)
							usr.PTai=150
							usr.PMTai=150
							usr.PNin=150
							usr.PMNin=150
							usr.PGen=150
							usr.PMGen=150
					//		if(PetName=="Biscuit")
					//			usr.PetsHealth=4000
					//			usr.PTai=500f
					//			usr.PMTai=500
							usr.verbs+=typesof(/mob/dogstuff/verb)
						else
							usr<<"This dog already belongs to someone."
							return
					else
						usr.verbs-= new /mob/inuzuka/verb/Tame
						return
				else
					usr<<"You already have a canine companion."
					return
			else
				return
mob/dogstuff
	verb
		Tag()
			set name = "Play Tag"
			set category = "Dog"
			if(!usr.PetOut)
				usr<<"You need to bring out your pet to play tag with him."
				return
			if(!usr.hasdog)
				usr<<"You need a dog first."
				return
			if(usr.inso)
				usr<<"You're currently fused with your pet."
				return
			if(usr.UsingDomu||usr.Frozen||usr.firing||usr.knockedout)
				return
			if(usr.TagCD)
				usr<<"This is on cooldown."
				return
			usr.TagCD=1
			spawn(300)
				usr.TagCD=0
			//var/mob/pet/A
			//var/DogCheck=0
			for(var/mob/pet/P in oview(5,src))
				if(P.Owner==usr)
					if(usr.PetsAge>80)
						usr<<"[P.name] is too old to be playing tag"
						return
					if(P.PlayingTag)
						P.PlayingTag=0
						usr<<"You stop playing tag with [P.name]"
						return
					if(!P.PlayingTag)
						P.PlayingTag=1
						usr<<"You are now playing tag with [P.name]! Bump into him to tag him!"

		Pet()
			set name="Pet Dog"
			set category = "Dog"
			if(usr.PetCD)
				usr<<"This is on cooldown."
				return
			usr.PetCD=1
			spawn(300)
				usr.PetCD=0
		//	usr<<"Not available yet."
	//	..	return

			if(!usr.PetOut)
				usr<<"You need to bring out your pet to pet him."
				return
			var/mob/pet/A
			var/DogCheck=0
			for(var/mob/M in get_step(src,src.dir))
				if(istype(M,/mob/pet/))
					if(M.Owner==usr)
				//		var/mob/pet/A=M
						A=M
						DogCheck=1
			if(!DogCheck)
				usr<<"Your dog needs to be in front of you."
				return
			usr<<"You pet [A.name]."
			usr.Frozen=1
			sleep(30)
			usr.Frozen=0
			if(usr.DogCompanionship<10&&usr.PetsAge<10)
				if(prob(25))
					usr.DogCompanionship+=rand(0.2,0.35)
				usr<<"[A.name] stares at you with a confused look in their eyes, not knowing if the pet you gave him is a good or bad thing"
				return
			else if(usr.DogCompanionship>=10&&usr.DogCompanionship<20&&usr.PetsAge<20&&usr.PetsAge>=10)
				usr<<"[A.name] tries to lick your hand as you pet his head."
				if(prob(30))
					usr.DogCompanionship+=rand(0.3,0.45)
				return
			else
				usr<<"[A.name] wags his tail as you place your hand on top of his head and pet him."
				if(prob(30))
					usr.DogCompanionship+=rand(0.3,0.4)
					return



		Drop()
			set name="Release Canine"
			set category = "Dog"
			if(usr.inso)
				usr<<"You're currently fused with your pet.";return
			if(usr.PetOut)
				usr<<"Your pet is already out."
				return
			if(usr.UsingDomu)
				usr<<"Not now."
				return
			if(usr.PetsHealth<=100)
				if(usr.PetsHealth<=0)//was ==0
					usr<<"Your pet isn't in any condition to fight, as it's unconcious.."// knocked out!";
					return
				if(usr.PetsHealth<=100)
					usr<<"Your pet is not ready to fight yet, it's just one step away from passing out.";
					return
			else
				var/mob/pet/P=new()
				usr.PetOut=1

				P.Trait=usr.PetTrait
				P.icon=usr.SavedPetIcon
				if(usr.PetsAge<=4)
					usr.PetsMHealth=1500
					usr.PMTai=150
					if(usr.PetTrait=="Hardenend")
						usr.PMTai=200
						usr.PetsMHealth=1800
					usr.PTai=PMTai
				if(usr.PetsAge>4)
					usr.PetsMHealth=2000
					usr.PMTai=250//Was 180
					if(usr.PetTrait=="Hardenend")
						usr.PMTai=310
						usr.PetsMHealth=2300
					usr.PTai=PMTai
					if(usr.SavedPetIcon=='Icons/NPCs/dog.dmi')
						P.icon='Icons/NPCs/dogGrowUp.dmi'
					if(usr.SavedPetIcon=='Icons/NPCs/dog2.dmi')
						P.icon='Icons/NPCs/dog2GrowUp.dmi'
					if(usr.SavedPetIcon=='Icons/NPCs/dog3.dmi')
						P.icon='Icons/NPCs/dog3GrowUp.dmi'
					if(usr.SavedPetIcon=='Icons/NPCs/dog4.dmi')
						P.icon='Icons/NPCs/dog4GrowUp.dmi'
				if(usr.PetsAge>10)
					usr.PetsMHealth=4050
					usr.PMTai=350//was 200
					if(usr.PetTrait=="Hardenend")
						usr.PMTai=400
						usr.PetsMHealth=5000
					usr.PTai=PMTai
					usr.PetsStamina=6000
					usr.PetsMStamina=6000
		//		if(usr.PetsAge>15)
					if(usr.SavedPetIcon=='Icons/NPCs/dog.dmi')
						P.icon='Icons/NPCs/dogGrowUp2.dmi'
					if(usr.SavedPetIcon=='Icons/NPCs/dog2.dmi')
						P.icon='Icons/NPCs/dog2GrowUp2.dmi'
					if(usr.SavedPetIcon=='Icons/NPCs/dog3.dmi')
						P.icon='Icons/NPCs/dog3GrowUp2.dmi'
		//			if(usr.SavedPetIcon=='Icons/NPCs/dog4.dmi')
		//				P.icon='Icons/NPCs/dog4GrowUp2.dmi'
				usr<<"You release [usr.PetName]"
				if(P)
					P.name="[usr.PetName]"
					P.Owner=usr
					P.owned=1
					P.named=1
					P.loc = locate(usr.x+1, usr.y, usr.z)
					//
					P.Trait=usr.PetTrait
					P.health=usr.PetsHealth
					P.maxhealth=usr.PetsMHealth
					P.stamina=usr.PetsStamina
					P.maxstamina=usr.PetsMStamina
					P.chakra=usr.PetsChakra
					P.maxstamina=usr.PetsMChakra
					//
					if(P.Trait!="Hardenend")
						P.tai=usr.PTai
						P.Mtai=usr.PMTai
						P.nin=usr.PNin
						P.Mnin=usr.PMNin
						P.gen=usr.PGen
						P.Mgen=usr.PMGen
					else
						P.tai=usr.PTai*1.1
						P.Mtai=usr.PMTai
						P.nin=usr.PNin*1.1
						P.Mnin=usr.PMNin
						P.gen=usr.PGen*1.1
						P.Mgen=usr.PMGen
					//
					P.Rush=usr.Aggression
					P.MoveDelay=1.5-((usr.SpeedTraining+1)/9)
				while(usr.PetOut)
					if(usr.PetsAge<3)
						if(prob(22))
							usr.Canine+=pick(0.1,0.2,0.3)
							if(usr.PetTrait=="Loyalty")
								usr.Canine+=pick(0.2,0.3)
						if(prob(23))
							usr.Training+=0.1
							if(usr.PetTrait=="Loyalty")
								usr.Training+=pick(0.1,0.12)
							if(usr.Training>=50)
								usr.Training=50
						if(P.stamina<0)
							P.health-=abs(P.stamina)
					else
						if(prob(10))
							usr.Canine+=pick(0.1,0.2,0.3)
							if(usr.PetTrait=="Loyalty")
								usr.Canine+=pick(0.2,0.3)
						if(prob(10))
							usr.Training+=0.1
							if(usr.PetTrait=="Loyalty")
								usr.Training+=pick(0.1,0.11)
							if(usr.Training>=50)
								usr.Training=50
						if(P.stamina<0)
							P.health-=abs(P.stamina)
					sleep(11)
		Pickup()
			set category = "Dog"
			if(usr.PickUpCD)
				usr<<"This is on Cooldown."
				return
			spawn(200)
				usr.PickUpCD=0
			usr.PickUpCD=1
			for(var/mob/pet/A in world)
				if(A.Owner==usr)
					if(A.z!=usr.z)
						var/mob/pet/P = A
						usr.PetOut=0
						var/PetCap = ((usr.PetsAge+1)*100)
						if(usr.PMTai>PetCap)
							usr.PMTai=PetCap
						if(usr.PMNin>PetCap)
							usr.PMNin=PetCap
						if(usr.PMGen>PetCap)
							usr.PMGen=PetCap
						usr.PTai=usr.PMTai;
						P.tai=usr.PMTai;
						P.Mtai=usr.PMTai
						usr.PNin=usr.PMNin;
						P.nin=usr.PMNin;
						P.Mnin=usr.PMNin
						usr.PGen=usr.PMGen;
						P.gen=usr.PMGen;
						P.Mgen=usr.PMGen
						if(P.health<P.maxhealth*0.15)
							if(prob(25))
								usr.DogCompanionship+=rand(0.80,1.20)
						usr.PetsHealth=P.health
						usr.PetsMHealth=P.maxhealth
						usr.PetsStamina=P.stamina
						usr.PetsMStamina=P.maxstamina
						usr.PetsChakra=P.chakra
						usr.PetsMChakra=P.Mchakra
						usr.PTai=P.tai
						usr.PMTai=P.Mtai
						usr.PNin=P.nin
						usr.PMNin=P.Mnin
						usr.PGen=P.gen
						usr.PMGen=P.Mgen
						del(P)
						usr<<"You return [usr.PetName]"
				for(var/mob/pet/P in oview(1))
					if(P.Owner==usr)
						usr.PetOut=0

						var/PetCap = ((usr.PetsAge+1)*100)
						if(usr.PMTai>PetCap)
							usr.PMTai=PetCap
						if(usr.PMNin>PetCap)
							usr.PMNin=PetCap
						if(usr.PMGen>PetCap)
							usr.PMGen=PetCap
						usr.PTai=usr.PMTai;
						P.tai=usr.PMTai;
						P.Mtai=usr.PMTai
						usr.PNin=usr.PMNin;
						P.nin=usr.PMNin;
						P.Mnin=usr.PMNin
						usr.PGen=usr.PMGen;
						P.gen=usr.PMGen;
						P.Mgen=usr.PMGen
						if(P.health<P.maxhealth*0.15)
							if(prob(25))
								usr.DogCompanionship+=rand(0.80,1.20)
						usr.PetsHealth=P.health
						usr.PetsMHealth=P.maxhealth
						usr.PetsStamina=P.stamina
						usr.PetsMStamina=P.maxstamina
						usr.PetsChakra=P.chakra
						usr.PetsMChakra=P.Mchakra

						usr.PTai=P.tai
						usr.PMTai=P.Mtai
						usr.PNin=P.nin
						usr.PMNin=P.Mnin
						usr.PGen=P.gen
						usr.PMGen=P.Mgen

						del(P)
						usr<<"You return [usr.PetName]"
					else
						usr<<"This dog does not belong to you."
		Aggressive()
			set category = "Dog"
			for(var/mob/pet/P in oview())
				if(P.Owner==usr&&P.Wfight == 0)
					P.Wfight = 1
				//	usr<<"Your dog will now attack anything it bumps into."
					usr<<"[P.name] will now attack anything it bumps into."
					return
				else if(P.Owner==usr&&P.Wfight == 1)
//					usr<<"Your dog will no longer attack anything."
					usr<<"[P.name] will no longer attack anything."
					P.Wfight = 0
					return

		Sit(var/mob/pet/P in oview())
			set category = "Dog"
			if(usr.SitCD)
				usr<<"Sit is on Cooldown."
				return
			spawn(300)
				usr.SitCD=0
			usr.SitCD=1
		//	if((prob(30)&&usr.DogCompanionship<15)||((prob(15)&&usr.DogCompanionship>=15&&usr.DogCompanionship<50)))
		//		usr<<"[P.name] decides not to sit."
		//		return
			if(P.Owner==usr&&P.sit == 0)
				if(usr.PetsAge<80)
					usr<<"[P.name] starts to relax and begins to sit down."
				else
					usr<<"[P.name] slowly slouches onto the floor, thankful for having this moment to get back their energy."
				walk(src,0)
				walk_towards(src,src)
				P.sit=1
				if(prob(5))
					usr.DogCompanionship+=rand(0.09,0.12)
				P.icon_state="sit"
			else if(P.Owner==usr&&P.sit == 1)
				if(usr.PetsAge<80)
					usr<<"[P.name] stops sitting."
				else
					usr<<"[P.name] struggles to stand back up."
				walk(src,0)
				walk_towards(src,src)
				P.sit=0
				P.icon_state=""

		Come()
			set category = "Dog"
			if(usr.ComeCD)
				usr<<"This is on cooldown."
				return
			spawn(300)
				usr.ComeCD=0
			usr.ComeCD=1
			for(var/mob/pet/P in range(192,usr))
		//		if((prob(30)&&usr.DogCompanionship<15)||((prob(12)&&usr.DogCompanionship>=15&&usr.DogCompanionship<50)))
		//			usr<<"You tell [P.name] to come over to you but he decides not to."
		//			return
				if(P.Owner==usr)
					if((prob(30)&&usr.DogCompanionship<15)||((prob(12)&&usr.DogCompanionship>=15&&usr.DogCompanionship<50)))
						usr<<"You tell [P.name] to come over to you but he decides not to."
						return
			//		P.Frozen=0
					if(!P.Frozen)
						if(prob(5))
							usr.DogCompanionship+=rand(0.20,0.30)
						if(usr.PetsAge<10)
							walk_towards(P,src,2)
						else if(usr.PetsAge>=10&&usr.PetsAge<35)
							walk_towards(P,src,1)
						else if(usr.PetsAge>=35&&usr.PetsAge<80)
							walk_towards(P,src)
						else if(usr.PetsAge>=80)
							var/RandSpeed=pick(1,2)
							if(RandSpeed==1)
								walk_towards(P,src,4)
							else
								walk_towards(P,src,3)
					else
						usr<<"[P.name] isn't capable of moving right now."
		Hush()
			set category="Dog"
			if(usr.HushCD)
				usr<<"This is on cooldown."
				return
			spawn(300)
				usr.HushCD=0
			usr.HushCD=1
			for(var/mob/pet/P in range(192,usr))
				if(P.Owner==usr)
					if(!P.Speak)
						usr<<"[P.name] isn't barking at all in the first place."
						return
					if((prob(20)&&usr.DogCompanionship<15)||((prob(15)&&usr.DogCompanionship>=15&&usr.DogCompanionship<50)))
				//		usr<<"You tell [P.name] to stop barking but barking is his way to let you know he's not going to listen to you."
						usr<<"[P.name] ignores you and continues barking."
						return
					usr<<"[P.name] begins to quite down."
					spawn(rand(15,35))
						if(prob(10))
							usr.DogCompanionship+=rand(0.09,0.15)
						P.Speak=0
		Speak()
			set category="Dog"

			for(var/mob/pet/P in range(192,usr))
				if((prob(20)&&usr.DogCompanionship<15)||((prob(15)&&usr.DogCompanionship>=15&&usr.DogCompanionship<50)))
					usr<<"You tell [P.name] to bark but he doesn't."
					return
				if(P.Owner==usr)
					usr<<"[P.name] starts to bark."
					P.Speak=1;
					P.SoundEngine('SFX/Bark.wav',30)
		FollowSomeone(mob/M in view())
			set category = "Dog"
			for(var/mob/pet/P in oview())
				if(P.Owner == usr&&P.Frozen == 0)
					if(((M.blevel=="A"||M.blevel=="S")&&(usr.blevel=="E"||usr.blevel=="D"||usr.blevel=="C")))
						if(prob(80)&&usr.PetsAge<10)
							usr<<"[P.name] doesn't think it's a good idea to attack [M]"
							if(P.Wfight)
								usr<<"[P.name] stops acting aggressively."
								P.Wfight=0
							return
						else if(prob(50)&&usr.PetsAge>=10&&usr.PetsAge<25)
							usr<<"[P.name] doesn't think it's a good idea to attack [M]"
							if(P.Wfight)
								usr<<"[P.name] stops acting aggressively."
								P.Wfight=0
							return
					walk_towards(P,M)
/////////////////////////////////////////////////////////////////////////////////////////////
//Village Capture the Flag 1.1
mob/Bump(obj/src)
	..()
	if(istype(src,/obj/Base/Door))
		var/obj/Base/Door/D=src
		if(D.open)
			usr.loc=locate(pick(130,131),97,20)
		else
			if(!D.sentmessage)
				D.sentmessage=1
				spawn(30)
					D.sentmessage=0
				usr<<"Press F to open the door."
			return 0

	if(istype(src,/obj/Hidden_Ninja_Scroll))
		var/obj/Hidden_Ninja_Scroll/H=src
		if(!usr.client) return
		if(usr.Village!=H.VillageIn)
			if(!H.CanBeTaken)
				usr<<"Not yet, there is a 10 minute delay"
				return
			if(usr.pickedup)
				return
			usr.pickedup=1
			sleep(1)
			PreviousLocation=H.loc
			H.loc=usr;usr.loc=PreviousLocation
			usr.HasHiddenScroll=1
			if(prob(10))
				if(usr.Acceleration<10)
					var/image/I = new('Icons/Jutsus/Skillcards.dmi');I.pixel_y=32;I.layer=6;I.icon_state="SwiftYes"
					usr.overlays+=I
					spawn(15)
						usr.overlays-=I
					usr.Acceleration+=1
					if(usr.Acceleration>10)
						usr.Acceleration=10
			ScrollIsIn="Not Currently Taken"
			for(var/obj/VillageScrollPost/V in usr.loc)
				V.density=1

			if(H.VillageIn=="")
				world<<"<font color=red size=2>[usr] has picked up the Hidden Ninja Scroll!</font>"
			else
				world<<"<font color=red size=2>[usr] has stolen the Hidden Ninja Scroll from the [H.VillageIn] Temple!</font>"
		else
			return 0

	if(istype(src,/obj/captureTheFlagScroll))
		var/obj/captureTheFlagScroll/H=src
		if(!usr.client) return
		if(usr.Village==H.VillageIn)
			if(!H.CanBeTaken)
				usr<<"Not yet, there is a 30 second delay"
				return
	//		if(usr.pickedup)
	//			return
	//		usr.pickedup=1
	//		sleep(1)
			PreviousLocation=H.loc
			H.loc=usr;usr.loc=PreviousLocation
			usr.HasHiddenScroll=1
			for(var/obj/VillageScrollPost/V in usr.loc)
				V.density=1
			if(H.VillageIn=="")
				world<<"<font color=red size=2>[usr] has picked up the Flag!</font>"
			else
				world<<"<font color=red size=2>[usr] has stolen the Flag from the [H.VillageIn] Post!</font>"
		else
			return 0

	if(istype(src,/obj/VillageScrollPost))
		var/obj/O=src
		if(!usr.client) return
		if(O.VillagePost in list("Team 1","Team 2")) //If this is a village war post...
			if(usr.HasHiddenScroll)
				var/PostIs
				if(O.VillagePost=="Team 1") PostIs = global.villageWarTeamOne
				if(O.VillagePost=="Team 2") PostIs = global.villageWarTeamTwo
				if(usr.Village == PostIs)
					if(usr.delivered) return
					usr.delivered=1
					spawn(100)
						usr.delivered=0
					for(var/obj/captureTheFlagScroll/H in usr.contents)
						H.loc=locate(O.x,O.y+1,O.z)
						usr.HasHiddenScroll=0
						H.VillageIn=O.VillagePost
						world<<"<font color=red size=2>[usr] delivered the Flag to the [PostIs] Post!</font>"
						if(usr.Village == global.villageWarTeamOne)
							global.villageWarTeamOneScore++
						if(usr.Village == global.villageWarTeamTwo)
							global.villageWarTeamTwoScore++
						usr.pickedup=0
						H.ScrollWait()
					return 0
				else
					usr<<"You cannot deliver it to a village other than your own!"
					return
		else
			if(usr.HasHiddenScroll&&usr.Village==O.VillagePost)
				if(usr.delivered) return
				usr.delivered=1
				spawn(100)
					usr.delivered=0
				for(var/obj/Hidden_Ninja_Scroll/H in usr.contents)
					H.loc=locate(O.x,O.y+1,O.z)
					usr.HasHiddenScroll=0
					H.VillageIn=O.VillagePost
					world<<"<font color=red size=2>[usr] delivered the Hidden Ninja Scroll to the [O.VillagePost] Temple</font>"
					/*if(usr.JutsuInLearning!="")
						usr.JutsuEXPCost+=15000
						if(usr.Subscriber)
							usr.JutsuEXPCost+=5000
					if(usr.JutsuDelay>0)
						usr.JutsuDelay-=round(usr.JutsuDelay/10)*/
					if(O.VillagePost == "Leaf")
						for(var/mob/M in world)
							M.DBLEXPCD=1
							M<<"Leaf currently has the hidden ninja scroll! You now gain Double EXP/CD."
							if(M.Village == "Sound" || M.Village == "Rain" || M.Village == "Rock" || M.Village == "Missing")
								M.DBLEXPCD=0
					if(O.VillagePost == "Sound")
						for(var/mob/M in world)
							M.DBLEXPCD=1
							M<<"Sound currently has the hidden ninja scroll! You now gain Double EXP/CD."
							if(M.Village == "Leaf" || M.Village == "Rain" || M.Village == "Rock" || M.Village == "Missing")
								M.DBLEXPCD=0
					if(O.VillagePost == "Rain")
						for(var/mob/M in world)
							M.DBLEXPCD=1
							M<<"Rain currently has the hidden ninja scroll! You now gain Double EXP/CD."
							if(M.Village == "Leaf" || M.Village == "Sound" || M.Village == "Rock" || M.Village == "Missing")
								M.DBLEXPCD=0
					if(O.VillagePost == "Rock")
						for(var/mob/M in world)
							M.DBLEXPCD=1
							M<<"Rock currently has the hidden ninja scroll! You now gain Double EXP/CD."
							if(M.Village == "Leaf" || M.Village == "Sound" || M.Village == "Rain" || M.Village == "Missing")
								M.DBLEXPCD=0
					usr.VMorale+=7
					usr.pickedup=0
					if(prob(10))
						if(usr.RunningSpeed<5)
							var/image/I = new('Icons/Jutsus/Skillcards.dmi');I.pixel_y=32;I.layer=6;I.icon_state="SwiftYes"
							usr.overlays+=I
							spawn(15)
								usr.overlays-=I
							usr.RunningSpeed+=1
							if(usr.RunningSpeed>5)
								usr.RunningSpeed=5
					ScrollIsIn="[O.VillagePost]"
					H.ScrollWait()
				return 0
			else if(usr.Village!=O.VillagePost)
				usr<<"You cannot deliver it to a village other than your own!"
				return



	else if(istype(src,/obj/Genjutsu/FakeSwarm))
		if(src.Person!=usr)
			usr.loc=src.loc
			return
	else if(istype(src,/obj))//if it's obj...
		if(istype(src,/obj/NinjaEquipment/TheWires)&&!usr.ImmuneToDeath)
			viewers(10,usr)<<"[usr] tripped over the wire.";usr.Stun=11
			for(var/obj/NinjaEquipment/TheWires/W in oview(25,src))
				if(W.x==src.x||W.y==src.y)
					del(W)
				del(src)
			return//return..
mob/Bump(mob/src)
	..()
	if(istype(src,/turf))//if it's turf...
		return//return...
	if(istype(src,/obj))//if it's obj...
		return//return...
	if(src&&usr&&usr.inchoke||src&&usr&&src.inchoke)
		return
 if(istype(src,/turf))//if it's turf...
  return//return...
 if(istype(src,/mob/Bugs/)&&src.Owner==usr)
  usr.loc=src.loc
  return
 if(istype(src,/mob/pet/))
  var/mob/pet/B=src
  if(B.Owner==usr)
   if(B.PlayingTag)
    usr<<"You tagged [B.name]!"
    B.PlayingTag=0
    if(prob(20))
     usr.DogCompanionship+=rand(0.25,0.30)
 if(istype(src,/mob/Barrier2)&&usr.NosinasisMemoriaMember)
  usr.loc=src.loc
  return
 else if(istype(src,/mob/Barrier2)&&!usr.NosinasisMemoriaMember)
  usr<<"An unseeable force prevents you from proceeding further..."
  return
 else if(usr.Rasenganon)
  if(src.Chidorion||src.Raikirion)
   usr.Frozen=1;src.Frozen=1
   usr.firing=1;src.firing=1
   usr<<"You clash your Rasengan with [src]'s Chidori!";src<<"You clash your Chidori with [usr]'s Rasengan!"
   while(usr.Rasenganon&&src.Chidorion||usr.Rasenganon&&src.Raikirion)
    usr.RasenganD-=50
    src.ChidoriD-=50
    spawn() for(var/mob/M in oview(7))
     Quake_Effect(M,10,1)
    if(prob(50))
     spawn()
      usr.CreateSmoke("Light");
      src.CreateSmoke("Light")
    if(prob(25))
     spawn()
      usr.CreateCrator();src.CreateCrator()
    sleep(11)
   usr.Frozen=0;src.Frozen=0
   src.firing=0;usr.firing=0
   if(usr.Rasenganon)
    usr.RasenganD=5000
    usr.RasenganA(src)
   if(src.Chidorion)
    src.ChidoriD=5000
    src.ChidoriA(usr)
 else if(usr.Chidorion|usr.Raikirion)
  if(src.Rasenganon)
   usr.Frozen=1;src.Frozen=1
   usr.firing=1;src.firing=1
   usr<<"You clash your Chidori with [src]'s Rasengan!";src<<"You clash your Rasengan with [usr]'s Chidori!"
   while(src.Rasenganon&&usr.Chidorion||src.Rasenganon&&usr.Raikirion)
   	sleep(11)
    src.RasenganD-=50
    usr.ChidoriD-=50
    spawn()
     for(var/mob/M in oview(7))
      Quake_Effect(M,10,1)
     if(prob(50))
      usr.CreateSmoke("Light");src.CreateSmoke("Light")
     if(prob(25))
      usr.CreateCrator();src.CreateCrator()
   usr.Frozen=0;src.Frozen=0
   src.firing=0;usr.firing=0
   if(src.Rasenganon)
    src.RasenganD=5000
    src.RasenganA(usr)
   if(usr.Chidorion||usr.Raikirion)
    usr.ChidoriD=5000
    usr.ChidoriA(src)
  else
   usr.ChidoriA(src)

 else if(usr.intank)//MEAT TANK
  var/Damage=round(rand(usr.tai*300,usr.tai*350),1)
  if(usr.GatheredUpMeatTankCalories>=1)
  	Damage=Damage*(usr.GatheredUpMeatTankCalories)
  Damage/=src.Endurance
  if(usr.GatheredUpMeatTankCalories<=0&&Damage>3500)
  	Damage=3500
  if(!src.knockedout)
  	src.DamageProc(Damage,"Stamina",usr)
  	view()<<"[usr] hit [src] with their Nikudan Sensha for [Damage]!"//say it to those who are near you...
  step_rand(src);step(src,src.dir);step(src,src.dir)
  if(usr.GatheredUpMeatTankCalories>=1)
  	step_rand(src);step(src,src.dir);step(src,src.dir)
  usr.GatheredUpMeatTankCalories=0
 else if(usr.intsu)
  var/damage=round(rand(usr.tai*190,usr.tai*225))
  src.DamageProc(damage/(src.Endurance),"Stamina",usr)
  if(!usr.ManBeastClaws)
  	view()<<"[usr] hit [src] with their Tsuuga for [damage/(src.Endurance)]!"
  else
  	view()<<"[usr] hit [src] with their Tsuuga for [damage/(src.Endurance)/7]!"
//walk(src,usr.dir)
  spawn()
   step(src,usr.dir)
  if(usr.ManBeastClaws)
  	src.DamageProc(damage/(src.Endurance)/7,"Health",usr)
  	spawn()
  		src.Bloody();src.Bloody();src.Bloody()
  if(prob(23))
 	 step_rand(src)
 else if(usr.ingat)
  var/damage=round(rand(usr.tai*220,usr.tai*250))//*usr.ingat
  src.DamageProc(damage/(src.Endurance),"Stamina",usr)
  if(usr.ingat==2)
  	view()<<"[usr] hit [src] with their Garouga for [damage/(src.Endurance)]!"
  else
  	view()<<"[usr] hit [src] with their Gatsuuga for [damage/(src.Endurance)]!"
  if(usr.ManBeastClaws)
  	src.DamageProc(damage/(src.Endurance)/8,"Health",usr)
  	spawn()
  		src.Bloody();src.Bloody();src.Bloody()
  spawn()
   step(src,usr.dir);step(src,src.dir);step(src,src.dir);step(src,src.dir)
 else if(usr.usingA == 1)
  var/Damage=src.maxhealth*0.03
  if(src&&usr)
//   if(src.stamina>0)
 //   Damage=src.maxstamina*(0.02+(src.BoneMastery*0.0005))
  //  src.stamina-=Damage
 //  else
   src.health-=Damage
   spawn()Blood(src.x,src.y,src.z)
   view()<<"[src] was hit for [Damage] damage by [usr]'s arm bone!"
   src.Death(usr)
 else if(usr.InGarou)
  var/Damage=src.maxhealth*0.02
  var/RDirection=rand(1,8)
  if(src&&usr)
   src.DamageProc(Damage,"Health",usr)
   src.HitBack(6,turn(usr.dir,45*RDirection))
   spawn()
   	if(src) src.Bloody()
   view()<<"[src] was ripped to shreds by the tornado!"
  else
   return

/////////////////////////////////////////////////////////
//Scent Tracking..
//////////////////////////
//Need to add a cap for how many scents you can take at once!
mob/var/tmp/list/Scents=list()
mob
	proc
		CheckScents()
			if(src.ingat||src.Kaiten||src.firing||src.knockedout||src.Frozen||src.FrozenBind!="")
				return
			if(src.Scents.len<=0)
				src<<"You don't have any scents!"
				return
			src<<"You have [src.Scents.len] Scents."
			for(var/X in src.Scents)
				src<<"[X]"
		ScentTrackStart()
			if(src.ingat||src.Kaiten||src.firing)
				return
			var/TimeUntilEnd=5
			var/ScentsLen=src.Scents.len
			src<<"Go next to someone that you want to Track the scent of in the next 5 seconds to capture their scent!"
			while(TimeUntilEnd>0)
				sleep(10)
				TimeUntilEnd--
				if(src.knockedout)
					src<<"You got knocked out, making you lose your attempt to smell.."
					return
				if(src.Stun>0)
					src<<"You become stunned and unable to smell!"
					return
			for(var/mob/M in oview(1,src))
		//		if(M in OnlinePlayers)
				if(locate(M in src.Scents))
					src<<"You already have [M]'s scent!";
					return

				src.Scents+=M
				src<<"You begin to recognize [M]'s scent!"
			if(ScentsLen==src.Scents.len)
				src<<"You were unable to get another scent!"
		TrackScent()
			if(src.ingat||src.Kaiten||src.firing)
				return
			if(src.Scents.len<=0)
				src<<"You don't have any scents!"
				return
				//var/S = input(P,"These are the nominees for [Position], place your vote.",) in Nominees + list("I don't vote")
			var/S = input(src,"Whose Scent would you like to Search for?") in Scents + list("None")
			if(S=="None")
				return
			var/mob/M=S
			var/MapCheck=0
			if(M.z==src.z)
				MapCheck=1
			if(MapCheck==1)
				src<<"The location of [M] is [M.x] [M.y]!(Direct Coordinates)"
				if(M.x>src.x)
					src<<"[M] is farther east than you."
				else if(src.x>M.x)
					src<<"[M] is farther west than you."
				if(M.y>src.y)
					src<<"[M] is farther north than you."
				else if(M.y<src.y)
					src<<"[M] is farther south than you."
				if(prob(40))
					src.Scents-=S
			else
				src<<"You can't locate [M](They are on a different map than you!"
				return




///////////////////////////////////////////////////////
//Tsuuga..Done
//////////////////////////
mob/var/tmp/intsu=0
mob
	proc
		Tsuuga()
			if(usr.ingat||usr.Kaiten||usr.firing)
				return
			if(usr.inso == 1)
				usr<<"Not while in Soutourou!"
			else
				if(src.target)
					src.dir=get_dir(src,src.target)
	//			if(prob(50))
	//				view()<<"<font size=1><font face=verdana><b><font color=white>[usr]<font color=green> Says: <FONT COLOR=#708090>T</FONT><FONT COLOR=#a0abb5>s</FONT><FONT COLOR=#d0d5db>u</FONT><FONT COLOR=#ffffff>u</FONT><FONT COLOR=#d5d5d5>g</FONT><FONT COLOR=#ababab>a</FONT><FONT COLOR=#808080>!</FONT>"
				usr.intsu=1
				usr.ChakraDrain(12000)
			//	usr.Move_Delay-=1
				usr.overlays-='Icons/Jutsus/Tsuuga.dmi'
				usr.overlays+='Icons/Jutsus/Tsuuga.dmi'
				usr.firing=1
				sleep(150)
				usr.intsu=0
				usr.overlays-='Icons/Jutsus/Tsuuga.dmi'
			//	usr.Move_Delay=usr.Savedspeed
				usr.firing=0
				return
///////////////////////////////////////////////////////
//Shikyaku..Done
//////////////////////////
mob/var/tmp/shika=0
mob/proc/Shikyaku()
	if(src.shika)
		src<<"You turn back to normal!"
		src.shika=0
		src.icon_state=""
		src.tai=src.Mtai
	//	src.Endurance=src.MEndurance
		//src.Move_Delay=usr.Savedspeed
		return
	else
		if(src.stamina<=src.maxstamina*0.10)
			return
		src.shika=1
		src.icon_state="beastman"
		src<<"Your senses have improved!"
	//	src.Endurance+=5
		src.tai=src.Mtai*1.20
		while(src.shika)
			if(prob(3))
				src.SuperHearing+=pick(0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1)
				if(src.SuperHearing>6)
					src.SuperHearing=6
			sleep(11)
///////////////////////////////////////////////////////
//Exploding Puppy
//////////////////////////
mob/proc/ExplodingPuppy()
	if(!usr.PetOut)
		usr<<"Your Pet must be out!";
		return
	else
		usr.ChakraDrain(35000)
		for(var/obj/WEAPONS/Kunai/P in usr.contents)
			if(P.ammount<=9)
				usr<<"You don't have enough Kunais to use this Jutsu!"
				return
			if(P.ammount>9)
				P.ammount-=9
		for(var/mob/pet/P in view(10,src))
			if(P.Owner==src)
				var/obj/SmokeCloud/A=new();A.loc=P.loc
				var/X=pick(5,7)
				while(X>0)
					var/obj/WEAPONS/Kunai/K=new();K.icon_state="Throwz";K.loc=P.loc;K.dir=NORTH;K.Percision=src.Percision;K.Move_Delay=1;K.ShadowClone=1
					var/obj/WEAPONS/Kunai/KK=new();KK.icon_state="Throwz";KK.loc=P.loc;KK.dir=EAST;KK.Percision=src.Percision;KK.Move_Delay=1;KK.ShadowClone=1
					var/obj/WEAPONS/Kunai/KKK=new();KKK.icon_state="Throwz";KKK.loc=P.loc;KKK.dir=WEST;KKK.Percision=src.Percision;KKK.Move_Delay=1;KKK.ShadowClone=1
					var/obj/WEAPONS/Kunai/KKKK=new();KKKK.icon_state="Throwz";KKKK.loc=P.loc;KKKK.dir=SOUTH;KKKK.Percision=src.Percision;KKKK.Move_Delay=1;KKKK.ShadowClone=1
					var/obj/WEAPONS/Kunai/KKKKK=new();KKKKK.icon_state="Throwz";KKKKK.loc=P.loc;KKKKK.dir=SOUTHEAST;KKKKK.Percision=src.Percision;KKKKK.Move_Delay=1;KKKKK.ShadowClone=1
					var/obj/WEAPONS/Kunai/KKKKKK=new();KKKKKK.icon_state="Throwz";KKKKKK.loc=P.loc;KKKKKK.dir=SOUTHWEST;KKKKKK.Percision=src.Percision;KKKKKK.Move_Delay=1;KKKKKK.ShadowClone=1
					var/obj/WEAPONS/Kunai/KKKKKKK=new();KKKKKKK.icon_state="Throwz";KKKKKKK.loc=P.loc;KKKKKKK.dir=NORTHWEST;KKKKKKK.Percision=src.Percision;KKKKKKK.Move_Delay=1;KKKKKK.ShadowClone=1
					var/obj/WEAPONS/Kunai/KKKKKKKK=new();KKKKKKKK.icon_state="Throwz";KKKKKKKK.loc=P.loc;KKKKKKKK.dir=NORTHEAST;KKKKKKKK.Percision=src.Percision;KKKKKKKK.Move_Delay=1;KKKKKKK.ShadowClone=1
					K.Owner=usr;KK.Owner=usr;KKK.Owner=usr;KKKK.Owner=usr;
					KKKKK.Owner=usr;KKKKKK.Owner=usr;KKKKKKK.Owner=usr;KKKKKKKK.Owner=usr;
					walk(K,K.dir);walk(KK,KK.dir);walk(KKK,KKK.dir);walk(KKKK,KKKK.dir)
					walk(KKKKK,KKKKK.dir);walk(KKKKKK,KKKKKK.dir);walk(KKKKKKK,KKKKKKK.dir);walk(KKKKKKKK,KKKKKKKK.dir)
					X--
					sleep(pick(1,2))
				src.PetOut=0

				var/PetCap = ((src.PetsAge+1)*100)
				if(src.PMTai>PetCap) src.PMTai=PetCap
				if(src.PMNin>PetCap) src.PMNin=PetCap
				if(src.PMGen>PetCap) src.PMGen=PetCap
				src.PTai=src.PMTai;P.tai=src.PMTai;P.Mtai=src.PMTai
				src.PNin=src.PMNin;P.nin=src.PMNin;P.Mnin=src.PMNin
				src.PGen=src.PMGen;P.gen=src.PMGen;P.Mgen=src.PMGen

				src.PetsHealth=P.health
				src.PetsMHealth=P.maxhealth
				src.PetsStamina=P.stamina
				src.PetsMStamina=P.maxstamina
				src.PetsChakra=P.chakra
				src.PetsMChakra=P.Mchakra

				src.PTai=P.tai
				src.PMTai=P.Mtai
				src.PNin=P.nin
				src.PMNin=P.Mnin
				src.PGen=P.gen
				src.PMGen=P.Mgen

				del(P)


///////////////////////////////////////////////////////
//Juujin Bunshin..Done
//////////////////////////
mob
	proc
		JuujinBunshin()

			if(usr.firing)
				return
			if(usr.inso==1)
				usr<<"Not while in Soutourou!"
			if(!usr.shika)
				usr<<"You must be in Shikyaku!"
				return
			if(!usr.PetOut)
				usr<<"Your pet isn't out!"
				return
			else
				src.ChakraDrain(3000)
				usr.Handseals(1-usr.HandsealSpeed)
				if(usr.HandsSlipped) return
				for(var/mob/pet/M in oview(1))
					if(M.Owner==usr)
						if(M.Jujin)
							usr.Jujin=0
							M.Jujin=0
							M.overlays=null
							M.icon='Icons/NPCs/dog.dmi'
							M.Swift=src.Swift
							if(usr.PetsAge>4)
								if(usr.SavedPetIcon=='Icons/NPCs/dog.dmi')
									M.icon='Icons/NPCs/dogGrowUp.dmi'
								if(usr.SavedPetIcon=='Icons/NPCs/dog2.dmi')
									M.icon='Icons/NPCs/dog2GrowUp.dmi'
								if(usr.SavedPetIcon=='Icons/NPCs/dog3.dmi')
									M.icon='Icons/NPCs/dog3GrowUp.dmi'
								if(usr.SavedPetIcon=='Icons/NPCs/dog4.dmi')
									M.icon='Icons/NPCs/dog4GrowUp.dmi'
							return
			//			if(prob(50))
			//				view()<<"<font size=1><font face=verdana><b><font color=white>[usr]<font color=green> Says: <FONT COLOR=#f4a460>J</FONT><FONT COLOR=#ee9a5c>u</FONT><FONT COLOR=#e68f57>u</FONT><FONT COLOR=#df8352>j</FONT><FONT COLOR=#d8784d>i</FONT><FONT COLOR=#d16d48>n</FONT><FONT COLOR=#c96243> </FONT><FONT COLOR=#c2573e>B</FONT><FONT COLOR=#bb4c39>u</FONT><FONT COLOR=#b44034>n</FONT><FONT COLOR=#ac352f>s</FONT><FONT COLOR=#a52a2a>h</FONT><FONT COLOR=#a62a2a>i</FONT><FONT COLOR=#a72a2a>n</FONT><FONT COLOR=#a92929> </FONT><FONT COLOR=#aa2828>N</FONT><FONT COLOR=#ab2727>o</FONT><FONT COLOR=#ac2727> </FONT><FONT COLOR=#ad2626>J</FONT><FONT COLOR=#ae2525>u</FONT><FONT COLOR=#b02424>t</FONT><FONT COLOR=#b12424>s</FONT><FONT COLOR=#b22323>u</FONT><FONT COLOR=#b22222>!</FONT>"
						usr.Jujin=1
						M.tai=usr.tai
						M.nin=usr.nin
						sleep(3)
						M.icon=usr.icon
						M.shika=1
						var/obj/SmokeCloud/S = new /obj/SmokeCloud
						S.loc=locate(M.x,M.y,M.z)
						M.overlays+=usr.overlays
						sleep(5)
						M.Jujin=1
						return
///////////////////////////////////////////////////////
//Gatsuuga...Done
//////////////////////////
mob/var/tmp/ingat=0
mob
	proc
		Gatsuuga1()
			usr.ChakraDrain(15000)
			if(usr.ingat||usr.Kaiten||usr.firing)
				return
			if(usr.inso)
				return
			else
				for(var/mob/pet/P in oview(11,usr))
					if(!usr.Jujin||!P.Jujin)
						usr<<"You need to use Juujin Bunshin No Jutsu first!"
						return
		//			if(prob(50))
		//				view(usr)<<"<font size=1><font face=verdana><b><font color=white>[usr]<font color=green> Says: Gatsuuga!"
					usr.firing=1
					usr.ingat=1
					P.ingat=1
			//		usr.Move_Delay-=1
					usr.overlays-='Icons/Jutsus/Tsuuga.dmi'
					P.overlays-='Icons/Jutsus/Tsuuga.dmi'
					usr.overlays+='Icons/Jutsus/Tsuuga.dmi'
					P.overlays+='Icons/Jutsus/Tsuuga.dmi'
					usr.Constant()
					P.Constant()
					if(usr.target)
						var/mob/T=usr.target
						var/a=25
						while(a>0&&T)
							//var/d=get_dir(usr,T)
							//var/d2=get_dir(P,T)
							//if(usr.dir!=d)
							//	usr.dir=turn(usr.dir,45)
							//if(P.dir!=d2)
							//	P.dir=turn(P.dir,-45)
							P.dir=angle2dir(get_real_angle(P, T))
							step(usr,usr.dir)
							step(P,P.dir)
							a--
							sleep(2)
					else
						walk(usr,usr.dir)
						walk(P,P.dir)
						sleep(30)
					walk(usr,0)
					walk(P,0)
					usr.ingat=0
					P.ingat=0
					usr.overlays-='Icons/Jutsus/Tsuuga.dmi'
					P.overlays-='Icons/Jutsus/Tsuuga.dmi'
					P.Normal()
					usr.Normal()
				//	usr.Move_Delay=usr.Savedspeed
					usr.firing=0
					return
///////////////////////////////////////////////////////
//ManBeastClaws=0
//////////////////////////
mob/var/tmp/ManBeastClaws=0
mob/proc/ManBeastClaws()
	if(src.ManBeastClaws)
		src.ManBeastClaws=0
	else
		src.icon_state="handseal";src<<"You generate chakra that grows out your claws!"
		sleep(30);src.icon_state=""
		src.ManBeastClaws=1
		while(src.ManBeastClaws)
			src.chakra-=10
			sleep(11)
///////////////////////////////////////////////////////
//Soutourou
//////////////////////////
mob/var/tmp/inso=0
obj/Inuzuka/PartsOfSoutourou
	Part1
		icon='Soutourou-1W.dmi'
		layer=MOB_LAYER+1
		pixel_x=-32
		pixel_y=32
	Part2
		icon='Soutourou-2W.dmi'
		layer=MOB_LAYER+1
		pixel_y=32
	Part3
		icon='Soutourou-3W.dmi'
		layer=MOB_LAYER+1
		pixel_x=32
		pixel_y=32
	Part4
		icon='Soutourou-4W.dmi'
		layer=MOB_LAYER+1
		pixel_x=-32
	Part5
		icon='Soutourou-5W.dmi'
		layer=MOB_LAYER+1
	Part6
		icon='Soutourou-6W.dmi'
		layer=MOB_LAYER+1
		pixel_x=32
	Part7
		icon='Soutourou-7W.dmi'
		pixel_x=-32
		pixel_y=-32
	Part8
		icon='Soutourou-8W.dmi'
		pixel_y=-32
//	Part9
//		icon='Soutourou-9W.dmi'
//		pixel_x=32
//		pixel_y=-32

mob
	proc
		Soutourou()
			if(usr.firing)
				return
			if(!usr.shika)
				usr<<"You must be in Shikyaku!"
				return
			if(!usr.PetOut)
				usr<<"Your pet isn't out!"
				return
			else
				src.ChakraDrain(10000)
				usr.Handseals(1-usr.HandsealSpeed)
				if(usr.HandsSlipped) return
				for(var/mob/pet/P in world)
					if(P.Owner==usr)
						usr.PetOut=0

						var/PetCap = ((usr.PetsAge+1)*100)
						if(usr.PMTai>PetCap) usr.PMTai=PetCap
						if(usr.PMNin>PetCap) usr.PMNin=PetCap
						if(usr.PMGen>PetCap) usr.PMGen=PetCap
						usr.PTai=usr.PMTai;P.tai=usr.PMTai;P.Mtai=usr.PMTai
						usr.PNin=usr.PMNin;P.nin=usr.PMNin;P.Mnin=usr.PMNin
						usr.PGen=usr.PMGen;P.gen=usr.PMGen;P.Mgen=usr.PMGen

						usr.PetsHealth=P.health
						usr.PetsMHealth=P.maxhealth
						usr.PetsStamina=P.stamina
						usr.PetsMStamina=P.maxstamina
						usr.PetsChakra=P.chakra
						usr.PetsMChakra=P.Mchakra

						usr.PTai=P.tai
						usr.PMTai=P.Mtai
						usr.PNin=P.nin
						usr.PMNin=P.Mnin
						usr.PGen=P.gen
						usr.PMGen=P.Mgen

						var/obj/SmokeCloud/S = new /obj/SmokeCloud
						S.loc=locate(P.x,P.y,P.z)
						del(P)

						for(var/turf/T in oview(2,src))
							var/obj/SmokeCloud/X = new /obj/SmokeCloud
							X.loc=locate(T.x,T.y,T.z)

						src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part1
						src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part2
						src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part3
						src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part4
						src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part5
						src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part6
						src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part7
						src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part8
					//	src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part9

						src.overlays+=new/obj/Inuzuka/PartsOfSoutourou/Part1
						src.overlays+=new/obj/Inuzuka/PartsOfSoutourou/Part2
						src.overlays+=new/obj/Inuzuka/PartsOfSoutourou/Part3
						src.overlays+=new/obj/Inuzuka/PartsOfSoutourou/Part4
						src.overlays+=new/obj/Inuzuka/PartsOfSoutourou/Part5
						src.overlays+=new/obj/Inuzuka/PartsOfSoutourou/Part6
						src.overlays+=new/obj/Inuzuka/PartsOfSoutourou/Part7
						src.overlays+=new/obj/Inuzuka/PartsOfSoutourou/Part8
					//	src.overlays+=new/obj/Inuzuka/PartsOfSoutourou/Part9
						src.inso=1
						while(src.inso)
							src.chakra-=10
							src.tai=src.Mtai*5
							sleep(11)

						src.tai=src.Mtai
						for(var/turf/T in oview(2,src))
							var/obj/SmokeCloud/XZ = new /obj/SmokeCloud
							XZ.loc=locate(T.x,T.y,T.z)
						src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part1
						src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part2
						src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part3
						src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part4
						src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part5
						src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part6
						src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part7
						src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part8
					//	src.overlays-=new/obj/Inuzuka/PartsOfSoutourou/Part9
///////////////////////////////////////////////////////
//Garouga
//////////////////////////
mob
	proc
		Garouga()
			if(src.ingat||src.Kaiten||src.firing)
				return
			if(!src.inso)
				return
			else
				src.firing=1
				src.ingat=2
				spawn(100)
					src.ingat=0
		//		src.Move_Delay-=1
				while(usr.ingat==2)
					src.icon_state="Garouga"
			//		src.Move_Delay-=1
					src.Running=1
					sleep(11)
				src.icon_state=""
				src.Running=0
				src.firing=0
