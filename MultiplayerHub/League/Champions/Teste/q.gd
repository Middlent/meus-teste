extends Skill

@onready var animationNode = get_node("../../Animations")
@export var range = 100
@export var speed = 10
@export var cooldown_reduction = 1.5

var shot
var data = {}

func cast():
	animationNode.lock()
	data.direction = position.direction_to(get_local_mouse_position())
	animationNode.post_animation_action_callable = skillshot
	animationNode.play_animation("Q", 5, true, true)

func skillshot():
	shot = load("res://MultiplayerHub/League/Prefabs/skillshot.tscn").instantiate()
	get_parent().get_parent().add_sibling(shot)
	shot.hit.connect(on_sucessful_hit)
	shot.position = global_position
	data.range = range
	data.speed = speed
	data.size = Vector2(2, 2)
	var masks = Globals.masks.ENEMY_CHAMP_MASK
	shot.load_info(load("res://icon.svg"), data, masks)

func on_sucessful_hit(_data):
	reduce_cooldown(cooldown_reduction, ReductionType.FLAT)
	get_node(str(get_parent().get_path()) + "/W").reduce_cooldown(cooldown_reduction, ReductionType.FLAT)
	get_node(str(get_parent().get_path()) + "/E").reduce_cooldown(cooldown_reduction, ReductionType.FLAT)
	get_node(str(get_parent().get_path()) + "/R").reduce_cooldown(cooldown_reduction, ReductionType.FLAT)
