extends Node2D

@export var min_sfx_wait_seconds = 5.0
@export var max_sfx_wait_seconds = 20.0

func play_ambient_sfx():
	print("Playing ambient sounds...")
	var random_sfx = find_children("CaveSFX*").pick_random()
	random_sfx.play()
	$SFXTimer.wait_time = randf_range(min_sfx_wait_seconds, max_sfx_wait_seconds)

func _on_sfx_timer_timeout():
	play_ambient_sfx()
