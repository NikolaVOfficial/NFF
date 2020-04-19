#define MOVE_SLIDE 1
#define MOVE_JUMP 2
#define MOVE_TELEPORT 4

#define TILE_WIDTH  32
#define TILE_HEIGHT 32
#define TICK_LAG    1 //set to (10 / world.fps) a define is faster, though

atom/movable
    appearance_flags = LONG_GLIDE //make diagonal and horizontal moves take the same amount of time
    var
        move_delay = 0 //how long between self movements this movable should be forced to wait.
        tmp
            next_move = 0 //the world.time value of the next allowed self movement
            last_move = 0 //the world.time value of the last self movement
            move_dir = 0 //the direction of the current/last movement
            move_flags = 0 //the type of the current/last movement
    Move(atom/NewLoc,Dir=0)
        var/time = world.time
        if(next_move>time)
            return 0
        if(!NewLoc) //if the new location is null, treat this as a failed slide and an edge bump.
            move_dir = Dir
            move_flags = MOVE_SLIDE
        else if(isturf(loc)&&isturf(NewLoc)) //if this is a movement between two turfs
            var/dx = NewLoc.x - x //get the distance delta
            var/dy = NewLoc.y - y
            if(z==NewLoc.z&&abs(dx)<=1&&abs(dy)<=1) //if only moving one tile on the same layer, mark the current move as a slide and figure out the move_dir
                move_dir = 0
                move_flags = MOVE_SLIDE
                if(dx>0) move_dir |= EAST
                else if(dx<0) move_dir |= WEST
                if(dy>0) move_dir |= NORTH
                else if(dy<0) move_dir |= SOUTH
            else //jumping between z levels or more than one tile is a jump with no move_dir
                move_dir = 0
                move_flags = MOVE_JUMP
        else //moving into or out of a null location or another atom other than a turf is a teleport with no move_dir
            move_dir = 0
            move_flags = MOVE_TELEPORT
        glide_size = TILE_WIDTH / max(move_delay,TICK_LAG) * TICK_LAG //set the glide size
        if(ismob(src))
            var/mob/m = src
            glide_size = TILE_WIDTH / max(m.getMoveDelay(),TICK_LAG) * TICK_LAG
        . = ..() //perform the movement
        last_move = time //set the last movement time
        if(.)
            next_move = time+move_delay