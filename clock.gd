extends Node

signal clock_updated(new_time)

@export var MINUTE_INCREMENT = 5
var hour = 12
var minute = 0

func _on_update_timer_timeout():
	minute += MINUTE_INCREMENT
	if minute > 55:
		minute -= 60
		hour += 1

	var time_string = "PM" if hour < 24 else "AM"
	# Since the clock displays AM/PM, 16:00 should display as 4:00PM.
	# This converts the hour to the correct display value.
	var hour_in_12s = hour if hour < 13 else hour - 12
	var time = "%d:%02d %s" % [hour_in_12s, minute, time_string]
	clock_updated.emit(time)
