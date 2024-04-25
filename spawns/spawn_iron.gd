extends Node2D

@export var spawn_chance:float = 0.4

var iron = preload("res://entities/iron_rock/iron_rock.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for spawn in get_children():
		var random = randf()
		if random <= spawn_chance:
			var instance = iron.instantiate()
			instance.position = spawn.position
			add_child(instance)
