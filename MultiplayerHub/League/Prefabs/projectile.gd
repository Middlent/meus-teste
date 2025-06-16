extends CharacterBody2D

var attack_data = {}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if attack_data != {}:
		velocity = position.direction_to(attack_data.target.position) * attack_data.projectile_speed * 1000 * delta
		move_and_slide()


func _on_target_detector_body_entered(body):
	if body == attack_data.target:
		var reciever = get_node(str(attack_data.target.get_path()) + "/AttackReciever")
		reciever.recieve_attack(attack_data)
		queue_free()
