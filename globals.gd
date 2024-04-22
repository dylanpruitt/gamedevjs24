extends Node2D

signal score_changed

var player_score = 0
var player_money = 0
var player_found_items = {}

var num_bombs = 0
var num_warps = 0
var num_speeds = 0

var quota = 15

enum DamageTypes {
	DRILL,
	SWORD,
	ENEMY,
	ENV
}

enum CausesOfDeath {
	TERMINATED,
	KILLED,
	MISSING
}

var cause_of_death
var death_description

var previous_node

var working_overtime = false

func reset_globals():
	quota = 15
	player_score = 0
	player_money = 0
	player_found_items = {}
	num_bombs = 0
	num_speeds = 0
	num_warps = 0
	previous_node = null

func add_found_item(item):
	# item is tuple with [name, value]
	# dict entries have name as key and tuple of [value, amount, amount_overtime]
	if item[0] in player_found_items:
		if working_overtime:
			player_found_items[item[0]][2] += 1
		else:
			player_found_items[item[0]][1] += 1
	else:
		if working_overtime:
			player_found_items[item[0]] = [item[1], 0, 1]
		else:
			player_found_items[item[0]] = [item[1], 1, 0]

func update_player_score(delta):
	player_score += delta
	score_changed.emit()
