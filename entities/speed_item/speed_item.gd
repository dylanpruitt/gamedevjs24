extends AnimatedSprite2D

var in_use = false
var fixed_angle = false
@export var cooldown_seconds = 1.0
var speed_mod = preload("res://entities/player/speed_modifier.tscn")
var timeout_seconds = 25.0

func _ready():
	hide()
	
func _process(_delta):
	in_use = false

func use(delta, _power):
	if $Cooldown.time_left > 0 or $AmountComponent.amount < 1:
		return

	$AmountComponent.amount -= 1
	$Cooldown.start(cooldown_seconds)

	var player_modifiers = get_parent().get_parent().get_node("Modifiers")
	if player_modifiers.has_node("Speed"):
		player_modifiers.get_node("Speed").get_node("Timer").start(timeout_seconds)
	else:
		var instance = speed_mod.instantiate()
		player_modifiers.add_child(instance)
	
	await $Cooldown.timeout
