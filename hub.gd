extends Control




func _on_multiplayer_pressed():
	Globals.change_screen('res://MultiplayerHub/Multiplayer.tscn')


func _on_gerais_pressed():
	Globals.change_screen('res://Geral/Testes Gerais.tscn')


func _on_league_pressed():
	Globals.change_screen('res://MultiplayerHub/League/LeagueGame.tscn')
