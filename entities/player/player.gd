extends CharacterBody2D

signal health_changed(old,new)
signal power_changed(old,new)
signal stopped_charging

var PLAYER_SPEED = 100
var power = 500
var max_power = 500
var charging = false
var charge_rate = 10
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$PlayerSprite/Drill.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	var animation_to_play
	var using_drill = false

	if Input.is_action_pressed("move_up"):
		velocity.y -= PLAYER_SPEED
		animation_to_play = "walk_up"
	if Input.is_action_pressed("move_left"):
		velocity.x -= PLAYER_SPEED
		animation_to_play = "walk_right"
		$PlayerSprite.flip_h = true
	if Input.is_action_pressed("move_right"):
		velocity.x += PLAYER_SPEED
		animation_to_play = "walk_right"
		$PlayerSprite.flip_h = false
	if Input.is_action_pressed("move_down"):
		velocity.y += PLAYER_SPEED
		animation_to_play = "walk_down"
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_position = get_global_mouse_position()
		var angle = position.angle_to_point(mouse_position)
		var offset = 5
		$PlayerSprite/Drill.rotation = angle
		using_drill = true

	if $PlayerSprite/Flashlight.toggled and !using_drill:
		$PlayerSprite/Flashlight.visible = true
	else:
		$PlayerSprite/Drill.show()
		$PlayerSprite/Drill.play()
		$PlayerSprite/Flashlight.visible = false
	
	if !using_drill:
		$PlayerSprite/Drill.hide()
		$PlayerSprite/Drill.stop()

	if velocity.length() > 0:
		velocity = velocity.normalized() * PLAYER_SPEED
		set_velocity(velocity)
		
		move_and_slide()
		$PlayerSprite.play(animation_to_play)
	else:
		$PlayerSprite.stop()

	if charging:
		add_power(charge_rate * delta)
		if power == max_power:
			charging = false
			stopped_charging.emit()

func _input(event):
	if event is InputEventMouseMotion:
		var mouse_position = get_global_mouse_position()
		var angle = position.angle_to_point(mouse_position)
		var offset = 5
		$PlayerSprite/Flashlight.rotation = angle

func add_power(delta):
	if power + delta > max_power:
		power_changed.emit(power, max_power)
		power = max_power
	else:
		power_changed.emit(power, power + delta)
		power += delta

func _on_health_changed(old_value, new_value):
	health_changed.emit(old_value, new_value)


func _on_drill_drained_power(delta):
	power_changed.emit(power, power - delta)
	power -= delta

func _on_flashlight_drained_power(delta):
	power_changed.emit(power, power - delta)
	power -= delta

func _on_ship_charging_items(is_charging):
	if is_charging:
		print("charging power...")
		$PlayerSprite/Flashlight.toggled = false
	else:
		print("stopped charging")

	charging = is_charging
