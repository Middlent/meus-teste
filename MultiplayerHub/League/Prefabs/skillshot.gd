extends CharacterBody2D

var attack_data = {}
var current_data = {}
var distance_remaining = 0
var loaded = false

var size

signal hit(data)
signal missed(data)
signal finished(data)


func load_info(image, data, target_mask = 0):
	$Sprite.texture = image
	attack_data = data
	collision_mask = target_mask
	size = data.size
	$Collision.scale = size
	distance_remaining = data.range
	loaded = true

func _physics_process(delta):
	$Collision.scale = size
	if loaded:
		if distance_remaining > 0:
			var old_pos = global_position
			var collision = move_and_collide(attack_data.direction * attack_data.speed * delta)
			if collision:
				current_data.position = position
				hit.emit(current_data)
				finished.emit(current_data)
				queue_free()
			else:
				distance_remaining = distance_remaining - position.distance_to(old_pos)
		else:
			current_data.position = global_position
			missed.emit(current_data)
			finished.emit(current_data)
			queue_free()
