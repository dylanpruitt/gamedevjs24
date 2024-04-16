extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVariables.add_found_item(["Rock", 1])
	GlobalVariables.add_found_item(["Rock", 1])
	GlobalVariables.add_found_item(["Rock", 1])
	GlobalVariables.add_found_item(["Coal", 7])
	var i = 0
	var total_value = 0
	for found_item in GlobalVariables.player_found_items:
		var label = Label.new()
		var num_found = GlobalVariables.player_found_items[found_item][1]
		var item_value = num_found * GlobalVariables.player_found_items[found_item][0]
		label.text = "%s: found %d (value: %d)" % [found_item, num_found, item_value]
		label.position = Vector2(16, 16 + i*32)
		add_child(label)
		i += 1
		total_value += item_value

	var label = Label.new()
	label.text = "Total value: %d" % total_value
	label.position = Vector2(16, 16 + i*32)
	add_child(label)

	GlobalVariables.update_player_score(total_value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
