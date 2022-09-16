extends CharacterBody2D

@export var MAX_SPEED: float = 150.0
@export var ACCELERATION: float = MAX_SPEED * 10
@export var FRICTION: float = MAX_SPEED * 10 
@export var DASH_SPEED: float = 500.0

enum {
	MOVE,
	DASH
}
var state = MOVE

var direction_vector:= Vector2.ZERO

@onready var dashTimer: Timer = $DashTimer
@onready var dashParticules: CPUParticles2D = $DashParticules

@onready var weaponPosition: Position2D = $WeaponPosition

func _input(event):
	weaponPosition.look_at(get_global_mouse_position())
	weaponPosition.rotation = fmod(weaponPosition.rotation, 2*PI)

func _physics_process(delta):
	match state:
		MOVE:
			move(delta)
		DASH:
			dash(direction_vector)

func move(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("move_up", "move_down")
	input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		direction_vector = input_vector
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("dash"):
		start_dash()

func start_dash():
	state = DASH
	dashParticules.emitting = true
	dashTimer.start()


func dash(input_vector):
	velocity = input_vector * DASH_SPEED
	move_and_slide()


func _on_dash_timer_timeout():
	state = MOVE
