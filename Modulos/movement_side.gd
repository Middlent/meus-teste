extends Node2D

@export var speed: float

@rpc("any_peer","call_local")
func move(direction):
	get_parent().velocity.x = speed * direction
	get_parent().move_and_slide()
