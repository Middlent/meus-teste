extends Control

var peer_ready = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if(multiplayer.is_server()):
		$HostName.text = get_parent().chat_name
		var ip_adress :String
		if OS.has_feature("windows"):
			if OS.has_environment("COMPUTERNAME"):
				ip_adress =  IP.resolve_hostname(str(OS.get_environment("COMPUTERNAME")),1)
		elif OS.has_feature("x11"):
			if OS.has_environment("HOSTNAME"):
				ip_adress =  IP.resolve_hostname(str(OS.get_environment("HOSTNAME")),1)
		elif OS.has_feature("OSX"):
			if OS.has_environment("HOSTNAME"):
				ip_adress =  IP.resolve_hostname(str(OS.get_environment("HOSTNAME")),1)
		$Ip.text = "Ip: "+ip_adress+"\nPort: "+get_parent().port
		get_parent().users[1] = get_parent().name
		$Start.pressed.connect(press_start)
	else:
		connect_peer.rpc(get_parent().chat_name)
		$Start.text = "Ready"
		$Start.disabled = false
		$Start.pressed.connect(press_ready)


@rpc("any_peer","call_local")
func connect_peer(name):
		$GuestName.text = name
		$GuestName.modulate = Color(1, 1, 1, 1)
		$TextureRect2.modulate = Color(1, 1, 1, 1)

@rpc("any_peer","call_local")
func ready_peer():
	if multiplayer.is_server():
		$GuestName.modulate = Color(0, 1, 0, 1)
		$Start.disabled = false
	else:
		$Start.text = "Unready"
	

@rpc("any_peer","call_local")
func unready_peer():
	if multiplayer.is_server():
		$GuestName.modulate = Color(1, 1, 1, 1)
		$Start.disabled = true
	else:
		$Start.text = "Ready"

func press_ready():
	peer_ready = !peer_ready
	if peer_ready:
		ready_peer.rpc()
	else:
		unready_peer.rpc()

func press_start():
	print("lets goooooooooooooooooooooooooooo")
	
