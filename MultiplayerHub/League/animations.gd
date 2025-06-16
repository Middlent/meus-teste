extends AnimationPlayer


func play_animation(animation, speed = 1):
	var loop = get_animation(animation).loop_mode
	if not loop or current_animation != animation:
		print("starting ", animation)
		play("RESET")
		speed_scale = speed
		play(animation)

func stop_animation():
	play("RESET")
	speed_scale = 1
