extends Node2D


func attack(target: CharacterBody2D, damage):
	if target.has_node("AttackReciever"):
		var reciever = get_node(str(target.get_path()) + "/AttackReciever")
		reciever.recieve_attack(damage)
	else:
		print("Target ",target," can't get attacked")
