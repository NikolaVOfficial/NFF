//Korona's DA system, All the base coding goes to him,
//Meth: I've modified some of this code to be used as a library thus anything above the line goes to me and him
//Credits for comments and explainations go to Meth
mob
	var
		DALastAttacker
		DATimer
		DAAmounts=0
////////Anything below this, credit goes to Korona
var/list/DAList = list()//DA List
proc
	DASave()
		if(length(DAList))
			var/savefile/F = new("DAList.sav")
			F["DAList"]	<< DAList
	DAListLoad()
		if(fexists("DAList.sav"))
			var/savefile/F = new ("DAList.sav")
			F["DAList"] >> DAList
mob/proc
	DAPunish()
		src<<"You Death Avoided the last time you logged out.You've death avoided [src.DAAmounts] times. Your bounty has been reset, and deaths have been inceased."
		src.DAAmounts++
	//	if(src.JutsuDelay<0)
	//		src.JutsuDelay=0
	//		src.JutsuDelay=5000*src.DAAmounts
	//	else
	//		src.JutsuDelay+=10000*src.DAAmounts
		src.deaths-=src.DAAmounts
		src.bounty = 0
		if(src.Yen>1000)
			var/GainedYen=src.Yen*0.75;src<<"You lost [GainedYen] Ryo for death avoiding!";src.Yen-=GainedYen
		DAList.Remove(src.key)
		src.AutoSave()// remove the // to implement
		DASave()
