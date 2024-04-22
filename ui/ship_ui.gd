extends Control

func _on_ship_player_in_ship(inside_ship):
	if inside_ship and not get_parent().get_node("Player").walking_cutscene:
		show()
		$LeaveButton.grab_focus()
		$ShipArrow.hide()
	else:
		hide()
		if get_tree() != null:
			await get_tree().create_timer(2).timeout
			$ShipArrow.show()

func _on_ship_charging_items(is_charging):
	if is_charging:
		$Label.show()
	else:
		$Label.hide()

func _on_player_stopped_charging():
	$Label.hide()
