extends Node2D


func receive(data):
	print(get_parent(), " had ", get_parent().champion.stats.hp, " hp")
	print(get_parent(), " took ", data.damage, " damage")
	get_parent().champion.stats.hp = max(0, get_parent().champion.stats.hp - data.damage)
	print("Hp left = ",get_parent().champion.stats.hp)
