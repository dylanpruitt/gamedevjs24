extends Node2D

@export var spawn_chance:float = 0.4

var rock = preload("res://entities/rock/rock.tscn")
var small_rock = preload("res://entities/small_rock/small_rock.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for spawn in get_children():
		var random = randf()
		if random <= spawn_chance:
			var instance
			if random <= 0.1:
				instance = small_rock.instantiate()
			else:
				instance = rock.instantiate()

			instance.position = spawn.position
			add_child(instance)
