extends KinematicBody2D

#movement variables
export var movementSpeed:float = 175
var _velocity:= Vector2.ZERO

#animations
var isMovingLeft:bool
var isMovingRight:bool
var isMovingUp:bool
var isMovingDown:bool
onready var _animator: AnimationPlayer = $AnimationPlayer
onready var _pivot: Node2D = $Sprite
onready var _scale: Vector2 = _pivot.scale

func _ready():
	rand.randomize()
	noise.seed = rand.randf()
	noise.period = 2
	

func _physics_process(delta:float) -> void:
	var _horizontalDirection = (
		Input.get_action_strength("move_right")
		- Input.get_action_strength("move_left")
		)
	var _verticalDirection = (
		Input.get_action_strength("move_down")
		- Input.get_action_strength("move_up")
		)	

	_velocity.x = _horizontalDirection * movementSpeed
	_velocity.y = _verticalDirection * movementSpeed
	if Global.is_cutscene:
		_velocity = Vector2.ZERO
	if Global.is_chased:
		_velocity *= 1.5
	_velocity = move_and_slide(_velocity)
	var isWalking := _velocity.x or _velocity.y > 0.1
	animationInput()
	animationCheck(_animator)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shakeStrength = lerp(shakeStrength, 0, shakeDecayRate * delta)

	camera.offset = getNoiseOffset(delta)

func animationCheck(_animator):
	if Input.is_action_pressed("move_left"):
		applyShake()
		_animator.play("walkLeft")
	elif Input.is_action_just_released("move_left"):
		_animator.stop()
	if Input.is_action_pressed("move_right"):
		_animator.play("walkRight")
	elif Input.is_action_just_released("move_right"):
		_animator.stop()
	if Input.is_action_pressed("move_up"):
		_animator.play("walkUp")
	elif Input.is_action_just_released("move_up"):
		_animator.stop()
	if Input.is_action_pressed("move_down"):
		_animator.play("walkDown")
	elif Input.is_action_just_released("move_down"):
		_animator.stop()


func animationInput():
	if Input.is_action_pressed("move_left"):
		isMovingLeft = true
	if Input.is_action_pressed("move_right"):
		isMovingRight = true
	if Input.is_action_pressed("move_up"):
		isMovingUp = true
	if Input.is_action_pressed("move_down"):
		isMovingDown = true




	if !Global.is_cutscene:
		if Input.is_action_pressed("move_left"):
			_animator.play("walkLeft")
		if Input.is_action_pressed("move_right"):
			_animator.play("walkRight")
		if Input.is_action_pressed("move_up"):
			_animator.play("walkUp")
		if Input.is_action_pressed("move_down"):
			_animator.play("walkDown")

export var randomShakeStrength:float = 32.5
export var shakeDecayRate:float = 4.7
export var noiseShakeSpeed:float = 30
export var noiseShakeStrength:float = 60


onready var camera = $Camera2D
onready var rand = RandomNumberGenerator.new()
onready var trigger:Area2D = $playerArea
onready var noise = OpenSimplexNoise.new()

var noise_i:float = 0.0
var shakeStrength:float = 0.0

func applyShake() -> void:
	shakeStrength = noiseShakeStrength


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


func _on_playerArea_area_entered(area):
	if (area.name == "fireWorksTrigger"):
		applyShake()
		print("satsujinki")
