//Meth Server Optimizer its in the beta right now//
var/minimums = 35//This var basically controls the minimum amount of Cpu power used before it starts to delete stuff
var/RealCPU//REALCPU definition
proc
	Optimizer()
		set background =1//Allows it to run in the background so that the lag doesnt effect it
		RealCPU=abs(world.cpu - 100)//it updates the REALCPU var
		if(RealCPU <= minimums)//If the CPU power is under the minimums
			for(var/mob/NPC/A in world)//it searchs for NPCs in the world
				if(!A.CNNPC)//NPCs with AI
					del(A)//Deletes them
/*		if(RealCPU=0)//the the CPU EVER DROPS TO 0
			world<<"Server CPU has fallen to 0, server reboot in 5 seconds. SAVE!"//world notification
			spawn(5)//it waits 5 seconds
				world.Reboot()//it forces the world to reboot
*/
		else//or else
			world.Repop()//it repspawns all the NPCs in the world that were deleted
	ProcessorCheck()//Use this if(ProcessorCheck())return on procs that use put CPU power for rendering effects like smoke
		set background =1//Same as above
		RealCPU=abs(world.cpu - 100)//Updates teh real CPU
		if(RealCPU <= minimums)//checks the real CPU agianst minimums
			return TRUE//if it is true then it will stop the process
		else return FALSE//or else it will return it as false and the process will continue to render the effect
//	BanUpdate()//Server update proc insertion
//		Optimizer()//It inserts the optimzer proc into the ban check proc
//		..()//It runs the ban check like normal
world
	New()//When the game is booted up
		Optimizer()//it runs the optimizer proc
		..()//and begins as normal
		/*
mob//Below is just defining the NPC Code you can /* */ when you enable this library in NFF
	var
		CNNPC
	NPC
		Methodst
			CNNPC=1
*/