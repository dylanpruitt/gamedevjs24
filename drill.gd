extends AnimatedSprite2D

signal drain_power(power)

var drill_range = 20
var drill_power = 5
var out_of_power = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and !out_of_power:
		drain_power.emit($PowerDrainComponent.power_drain * delta)
		var mouse_position = get_local_mouse_position()

		if position.distance_to(mouse_position) <= drill_range:
			$RayCast2D.target_position = mouse_position
			var obj_at_cursor = $RayCast2D.get_collider()
			if obj_at_cursor != null:
				var obj_health = obj_at_cursor.find_child("HealthComponent")
				if obj_health and obj_at_cursor.name != "Player":
					obj_health.take_damage(drill_power * delta, "drill")
