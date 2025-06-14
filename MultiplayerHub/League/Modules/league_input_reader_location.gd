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
			var mouse_pos = get_global_mouse_position()
			if !event.shift_pressed:
				var parameters = PhysicsPointQueryParameters2D.new()
				parameters.position = mouse_pos
				var collisions = get_world_2d().direct_space_state.intersect_point(parameters)
				for collision in collisions:
					if collision.collider.is_in_group("Enemy"):
						go_to(get_parent().position)
						print("Attack ",collision.collider)
						return
			else:
				var parameters = PhysicsShapeQueryParameters2D.new()
				parameters.transform = Transform2D(0,Vector2(14,14),0,mouse_pos)
				var shape = CircleShape2D.new()
				parameters.shape = shape
				var collisions = get_world_2d().direct_space_state.intersect_shape(parameters)
				collisions.sort_custom(func(a,b): return mouse_pos.distance_to(a.collider.position) < mouse_pos.distance_to(b.collider.position))
				for collision in collisions:
					if collision.collider.is_in_group("Enemy"):
						go_to(get_parent().position)
						print("Attack ",collision.collider)
						return
				
			go_to(mouse_pos)

func _process(_delta):
	if target.distance_to(get_parent().position) > deadzone:
		move.emit(get_parent().position.direction_to(target))


func go_to(location: Vector2):
	target = location
