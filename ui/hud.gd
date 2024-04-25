extends CanvasLayer

func _ready():
	GlobalVariables.player_found_item.connect(update_inventory_label)

func update_health(health):
	var max_hp = 100
	if GlobalVariables.has_health_upgrade:
		max_hp += 100
		$HealthBar.max_value = 200

	$HealthBar.value = health

	if health >= 0:
		$HealthDetailLabel.text = "%s/%s" % [health, max_hp]
	else:
		$HealthDetailLabel.text = "0/%s" % [max_hp]

func update_power(power):
	$PowerBar.value = round(power)
	if power >= 0:
		$PowerDetailLabel.text = "%s/500" % round(power)
	else:
		$PowerDetailLabel.text = "0/100"

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

func update_inventory_label():
	if GlobalVariables.player_found_items.size() > 0:
		$InventoryLabel.show()
		var text = ""
		for item in GlobalVariables.player_found_items:
			var amount_found = GlobalVariables.player_found_items[item][1]
			var amount_found_ot = GlobalVariables.player_found_items[item][2]
			text += "%s x%s (+%s OT)\n" % [item, amount_found, amount_found_ot]
		$CollectedItemsLabel.text = text
		$CollectedItemsLabel.show()
	else:
		$InventoryLabel.hide()
		$CollectedItemsLabel.hide()

func _on_player_health_changed(_old, new):
	update_health(new)


func _on_player_power_changed(_old, new):
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
