extends Node

@export var price = 10

signal item_bought
signal too_broke

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func buy():
	if GlobalVariables.player_money >= price:
		GlobalVariables.player_money -= price
		item_bought.emit()
	else:
		too_broke.emit()
