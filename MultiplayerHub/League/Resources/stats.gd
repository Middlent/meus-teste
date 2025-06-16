class_name Stats extends Resource

var level: int = 1

@export var hpBase: float
@export var hpLevel: float
var hp: float

@export var asBase: float
@export var asLevel: float
var aSpeed: float

@export var adBase: float
@export var adLevel: float
var ad: float

@export var rangeBase: float
var range: float

@export var projSpeed: float

func _init():
	setup.call_deferred()
	
func setup():
	hp = hpBase + hpLevel * (level - 1)
	aSpeed = asBase + asLevel * (level - 1)
	ad = adBase + adLevel * (level - 1)
	range = rangeBase
