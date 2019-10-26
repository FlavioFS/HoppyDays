extends KinematicBody2D

signal animate

const MAX_SPEED = 1000
const BOOST_MULTIPLIER = 1.5
const WORLD_LIMIT = 4000
const JUMP_SFX = preload("res://SFX/jump1.ogg")
const HURT_SFX = preload("res://SFX/hurt.ogg")
const FLOAT_PRECISION: float = 0.05

export(float, -3000, -1000, 10) var jump_force: float = -2500
export(float, 0, 200, 5) var gravity: float = 125
export(float, 0, 1000, 10) var base_move_speed: float = 300
export(float, 0.0, 1.0, 0.01) var damping: float = 0.7

var velocity = Vector2(0,0)
var lives = 5

var jump_count = 0
var extra_jumps = 1
var direction = 1
var input_direction = 0
var speed = Vector2(0,0)

func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP, true)
	apply_gravity(delta)
	move_horizontally()
	jump()
	animate()

func apply_gravity(delta):
	if position.y > WORLD_LIMIT:
		get_tree().call_group("Gamestate", "end_game")
	elif is_on_floor() and velocity.y > 0:
		velocity.y = 0
	elif is_on_ceiling() and velocity.y < 0:
		velocity.y = 1
	else:
		velocity.y += gravity

func move_horizontally():
	velocity.x  = 0 if abs(velocity.x) < FLOAT_PRECISION else velocity.x * damping
	if Input.is_action_pressed("Left"):
		velocity.x -= base_move_speed
	if Input.is_action_pressed("Right"):
		velocity.x += base_move_speed
	velocity.x = min(max(velocity.x, -MAX_SPEED), MAX_SPEED)

func jump(): # Fix double jump bug
	if Input.is_action_just_pressed("Jump"):
		if jump_count < extra_jumps:
			velocity.y = jump_force
			jump_count += 1
			play_SFX(JUMP_SFX)
	if is_on_floor():
		jump_count = 0

func animate():
	emit_signal("animate", velocity)

func hurt():
	add_extra_frame()
	velocity.y = jump_force
	play_SFX(HURT_SFX)
	lives -= 1

func boost():
	add_extra_frame()
	velocity.y = jump_force * BOOST_MULTIPLIER
	play_SFX(JUMP_SFX)

func play_SFX(FILE):
	$SFX.stream = FILE
	$SFX.play()

func add_extra_frame():
	position.y -= 1
	yield(get_tree(), "idle_frame")