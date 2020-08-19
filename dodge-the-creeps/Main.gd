extends Node


export (PackedScene) var Enemy

var score

func _ready():
	print(OS.get_name())
	randomize()

var joystick_direction = Vector2(0, 0)
var lock = false;
func _process(delta):
	var direction = $Joystick.get_direction()
	if $Joystick.emit == true and (joystick_direction.x != direction.x or joystick_direction.y != direction.y):
		Input.action_press("ui_up", direction.x)
		Input.action_press("ui_right", direction.y)
		joystick_direction = direction
		lock = true
	elif $Joystick.emit == false and lock == true:
		lock = false
		Input.action_press("ui_up", 0)
		Input.action_press("ui_right", 0)

func game_over():
	$Joystick.hide()
	$Music.stop()
	$DeathSound.play()
	$ScoreTimer.stop()
	$EnemyTimer.stop()
	$HUD.show_game_over()
	
func new_game():
	$Music.play()
	get_tree().call_group("enemies", "queue_free")
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("GET READY")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Joystick.show()

func _on_StartTimer_timeout():
	$EnemyTimer.start()
	$ScoreTimer.start()
	$HUD.update_score(score)

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_EnemyTimer_timeout():
	# random location on path2d (Enemy path)
	$EnemyPath/MobSpawnLocation.offset = randi()
	# instance and add enemy to scene
	var enemy = Enemy.instance()
	add_child(enemy)
	# set the enemy's direction perpendicular to the path direction
	var direction = $EnemyPath/MobSpawnLocation.rotation + PI / 2
	# set enemy's postion to random location 
	enemy.position = $EnemyPath/MobSpawnLocation.position
	# add some randomnes to direction
	direction += rand_range(-PI / 4, PI / 4)
	# set velocity and direction
	enemy.linear_velocity = Vector2(rand_range(enemy.min_speed, enemy.max_speed), 0)
	enemy.linear_velocity = enemy.linear_velocity.rotated(direction)
	



