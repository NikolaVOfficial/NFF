mob/GainedAfterLogIn/verb/A2Test()
	set hidden=1
	if(usr.Jailed||usr.HoldingA||usr.knockedout||usr.Frozen||usr.firing/*||usr.FrozenBind!=""||usr.FrozenBind!="Spider Web"||usr.FrozenBind!="Syrup"*/)
		return
//	usr<<"A2Test verb pressed. Is User holding A: [usr.HoldingA]"
	usr.HoldingA=1
	spawn()
//		usr<<"Activating A2DownTesting proc"

		usr.A2DownTesting()

mob/GainedAfterLogIn/verb/ATest()
	set hidden=1
	if(usr.Jailed||usr.HoldingL||usr.knockedout||usr.Frozen||usr.firing/*||usr.FrozenBind!=""||usr.FrozenBind!="Spider Web"||usr.FrozenBind!="Syrup"*/)
		return
//	usr<<"ATest verb pressed. Is User holding L: [usr.HoldingL]"
	usr.HoldingL=1
	spawn()
//		usr<<"Activating ADownTesting proc"
		usr.ADownTesting()
mob/proc/
	A2DownTesting()//This is the new one that we are now using Argon.
		set hidden=1
		if(src.KBunshinOn)
			usr=src.controlled
		else
			usr=src
//		src<<"A2DownTesting Proc reached: LHP = [src.LHP]. ChargingLHP = [src.ChargingLHP]."
		if(usr.knockedout||src.LHP>0||usr.LHP>0||usr.ChargingLHP)
			if(usr.ChargingLHP)
				usr<<"You're already charging!"
				usr.ChargingAttack=""
				usr.LHP=0
				usr.ChargingLHP=0
				usr.AttackVerb2(0)
				return
		usr.ChargingAttack="Left"
		usr.ChargingLHP=1
		if(usr.target)
			var/mob/M=usr.target
			if(M.shari&&M.SharinganMastery>500||M.bya&&M.ByakuganMastery>5000)
				M<<"You notice the muscles in [usr]'s left arm tensing up!"

		if(usr.GateIn=="Initial")
			usr.LHP+=5;
		if(src.Trait!="Powerful"&&src.RaiArmor!=2)
			if(src.GateIn!="View")
				while(src.LHP<25&&src.ChargingAttack=="Left"&&usr.HoldingA)//&&usr.ChargingLHP)
				//	src<<"First while loop reached."
					if(src.runningspeed>0)
						if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
							src<<"Your charge is at [LHP]. User is Holding down A: [src.HoldingA]"
						src.LHP+=pick(0,0.5)
						if(src.TaijutsuStyle=="Quick Fist")
							src.LHP++

						if(src.SageMode=="Toad")
							src.LHP++
							if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
								src<<"Your charge is at [LHP]. User is Holding down A: [src.HoldingA]"
						sleep(1)
					else
						src.LHP++
						if(src.TaijutsuStyle=="Quick Fist")
							src.LHP++
							if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
								src<<"Your charge is at [LHP]. User is Holding down A: [src.HoldingA]"
						sleep(1)
			else
				while(usr.ChargingAttack=="Left")
					usr.LHP+=pick(2,3)
					if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
						src<<"Your charge is at [LHP]. User is Holding down A: [src.HoldingA]"
					sleep(1)
		else
			if(usr.GateIn!="View")
				while(usr.LHP<30&&usr.ChargingAttack=="Left")//&&usr.ChargingLHP)
					if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
						src<<"Your charge is at [LHP]. User is Holding down A: [src.HoldingA]"
					if(usr.SageMode=="Toad")
						usr.LHP++
						if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
							src<<"Your charge is at [LHP]. User is Holding down A: [src.HoldingA]"
					if(usr.runningspeed>0)
						usr.LHP++
						if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
							src<<"Your charge is at [LHP]. User is Holding down A: [src.HoldingA]"
					else
						usr.LHP+=pick(2,3)
						if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
							src<<"Your charge is at [LHP]. User is Holding down A: [src.HoldingA]"
					sleep(1)
			else
				while(usr.ChargingAttack=="Left")
					usr.LHP+=pick(2,3)
					if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
						src<<"Your charge is at [LHP]. User is Holding down A: [src.HoldingA]"
					sleep(1)


mob/proc/
	ADownTesting()
		set hidden=1
		if(src.KBunshinOn)
			usr=src.controlled
		else
			usr=src
	//	if(usr.knockedout||src.RHP>0) return
//		src<<"ADownTesting Proc reached: RHP = [src.RHP]. ChargingRHP = [src.ChargingRHP]."
		if(usr.knockedout||src.RHP>0||usr.RHP>0||usr.ChargingRHP)
			if(usr.ChargingRHP)
		//		usr<<"You're already charging!"
				usr.ChargingAttack=""
				usr.RHP=0
				usr.ChargingRHP=0
				usr.AttackVerb(0)
				return
		usr.ChargingAttack="Right"
		usr.ChargingRHP=1
		if(usr.target)
			var/mob/M=usr.target
			if(M.shari&&M.SharinganMastery>500||M.bya&&M.ByakuganMastery>2000)
				M<<"You notice the muscles in [usr]'s right arm tensing up!"

		if(usr.GateIn=="Initial")
			usr.RHP+=5
		if(usr.Trait!="Powerful"&&usr.RaiArmor!=2)
			if(usr.GateIn!="View")
				while(usr.RHP<25&&usr.ChargingAttack=="Right")
					if(usr.runningspeed>0)
						if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
							src<<"Your charge is at [RHP]. User is Holding down L: [src.HoldingL]"
						usr.RHP+=pick(0,0.5)
						if(usr.TaijutsuStyle=="Quick Fist")
							usr.RHP++
							if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
								src<<"Your charge is at [RHP]. User is Holding down L: [src.HoldingL]"
						if(usr.SageMode=="Toad")
							usr.RHP++
							if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
								src<<"Your charge is at [RHP]. User is Holding down L: [src.HoldingL]"
						sleep(1)

					else
						usr.RHP++
						if(usr.TaijutsuStyle=="Quick Fist")
							usr.RHP++
							if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
								src<<"Your charge is at [RHP]. User is Holding down L: [src.HoldingL]"
						if(usr.SageMode=="Toad")
							usr.RHP++
							if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
								src<<"Your charge is at [RHP]. User is Holding down L: [src.HoldingL]"
						sleep(1)
			else
				while(usr.ChargingAttack=="Right")
					usr.RHP+=pick(2,3)
					if(src.key==""||src.key=="Ishuri")
						src<<"Your charge is at [RHP]. User is Holding down L: [src.HoldingL]"
					sleep(1)
		else
			if(usr.GateIn!="View")
				while(usr.RHP<30&&usr.ChargingAttack=="Right")
					if(usr.runningspeed>0)
						usr.RHP++
						if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
							src<<"Your charge is at [RHP]. User is Holding down L: [src.HoldingL]"
					if(usr.SageMode=="Toad")
						usr.RHP++
						if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
							src<<"Your charge is at [RHP]. User is Holding down L: [src.HoldingL]"
					else
						if(!usr.DoingPalms)
							usr.RHP+=pick(2,3)
							if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
								src<<"Your charge is at [RHP]. User is Holding down L: [src.HoldingL]"
						else
							usr.RHP++
							if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
								src<<"Your charge is at [RHP]. User is Holding down L: [src.HoldingL]"
					sleep(1)
			else
				while(usr.ChargingAttack=="Right")
					if(!usr.DoingPalms)
						usr.RHP+=pick(2,3)
						if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
							src<<"Your charge is at [RHP]. User is Holding down L: [src.HoldingL]"
					else
						usr.RHP++
						if(src.key=="DemonicK"&&src.key==""&&src.key=="Ishuri")
							src<<"Your charge is at [RHP]. User is Holding down L: [src.HoldingL]"
					sleep(1)