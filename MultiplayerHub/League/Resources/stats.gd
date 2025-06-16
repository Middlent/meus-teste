class_name Stats extends Resource

var level: int = 1

@export var hpBase: float
@export var hpLevel: float
var hp: float :
	set(new_hp):
		hp = new_hp
		emit_changed()

@export var asBase: float
@export var asLevel: float
var aSpeed: float :
	set(new_aSpeed):
		aSpeed = new_aSpeed
		emit_changed()

@export var adBase: float
@export var adLevel: float
var ad: float :
	set(new_ad):
		ad = new_ad
		emit_changed()

@export var rangeBase: float
var range: float :
	set(new_range):
		range = new_range
		emit_changed()

@export var projSpeed: float

func _init():
	setup.call_deferred()
	
func setup():
	hp = hpBase + hpLevel * (level - 1)
	aSpeed = asBase + asLevel * (level - 1)
	ad = adBase + adLevel * (level - 1)
	range = rangeBase
