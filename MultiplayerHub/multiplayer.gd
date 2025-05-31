extends Node2D

var users = {}
var chat_name = ""
var port = ""

func _ready():
	multiplayer.peer_connected.connect(on_peer_connection)

func on_peer_connection(id):
	print("Conectado ",id)
	print(multiplayer.is_server())

@rpc("call_local")
func change_screen(new_screen_path):
	get_child(0).queue_free()
	add_child(load(new_screen_path).instantiate())
