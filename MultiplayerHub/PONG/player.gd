extends Node2D



@rpc("call_local")
func check(id):
	set_multiplayer_authority(id)
	$InputReader.set_process(multiplayer.get_unique_id() == get_multiplayer_authority())
