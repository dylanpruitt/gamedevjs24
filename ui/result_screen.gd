extends CanvasLayer

var met_quota

# Called when the node enters the scene tree for the first time.
func _ready():
	$QuotaLabel.text = "Quota: $%s" % GlobalVariables.quota

	var i = 0
	var total_value = 0
	for found_item in GlobalVariables.player_found_items:
		await get_tree().create_timer(1.0).timeout
		var num_found = GlobalVariables.player_found_items[found_item][1]
		var num_found_overtime = GlobalVariables.player_found_items[found_item][2]
		var item_value = GlobalVariables.player_found_items[found_item][0]
		# Items found on overtime are worth double money.
		var total_item_value = (num_found + num_found_overtime*2) * item_value

		add_item_label("%s ($%s)" % [found_item, item_value], 200, 216 + i*32)
		add_item_label("x%d" % num_found, 420, 216 + i*32)
		add_item_label("(+%d overtime)" % num_found_overtime, 480, 216 + i*32)
		add_item_label(" = $%d" % total_item_value, 640, 216 + i*32)
		$TypewriterClickSFX.play()
		
		total_value += total_item_value
		i += 1

	await get_tree().create_timer(1.0).timeout
	add_item_label("Total found", 200, 216 + (i+1)*32)
	add_item_label(" = $%s" % total_value, 640, 216 + (i+1)*32)
	$TypewriterClickSFX.play()

	await get_tree().create_timer(1.0).timeout
	
	met_quota = player_met_quota(total_value)
	
	if met_quota:
		$QuotaStatusLabel.text = "You met quota!"
		$QuotaMetSFX.play()
	else:
		$QuotaStatusLabel.text = "You failed to meet the quota..."
		$QuotaNotMetSFX.play()
	$QuotaStatusLabel.show()

	await get_tree().create_timer(1.0).timeout
	$Continue.show()

	GlobalVariables.update_player_score(total_value)
	GlobalVariables.player_money += total_value
	GlobalVariables.quota = int(GlobalVariables.quota * 1.75)

func add_item_label(item_text, x, y):
	var label = Label.new()
	label.text = item_text
	label.position = Vector2(x, y)
	label.add_theme_font_size_override("font_size", 24)
	add_child(label)

func player_met_quota(player_item_value):
	return player_item_value >= GlobalVariables.quota

func _on_continue_pressed():
	GlobalVariables.previous_node = null
	if met_quota:
		get_tree().change_scene_to_file("res://ui/shop_screen.tscn")
	else:
		GlobalVariables.cause_of_death = GlobalVariables.CausesOfDeath.TERMINATED
		GlobalVariables.death_description = "You couldn't meet the quota."
		get_tree().change_scene_to_file("res://ui/game_over_screen.tscn")
