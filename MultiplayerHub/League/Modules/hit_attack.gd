extends Node2D


func attack(attack_data):
	if attack_data.target.has_node("AttackReciever"):
		var reciever = get_node(str(attack_data.target.get_path()) + "/AttackReciever")
		reciever.recieve_attack(attack_data)
	else:
		print("Target ",attack_data.target," can't get attacked")
