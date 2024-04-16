extends Node2D

signal score_changed

var player_score = 0
var player_found_items = {}

func add_found_item(item):
	# item is tuple with [name, value]
	# dict entries have name as key and tuple of [value, amount]
	if item[0] in player_found_items:
		player_found_items[item[0]][1] += 1
	else:
		player_found_items[item[0]] = [item[1], 1]

func update_player_score(delta):
	player_score += delta
	score_changed.emit()
