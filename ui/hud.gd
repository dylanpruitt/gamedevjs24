extends CanvasLayer

func update_health(health):
	$HealthBar.value = health
	$HealthDetailLabel.text = "%s/100" % health

func update_power(power):
	$PowerBar.value = round(power)
	$PowerDetailLabel.text = "%s/500" % round(power)

func update_clock(time):
	$ClockLabel.text = time


func _on_player_power_changed(old, new):
	update_power(new)
