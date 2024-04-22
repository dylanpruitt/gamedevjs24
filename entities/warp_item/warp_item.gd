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

	await get_tree().create_timer(2.0).timeout
	in_use = false

	player_warped.emit()

	await $Cooldown.timeout
