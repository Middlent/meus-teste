extends CharacterBody2D

"""
projectile_speed: float - Velocidade do projetil
mode: int - Forma que o projetil se move
target: CharacterBody2D - Alvo do projétil (Somente modo TARGET e talvez CUSTOM)
direction: Vector2D - Direção do projétil (Somente modo STRAIGHT)
mask: int - Mascara do projétil (Somente modo STRAIGHT e MOUSE e talvez CUSTOM)
range: float - Distancia do projétil em segundos (Nao utilizado no modo target, priorizado no modo straight)
duration: float - Duração do projétil em segundos (Nao utilizado no modo target, priorizado no modo mouse)
movement_function: Callable - Funcao para movimento do projétil (Somente modo CUSTOM, deve receber delta)
"""
var data = {}
var current_data = {}

enum mode {
	TARGET = 0,
	STRAIGHT = 1,
	MOUSE = 2,
	CUSTOM = 3
}

var velocity_adjust = 1000 # Ajuste pra poder usar unidades menores na velocidade

func load_info(projectile_data):
	#$Sprite.texture = image
	data = projectile_data
	if data.mode == mode.TARGET:
		$TargetDetector.collision_mask = data.target.collision_layer
	else:
		$TargetDetector.collision_mask = data.mask
	#size = data.size
	#$Collision.scale = size
	#distance_remaining = data.range

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if data != {}:
		match(data.mode):
			mode.TARGET:
				follow_target(delta)
			mode.STRAIGHT:
				go_straight(delta)
			mode.MOUSE:
				follow_mouse(delta)
			mode.CUSTOM:
				data.movement_function(delta)

func follow_target(delta):
	velocity = position.direction_to(data.target.position) * data.projectile_speed * velocity_adjust * delta
	move_and_slide()

func go_straight(delta):
	var old_pos = global_position
	velocity = position.direction_to(data.direction) * data.projectile_speed * velocity_adjust * delta
	move_and_slide()
	if data.has("range"):
		var progress = old_pos.distance_to(global_position)
		if !current_data.has("traveled"):
			current_data.traveled = data.range
		current_data.traveled -= progress
		if current_data.traveled <= 0:
			queue_free()
	elif data.has("duration"):
		if !current_data.has("elapsed"):
			current_data.elapsed = data.duration
		current_data.elapsed -= delta
		if current_data.elapsed <= 0:
			queue_free()
	else:
		queue_free()

func follow_mouse(delta):
	var old_pos = global_position
	velocity = position.direction_to(get_global_mouse_position()) * data.projectile_speed * velocity_adjust * delta
	move_and_slide()
	if data.has("duration"):
		if !current_data.has("elapsed"):
			current_data.elapsed = data.duration
		current_data.elapsed -= delta
		if current_data.elapsed <= 0:
			queue_free()
	elif data.has("range"):
		var progress = old_pos.distance_to(global_position)
		if !current_data.has("traveled"):
			current_data.traveled = data.range
		current_data.traveled -= progress
		if current_data.traveled <= 0:
			queue_free()
	else:
		queue_free()

func _on_target_detector_body_entered(body):
	if body == data.target:
		var reciever = get_node(str(data.target.get_path()) + "/Receiver")
		reciever.receive(data)
		queue_free()
