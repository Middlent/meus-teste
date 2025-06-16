extends AnimationPlayer


func play_animation(animation, speed = 1, reset = true):
	var loop = get_animation(animation).loop_mode
	if (not loop) or (current_animation != animation):
		print("starting ", animation)
		if reset:
			print("reseted in")
			play("RESET")
		speed_scale = speed
		play(animation)

func stop_animation(animation = ""):
	if animation == "" or animation == current_animation:
		print("reseted out")
		play("RESET")
		speed_scale = 1
