extends KinematicBody2D

const UP_DIRECTION = Vector2(0, -1)
const SPEED = 300
const GRAVITY = 20
const JUMP_HEIGHT = 500 

var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	else:
		motion.x = 0
	
	if is_on_floor() and Input.is_action_pressed("ui_up"):
		motion.y = -JUMP_HEIGHT


	motion = move_and_slide(motion, UP_DIRECTION)
