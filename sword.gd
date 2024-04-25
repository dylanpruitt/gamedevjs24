extends AnimatedSprite2D

signal drain_power(power)

@export var sword_cooldown_seconds = 0.2
@export var sword_damage = 3
var sword_knockback_force = 30000
var swinging_sword = false
var in_use = false
var fixed_angle = false

func _ready():
	if GlobalVariables.has_sword_upgrade:
		sword_damage += 2
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if swinging_sword:
		rotation += 5 * PI * delta

func use(_delta, power):
	if $Cooldown.time_left > 0 or power <= 0:
		return

	in_use = true
	fixed_angle = true
	swinging_sword = true
	drain_power.emit($PowerDrainComponent.power_drain)
	$Cooldown.start(sword_cooldown_seconds)
	$SwingSFX.play()

	rotation -= (PI / 2)

	await get_tree().create_timer(0.2).timeout
	swinging_sword = false
	
	await $Cooldown.timeout
	in_use = false
	fixed_angle = false


func _on_hitbox_body_entered(body):
	if not in_use:
		return

	if body.name != "Player" and body.has_node("HealthComponent"):
		var health_component = body.get_node("HealthComponent")
		health_component.take_damage(sword_damage, GlobalVariables.DamageTypes.SWORD)

		var direction = get_parent().get_parent().position.direction_to(body.position)
		body.apply_force(direction * (sword_knockback_force / body.mass))
