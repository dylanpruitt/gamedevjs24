extends RigidBody2D

@export var lifetime_seconds = 3



# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(lifetime_seconds).timeout
	
	var explosion = preload("res://entities/explosion/explosion.tscn").instantiate()
	explosion.position = position
	get_tree().root.add_child(explosion)
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
