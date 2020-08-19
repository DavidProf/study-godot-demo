extends RigidBody2D

export var min_speed = 150 # enemy min speed
export var max_speed = 250 # enemy max speed


func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names() # get all animations from enemy
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
