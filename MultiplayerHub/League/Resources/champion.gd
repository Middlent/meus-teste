class_name ChampionResource extends Resource

@export var stats: Stats
@export var skills: PackedScene

var attack_data :
	get:
		return {
			"projectile_speed": stats.projSpeed,
			"damage": stats.ad
		}
