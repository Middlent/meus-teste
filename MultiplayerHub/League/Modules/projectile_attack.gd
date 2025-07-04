extends Node2D

var attack_data = {}
@onready var cooldown = $Cooldown

func attack(data):
	attack_data = data
	%Animations.play_animation("WindUp", 5, false)

func hit():
	if attack_data.target.has_node("Receiver"):
		cooldown.start(1 / get_parent().champion.stats.aSpeed)
		var projectile = load("res://MultiplayerHub/League/Prefabs/Projectile.tscn").instantiate()
		projectile.position = get_parent().position
		attack_data.mode = projectile.mode.TARGET
		attack_data.effects = [Effects.damage.bind(get_parent(), attack_data.damage)]
		projectile.load_info(attack_data)
		get_parent().add_sibling(projectile)
	else:
		print("Target ",attack_data.target," can't get attacked")
	
