
/*

Started at 117884k memory in task manager

September 20th 2013:
	-Reorganized/Recoded Check proc upon logging in
	-Reorganized Regeneration Proc completely reducing it's size by half
	-Stat proc organized a bit better now (When updating Stats not every player will check every clan to see if it matches, etc)
	-Hud Proc's that update stamina and chakra and vit reorganized to be much more sufficient (Also stops checking the other huds info, since you're not using it, and that just took up server usage)
	-Edited the Login Proc to make it much less consuming regarding checking if you're a part of the staff
	-Edited a few things in Mouse Entered that seemed rather pointless and just cpu conusming checks
	-Recoded a few Doton and Katon Jutsu to be less Cpu Consuming
	-Reorganized a few things in the Death Proc, making Computers check less unneeded things
	-Weather System code made much more efficient by not checking other weathers once yours is detected
	-Target System code made more efficient by not constantly deleting your target, even if you don't have one
	-Jutsus that require clicking or double clicking to use now cause less computer usage due to less checks once found
	-Chuunin Exam verb recoded to be less cpu intensive (reduced amount of for loops from 15 to 5)
	-Death Proc completly reorganized, moving all the npcs and mobs that aren't players to a seperate section so the death proc no longer checks if the players are npc type things in game causing unneccesary server usage
	-Over 350 For Loops Modified:
		-Most segments in the code that check for players and such check more than players
		-They check extra things like Sabaku sand, aburame bugs(which can cause lag..lots..), and other things such as NPCs, that are just causing server stress
		-Loops now will only check players, checking on average 180-200 things, now down to 90-100
	-Several Lists of if checks changed to Else-if checks to cause less server usage
	-Damage Proc made much cleaner And organized to process less junk for players when taking damage

*/






































