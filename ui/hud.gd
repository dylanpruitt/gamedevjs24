extends CanvasLayer

func update_health(health):
	$HealthBar.value = health
	$HealthDetailLabel.text = "%s/100" % health

func update_power(power):
	$PowerBar.value = round(power)
	$PowerDetailLabel.text = "%s/500" % round(power)

func update_clock(time):
	var hour = time[0]
	var minute = time[1]

	var time_suffix = "PM" if hour < 24 else "AM"
	# Since the clock displays AM/PM, 16:00 should display as 4:00PM.
	# This converts the hour to the correct display value.
	var hour_in_12s = hour if hour < 13 else hour - 12
	var time_string = "%d:%02d %s" % [hour_in_12s, minute, time_suffix]
	$ClockLabel.text = time_string

	if hour > 20:
		$OvertimeLabel.show()
	else:
		$OvertimeLabel.hide()


func _on_player_power_changed(old, new):
	update_power(new)


func _on_player_light_toggled(is_on):
	if is_on:
		$FlashlightIcon.show()
	else:
		$FlashlightIcon.hide()


func _on_player_is_speedy(speedy):
	if speedy:
		$SpeedIcon.show()
	else:
		$SpeedIcon.hide()
