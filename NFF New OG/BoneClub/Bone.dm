turf
     Mud
          icon='BoneClub/floor.dmi'

     wall
          icon='BoneClub/WallMiddle.dmi'
     WallDownLeft
          icon='BoneClub/WallDownLeft.dmi'
     WallDownRight
          icon='BoneClub/WallDownRight.dmi'
     WallFullDownLeft
          icon='BoneClub/WallFullDownLeft.dmi'
     WallFullDownRight
          icon='BoneClub/WallFullDownRight.dmi'
     WallCornerLeft
          icon='BoneClub/WallCornerLeft.dmi'
     WallCornerRight
          icon='BoneClub/WallCornerRight.dmi'
     WallCornerLeftBlank
          icon='BoneClub/WallCornerLeftBlank.dmi'
     WallCornerRightBlank
          icon='BoneClub/WallCornerRightBlank.dmi'
     WallFullDownLeftBlank
          icon='BoneClub/WallFullDownLeftBlank.dmi'
     WallFullDownRightBlank
          icon='BoneClub/WallFullDownRightBlank.dmi'
     ArenaFloor
          icon='BoneClub/Arenafloor.dmi'
     Fence
          icon='BoneClub/fence.dmi'
     BlueChair
          icon='BoneClub/BlueChair.dmi'
     WallFullDownLeftContinued
          icon='BoneClub/WallFullDownLeftContinued.dmi'
     WallFullDownRightArena
          icon='BoneClub/WallFullDownRightArena.dmi'
     Fencewall
          icon='BoneClub/FenceWall.dmi'
     Grave
          icon='BoneClub/Grave.dmi'
     SemiOldgrave
          icon='BoneClub/SemiOldGrave.dmi'
     OldGrave
          icon='BoneClub/OldGrave.dmi'
     Store
          icon='BoneClub/store.dmi'
     StoreWallLeft
          icon='BoneClub/StoreWallLeft.dmi'
     StoreWallRight
          icon='BoneClub/StoreWallRight.dmi'
     RockFloor
          icon='BoneClub/RockFloor.dmi'
     Stair
          icon='BoneClub/Stair.dmi'
     WallStair
          icon='BoneClub/WallStair.dmi'
     WallFloor
          icon='BoneClub/WallFloor.dmi'



turf
	BoneEntranceturf
		density=0
		Enter(A)
			if(ismob(A))
				var/mob/M = A
				if(!M.BoneClubMember&&!M.BoneClubLeader)
					M.loc=locate(5,1,44)
				else
					return
			else
				if(isobj(A))
					del(A)
	BoneExitTurf
		density=0
		Enter(A)
			if(ismob(A))
				var/mob/M = A
				M.loc=locate(120,14,33)
			else
				if(isobj(A))
					del(A)

	BoneEntrance
		density=1
		icon='BoneClub/BoneEntrance.dmi'































turf/BoneClubOrg/
     Mud
          icon='BoneClub/floor.dmi'
     wall
          icon='BoneClub/WallMiddle.dmi'
     WallDownLeft
          icon='BoneClub/WallDownLeft.dmi'
     WallDownRight
          icon='BoneClub/WallDownRight.dmi'
     WallFullDownLeft
          icon='BoneClub/WallFullDownLeft.dmi'
     WallFullDownRight
          icon='BoneClub/WallFullDownRight.dmi'
     WallCornerLeft
          icon='BoneClub/WallCornerLeft.dmi'
     WallCornerRight
          icon='BoneClub/WallCornerRight.dmi'
     WallCornerLeftBlank
          icon='BoneClub/WallCornerLeftBlank.dmi'
     WallCornerRightBlank
          icon='BoneClub/WallCornerRightBlank.dmi'
     WallFullDownLeftBlank
          icon='BoneClub/WallFullDownLeftBlank.dmi'
     WallFullDownRightBlank
          icon='BoneClub/WallFullDownRightBlank.dmi'
     ArenaFloor
          icon='BoneClub/Arenafloor.dmi'
     Fence
          icon='BoneClub/fence.dmi'
     BlueChair
          icon='BoneClub/BlueChair.dmi'
     WallFullDownLeftContinued
          icon='BoneClub/WallFullDownLeftContinued.dmi'
     WallFullDownRightArena
          icon='BoneClub/WallFullDownRightArena.dmi'
     Fencewall
          icon='BoneClub/FenceWall.dmi'
     Grave
          icon='BoneClub/Grave.dmi'
     SemiOldgrave
          icon='BoneClub/SemiOldGrave.dmi'
     OldGrave
          icon='BoneClub/OldGrave.dmi'
     Store
          icon='BoneClub/store.dmi'
     StoreWallLeft
          icon='BoneClub/StoreWallLeft.dmi'
     StoreWallRight
          icon='BoneClub/StoreWallRight.dmi'
     RockFloor
          icon='BoneClub/RockFloor.dmi'
     Stair
          icon='BoneClub/Stair.dmi'
     WallStair
          icon='BoneClub/WallStair.dmi'
     WallFloor
          icon='BoneClub/WallFloor.dmi'
