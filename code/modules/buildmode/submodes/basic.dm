/datum/buildmode_mode/basic
	key = "basic"

/datum/buildmode_mode/basic/show_help(client/c)
	to_chat(c, "<span class='notice'>***********************************************************</span>")
	to_chat(c, "<span class='notice'>Left Mouse Button        = Construct / Upgrade</span>")
	to_chat(c, "<span class='notice'>Right Mouse Button       = Deconstruct / Delete / Downgrade</span>")
	to_chat(c, "<span class='notice'>Left Mouse Button + ctrl = R-Window</span>")
	to_chat(c, "<span class='notice'>Left Mouse Button + alt  = Airlock</span>")
	to_chat(c, "")
	to_chat(c, "<span class='notice'>Use the button in the upper left corner to</span>")
	to_chat(c, "<span class='notice'>change the direction of built objects.</span>")
	to_chat(c, "<span class='notice'>***********************************************************</span>")

/datum/buildmode_mode/basic/handle_click(client/c, params, obj/object)
	var/list/pa = params2list(params)
	var/left_click = pa.Find("left")
	var/right_click = pa.Find("right")
	var/ctrl_click = pa.Find("ctrl")
	var/alt_click = pa.Find("alt")

	if(istype(object,/turf) && left_click && !alt_click && !ctrl_click)
		var/turf/T = object
		if(isfloorturf(object))
			T.PlaceOnTop(/turf/closed/wall/mineral/decowood)
		log_admin("Build Mode: [key_name(c)] built [T] at [AREACOORD(T)]")
		return
	else if(right_click)
		log_admin("Build Mode: [key_name(c)] deleted [object] at [AREACOORD(object)]")
		if(isturf(object))
			var/turf/T = object
			T.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
		else if(isobj(object))
			qdel(object)
		return
