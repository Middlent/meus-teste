extends Control


func _on_teste_pressed():
	get_parent().change_screen("res://MultiplayerHub/Teste/lobby.tscn")


func _on_pong_pressed():
	get_parent().change_screen("res://MultiplayerHub/PONG/PongLobby.tscn")
