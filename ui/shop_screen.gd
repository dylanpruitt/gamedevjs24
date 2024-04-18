extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	update_money_label()

func _on_item_bought():
	print("buying")
	$BuySFX.play()
	update_money_label()

func _on_too_broke():
	print("!")
	pass # Replace with function body.

func update_money_label():
	$MoneyLabel.text = "$%s" % GlobalVariables.player_money
