extends RigidBody2D

signal left_moon
signal charging_items(is_charging)
signal player_in_ship(inside_ship)

func _on_inner_area_body_entered(body):
	if body.name == "Player":
		player_in_ship.emit(true)

func _on_inner_area_body_exited(body):
	if body.name == "Player":
		player_in_ship.emit(false)
		charging_items.emit(false)

func _on_leave_button_pressed():
	left_moon.emit()

func _on_charge_items_button_pressed():
	$ChargeStartSFX.play()
	charging_items.emit(true)
