class_name Skill extends Node2D

@export var mana_cost = 0
@onready var champion = get_parent().get_parent().champion

func try_cast():
	if champion.stats.mana > mana_cost:
		champion.stats.mana -= mana_cost
		cast()
	else:
		out_of_mana()

func cast():
	print("Unimplemented skill")

func out_of_mana():
	print("Out of mana")
