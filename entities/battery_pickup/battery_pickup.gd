extends Area2D

var power_gain = 150

func _on_body_entered(body):
	# Kind of hacky, but if the player is colliding, give them power.
	if "power" in body:
		if body.power >= body.max_power:
			print("full charge already")
			return

		body.add_power(power_gain)
		$PickupSFX.play()
		$CollisionShape2D.queue_free()
		$Sprite2D.queue_free()
		await $PickupSFX.finished
		queue_free()
