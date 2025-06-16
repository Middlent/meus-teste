extends Node2D


var attack_data = {}
@onready var cooldown = $Cooldown

func attack(data):
	attack_data = data
	%Animations.play_animation("WindUp", 5, false)


func hit():
	if attack_data.target.has_node("AttackReciever"):
		cooldown.start(1 / get_parent().champion.stats.aSpeed)
		var reciever = get_node(str(attack_data.target.get_path()) + "/AttackReciever")
		reciever.recieve_attack(attack_data)
	else:
		print("Target ",attack_data.target," can't get attacked")
