extends Area2D

var PLAYER_SPEED = 100
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$PlayerSprite/Drill.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	var animation_to_play

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
		$PlayerSprite/Drill.offset.x = cos(angle) * offset
		$PlayerSprite/Drill.offset.y = sin(angle) * offset
		$PlayerSprite/Drill.rotation = angle
		$PlayerSprite/Drill.show()
		$PlayerSprite/Drill.play()
	else:
		$PlayerSprite/Drill.hide()
		$PlayerSprite/Drill.stop()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * PLAYER_SPEED
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
		$PlayerSprite.play(animation_to_play)
	else:
		$PlayerSprite.stop()
