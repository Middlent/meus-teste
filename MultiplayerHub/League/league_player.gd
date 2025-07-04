extends CharacterBody2D

@export var team = 0
@export var champion: ChampionResource
@export var locked = false

@rpc("call_local")
func check(id, player_team):
	set_multiplayer_authority(id)
	var is_me = multiplayer.get_unique_id() == get_multiplayer_authority()
	$InputReader.set_process(is_me)
	$InputReader.set_process_input(is_me)
	var layers = 0
	if player_team == get_parent().team:
		layers += Globals.masks.ALLY_CHAMP_MASK
		if is_me:
			layers += Globals.masks.SELF_CHAMP_MASK
		else:
			layers += Globals.masks.OTHER_ALLY_CHAMP_MASK
		add_to_group("Ally")
	else:
		layers += Globals.masks.ENEMY_CHAMP_MASK
		add_to_group("Enemy")
	collision_layer = layers


func _ready():
	setup.rpc.call_deferred()

@rpc("call_local")
func setup():
	on_stats_changed()
	champion.stats.changed.connect(on_stats_changed)
	var skills = champion.skills.instantiate()
	skills.name = "Skills"
	
	add_child(skills)
	
	var is_me = multiplayer.get_unique_id() == get_multiplayer_authority()
	skills.set_process(is_me)
	skills.set_process_input(is_me)

func on_stats_changed():
	$HealthBar.max_value = champion.stats.getHpMax()
	$HealthBar.value = champion.stats.hp
	$ManaBar.max_value = champion.stats.getManaMax()
	$ManaBar.value = champion.stats.mana
