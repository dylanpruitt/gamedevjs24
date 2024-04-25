extends AnimatedSprite2D

signal player_warped

var in_use = false
var fixed_angle = false
@export var cooldown_seconds = 1.0

func _ready():
	hide()


func use(delta, _power):
	if $Cooldown.time_left > 0 or $AmountComponent.amount < 1:
		return

	in_use = true
	$AmountComponent.amount -= 1
	$Cooldown.start(cooldown_seconds)

	var warp_label = get_parent().get_node("WarpLabel")
	warp_label.show()
	await get_tree().create_timer(1.3).timeout
	$WarpSFX.play()
	await get_tree().create_timer(0.7).timeout
	in_use = false
	warp_label.hide()
	player_warped.emit()

	var warp_particles = get_parent().get_node("WarpParticles")
	warp_particles.emitting = true

	await $Cooldown.timeout
