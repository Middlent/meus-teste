class_name Skill extends Node2D

@export var mana_cost = 0
@export var unlockable = false
@onready var champion = get_parent().get_parent().champion

func try_cast():
	if unlockable or !get_parent().get_parent().locked:
		if champion.stats.mana > mana_cost:
			champion.stats.mana -= mana_cost
			cast()
		else:
			out_of_mana()
	else:
		print("ta lockado")

func cast():
	print("Unimplemented skill")

func out_of_mana():
	print("Out of mana")
