extends Skill

@onready var animationNode = get_node("../../Animations")
@onready var player = get_node("../..")

@export var range = 100
@export var speed = 10
@export var cooldown_reduction = 1.5
@export var percent_ad = 1.3
@export var percent_ap = 0.15

var shot
var data = {}

var mouse_pos

func cast():
	animationNode.lock()
	mouse_pos = get_global_mouse_position()
	animationNode.post_animation_action_callable = skillshot
	animationNode.play_animation("Q", 5, true, true)

func skillshot():
	shot = load("res://MultiplayerHub/League/Prefabs/Projectile.tscn").instantiate()
	get_parent().get_parent().add_sibling(shot)
	
	shot.position = global_position
	
	data.projectile_speed = speed
	data.size = Vector2(2, 2)
	
	data.mode = shot.mode.STRAIGHT
	data.direction = global_position.direction_to(mouse_pos)
	data.range = range
	data.mask = Globals.masks.ENEMY_CHAMP_MASK + Globals.masks.ENEMY_UNIT_MASK
	
	var damage = 20 + percent_ad * player.champion.stats.ad + percent_ap * player.champion.stats.ap
	data.interactiveEffects = [
		Effects.damage.bind(player, damage)
		]
	data.effects = [
		Effects.reduce_cooldown.bind(player, "Q", cooldown_reduction, Effects.SkillReductionType.FLAT),
		Effects.reduce_cooldown.bind(player, "W", cooldown_reduction, Effects.SkillReductionType.FLAT),
		Effects.reduce_cooldown.bind(player, "E", cooldown_reduction, Effects.SkillReductionType.FLAT),
		Effects.reduce_cooldown.bind(player, "R", cooldown_reduction, Effects.SkillReductionType.FLAT)
		]
	
	shot.load_info(data)
