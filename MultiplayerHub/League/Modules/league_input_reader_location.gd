extends Node2D

signal move(direction)

@export var deadzone : float

var target : Vector2
var movement := Vector2.ZERO

func _ready():
	target = get_parent().position

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			var parameters = PhysicsPointQueryParameters2D.new()
			parameters.position = get_global_mouse_position()
			var collisions = get_world_2d().direct_space_state.intersect_point(parameters)
			for collision in collisions:
				if collision.collider.is_in_group("Enemy"):
					go_to(get_parent().position)
					return
			go_to(get_global_mouse_position())

func _process(_delta):
	if target.distance_to(get_parent().position) > deadzone:
		move.emit(get_parent().position.direction_to(target))


func go_to(location: Vector2):
	target = location
