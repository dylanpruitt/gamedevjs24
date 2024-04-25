extends AnimatedSprite2D

signal drain_power(power)

var drill_range = 20
var drill_power = 5.0
var fixed_angle = false
var in_use = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalVariables.has_drill_upgrade1:
		drill_power += 5.0

func use(delta, power):
	if power <= 0:
		in_use = false
		return

	in_use = true
	drain_power.emit($PowerDrainComponent.power_drain * delta)
	var mouse_position = get_local_mouse_position()

	var colliding_bodies = $Hitbox.get_overlapping_bodies().filter(func(b): return b.name != "Player")
	
	for body in colliding_bodies:
		if not body.has_node("HealthComponent"):
			return

		var object_health = body.get_node("HealthComponent")
		if object_health != null:
			object_health.take_damage(drill_power * delta, GlobalVariables.DamageTypes.DRILL)
