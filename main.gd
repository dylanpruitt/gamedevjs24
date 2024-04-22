extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	set_camera_limits($Overworld)
	$PauseMenu.hide()

	$Player/PlayerSprite/BombItem/AmountComponent.amount = GlobalVariables.num_bombs
	$Player/PlayerSprite/SpeedItem/AmountComponent.amount = GlobalVariables.num_speeds
	$Player/PlayerSprite/WarpItem/AmountComponent.amount = GlobalVariables.num_warps
	$InventoryUI.update_ui()
	$InventoryUI.hide()

	# Intro cutscene
	$Player.walking_cutscene = true
	$Player.PLAYER_SPEED = 75
	$ShipUI.hide()
	$HUD.hide()

	await get_tree().create_timer(2.0).timeout
	$Player.PLAYER_SPEED = 100
	$Player.walking_cutscene = false

	await get_tree().create_timer(1.8).timeout
	$HUD/QuotaLabel.text = "Quota: $%s" % GlobalVariables.quota
	$HUD.show()
	$InventoryUI.show()

func set_camera_limits(scene):
	var tilemap = scene.get_node("TileMap")
	$Player/Camera2D.limit_left = tilemap.get_used_rect().position.x * tilemap.tile_set.tile_size.x * 2
	$Player/Camera2D.limit_top = tilemap.get_used_rect().position.y * tilemap.tile_set.tile_size.y * 2
	$Player/Camera2D.limit_right = tilemap.get_used_rect().end.x * tilemap.tile_set.tile_size.x * 2
	$Player/Camera2D.limit_bottom = tilemap.get_used_rect().end.y * tilemap.tile_set.tile_size.y * 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		print("Paused game")
		# Show pause menu and focus on "resume game" button.
		$PauseMenu.show()
		$PauseMenu/ResumeButton.grab_focus()
		get_tree().paused = true

func _on_pause_menu_pressed_resume_button():
	print("Unpaused game")
	$PauseMenu.hide()
	get_tree().paused = false

func _on_pause_menu_pressed_exit_button():
	print("Exiting game...")
	get_tree().quit()

func _on_clock_updated(new_time):
	# Player goes missing at 12 AM.
	if new_time[0] == 24:
		GlobalVariables.cause_of_death = GlobalVariables.CausesOfDeath.MISSING
		GlobalVariables.death_description = "Your body was never found."
		get_tree().change_scene_to_file("res://ui/game_over_screen.tscn")
	else:
		$HUD.update_clock(new_time)
		if new_time == [18,0]:
			$Ship/PointLight2D.show()
			$Ship/ToggleSFX.play()

func _on_player_health_changed(_old, new):
	$HUD.update_health(new)

func _on_player_power_changed(_old, new):
	$HUD.update_power(new)

func _on_ship_left_moon():
	print("leaving moon...")
	get_tree().change_scene_to_file("res://ui/results_screen.tscn")

func _on_player_died():
		GlobalVariables.cause_of_death = GlobalVariables.CausesOfDeath.KILLED
		GlobalVariables.death_description = "You died a gruesome death."
		get_tree().change_scene_to_file("res://ui/game_over_screen.tscn")

# Code handling transition from overworld to the cave.
func _on_scene_transition_area_player_entered():
	$Overworld.set_process(false)
	$Ship.set_process(false)
	$ShipUI.set_process(false)
	$Ship.hide()

	var cave
	
	if GlobalVariables.previous_node == null:
		cave = preload("res://cave1.tscn").instantiate()
	else:
		cave = GlobalVariables.previous_node
	
	GlobalVariables.previous_node = $Overworld
	call_deferred("remove_child", $Overworld)
	call_deferred("add_child", cave)

	$Player.position = cave.get_node("SpawnFromOverworld").position
	set_camera_limits(cave)

	var to_overworld = cave.get_node("ToOverworld")
	to_overworld.player_entered.connect(_on_cave_transition_area_player_entered)

# Code handling transition from the cave to the overworld.
func _on_cave_transition_area_player_entered():
	var cave = get_node("Cave")
	var overworld = GlobalVariables.previous_node
	cave.set_process(false)
	overworld.set_process(true)
	$Ship.set_process(true)
	$ShipUI.set_process(true)
	$Ship.show()

	call_deferred("remove_child", cave)
	call_deferred("add_child", overworld)
	GlobalVariables.previous_node = cave

	call_deferred("move_child", $Ship, -1)
	call_deferred("move_child",$ShipUI, -1)
	$Player.position = overworld.get_node("SpawnFromCave").position
	set_camera_limits(overworld)


func _on_player_warped():
	if has_node("Overworld"):
		var overworld = get_node("Overworld")
		$Player.position = overworld.get_node("WarpPoint").position
	else:
		var cave = get_node("Cave")
		var overworld = GlobalVariables.previous_node
		cave.set_process(false)
		overworld.set_process(true)
		$Ship.set_process(true)
		$ShipUI.set_process(true)
		$Ship.show()

		call_deferred("remove_child", cave)
		call_deferred("add_child", overworld)
		GlobalVariables.previous_node = cave

		call_deferred("move_child", $Ship, -1)
		call_deferred("move_child",$ShipUI, -1)
		$Player.position = overworld.get_node("WarpPoint").position
		set_camera_limits(overworld)
