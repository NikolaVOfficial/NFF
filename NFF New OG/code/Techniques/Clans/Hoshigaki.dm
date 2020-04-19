/*Hoshigaki not needed 2.0
mob/Hoshigaki/verb/CreateSameHade()
	var/CreatingSword=0
	if(CreatingSword)
		return
	CreatingSword=1
	usr<<"You begin to create the sword."
	sleep(100);CreatingSword=0
	usr.stamina-=2500
	var/obj/WEAPONS/Samehade/A=new();A.loc=usr
*/
mob/proc/SamehadeReturn()
	for(var/obj/WEAPONS/Samehade/A in src.contents)
		if(A.Equipped)
			src<<"It's already equipped!";return
		else
			if(prob(50))
				src<<"You return the Samehade to your hand!"
				A.Equipped=1
				src.WeaponInLeftHand="Samehade"
				src.WeaponInRightHand="Samehade"