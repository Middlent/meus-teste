extends Control

var chat_text = []

func _ready():
	multiplayer.peer_connected.connect(on_client_connected)
	
func on_client_connected(id):
	if get_parent().chat_name == "":
		if multiplayer.is_server():
			change_name("Server")
		else:
			change_name("Client_"+str(multiplayer.get_unique_id()))
	if multiplayer.is_server():
		peer_name_changed.rpc_id(id,get_parent().chat_name)
	else:
		peer_name_changed.rpc(get_parent().chat_name)

func _on_cliente_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client($CanvasLayer/Screen/IP.text, int($CanvasLayer/Screen/PORT.text))
	multiplayer.multiplayer_peer = peer


func _on_server_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(int($CanvasLayer/Screen/PORT.text), 4)
	multiplayer.multiplayer_peer = peer


func _on_servercheck_pressed():
	print(multiplayer.get_unique_id())
	print(multiplayer.is_server())


func _on_send_pressed():
	change_label.rpc($CanvasLayer/Screen/TextToSend.text)

@rpc("any_peer","call_local")
func change_label(new_text):
	if len(chat_text) >= 5:
		chat_text.pop_front()
	chat_text.append({"User":multiplayer.get_remote_sender_id(), "text":new_text})
	chat_refresh()

func chat_refresh():
	$"CanvasLayer/Screen/Received Text".text = ""
	for linha in chat_text:
		$"CanvasLayer/Screen/Received Text".text += get_parent().users[linha["User"]]+" disse: "+linha.text+"\n"
	$"CanvasLayer/Screen/Received Text".text = $"CanvasLayer/Screen/Received Text".text.strip_edges()
	

func _on_change_name_pressed():
	change_name($"CanvasLayer/Screen/Name Text".text)

func change_name(new_name):
	get_parent().chat_name = new_name
	$"CanvasLayer/Screen/Name Show".text = "Name: "+get_parent().chat_name
	peer_name_changed.rpc(get_parent().chat_name)

@rpc("any_peer","call_local")
func peer_name_changed(new_name):
	print(multiplayer.get_remote_sender_id())
	print(new_name)
	get_parent().users[multiplayer.get_remote_sender_id()] = new_name
	chat_refresh()


func _on_enter_game_pressed():
	if multiplayer.is_server():
		get_parent().change_screen.rpc("res://MultiplayerHub/Teste/MultiGame.tscn")
	else:
		print("Tu n é server")
