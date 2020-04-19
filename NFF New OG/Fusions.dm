/*Lightning + Lightning = Magnetism - The combination of lightning and lightning allows for the control of magnetic polarity of ions in the air, allowing the user to fight using attracting and repelling magnetic forces.

Lightning + Earth = Gravity - This element combines the powers of Lightning and Earth chakras to control the force of gravity and it’s effects on objects persons and the environment. Controlling the very weight of everything is a potent weapon and can leave a victim flattened, disorientated, and in worst case utterly helpless.

Lightning + Water = Storm - The abilities granted by mixing an electric field and water is of course weather control, this chakra ability can shape and control storm clouds, it can also alter pressures, temperatures, and compositions of the air.

Lightning + Fire = Radiation - By combining Lightning then Fire chakras this element controls the heat and reactivity of substances at the molecular level, by controlling the heat and particle transfer at the subatomic level users of this element use subtle but powerful attacks that in their early stages fatigued and or sterilize victims, in their highest and most unstable stages create reactions of cataclysmic proportions. It is rumored that Chakra Absorbers are of this elements affinity.

Lightning + Wind = Shock - This element controls the positive or negative charge in opposing bodies of energy and create static charges. This of course can be used to channel electricity more effectively, but also allows for more subtle and more interesting variations. At any rate all applying the ability to control the charge and flow of energy is key in this elemen
Doton


Earth Combinations


Earth + Earth = Metal - Adding earth chakra with more earth chakra will allow the user to create and manipulate different forms of metal.

Earth + Water = Wood [Ex: Yamato's Jutsus] - This correctly molds earth then water chakras to grow or otherwise generate plantlife… The first user of this fusion was the first Hokage and his manipulation of wood… but even with the extinction of that specific ability, there are plenty of other variations still left in the world.

Earth + Fire = Magma - This chakra affinity allows the user to summon from the ground molten earth and control over the substances movements… this deadly fusion of Fire then Earth can create a landscape of ash and fire.

Earth + Lightning = Explosion [Ex: Deidara's Jutsus] - Fusing Earth chakra then Lightning chakra forms the ability to create and form explosions out of clay, phosphor, nitroglycerin and other volatile substances. This ability is idealized in the shows staple demolitions expert Deidara who can mold explosive clay into living objects and produce concussive and bombarding forces with them.

Earth + Wind = Sand - Combining Earth and Wind creates the ability to create sand out of thin air. Like Gaara, person of this affinity can extract minerals from the ground itself and combine them with the air to create sand.
Fuuton

Wind + Wind = Sound - The combination of wind then wind allows for the free control of air particles, creating, destroying or otherwise manipulating sound, regular flames will not work against sound as it is too powerful a force to stop with just a fire.

Wind + Lightning = Light - This balancing of wind then lighting energies, allows for users to alter the hues of the colors around them, create beams of light, and also electrocute enemies… the principle is by controlling wind and mastering the separation of different chemical elements of the air such as Neon for example, and then exciting that substance with electricity, one can manipulate, and create light energy.

Wind + Earth = Phasing - This technique allows by controlling the molecules of substances for the free passing of persons or objects through other matter… by using both wind then earth chakra together one can control all of the particles of matter that make up their surroundings, and allows for interesting variations that include the Kaguya Clans ability to make the bones of their body grow and change their attributes, and another variation in the sound brothers Ukon and Sakon who can rematerialize themselves in one or two bodies at will.

Wind + Fire = Flight - This element is the mastery of the creation and control of hot air a.k.a. Thermals by controlling winds and air temperature with chakra users of this element can use this ability to make flat buoyant objects fly, it allows for fatiguing and dehydrating wind attacks, and also this ability allows for the bending of light into genjutsu mirages. weak against fire then water attacks, strong against lightning then wind attacks.
Katon


Fire Combinations


Fire + Fire = Combustion - The combustion element masters the ability to burn given materials, wind users can’t face this element and hope to have a chance, in fact even normal water will not put out the flames created by this chakra, only a level two combination of water with another element can hope to dowse these flames.

Fire + Wind = Poison - This Element is the potent combination of Fire then Wind that allows for the complete control of toxic gases and poisonous substances… the user creates them by burning the materials needed for recipes of death and uses wind to direct and funnel their smoke wherever they want… in it’s earlier stages it allows for thick clouds of gas, in it’s crueler higher skilled attacks can be invisible or otherwise detected too late after the victim is caught in the users clutches.

Fire + Lightning = Plasma - The “Element of the Sun” as it is referred to… it is a potent mix of Fire then Lightning chakra that allows one to create a substance that has the brightness and burning power of the Sun… burns from this substance are extremely painful and are not wholly heal able for people who are lucky, or unlucky enough to survive an assault by users of this formidable element… It is rumored that this element is the end result of the Uchiha Bloodline’s abilities in chakra formation but that rumor is to date unconfirmed.

Fire + Earth = Magma - This chakra affinity allows the user to summon from the ground molten earth and control over the substances movements. This deadly fusion of Fire then Earth can create a landscape of ash and fire, but will fee water based charkra attacks if they get careless.

Fire + Water = Steam - This mixture of the forces of Fire then Water in chakra give the user ability to create clouds of vapor that are actually boiling hot. They can control geothermal upwelling and also manipulate the steam into forms allowing for potent and painful illusions.
Suiton

Water + Water = Liquids - Fusing two chakras with water energy together forms a chakra that can control any liquid, fire users beware this power allows for the control of not only the water that can extinguish flames but also the fluids that fuel fire as well allowing for control of virtually any liquid known to exist.

Water + Fire = Mist - This element comes from the ability to use water then fire chakra the heat water so that it evaporates into the air beyond the dew point of the air around the user to create mist that blinds and confuses the enemy. This technique is idealized in the show by the rogue ninja Zabuza, who uses mist to try and combat Kakashi’s Sharingan Eye. Other people have made interesting variations of this unique ability. Notably Kumiko of Raikou can create a mist that absorbs chakra from her foes, but regardless of the traits of mist, most fog and mist based attacks are based off of this element.

Water + Wind = Ice - Water then Wind Chakra together produce the secret element of Ice frozen water that can be molded shaped and used in combat. Haku, Zabuza’s right hand companion used his bloodline ability to form his patented “Crystal Ice Mirrors”. This element has some other variations in application but all has to do with the ability to cool and calm the temperature.

Water + Lightning = Acid - Water then Lightning chakra utilizes the chemical properties of inert and dissolved chemicals in water to create Acidic and Basic chemicals… using them can be a potent and deadly art.

Water + Earth = Diamond - Water then Earth chakra mastery allows one to form and use crystalline minerals such as diamonds and use them in battle. Basic forms can use sharp projectile minerals and protective armors. Advanced users can use other tricks like creating lazers out of sunlight, weapons with razor sharp crystal blades, and lastly the ability to petrify, fossilize or otherwise solidify liquid based objects and substances.
IF YOU ARE A CLAN THAT IS ALREADY BORN WITH AN ELEMENTAL FUSION YOU WILL BE UNABLE TO FUSE YOUR ELEMENTS OR PUSH THEM TO THE FURTHER CAPABILITIES.*/

var/Fusions = list("Lava","Wood","Ice","Dust","Ghost")
mob/var/Fusion =""
mob/Teachers/
	Fusion_Teacher
		name = "Saruna"
		icon = 'Icons/New Base/Base.dmi'
		CNNPC = 1
		Village=""
		health = 9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/ExclusiveH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(225,245,122)
				Hair+=rgb(200,100,60)
				Shirt+=rgb(100,12,99)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			if(usr.Fusion!="") usr<< "You already have a fusion.";return
			usr<<"Hmm..."
			sleep(3)
			switch(input(usr, "What Fusion would you like to learn, you may only have one") in list (Fusions, "Cancel"))
				if("Lava")
					if(usr.FireE&&usr.EarthE)
						if(usr.KatonKnowledge>=1000&&usr.DotonKnowledge>=1000)
							usr.Fusion+="Lava"
							usr << "You now posses Lava"
						return
					else usr <<"You don't have the proper element combination..."; return

				if("Cancel")
					usr<<"Come back soon.";return