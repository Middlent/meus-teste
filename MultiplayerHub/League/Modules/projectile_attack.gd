extends Node2D


func attack(attack_data):
	if attack_data.target.has_node("AttackReciever"):
		var projectile = load("res://MultiplayerHub/League/Prefabs/Projectile.tscn").instantiate()
		projectile.position = get_parent().position
		projectile.attack_data = attack_data
		get_parent().add_sibling(projectile)
	else:
		print("Target ",attack_data.target," can't get attacked")
