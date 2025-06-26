extends Node

enum masks{
	# Mascaras de campeão
	SELF_CHAMP_MASK = 1,
	ALLY_CHAMP_MASK = 2,
	ENEMY_CHAMP_MASK = 4,
	OTHER_ALLY_CHAMP_MASK = 8,
	
	# Mascaras de unidade
	ALLY_UNIT_MASK = 16,
	ENEMY_UNIT_MASK = 32,
	NEUTRAL_UNIT_MASK = 64,
	# 128 Unused
	
	# Mascara genericas temporária
	ALLY_TOWER_MASK = 256,
	ENEMY_TOWER_MASK = 512
}

func change_screen(new_screen):
	get_tree().change_scene_to_file(new_screen)
