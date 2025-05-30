extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if multiplayer.is_server():
		var new_position = Vector2(200, 200)
		spawnPlayer(1, new_position)
		for user in multiplayer.get_peers():
			new_position += Vector2 (200, 0)
			spawnPlayer(user, new_position)

func spawnPlayer(id, pos):
	var player: Node2D = load("res://MultiplayerHub/Teste/Multi_Player.tscn").instantiate()
	add_child(player, true)
	player.get_child(-1).check.rpc(id, pos)
