class_name Champion extends Resource

@export var stats: Stats

var attack_data :
	get:
		return {
			"projectile_speed": stats.projSpeed,
			"damage": stats.ad
		}
