/*variables NatureChakra- how much nature energy the user can store, dictates how long sage mode can be active
			SageMastery determines how fast the user can charge sage chakra*/

mob/proc/SageModeCharge()
	if(src.knockedout)
		return
	src.icon_state="rest"
	src<<"You begin to build natural chakra for Sage Mode! Don't move at all!"

	var/A=2
	usr.SageMastery+=1
	if (src.SageMastery >= 100)
		src.SageMastery= 500
	src.Frozen=1;src.firing=1
	while(A>1)
		if(src.icon_state!="rest")
			src<<"You stop building nature chakra";A=0;src.Frozen=0;src.firing=0;return
		if(src.icon_state=="rest")
			src.SageMastery+=rand(0.1, 2)
			if (src.SageMastery >= 100)
				src.SageMastery= 500
			src.NatureChakra+=((src.SageMastery/100) + (src.NinjutsuKnowledge/250))
			src.Frozen=1;src.firing=1
			if(src.NatureChakra>=600)
				src.NatureChakra = 600
				src << "Your sage mode chakra has reached maximum capacity"
				A=0
		sleep(50)
	src.icon_state=""
	src.Frozen=0
	src.firing=0

mob/proc/BunshinSageCharge()
	src.ChakraDrain(25000)
	src.Handseals(1)
	if(src.HandsSlipped) return
	/*if(src.SageMode=="")
		src<< "Sage Mode must be on in order to use this"
		return*/
	var/mob/Clones/Clone/A=new();
	var/obj/SmokeCloud/S=new()
	A.RunningSpeed=src.RunningSpeed;
	A.Acceleration=src.Acceleration;
	A.Running=1
	A.icon=src.icon;
	A.overlays+=src.overlays
	A.loc=locate(src.x+1,src.y,src.z);
	S.loc=locate(A.x,A.y,A.z)
	A.name="[name]";
	A.Owner=src;
	A.dir=src.dir
	A.Clone=1;
	A.Running=1;
	A.icon_state="rest"
	A.health=200
	A.RunningSpeed=5;;
	A.density=1
	A.NatureChakra=0
	A.SageMastery = src.SageMastery
	A.NinjutsuKnowledge = src.NinjutsuKnowledge
	A.CloneType="SageCharge"
	A.Frozen = 1
	while(A&&A.icon_state=="rest")
		A.NatureChakra += ((A.SageMastery)/250 + (A.NinjutsuKnowledge/500))
		if (A.NatureChakra >=600)
			A.NatureChakra = 600

		sleep(10)
	src << "Your Clone has been destroyed and you gained [A.NatureChakra] Sage Chakra!"
	del (A)
