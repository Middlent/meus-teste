extends Node2D


func recieve_attack(damage):
	print(get_parent(), " had ", get_parent().champion.stats.hp, " hp")
	print(get_parent(), " took ", damage, " damage")
	get_parent().champion.stats.hp = max(0, get_parent().champion.stats.hp - damage)
	print("Hp left = ",get_parent().champion.stats.hp)
