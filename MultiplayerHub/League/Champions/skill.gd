class_name Skill extends Node2D


@export var mana_cost = 0
@export var unlockable = false
@onready var champion = get_parent().get_parent().champion

@export var cooldown = 1
var cooldown_remaining = 0

func _process(delta):
	if cooldown_remaining != 0:
		cooldown_remaining = max(0, cooldown_remaining - delta)

func try_cast():
	if unlockable or !get_parent().get_parent().locked:
		if cooldown_remaining == 0:
			if champion.stats.mana > mana_cost:
				cooldown_remaining = cooldown
				champion.stats.mana -= mana_cost
				cast()
			else:
				out_of_mana()
		else:
			out_of_cooldown()
	else:
		print("ta lockado")

func cast():
	print("Unimplemented skill")

func out_of_mana():
	print("Out of mana")

func out_of_cooldown():
	print("Out of cooldown")
