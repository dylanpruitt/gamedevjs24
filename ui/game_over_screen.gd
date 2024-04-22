extends CanvasLayer

# Used internally to tell when typing effects finish.
signal typing_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalVariables.cause_of_death == GlobalVariables.CausesOfDeath.TERMINATED:
		type_terminated()
	elif GlobalVariables.cause_of_death == GlobalVariables.CausesOfDeath.MISSING:
		type_missing()
	else:
		type_killed()

	if GlobalVariables.death_description != null:
		$Control/DeathDescription.text = GlobalVariables.death_description
	else:
		$Control/DeathDescription.text = "Game over..."
	$Control/ScoreLabel.text = "Score: %s" % GlobalVariables.player_score

	await typing_finished
	await get_tree().create_timer(1.0).timeout
	$BongSFX.play()
	$Control.show()
	$Control/PlayAgain.grab_focus()

func type_terminated():
	$StatusLabel.position.x = 253.5
	type_letter("T")
	await get_tree().create_timer(0.5).timeout
	type_letter("E")
	await get_tree().create_timer(0.5).timeout
	type_letter("R")
	await get_tree().create_timer(0.5).timeout
	type_letter("M")
	await get_tree().create_timer(0.5).timeout
	type_letter("I")
	await get_tree().create_timer(0.5).timeout
	type_letter("N")
	await get_tree().create_timer(0.33).timeout
	type_letter("A")
	await get_tree().create_timer(0.33).timeout
	type_letter("T")
	await get_tree().create_timer(0.33).timeout
	type_letter("E")
	await get_tree().create_timer(1.0).timeout
	type_letter("D")

	typing_finished.emit()

func type_missing():
	$StatusLabel.position.x = 330
	type_letter("M")
	await get_tree().create_timer(0.33).timeout
	type_letter("I")
	await get_tree().create_timer(0.33).timeout
	type_letter("S")
	await get_tree().create_timer(0.33).timeout
	type_letter("S")
	await get_tree().create_timer(0.5).timeout
	type_letter("I")
	await get_tree().create_timer(0.5).timeout
	type_letter("N")
	await get_tree().create_timer(0.5).timeout
	type_letter("G")

	typing_finished.emit()

func type_killed():
	$StatusLabel.position.x = 359.5
	await get_tree().create_timer(0.17).timeout
	type_letter("K")
	await get_tree().create_timer(0.33).timeout
	type_letter("I")
	await get_tree().create_timer(0.17).timeout
	type_letter("L")
	await get_tree().create_timer(0.33).timeout
	type_letter("L")
	await get_tree().create_timer(0.5).timeout
	type_letter("E")
	await get_tree().create_timer(0.66).timeout
	type_letter("D")

	typing_finished.emit()

func type_letter(letter):
	$StatusLabel.text += letter
	$TypewriterClickSFX.play()

func _on_play_again_pressed():
	print("playing again...")
	GlobalVariables.reset_globals()
	get_tree().change_scene_to_file("res://ui/tutorial_screen.tscn")

func _on_exit_game_pressed():
	print("Exiting game...")
	get_tree().quit()
