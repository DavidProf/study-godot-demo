#http://www.openpixelproject.com/
extends KinematicBody2D

const UP_DIRECTION = Vector2(0, -1)
const GRAVITY = 20
const JUMP_HEIGHT = 500
const ACCELERATION = 20
const MAX_SPEED = 300
onready var screen_size = get_viewport_rect().size

var motion = Vector2()

func _physics_process(delta):
	var friction = false
	if position.y > screen_size.y:
		position = Vector2.ZERO
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.offset.x = 160
		$AnimatedSprite.play("Run")
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite.offset.x = -160
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Run")
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	else:
		if is_on_floor():
			$AnimatedSprite.play("Idle")
		friction = true
		
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = -JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.3)
	else:
		if motion.y < 0:
			$AnimatedSprite.play("Jump")
		else:
			$AnimatedSprite.play("Fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
	motion = move_and_slide(motion, UP_DIRECTION)
