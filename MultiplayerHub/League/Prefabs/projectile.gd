extends CharacterBody2D

"""
projectile_speed: float - Velocidade do projetil
size: Vector2D - Tamanho do projetil
sprite: Texture - Sprite do projetil
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

signal hitted(data)
signal missed(data)
signal finished(data)

enum mode {
	TARGET = 0,
	STRAIGHT = 1,
	MOUSE = 2,
	CUSTOM = 3
}

func load_info(projectile_data):
	data = projectile_data
	if data.mode == mode.TARGET:
		collision_mask = data.target.collision_layer
	else:
		collision_mask = data.mask
	
	current_data.sprite = data.sprite if data.has("sprite") else $Sprite.texture
	current_data.size = data.size if data.has("size") else $Collision.scale
	
	
	update_components()

func update_components():
	$Collision.scale = current_data.size
	$Sprite.texture = current_data.sprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if data != {}:
		update_components()
		match(data.mode):
			mode.TARGET:
				follow_target(delta)
			mode.STRAIGHT:
				go_straight(delta)
			mode.MOUSE:
				follow_mouse(delta)
			mode.CUSTOM:
				data.movement_function(delta)

func move(direction):
	var colision = move_and_collide(direction)
	if colision:
		if data.mode != mode.TARGET or colision.get_collider() == data.target:
			var reciever = get_node(str(colision.get_collider().get_path()) + "/Receiver")
			hit()
			reciever.receive(data)
			queue_free()

func hit():
	current_data.position = position
	hitted.emit(current_data)
	finish()

func miss():
	current_data.position = global_position
	missed.emit(current_data)
	finish()

func finish():
	finished.emit(current_data)
	queue_free()

func follow_target(delta):
	var direction = position.direction_to(data.target.position) * data.projectile_speed * delta
	move(direction)

func go_straight(delta):
	var old_pos = global_position
	var direction = data.direction * data.projectile_speed * delta
	move(direction)
	if data.has("range"):
		var progress = old_pos.distance_to(global_position)
		if !current_data.has("traveled"):
			current_data.traveled = data.range
		current_data.traveled -= progress
		if current_data.traveled <= 0:
			miss()
	elif data.has("duration"):
		if !current_data.has("elapsed"):
			current_data.elapsed = data.duration
		current_data.elapsed -= delta
		if current_data.elapsed <= 0:
			miss()
	else:
		queue_free()

func follow_mouse(delta):
	var old_pos = global_position
	var direction = position.direction_to(get_global_mouse_position()) * data.projectile_speed * delta
	move(direction)
	if data.has("duration"):
		if !current_data.has("elapsed"):
			current_data.elapsed = data.duration
		current_data.elapsed -= delta
		if current_data.elapsed <= 0:
			miss()
	elif data.has("range"):
		var progress = old_pos.distance_to(global_position)
		if !current_data.has("traveled"):
			current_data.traveled = data.range
		current_data.traveled -= progress
		if current_data.traveled <= 0:
			miss()
	else:
		queue_free()
