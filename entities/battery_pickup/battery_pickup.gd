extends Area2D

var power_gain = 350

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	# Kind of hacky, but if the player is colliding, give them power.
	if body.power:
		body.add_power(power_gain)
		queue_free()
