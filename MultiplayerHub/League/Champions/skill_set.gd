class_name SkillSet extends Node2D

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_Q:
				Q()
			KEY_W:
				W()
			KEY_E:
				E()
			KEY_R:
				R()

func Q():
	print("Unimplemented Skill ",get_parent())

func W():
	print("Unimplemented Skill ",get_parent())

func E():
	print("Unimplemented Skill ",get_parent())

func R():
	print("Unimplemented Skill ",get_parent())
