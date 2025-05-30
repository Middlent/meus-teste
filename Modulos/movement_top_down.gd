extends Node2D

@export var speed: float

func on_movement_received(direction):
	move.rpc(direction)

@rpc("any_peer","call_local")
func move(direction):
	get_parent().velocity = speed * direction * 500
	get_parent().move_and_slide()
