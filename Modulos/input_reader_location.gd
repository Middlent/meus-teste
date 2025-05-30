extends Node2D

signal move(direction)

@export var deadzone : float

var target : Vector2
var movement := Vector2.ZERO

func _ready():
	target = get_parent().position

func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		go_to(get_global_mouse_position())
		
	if target.distance_to(get_parent().position) > deadzone:
		move.emit(get_parent().position.direction_to(target))


func go_to(location: Vector2):
	target = location
