class_name Skill extends Node2D

@export var mana_cost = 0
@export var unlockable = false
@onready var champion = get_parent().get_parent().champion

@export var cooldown = 1
var cooldown_waiter: Timer

func _ready():
	cooldown_waiter = Timer.new()
	cooldown_waiter.one_shot = true
	add_child(cooldown_waiter)

func try_cast():
	if unlockable or !get_parent().get_parent().locked:
		if cooldown_waiter.is_stopped():
			if champion.stats.mana > mana_cost:
				cooldown_waiter.wait_time = cooldown
				cooldown_waiter.start()
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
