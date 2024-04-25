extends Node2D

@export var spawn_chance:float = 0.5

var big_rock = preload("res://entities/big_rock/big_rock.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for spawn in get_children():
		var random = randf()
		if random <= spawn_chance:
			var instance = big_rock.instantiate()
			instance.position = spawn.position
			add_child(instance)
