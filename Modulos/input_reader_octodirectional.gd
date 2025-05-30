extends Node2D

signal move(direction)

func _process(delta):
	var movement_direction = Vector2(0, 0)
	if Input.is_action_pressed("move_right"):
		movement_direction.x += 1
	if Input.is_action_pressed("move_left"):
		movement_direction.x -= 1
	if Input.is_action_pressed("move_up"):
		movement_direction.y -= 1
	if Input.is_action_pressed("move_down"):
		movement_direction.y += 1
	
	
	move.emit(movement_direction)
