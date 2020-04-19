Sound
	New(volume)
		if(volume==100)
			volume/=2
		..()



/************************************************************************

Sound System Library

The primary function of this library is to allow fade in and out effects
for music as well as volume control for music and sound. For music, the
library reserves channels 1 and 2, so that it can fade back and forth
between channels. When you alternate musics, it will fade out one channel
while at the same time fading in the other, so you hear seamless music
playing at all times and avoid the harsh stops and starts.

Sound effects played through this library will be played at the current
volume setting for sound effects. Music volume can be changed at any time
and the music that is currently playing will reflect the changes. Sound
effects however, will not reflect volume changes while playing.


Instructions:

	This library automatically assigns a sound_system datum to each client
	as client.sound_system. You can work with the sound system through
	that variable. This is a list of functions that you can use:

	_________
	PlaySound

		Eg: client.sound_system.PlaySound('sound.wav', location, environment, frequency, altitude_layer)

		This will play the specified sound file for the client at the volume
		specified by the sound volume setting. You can also modify the way
		that the sound file sounds to the hearer through the other arguments:

		soundfile - The sound file to play.

		location - Assign this to a turf, obj or mob if you want the sound
			effect to sound as though its coming from that object.

		environment - If you want to include environment modifications (if
			you don't have a good sound card you probably won't notice the
			difference), you can assign a specific environment to the sound
			effect.

		frequency - Chance the playback rate of the sound file, from -100 to 100.

		altitude_layer - This is the 'layer' variable by default, but if you
			want to change the variable used to determine an object's altitude,
			you can change the name of the variable used with this argument.

	__________
	AlterMusic

				********************************************************
				***  NOTE: You'll probably want to be using this if  ***
				*** you'll be playing background music in your game! ***
				********************************************************

		Eg: client.sound_system.AlterMusic('music.mid', increments)

		Eg: client.sound_system.AlterMusic('music.mid', increments, time)

		This function alternates from one musical score to another seamlessly,
		by fading out the previous song while at the same time fading in the
		new song. Just specify which song you want to play next and it will
		happen automatically. You can specify the number of times that the
		volume will adjust during the transition using the 'increments' value,
		and you can change the speed at which the transition happens by
		changing the 'time' value (in 1/10th seconds). The default transition
		time is 2 seconds.

		If there is no music playing, it will only fade in the new song.

	_________
	PlayMusic

		Eg: client.sound_system.PlayMusic('music.mid')

		Immediately starts playing the specified music file for the client.
		The music volume will reflect the current music volume settings.

	________
	EndMusic

		Eg: client.sound_system.EndMusic()

		Immediately stops whatever music is currently playing.

	___________
	MusicFade

		Eg: client.sound_system.MusicFadeIn(start, end, increments, time)

		With this you can cause the music to fade from one volume to another
		with the number of increments and at the speed you specify. The
		first two arguments are the starting volume and the ending volume,
		the number of increments is how many volume changes there will be
		during the transition, and the time is the speed at which the change
		takes place (in 1/10th seconds)

		If you set the starting value to NULL, it will automatically insert
		the volume that the music is currently at. Note that this is the
		music's volume, not the volume setting. If the music is currently
		in a fade, the music's volume at this point in the fade will be used.

		If you set the ending value to NULL, it will insert the volume setting.

	______________
	SetMusicVolume

		Eg: client.sound_system.SetMusicVolume(new_volume, increments, time)

		Causes the music volume to fade from its current volume to the newly
		specified volume - after which any music played will play at this
		volume. The increments value allows you to adjust how many volume
		changes there will be during the transition, and the time value allows
		you to specify how quickly the volume changes.

		Specifying zero increments or time will cause an instant change.

	______________
	SetSoundVolume

		Eg: client.sound_system.SetSoundVolume(new_volume)

		Sets the volume for any sound effects that will be played after the
		setting changes. Any sound effects currently playing will NOT reflect
		the change in volume.


	______________
	GetMusicVolume

		Eg: client.sound_system.GetMusicVolume()

		Returns the current music volume setting.


	______________
	GetSoundVolume

		Eg: client.sound_system.GetSoundVolume()

		Returns the current sound volume setting.




************************************************************************/






/*
When a client is created, this creates a sound system datum for them.
*/
client
	var
		sound_system/sound_system

	New()
		..()
		sound_system = new(src)





// THE sound SYSTEM DATUM
sound_system

	var
		// The client that this sound system plays sounds for.
		client/owner

		// Volume levels that all music and sound effects are played at.
		music_volume = 50
		sound_volume = 50//75

		// The current channel to play music on. Two channel are required for
		// fading between songs, so we're reserving channels 1 and to for music.
		music_channel = 2 // (1 or 2)

		// The current music file that the player is listening to.
		sound/current_music = null


	// When a sound system is created, it the owner value should be assigned to the
	// client that it was created for, so that it can refer back to that client.
	New(new_owner)
		src.owner = new_owner






/*
PLAY SOUND
Description: Loads the song file and plays it back to the player. There are also
several options that you can use to alter the way the sound is played - you can
assign the sound effect a location: turf, obj, or mob, and the sound effect will
sound as if it is coming from that location. You can assign an environment to
the sound if you want it to sound like its being played in a specific environment,
you can change the frequency (playback rate) of the sound, and you can provide
an altitude variable if you want to influence the altitude of the sound.
Variables:
	- soundfile: The sound file to play.
	- location: Assign this to a turf, obj or mob if you want the sound effect to
			sound as though its coming from that object.
	- environment: If you want to include environment modifications (if you don't
			have a good sound card you probably won't notice the difference), you can
			assign a specific environment to the sound effect.
	- frequency: Chance the playback rate of the sound file, from -100 to 100.
	- altitude_layer: This is the 'layer' variable by default, but if you want to
			change the variable used to determine an object's altitude, you can change
			the name of the variable used with this argument.
*/
sound_system/proc/PlaySound(soundfile, atom/location, environment=-1, frequency=0, altitude_var="layer")
	var/sound/sound = sound(soundfile)
	sound.volume = src.sound_volume
	// If a sound location is specified and the location is NOT the player who
	// will be hearing the sound, then the sound will be played in 3D with location
	// offsets to make it sounds like its coming from the player's environment.
	if(location && location != src.owner)
		// Find the player's view resolution and set the falloff point to the edge
		// of the client's screen.
		var/x = findtext(src.owner.view,"x")
		sound.falloff = x ? copytext(src.owner.view, 1, x) : src.owner.view

		// Change 'layer' to another variable if an altitude variable is used.
		sound.x = location.x - src.owner.mob.x
		var/sy = location.y - src.owner.mob.y
		var/sz = location.vars[altitude_var] - src.owner.mob.vars[altitude_var]
		sound.y = (sy + sz) * 0.707106781187
		sound.z = (sy - sz) * 0.707106781187

	sound.environment = environment
	sound.frequency = frequency
	src.owner << sound
	return



/*
PLAY MUSIC
Description: Loads the song file, applies the current volume and channel settings,
	adds it to the current_sounds list and makes it the current music, then plays it.
Exceptions: If the desired music is already playing, nothing will happen.
Variables:
	- songfile: The song file to play.
*/
sound_system/proc/PlayMusic(songfile)
//	world<<"Play Music called: Current Music about to be played is [songfile]"

	// If music is already playing...
	if(src.current_music)

		// If we're already playing this song, don't change anything.
		if("[songfile]" == "[src.current_music.file]")
			return

	// Load the song file.
	var/sound/song = sound(songfile, repeat=1)

	// Modify the song file settings.
	song.channel = src.music_channel
	song.volume = src.music_volume
	song.priority = 100

	src.current_music = song
	src.owner << song
//	world<<"Play Music called: Current music is [src.current_music.file]"
	return



/*
END MUSIC
Description: Ends whatever song is currently playing.
*/
sound_system/proc/EndMusic(sound/song)
//	world<<"End Music called: Current Music is [src.current_music.file]"
	if(!song)
		song = src.current_music
//		world<<"No song detected. song var is [song]"
	src.owner << sound(null, channel = song.channel)
	del(song)
	return



/*
ALTER MUSIC
Description: Fades out the current song and replaces it with a new one
Exceptions: If no song is playing, it simply starts the new song. If the new song is the same
	as the old song, it doesn't change anything.
Variables:
	- newsong: The song file to play.
	- transition_time: Number of ticks it takes to transition from the old song to the new.
*/
sound_system/proc/AlterMusic(newsong, increments=20, time=increments)
	if(!src.current_music)
		src.PlayMusic(newsong)
		src.MusicFade(0, src.music_volume, increments, time)
		return

	if("[newsong]" == "[src.current_music.file]")
		return

	src.music_channel = (src.music_channel == 1 ? 2 : 1)

	src.MusicFade(src.music_volume, 0, increments, time)
	src.PlayMusic(newsong)
	src.MusicFade(0, src.music_volume, increments, time)
	return



/*
MUSIC FADE
Description: This will cause the music currently playing (ignoring any music that
	may be fading out due to the AlterMusic function) to fade from the specified
	start volume to the specified ending volume in the number of increments and the
	amount of time you specify. Note that the fade function will end prematurely if
	it detects that another fade function is working at the same time.
Variables:
	- start_volume: The volume to start fading from, 0 to 100. If this is set to NULL
		then it will use whatever the current music's volume is (NOT the volume setting).

	- end_volume: The volume to end the fade at, 0 to 100. If this is set to NULL
		then it will use the current volume SETTING as the value.

	- increments: how many points there are between the starting volume and the ending
		volume. If too many points is creating lag, try reducing this number.

	- speed: how long (in 1/10th seconds) it takes to fade from the starting volume
		to the ending volume.
*/
sound_system/proc/MusicFade(start_volume, end_volume, increments=10, time=increments)
	if(!src.current_music)
		return

	// If you set either the start or ending volumes to null, it will
	// use the current music volume (the ACTUAL volume) for that value.
	if(start_volume == null)
		start_volume = src.current_music.volume
	if(end_volume == null)
		end_volume = src.music_volume

	var/sound/music = src.current_music

	// No increments or time specified means instant change.
	if(!increments || !time)
		music.volume = end_volume
		music.status |= SOUND_UPDATE
		src.owner << music
		return

	// If there are more increments than there is time to have at
	// lest one tick per increment, then limit the number of increments
	// to the amount of time available.
	increments = min(increments, time)

	// How much the volume needs to decrease each increment.
	var/current_volume = start_volume
	var/inc_amount = (start_volume - end_volume) / increments
	var/inc_time = time / increments

	// Set the music to the starting volume.
	music.volume = current_volume
	music.status |= SOUND_UPDATE
	src.owner << music

	spawn()
		for(var/inc = increments, inc > 0, inc--)

			// Check to see if the music volume has changed outside of this function.
			if(music.volume != current_volume)
				return // music volume changed itself, to skip this.

			// In case the music object stopped existing...
			if(!music)
				return

			current_volume -= inc_amount
			music.volume = current_volume
			music.status |= SOUND_UPDATE
			src.owner << music

			sleep(inc_time)

		// Set the volume to the desired volume in the end, just in case
		// it didn't quite reach it through the increments.
		music.volume = end_volume
		music.status |= SOUND_UPDATE
		src.owner << music

		// If the music is now mute, and it is no longer the primary music channel,
		// then it was probably faded out and alternated with another song, so to
		// prevent it from playing uselessly in the background, we'll delete it.
		if(!music.volume)
			if(music.channel != src.music_channel)
				src.EndMusic(music)

	return



/*
CHANGE MUSIC VOLUME
Description: Changes the current volume setting for the music which is currently playing,
	and causes it to fade from its previous volume to the specified volume at the rate
	specified by the 'speed' setting.
Variables:
	- new_volume: The new volume setting.
	- increments: how many volume changes there will be during the transition.
	- speed: how quickly (in 1/10th seconds) that it should fade to the new volume.
*/
sound_system/proc/SetMusicVolume(new_volume = 50, increments=10, time=increments)
	// If no time or increments is specified, then the music volume change is instant.
	if(!increments || !time)
		src.music_volume = new_volume

	else
		new_volume = min(max(new_volume, 0), 100)
		src.MusicFade(null, new_volume, increments, time)
		src.music_volume = new_volume
	return



/*
CHANGE SOUND VOLUME
Description: Changes the current volume setting for all sounds played after this point.
Variables:
	- new_volume: The new volume setting.
*/
sound_system/proc/SetSoundVolume(new_volume = 50)
	new_volume = min(max(new_volume, 0), 100)
	src.sound_volume = new_volume
	return



/*
GET MUSIC VOLUME
Description: This function returns the current music volume setting.
*/
sound_system/proc/GetMusicVolume()
	return src.music_volume



/*
GET SOUND VOLUME
Description: This function returns the current sound volume setting.
*/
sound_system/proc/GetSoundVolume()
	return src.sound_volume