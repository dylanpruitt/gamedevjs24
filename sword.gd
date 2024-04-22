extends AnimatedSprite2D

signal drain_power(power)

@export var sword_cooldown_seconds = 0.2
var swinging_sword = false
var in_use = false
var fixed_angle = false

func _ready():
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
