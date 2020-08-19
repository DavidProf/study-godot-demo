extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("GAME OVER")
	# wait until messagetimer finish
	yield($MessageTimer, "timeout")
	
	$MessageLabel.text = "DODGE THE\nCREEPS!"
	$MessageLabel.show()
	# Make one shot timer and wait to finish
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
