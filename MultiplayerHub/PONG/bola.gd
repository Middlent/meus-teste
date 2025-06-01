extends CharacterBody2D

@export var base_speed = 10
@export var increment = 0.2
var SPEED = base_speed
var angle = 30
var start

func _ready():
	start = position
	reset()

func _physics_process(delta):
	var collision = move_and_collide(Vector2.from_angle(deg_to_rad(angle)) * SPEED)
	if collision:
		angle = rad_to_deg((Vector2.from_angle(deg_to_rad(angle)) + 2 * collision.get_normal()).angle())
		if collision.get_collider().is_in_group("Player"):
			speed_up(5)
		elif collision.get_collider().is_in_group("Goal"):
			reset()
			collision.get_collider().goal.emit()
		else:
			speed_up()

func speed_up(amount = 1):
	SPEED += increment * amount

func slow_down(amount = 1):
	SPEED -+ increment * amount

func reset():
	position = start
	SPEED = base_speed
	angle = [randi_range(60,70),randi_range(-60,-70),randi_range(110,120),randi_range(-110,-120)].pick_random()
