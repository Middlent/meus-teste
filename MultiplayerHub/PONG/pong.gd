extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	if multiplayer.is_server():
		$Player.check.rpc(1)
		$Player2.check.rpc(multiplayer.get_peers()[0])


func _on_goal_1_goal():
	$"Vidas 1".text = str(int($"Vidas 1".text) - 1)


func _on_goal_2_goal():
	$"Vidas 2".text = str(int($"Vidas 2".text) - 1)
