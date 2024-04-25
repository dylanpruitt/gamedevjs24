extends Node

signal clock_updated(new_time)

@export var MINUTE_INCREMENT = 5
@export var hour = 12
var minute = 0
var charging_time_mult = 1

func _on_update_timer_timeout():
	minute += (MINUTE_INCREMENT * charging_time_mult)
	if minute > 55:
		minute -= 60
		hour += 1

	GlobalVariables.working_overtime = hour > 20
	clock_updated.emit([hour, minute])

func _on_ship_charging_items(is_charging):
	if is_charging:
		charging_time_mult = 3
	else:
		charging_time_mult = 1

func _on_player_stopped_charging():
	charging_time_mult = 1
