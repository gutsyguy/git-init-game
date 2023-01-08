extends Node2D

export var randomShakeStrength:float = 32.5
export var shakeDecayRate:float = 4.7
export var noiseShakeSpeed:float = 30
export var noiseShakeStrength:float = 60


onready var camera = $camera
onready var rand = RandomNumberGenerator.new()
onready var applyButton = $ui/apply_shake
onready var noise = OpenSimplexNoise.new()

var noise_i:float = 0.0
var shakeStrength:float = 0.0


func _ready():
	rand.randomize()
	applyButton.connect("pressed", self, "applyShake")
	
	noise.seed = rand.randf()
	noise.period = 2
	
func applyShake() -> void:
	shakeStrength = noiseShakeStrength


func _process(delta:float) -> void:
	shakeStrength = lerp(shakeStrength, 0, shakeDecayRate * delta)
	
	camera.offset = getNoiseOffset(delta)

func getNoiseOffset(delta:float) -> Vector2:
	noise_i += delta * noiseShakeSpeed
	return Vector2(
		noise.get_noise_2d(1, noise_i) * shakeStrength,
		noise.get_noise_2d(100, noise_i) * shakeStrength
	)


func getRandomOffset() -> Vector2:
	return Vector2(
		rand.randfRange(-shakeStrength,shakeStrength),
		rand.randfRange(-shakeStrength, shakeStrength)
	)
