extends Node2D

@export var spawn_chance:float = 0.5

var coal = preload("res://entities/coal_rock/coal_rock.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for spawn in get_children():
		var random = randf()
		if random <= spawn_chance:
			var coal_instance = coal.instantiate()
			coal_instance.position = spawn.position
			add_child(coal_instance)
