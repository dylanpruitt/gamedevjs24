extends Node

signal clock_updated(new_time)

@export var MINUTE_INCREMENT = 5
@export var hour = 12
var minute = 0

func _on_update_timer_timeout():
	minute += MINUTE_INCREMENT
	if minute > 55:
		minute -= 60
		hour += 1

	GlobalVariables.working_overtime = hour > 20
	clock_updated.emit([hour, minute])
