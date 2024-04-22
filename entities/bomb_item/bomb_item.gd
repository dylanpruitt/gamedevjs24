extends AnimatedSprite2D

var in_use = false
var fixed_angle = false
@export var cooldown_seconds = 1.0
var bomb = preload("res://entities/bomb/bomb.tscn")

func _ready():
	hide()
	
func _process(_delta):
	in_use = false

func use(delta, _power):
	if $Cooldown.time_left > 0 or $AmountComponent.amount < 1:
		return

	$AmountComponent.amount -= 1
	$Cooldown.start(cooldown_seconds)
	var bomb_instance = bomb.instantiate()
	bomb_instance.position = get_parent().get_parent().position
	var main_scene = get_tree().root.get_node("Main")
	main_scene.add_child(bomb_instance)
	
	await $Cooldown.timeout
