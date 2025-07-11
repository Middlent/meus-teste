extends Node2D

signal move(direction)

@export var deadzone : float

var targetLocation : Vector2
var targetEnemy : Node2D
var movement := Vector2.ZERO

@onready var champion = get_parent().champion
@onready var stats = champion.stats

func _ready():
	targetLocation = get_parent().position

func _input(event):
	if get_parent().locked:
		return
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			var mouse_pos = get_global_mouse_position()
			
			if %Attack.cooldown.is_stopped():
				var parameters = null
				var collisions = []
				if !event.shift_pressed:
					parameters = PhysicsPointQueryParameters2D.new()
					parameters.position = mouse_pos
					collisions = get_world_2d().direct_space_state.intersect_point(parameters)
				else:
					parameters = PhysicsShapeQueryParameters2D.new()
					parameters.transform = Transform2D(0,Vector2(14,14),0,mouse_pos)
					parameters.shape = CircleShape2D.new()
					collisions = get_world_2d().direct_space_state.intersect_shape(parameters)
					collisions.sort_custom(func(a,b): return mouse_pos.distance_to(a.collider.position) < mouse_pos.distance_to(b.collider.position))
					
				for collision in collisions:
					if collision.collider.is_in_group("Enemy"):
						go_to(collision.collider.position)
						targetEnemy = collision.collider
						return
			
			go_to(mouse_pos)

func _process(_delta):
	if get_parent().locked:
		if get_parent().velocity != Vector2.ZERO:
			stop()
		return

	if targetEnemy != null:
		%Animations.play_animation("AttackWalking", 5)
	elif get_parent().velocity.length() > 0:
		%Animations.play_animation("Walking", 5)
	else:
		%Animations.stop_animation("Walking")
		%Animations.stop_animation("AttackWalking")
	
	if targetEnemy == null:
		if targetLocation.distance_to(get_parent().position) < deadzone:
			stop()
			return
	elif targetEnemy.position.distance_to(get_parent().position) < stats.range:
		var attack_data = champion.attack_data
		attack_data.target = targetEnemy
		%Attack.attack(attack_data)
		stop()
		return
	move.emit(get_parent().position.direction_to(targetLocation))

func go_to(location: Vector2):
	targetEnemy = null
	targetLocation = location

func stop():
	go_to(get_parent().position)
	get_parent().velocity = Vector2.ZERO
	
