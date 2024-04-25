extends Control

func _ready():
	if GlobalVariables.has_sword_upgrade:
		disable_button()

func _on_button_pressed():
	$PriceComponent.buy()

func _on_item_bought():
	GlobalVariables.has_sword_upgrade = true
	disable_button()

func disable_button():
	$Button.disabled = true
	$Button.text = "Sold out!"
