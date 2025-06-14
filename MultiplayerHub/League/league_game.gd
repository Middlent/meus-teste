extends Control

@export var team = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if multiplayer.is_server():
		$Player.check.rpc(1, $Player.team)
		if len(multiplayer.get_peers()) > 0:
			$Player2.check.rpc(multiplayer.get_peers()[0], $Player2.team)
		else:
			$Player2.check.rpc(2, $Player2.team)
			$Player3.check.rpc(3, $Player3.team)
