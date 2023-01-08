extends Node2D

# How quickly to move through the noise
export var NOISE_SHAKE_SPEED: float = 30.0
export var NOISE_SWAY_SPEED: float = 1.0
# Noise returns values in the range (-1, 1)
# So this is how much to multiply the returned value by
export var NOISE_SHAKE_STRENGTH: float = 60.0
export var NOISE_SWAY_STRENGTH: float = 10.0
# The starting range of possible offsets using random values
export var RANDOM_SHAKE_STRENGTH: float = 30.0
# Multiplier for lerping the shake strength to zero
export var SHAKE_DECAY_RATE: float = 3.0

var shakeCounter = 0

enum ShakeType {
	Random,
	Noise,
	Sway
}

onready var camera = $realPlayer/Camera2DCamera2D
onready var random_shake = $Ui/trigger
onready var noise_shake = $Ui/trigger
onready var noise_sway = $Ui/trigger


func _on_trigger_pressed():
	Global.camera._shake(100,2,10)
	
	
 
	


func _on_shakeTrigger_area_entered(area):
	if shakeCounter == 0:
		Global.camera._shake(30,2,10)
		shakeCounter = shakeCounter+1
