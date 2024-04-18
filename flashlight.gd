extends AnimatedSprite2D

signal drain_power(power)

@export var toggled = false

var flashlight_range = 50
var flashlight_energy = 0.8
var out_of_power = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if toggled and !out_of_power:
		drain_power.emit($PowerDrainComponent.power_drain * delta)
	if Input.is_action_just_pressed("toggle_flashlight"):
		toggle_light()

	if out_of_power and toggled:
		toggle_light()

func toggle_light():
	toggled = !toggled
	visible = !visible
	$PointLight2D.enabled = toggled
	$ToggleSFX.play()
