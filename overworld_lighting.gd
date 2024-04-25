extends Node2D

@export var gradient:GradientTexture1D

var spawned_night_monsters = false
var fly = preload("res://entities/fly/fly.tscn")
var slime = preload("res://entities/slime/slime.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var clock = get_parent().get_node("Clock")
	if clock.hour < 18:
		$DayBGM.play()

func _on_clock_updated(new_time):
	# number of minutes since 12 PM.

	var time_diff = (new_time[0] - 12) * 60 + new_time[1]
	var percent_day = time_diff / 720.0
	$CanvasModulate.color = gradient.gradient.sample(percent_day)

	if new_time[0] >= 18:
		if $DayBGM.playing:
			$DayBGM.stop()

		if !$WindSFX.playing and is_inside_tree():
			print("playing wind sfx")
			$WindSFX.play()

	if new_time[0] >= 20 and not spawned_night_monsters:
		spawn_monsters()

func spawn_monsters():
	var num_slimes = randi_range(0,2)
	var num_flies = randi_range(3,7)
	print("%s slimes" % num_slimes)
	print("%s flies" % num_flies)

	for i in range(num_slimes):
		var spawn_pos = $SlimeSpawns.get_children().pick_random()
		var mob = slime.instantiate()
		mob.position = spawn_pos.position
		add_child(mob)

	for i in range(num_flies):
		var spawn_pos = $FlySpawns.get_children().pick_random()
		print(spawn_pos)
		var mob = fly.instantiate()
		mob.position = spawn_pos.position
		add_child(mob)

	spawned_night_monsters = true

func _on_wind_sfx_finished():
	print("playing wind sfx")
	$WindSFX.play()
