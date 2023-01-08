extends Camera2D

var shakeAmount = 10
var newShake = 100
var shakeTime = 10
var shakeLimit = 100
var defaultOffset = offset

onready var tween = $Tween
onready var timer = $Timer

func _ready():
	Global.camera = self
	set_process(false)
	randomize()

func _process(delta):
	offset = Vector2(rand_range(-shakeAmount,shakeAmount),rand_range(-shakeAmount,shakeAmount)) * delta * defaultOffset
	
func _shake(newShake,shakeTime, shakeLimit):
	shakeAmount += newShake
	tween.stop_all()
	set_process(true)
	timer.start()


func _on_Timer_timeout():
	shakeAmount = 0
	set_process(false)
	tween.interpolate_property(self, "offset", offset, defaultOffset, 0.1, tween.TRANS_QUAD ,tween.EASE_IN_OUT)
	tween.start()


func _on_playerArea_area_entered(area,time, amount):
	if (area.name == "fireWorksTrigger"):
		_shake(newShake,shakeTime, shakeLimit)
		print("d")
		
		
