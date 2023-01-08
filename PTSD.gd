extends Node2D

export var randomShakeStrength:float = 32.5
export var shakeDecayRate:float = 4.7
export var noiseShakeSpeed:float = 30
export var noiseShakeStrength:float = 60


onready var camera = get_node("/root/Global/realPlayer")
onready var rand = RandomNumberGenerator.new()
onready var trigger:Area2D = $fireWorksTrigger
onready var noise = OpenSimplexNoise.new()


func _on_fireWorksTrigger_area_entered(area):
	if (area.name == "fireWorksTrigger"):
		print("satsujinki")
