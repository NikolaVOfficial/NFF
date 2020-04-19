mob/var/tmp/
	AstralSoulForm=0
	AstralSoulPoss=""
	AstralSoulAtta=0
	AstralSoulHeal=0


mob/proc
	AstralSoulProjection()
		set background=1
		if(src.AstralSoulForm>0)
			src<<"You return to your body!"
			for(var/mob/AstralSoul/Projection/A in src.JutsuList)
				if(A.Owner==src)
					del(A)
			src.AstralSoulForm=0;
			src.see_invisible=1
			src.ChakraSight(0)
			src.UnableToChargeChakra=0
			src.controlled=null;
			src.client.perspective=MOB_PERSPECTIVE;
			src.client.eye=src
			src.icon_state=""
		else
			if(src.Kaiten||src.firing||src.knockedout)
				return
			src << "You begin to project your soul."
			src.AstralSoulForm=1
			src.see_invisible=99
			src.ChakraSight(1)
			var/mob/AstralSoul/Projection/AT=new()
			AT.name="[src]";AT.Owner=src;src.JutsuList+=AT;
			AT.icon=src.icon;AT.overlays+=src.overlays
			AT.RunningSpeed=src.RunningSpeed;AT.Acceleration=src.Acceleration
			AT.loc=locate(src.x,src.y,src.z);AT.dir=src.dir;src.controlled=AT;src.UnableToChargeChakra=1
			AT.RunningSpeed=5;AT.Running=1
			AT.icon_state="running";AT.cansave=0
			src.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;
			src.client.eye=AT
			while(src.AstralSoulForm>=1)
				src.chakra-=1
				sleep(11)
	AstralSoulManifest()
		for(var/mob/AstralSoul/Projection/s in src.JutsuList)
			if(s.invisibility>=99)
				s.invisibility=1
				for(var/mob/a in view(9))
					a<<"A form manifests suddenly!"
				return
			if(s.invisibility<=1)
				s.invisibility=99
				for(var/mob/a in view(9))
					a<<"The Projection Fades!"
				return
	AstralSoulSeek()
		for(var/mob/AstralSoul/Projection/s in src.JutsuList)
			var/PP=s.Owner
			var/varPeople = list()
			for(var/mob/T in world)
				if(T.client)
					if(T.name!=T.oname)
						if(T.oname==""||T.oname==null)
							T.oname=T.name
							varPeople += T.name
						else
							varPeople += T.oname
					else
						varPeople += T.name

			var/M = input(usr,"Who do you want to find?","Soul Seek") in varPeople + list("Cancel","Leaf Village","Sound Village","Rain Village","Rock Village","Tea Village")
			if(M == "Cancel")
				return
			if(M == "Leaf Village")
				s.loc=locate(58,25,11)
				return
			if(M == "Rain Village")
				s.loc=locate(82,44,6)
				return
			if(M == "Rock Village")
				s.loc=locate(151,9,14)
				return
			if(M == "Sound Village")
				s.loc=locate(63,30,4)
				return
			if(M == "Tea Village")
				s.loc=locate(83,36,2)
				return
			else
				for(var/mob/P in world)
					if(P.oname==M)
						s.loc=locate(P.x,P.y,P.z)
						PP<<"[P]'s current location is [P.x],[P.y],[P.z]."
	AstralSoulAttach()
		if(!src.AstralSoulAtta)
			for(var/mob/AstralSoul/Projection/s in src.JutsuList)
				var/varPeople = list()
				for(var/mob/T in view(5,s))
					if(T.client)
						if(T.name!=T.oname)
							if(T.oname==""||T.oname==null)
								T.oname=T.name
								varPeople += T.name
							else
								varPeople += T.oname
						else
							varPeople += T.name
				var/M = input(usr,"Who do you want to attach to?","Soul Attachment") in varPeople + list("Cancel")
				if(M == "Cancel")
					return
				else
					for(var/mob/P in view(5,s))
						if(P.oname==M)
							if(P.AstralSoulPoss=="")
								P.AstralSoulPoss="[src]"
								src.AstralSoulAtta=1
								src.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
								src.client.eye=P
								src.Frozen=1
								del(s)
								return
		else
			for(var/mob/M in world)
				if(M.AstralSoulPoss=="[src]")
					M.AstralSoulPoss=""
			src.client.perspective=MOB_PERSPECTIVE
			src.client.eye=src
			src.AstralSoulForm=0
			src.AstralSoulHeal=0
			src.AstralSoulAtta=0
			src.Frozen=0
			src.see_invisible=1
			src.ChakraSight(0)
			src.UnableToChargeChakra=0
			return
	AstralSoulHeal()
		if(src.AstralSoulAtta==1)
			src.AstralSoulHeal=1
			for(var/mob/y in world)
				if(y.AstralSoulPoss=="[src]")
					while(src.AstralSoulHeal>0&&!src.knockedout)
						if(y.health<y.maxhealth)
							y.health+=10
						if(y.stamina<y.maxstamina)
							y.stamina+=30
						sleep(11)
					src.AstralSoulHeal=0



mob/AstralSoul/
	Projection
		health=99999999999
		density=0
		invisibility=99



mob/Teachers/
	AstralTeacher1
		name = "Astral, Ennigma"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Rain"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/KakashiH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(220,0,220)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi' + rgb(200,0,200)
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/BaggyPants.dmi' + rgb(200,0,200)
				src.overlays+='Icons/New Base/Clothing/cloak3.dmi' + rgb(200,0,200)
				src.overlays+='Icons/New Base/Clothing/Headbands/HeadbandNeck.dmi' + rgb(200,0,200)
				src.overlays-=Hair
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			sleep(3)
			if(usr.Clan=="Astral")
				var/Options = list("Teach me.")
				Options += "Nevermind."
				switch(input(usr,"Hello, what can I do for you?", "Astral, Ennigma") in Options)
					if("Nevermind.")
						return
					if("Teach me.")
						switch(input("What would you like to learn?") in list("Soul Projection","Soul Manifest","Soul Seek","Soul Attach","Soul Heal","Nevermind"))
							if("Soul Projection")
								usr.LearnJutsu("Soul Projection",2,"AstralSoulProject","Allows you to leave your body, projecting an invisible to the naked eye soul of yourself.","Ninjutsu")
								return
							if("Soul Manifest")
								usr.LearnJutsu("Soul Manifest",2,"AstralSoulManifest","Allows you to visually manifest your soul, use this while your soul is out.","Ninjutsu")
								return
							if("Soul Seek")
								usr.LearnJutsu("Soul Seek",2,"AstralSoulSeek","Allows you to locate nearby players, use this while your soul is out.","Ninjutsu")
								return
							if("Soul Attach")
								usr.LearnJutsu("Soul Attach",2,"AstralSoulAttach","Allows you to attach your soul to a nearby player, creating a link, use this while your soul is out.","Ninjutsu")
								return
							if("Soul Heal")
								usr.LearnJutsu("Soul Heal",2,"AstralSoulHeal","Allows you to slowly rejuvinate someone, use this while your soul is attached to someone.","Ninjutsu")
								return
							if("Nevermind")
								return