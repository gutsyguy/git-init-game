extends KinematicBody2D


#movement variables
export var movementSpeed:float = 175
var _velocity:= Vector2.ZERO

#animations
var isMovingLeft:bool
var isMovingRight:bool
var isMovingUp:bool
var isMovingDown:bool
onready var _animator: AnimationPlayer = $PlayerAnimation
onready var _pivot: Node2D = $Player
onready var _scale: Vector2 = _pivot.scale


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

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
	_velocity = move_and_slide(_velocity)
	var isWalking := _velocity.x or _velocity.y > 0.1
	animationInput()
	animationCheck(_animator)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func animationCheck(_animator):
	if Input.is_action_pressed("move_left"):
		_animator.play("walk_left")
	elif Input.is_action_just_released("move_left"):
		_animator.stop()
	if Input.is_action_pressed("move_right"):
		_animator.play("walk_right")
	elif Input.is_action_just_released("move_right"):
		_animator.stop()
	if Input.is_action_pressed("move_up"):
		_animator.play("walk_back")
	elif Input.is_action_just_released("move_up"):
		_animator.stop()
	if Input.is_action_pressed("move_down"):
		_animator.play("Walk")
	elif Input.is_action_just_released("move_dow "):
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

	

	
	
