extends Node2D


func receive(data):
	if data.has("effects"):
		for effect in data.effects:
			effect.call(get_parent())
