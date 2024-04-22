extends Node2D

@export var gradient:GradientTexture1D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_clock_updated(new_time):
	# number of minutes since 12 PM.
	var time_diff = (new_time[0] - 12) * 60 + new_time[1]
	var percent_day = time_diff / 720.0
	$CanvasModulate.color = gradient.gradient.sample(percent_day)

	if new_time[0] >= 18:
		if $DayBGM.playing:
			$DayBGM.stop()

		if !$WindSFX.playing:
			print("playing wind sfx")
			$WindSFX.play()

func _on_wind_sfx_finished():
	print("playing wind sfx")
	$WindSFX.play()
