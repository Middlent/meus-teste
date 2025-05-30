extends Node2D

signal move(direction)

func _process(delta):
	var movement_direction = 0
	if Input.is_action_pressed("move_right"):
		movement_direction.x += 1
	if Input.is_action_pressed("move_left"):
		movement_direction.x -= 1
	
	
	move.emit(movement_direction)
