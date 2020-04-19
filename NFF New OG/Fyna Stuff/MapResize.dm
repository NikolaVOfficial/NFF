mob/proc
	dd_text2List()

mob/proc
	resize_map()
		set hidden = 1
		var s = winget(src, "mapwindow", "size")
		var list/dimensions = dd_text2List(s, "x")
		var nx = text2num(dimensions[1]), ny = text2num(dimensions[2])
		client.view = "[round(nx / 32)]x[round(ny / 32)]"//round(

mob/verb/MapResize() /// this changes the user view to fit screen but it increases lag
	set hidden = 1
	winset (src,"mapwindow","icon-size=32")
	resize_map()



mob/verb/DefaultSize()
	client.view = "32x23"
	winset (src ,"mapwindow" , "icon-size=0")


