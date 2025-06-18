extends Skill

@onready var animationNode = get_node("../../Animations")

func cast():
	animationNode.lock()
	animationNode.post_animation_action_callable = print.bind("Pew")
	animationNode.play_animation("Q", 5, true, true)
