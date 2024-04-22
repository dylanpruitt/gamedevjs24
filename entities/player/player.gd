extends CharacterBody2D

signal health_changed(old,new)
signal power_changed(old,new)
signal light_toggled(is_on)
signal stopped_charging
signal used_item
signal is_speedy(speedy)

var PLAYER_SPEED = 100
var power = 500
var max_power = 500
var walking_cutscene = false
var charging = false
var charge_rate = 10
var screen_size

@onready var inventory = [$PlayerSprite/Drill, $PlayerSprite/Sword, $PlayerSprite/BombItem,
	$PlayerSprite/SpeedItem, $PlayerSprite/WarpItem]
@onready var current_item = inventory[0]

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$PlayerSprite/Drill.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	var animation_to_play

	if Input.is_action_pressed("move_up") and not walking_cutscene:
		velocity.y -= get_player_speed()
		animation_to_play = "walk_up"
	if Input.is_action_pressed("move_left") and not walking_cutscene:
		velocity.x -= get_player_speed()
		animation_to_play = "walk_right"
		$PlayerSprite.flip_h = true
	if Input.is_action_pressed("move_right") or walking_cutscene:
		velocity.x += get_player_speed()
		animation_to_play = "walk_right"
		$PlayerSprite.flip_h = false
	if Input.is_action_pressed("move_down") and not walking_cutscene:
		velocity.y += get_player_speed()
		animation_to_play = "walk_down"
	if Input.is_action_just_pressed("toggle_flashlight"):
		$PlayerSprite/Flashlight.toggle_light()
		light_toggled.emit($PlayerSprite/Flashlight.toggled)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) \
		and not walking_cutscene \
		and not current_item.in_use:

		current_item.in_use = true
		used_item.emit()

		if current_item.has_node("AmountComponent"):
			if current_item.get_node("AmountComponent").amount == 0:
				current_item.in_use = false
		elif power <= 0:
			current_item.in_use = false

	if $PlayerSprite/Flashlight.toggled and !current_item.in_use:
		$PlayerSprite/Flashlight.visible = true
	else:
		current_item.show()
		if power > 0:
			current_item.play()
		$PlayerSprite/Flashlight.visible = false
	
	if current_item.in_use:
		if !current_item.fixed_angle:
			var mouse_position = get_global_mouse_position()
			var angle = position.angle_to_point(mouse_position)
			current_item.rotation = angle

		current_item.use(delta, power)

	else:
		current_item.hide()
		current_item.stop()

	if velocity.length() > 0:
		velocity = velocity.normalized() * get_player_speed()
		set_velocity(velocity)
		
		move_and_slide()
		$PlayerSprite.play(animation_to_play)
		if !$FootstepSFX.playing:
			$FootstepSFX.play()
	else:
		$PlayerSprite.stop()

	if charging:
		add_power(charge_rate * delta)
		if power == max_power:
			charging = false
			stopped_charging.emit()

	if power <= 0:
		$PlayerSprite/Flashlight.out_of_power = true
	else:
		$PlayerSprite/Flashlight.out_of_power = false

	is_speedy.emit($Modifiers.has_node("Speed"))

func get_player_speed():
	var modifier = 1.0

	if $Modifiers.has_node("Speed"):
		modifier = 1.5
	return modifier * PLAYER_SPEED

func _input(event):
	if event is InputEventMouseMotion:
		var mouse_position = get_global_mouse_position()
		var angle = position.angle_to_point(mouse_position)

		$PlayerSprite/Flashlight.rotation = angle

	if event is InputEventMouseButton and not event.pressed:
		current_item.in_use = false

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

func _on_sword_drain_power(delta):
	power_changed.emit(power, power - delta)
	power -= delta

func _on_ship_charging_items(is_charging):
	if is_charging:
		print("charging power...")
		$PlayerSprite/Flashlight.toggled = false
	else:
		print("stopped charging")
		stopped_charging.emit()

	charging = is_charging

func _on_player_changed_item(idx):
	if idx < inventory.size():
		print("changed item")
		current_item.hide()
		current_item = inventory[idx]
	else:
		print("ignored item change to index %s: no item there" % idx)
