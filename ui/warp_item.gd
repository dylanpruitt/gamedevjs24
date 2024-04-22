extends Control

func _on_button_pressed():
	$PriceComponent.buy()

func _on_item_bought():
	GlobalVariables.num_warps += 1
