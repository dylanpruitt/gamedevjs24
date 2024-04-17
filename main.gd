extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$PauseMenu.hide()
	$Player/Camera2D.limit_left = 0
	$Player/Camera2D.limit_top = 0
	$Player/Camera2D.limit_right = $TileMap.get_used_rect().end.x * $TileMap.tile_set.tile_size.x * 2
	$Player/Camera2D.limit_bottom = $TileMap.get_used_rect().end.y * $TileMap.tile_set.tile_size.y * 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		print($Player/Camera2D.offset)
	if Input.is_action_pressed("ui_cancel"):
		print("Paused game")
		# Show pause menu and focus on "resume game" button.
		$PauseMenu.show()
		$PauseMenu/ResumeButton.grab_focus()
		get_tree().paused = true
	if Input.is_action_just_pressed("test"):
		$CanvasModulate.visible = !$CanvasModulate.visible

func _on_pause_menu_pressed_resume_button():
	print("Unpaused game")
	$PauseMenu.hide()
	get_tree().paused = false

func _on_pause_menu_pressed_exit_button():
	print("Exiting game...")
	get_tree().quit()

func _on_clock_updated(new_time):
	$HUD.update_clock(new_time)

func _on_player_health_changed(old, new):
	$HUD.update_health(new)

func _on_ship_left_moon():
	print("leaving moon...")
