extends Node2D

signal move(direction)

func _process(delta):
	var movement_direction = 0
	if Input.is_action_pressed("move_up"):
		movement_direction -= 1
	if Input.is_action_pressed("move_down"):
		movement_direction += 1
	
	move.emit(movement_direction)
