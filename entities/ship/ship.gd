extends RigidBody2D

signal left_moon
signal charging_items(is_charging)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control.hide()
	$Control/LeaveButton.hide()
	$Control/ChargeItemsButton.hide()

func _on_inner_area_body_entered(body):
	if body.name == "Player":
		$Control.show()
		$Control/LeaveButton.show()
		$Control/ChargeItemsButton.show()
	

func _on_inner_area_body_exited(body):
	if body.name == "Player":
		$Control.hide()
		$Control/LeaveButton.hide()
		$Control/ChargeItemsButton.hide()
		$Control/Label.hide()
		charging_items.emit(false)

func _on_leave_button_pressed():
	left_moon.emit()

func _on_charge_items_button_pressed():
	$Control/Label.show()
	charging_items.emit(true)
