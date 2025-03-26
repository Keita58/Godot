extends CanvasLayer

signal start_game

var durationPowerUp:int

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	$Message.hide()
	
func update_powerUpTime(timeLeft)->void:
	$PowerUpTimeLeft.text=str("Time left: "+" "+str(timeLeft))

func _on_player_iniciar_timer_power_up(duration: int) -> void:
	$PowerUpTimer.start()
	%AudioStreamPlayer2D.stream=load("res://art/youtube_MFtr4rw-dwI_854x478_h264.wav")
	%AudioStreamPlayer2D.play()
	$PowerUpTimeLeft.show()
	update_powerUpTime(duration)
	durationPowerUp=duration

func _on_power_up_timer_timeout() -> void:
	durationPowerUp-=1
	if durationPowerUp<0:
		$PowerUpTimer.stop()
		$PowerUpTimeLeft.hide()
		%AudioStreamPlayer2D.stop()
	else:
		update_powerUpTime(durationPowerUp)
	

func _on_player_hurt(vida: int) -> void:
	$Hp.text = "Lives: " + str(vida)
