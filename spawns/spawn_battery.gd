extends Node2D

@export var spawn_chance:float = 0.5

var battery = preload("res://entities/battery_pickup/battery_pickup.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var spawn = get_children().pick_random()
	var random = randf()
	if random <= spawn_chance:
		var instance = battery.instantiate()
		instance.position = spawn.position
		add_child(instance)
