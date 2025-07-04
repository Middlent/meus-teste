extends Skill

@onready var animationNode = get_node("../../Animations")
@export var range = 100
@export var speed = 10
@export var cooldown_reduction = 1.5

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
	
	shot.hitted.connect(on_sucessful_hit)
	shot.position = global_position
	
	data.projectile_speed = speed
	data.size = Vector2(2, 2)
	
	data.mode = shot.mode.STRAIGHT
	data.direction = global_position.direction_to(mouse_pos)
	data.range = range
	data.mask = Globals.masks.ENEMY_CHAMP_MASK + Globals.masks.ENEMY_UNIT_MASK
	
	shot.load_info(data)

func on_sucessful_hit(_data):
	reduce_cooldown(cooldown_reduction, ReductionType.FLAT)
	get_node(str(get_parent().get_path()) + "/W").reduce_cooldown(cooldown_reduction, ReductionType.FLAT)
	get_node(str(get_parent().get_path()) + "/E").reduce_cooldown(cooldown_reduction, ReductionType.FLAT)
	get_node(str(get_parent().get_path()) + "/R").reduce_cooldown(cooldown_reduction, ReductionType.FLAT)
