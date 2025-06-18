class_name SkillSet extends Node2D

func _ready():
	if !has_node("Q"):
		var node_q = Skill.new()
		node_q.name = "Q"
		add_child(node_q)
	if !has_node("W"):
		var node_w = Skill.new()
		node_w.name = "W"
		add_child(node_w)
	if !has_node("E"):
		var node_e = Skill.new()
		node_e.name = "E"
		add_child(node_e)
	if !has_node("R"):
		var node_r = Skill.new()
		node_r.name = "R"
		add_child(node_r)

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_Q:
				get_node("Q").try_cast()
			KEY_W:
				get_node("W").try_cast()
			KEY_E:
				get_node("E").try_cast()
			KEY_R:
				get_node("R").try_cast()
