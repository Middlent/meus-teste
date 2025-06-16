extends Node2D

var attack_data = {}

func attack(data):
	attack_data = data
	%Animations.play_animation("WindUp", 3, false)

func hit():
	print("ue")
	if attack_data.target.has_node("AttackReciever"):
		var projectile = load("res://MultiplayerHub/League/Prefabs/Projectile.tscn").instantiate()
		projectile.position = get_parent().position
		projectile.attack_data = attack_data
		get_parent().add_sibling(projectile)
	else:
		print("Target ",attack_data.target," can't get attacked")
	
