extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$PauseMenu.hide()

var health = 100
var power = 1000
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("test"):
		health -= 1
		$HUD.update_health(health)
	if Input.is_action_pressed("ui_cancel"):
		print("Paused game")
		# Show pause menu and focus on "resume game" button.
		$PauseMenu.show()
		$PauseMenu/ResumeButton.grab_focus()
		get_tree().paused = true

func _on_tick_timer_timeout():
	power -= 1
	$HUD.update_power(power)

func _on_pause_menu_pressed_resume_button():
	print("Unpaused game")
	$PauseMenu.hide()
	get_tree().paused = false

func _on_pause_menu_pressed_exit_button():
	print("Exiting game...")
	get_tree().quit()
