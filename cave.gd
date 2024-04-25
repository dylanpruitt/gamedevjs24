extends Node2D

@export var min_sfx_wait_seconds = 5.0
@export var max_sfx_wait_seconds = 20.0

var slime = preload("res://entities/slime/slime.tscn")
var spawn_timeout = 15.0

func _ready():
	print("loaded in")

func play_ambient_sfx():
	print("Playing ambient sounds...")
	var random_sfx = find_children("CaveSFX*").pick_random()
	random_sfx.play()
	$SFXTimer.wait_time = randf_range(min_sfx_wait_seconds, max_sfx_wait_seconds)

func _on_sfx_timer_timeout():
	play_ambient_sfx()

func _on_spawn_timer_timeout():
	spawn_slime()
	$SpawnTimer.start(spawn_timeout)

func spawn_slime():
	var spawn_pos = $SlimeSpawns.get_children().pick_random()
	print("Spawning slime at %s" % spawn_pos)
	var mob = slime.instantiate()
	mob.position = spawn_pos.position
	add_child(mob)

