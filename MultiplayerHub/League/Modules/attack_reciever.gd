extends Node2D


func recieve_attack(attack_data):
	print(get_parent(), " had ", get_parent().champion.stats.hp, " hp")
	print(get_parent(), " took ", attack_data.damage, " damage")
	get_parent().champion.stats.hp = max(0, get_parent().champion.stats.hp - attack_data.damage)
	print("Hp left = ",get_parent().champion.stats.hp)
