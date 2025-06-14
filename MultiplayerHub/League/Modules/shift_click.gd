extends Area2D


func scan(local):
	global_position = local

	var bodies = get_overlapping_bodies()
	print(bodies)
	bodies.sort_custom(order)
	for body in bodies:
		if body.is_in_group("Enemy"):
			return body
	
func order(a, b):
	return position.distance_to(a.position) < position.distance_to(b.position)
