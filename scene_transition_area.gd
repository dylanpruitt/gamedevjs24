extends Area2D

signal player_entered

func _on_body_entered(body):
	if body.name == "Player":
		player_entered.emit()
