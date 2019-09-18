extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 300
const FRICTION = 0
const MAX_SPEED = 1000
const MAX_FALL = 0
const ACCELERATION = 1000
const DECELERATION = 0
const JUMP_FORCE = -4000
const BOOST_MULTIPLIER = 1.5
const WORLD_LIMIT = 4000
const JUMP_SFX = preload("res://SFX/jump1.ogg")
const HURT_SFX = preload("res://SFX/hurt.ogg")

var velocity = Vector2(0,0)
var lives = 5

var jump_count = 0
var extra_jumps = 1
var direction = 1
var input_direction = 0
var speed = Vector2(0,0)

signal animate

func _physics_process(delta):
	move_and_slide(velocity, UP)
	apply_gravity(delta)
	move()
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
		velocity.y += GRAVITY


func move():
	if Input.is_action_pressed("Left") and not Input.is_action_pressed("Right"):
		velocity.x = max(velocity.x - ACCELERATION, -MAX_SPEED)
	elif Input.is_action_pressed("Right") and not Input.is_action_pressed("Left"):
		velocity.x = min(velocity.x + ACCELERATION, MAX_SPEED)
	else:
		velocity.x = 0


func jump(): # Fix double jump bug
	if Input.is_action_just_pressed("Jump") and jump_count < extra_jumps:
		velocity.y = JUMP_FORCE
		play_SFX(JUMP_SFX)
		jump_count += 1
	if is_on_floor():
		jump_count = 0
		
#	if is_on_floor() and Input.is_action_pressed("Jump"):
#		velocity.y = JUMP_FORCE
#		play_SFX(JUMP_SFX)


func animate():
	emit_signal("animate", velocity)


func hurt():
	add_extra_frame()
	velocity.y = JUMP_FORCE
	play_SFX(HURT_SFX)
	lives -= 1


func boost():
	add_extra_frame()
	velocity.y = JUMP_FORCE * BOOST_MULTIPLIER
	play_SFX(JUMP_SFX)


func play_SFX(FILE):
	if not $SFX.playing:
		$SFX.stream = FILE
		$SFX.play()


func add_extra_frame():
	position.y -= 1
	yield(get_tree(), "idle_frame")









