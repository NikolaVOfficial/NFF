/*
Mitchell Quinn
Ninja Cash System

The idea for this system is basically to have a system that allows for editing people in a fair and balance way.


Everyone will have the oppertunity to get these upgrades it will basically be an npc who sells them.
*/

mob/var/NinjaCash = 0;
mob/var/CharacterCooldown = 0;


obj/NinjaCash
	Age_Scroll
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="Age Scroll"
		Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return
		verb
			Get()
				set src in oview(1)
				usr<<"You picked up the scroll"
				src.Move(usr)
			Use()
				src.Utilize(usr)
		proc
			Utilize(mob/M)
				M=usr
				if(usr.AgeScrollBoost>0)
					usr<<"You're already using a Age scroll!"
					return
				if(usr.AgeScrollBoost<=0)
					usr.AgeScrollBoost=21600
					usr<<"A mystical power begins to flow through your veins..you will reach your next age a bit more quickly."
					del(src)
				else
					usr<<"Best to save this scroll for another time.."
					return
	Knowledge_Scroll
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="Knowledge Scroll"
		var/InUse=0
		Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return
		verb
			Get()
				set src in oview(1)
				usr<<"You picked up the scroll"
				src.Move(usr)
			Use()
				src.Utilize(usr)
		proc
			Utilize(mob/M)
				if(InUse)
					return
				src.InUse=1
				M=usr
				switch(input(usr,"This scroll contains vast amounts of knowledge. What do you want to research?") in list("Taijutsu","Ninjutsu","Genjutsu","Katon","Suiton","Raiton","Doton","Fuuton","Weapons"))
					if("Taijutsu")
						usr.TaijutsuKnowledge+=100
					if("Ninjutsu")
						usr.NinjutsuKnowledge+=100
					if("Genjutsu")
						usr.GenjutsuKnowledge+=100
					if("Katon")
						usr.KatonKnowledge+=100
					if("Suiton")
						usr.SuitonKnowledge+=100
					if("Raiton")
						usr.RaitonKnowledge+=100
					if("Doton")
						usr.DotonKnowledge+=100
					if("Fuuton")
						usr.FuutonKnowledge+=100
					if("Weapons")
						usr.KunaiMastery+=10
						if(usr.KunaiMastery>=100)
							usr.KunaiMastery=100
						usr.ShurikenMastery+=10
						if(usr.ShurikenMastery>=100)
							usr.ShurikenMastery=100
						usr.Kenjutsu+=10
						if(usr.Kenjutsu<100)
							usr.Kenjutsu+=10
						usr.Bojutsu+=10
						if(usr.Bojutsu>=100)
							usr.Bojutsu=100
				usr<<"You finish reading the scroll, and the sealing jutsu on the scroll activates and seals the scroll permanently."
				del(src)
	ExpScroll
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="Exp Scroll(25k)"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)

		proc
			Utilize(mob/M)
				M=usr
				if(usr.JutsuDelay<0)
					usr.JutsuEXPCost+=(50000)
					usr<<"Your gained EXP towards learning your jutsu! You're filled with knowledge!!"
					usr.SaveK()
					del(src)
				else
					usr<<"Best to save this scroll for another time.."
					return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				return


	CooldownScroll
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="Cooldown Scroll"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)

		proc
			Utilize(mob/M)
				M=usr
				if(usr.JutsuDelay>0)
					usr.JutsuDelay-=(50000)
					usr<<"Your Jutsu Learning CoolDown was reduced! You feel energetic!!"
					usr.SaveK()
					del(src)
				else
					usr<<"Best to save this scroll for another time.."
					return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				return

	CharacterBuildingScroll
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="Character Building Scroll (+2SP, +5EP)"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)

		proc
			Utilize(mob/M)
				M=usr
				if(usr.CharacterCooldown==0)
					usr.CharacterCooldown=1
					usr.StartingPoints +=2
					usr.ElementalPoints+=5
					usr<<"You apply the Character Building Scroll to your Character"
					usr.SaveK()
					del(src)
				else
					usr<<"You already used a Character Cooldown Scroll"
					return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				return


	MangekyouEyeRestore
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="Mangekyou Eye Restore"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)

		proc
			Utilize(mob/M)
				M=usr
				if(usr.MUses > 0)
					usr.MUses = 0
					usr<<"Your eyes are restored."
					usr.SaveK()
					del(src)
				else
					usr<<"You dont need to use this scroll."
					return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				return



	NameChangeScroll
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="Name Change Scroll"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)

		proc
			Utilize(mob/M)
				M=usr
				switch(input(usr,"[src]: Do you want to change your name?") in list ("Yes, I want to change my name.","No, I like my name"))
					if("No, I like my name")
						usr.SaveK()
						return
					if("Yes, I want to change my name.")
						usr.FirstName = input(usr,"Choose a name for your character.","Your Name",usr.FirstName)
						usr.SaveK()
						usr<<"Name Change Successful."
						return


			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				return