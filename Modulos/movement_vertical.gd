extends Node2D

@export var speed: float

@rpc("any_peer","call_local")
func move(direction):
	get_parent().velocity.y = speed * direction
	get_parent().move_and_slide()


func _on_input_reader_move(direction):
	move.rpc(direction)
