class_name Stats extends Resource

var level: int = 1

@export var hpBase: float
@export var hpLevel: float
@export var hpReg: float
var hp: float :
	set(new_hp):
		hp = new_hp
		emit_changed()

@export var manaBase: float
@export var manaLevel: float
@export var manaReg: float
var mana: float :
	set(new_mana):
		mana = new_mana
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

@export var ap: float :
	set(new_ap):
		ap = new_ap
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
	mana = manaBase + manaLevel * (level - 1)
	aSpeed = asBase + asLevel * (level - 1)
	ad = adBase + adLevel * (level - 1)
	range = rangeBase

func getHpMax():
	return hpBase + hpLevel * (level - 1)

func getManaMax():
	return manaBase + manaLevel * (level - 1)
	
func getASpeedMax():
	return asBase + asLevel * (level - 1)
	
func getAdMax():
	return adBase + adLevel * (level - 1)
