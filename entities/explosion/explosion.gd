extends Node2D

@export var lifetime_seconds = 1.5
@export var range_pixels = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(lifetime_seconds).timeout
	queue_free()




func _on_area_entered(area):
	if area.find_child("HealthComponent"):
		print(area)
