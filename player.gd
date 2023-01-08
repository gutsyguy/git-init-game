extends KinematicBody2D

#movement variables
export var movementSpeed:float = 75
var _velocity:= Vector2.ZERO

#animations
onready var _animator: AnimationPlayer = $PlayerAnimation
onready var _pivot: Node2D = $Player
onready var _scale: Vector2 = _pivot.scale



func _physics_process(delta:float) -> void:
	var _horizontalDirection = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	var _verticalDirection = (Input.get_action_strength("move_down")- Input.get_action_strength("move_up"))
	_velocity.x = _horizontalDirection * movementSpeed
	_velocity.y = _verticalDirection * movementSpeed
	if Global.is_cutscene:
		_velocity = Vector2.ZERO
	if Global.is_chased:
		_velocity *= 2
	_velocity = move_and_slide(_velocity)
	var isWalking := _velocity.x or _velocity.y > 0.1
	animationCheck(_animator)

func _process(delta):
	if Global.is_chased:
		if !$running.playing:
			$running.play()
		if !$schizo_voice.playing:
			$schizo_voice.play()
	
	if Global.normal:
		$schizo_voice.stop()
		$running.stop()
	
func animationCheck(_animator):
	if Input.is_action_pressed("move_left"):
		_animator.play("walk_left")
		$Light2D.rotation_degrees = 180
	elif Input.is_action_just_released("move_left"):
		_animator.stop()
	if Input.is_action_pressed("move_right"):
		_animator.play("walk_right")
		$Light2D.rotation_degrees = 0
	elif Input.is_action_just_released("move_right"):
		_animator.stop()
	if Input.is_action_pressed("move_up"):
		_animator.play("walk_back")
		$Light2D.rotation_degrees = 270
	elif Input.is_action_just_released("move_up"):
		_animator.stop()
	if Input.is_action_pressed("move_down"):
		_animator.play("Walk")
		$Light2D.rotation_degrees = 90
	elif Input.is_action_just_released("move_down"):
		_animator.stop()

	if !Global.is_cutscene:
		if Input.is_action_pressed("move_left"):
			_animator.play("walk_left")
		if Input.is_action_pressed("move_right"):
			_animator.play("walk_right")
		if Input.is_action_pressed("move_up"):
			_animator.play("walk_back")
		if Input.is_action_pressed("move_down"):
			_animator.play("Walk")

	
