extends Node2D

@export var team = 0
@export var champion: Champion

@rpc("call_local")
func check(id, player_team):
	set_multiplayer_authority(id)
	var is_me = multiplayer.get_unique_id() == get_multiplayer_authority()
	$InputReader.set_process(is_me)
	$InputReader.set_process_input(is_me)
	if player_team == get_parent().team:
		add_to_group("Ally")
	else:
		add_to_group("Enemy")

func _init():
	setup.call_deferred()
	
func setup():
	champion.stats.changed.connect(on_stats_changed)

func on_stats_changed():
	$ProgressBar.max_value = champion.stats.hpBase + champion.stats.hpLevel * (champion.stats.level - 1)
	$ProgressBar.value = champion.stats.hp
