extends Node2D

var low_health = false

func _on_entity_died():
	GlobalVariables.add_found_item(
		[$NameComponent.entity_name, $ValueComponent.money_value]
	)
	print(GlobalVariables.player_found_items)
	queue_free()

func _on_health_changed(old_value, new_value):
	$CPUParticles2D.emitting = true

	if new_value <= $HealthComponent.max_health / 2 and low_health == false:
		low_health = true
		var low_health_image = Image.load_from_file("res://assets/rock_broken.png")
		var low_health_texture = ImageTexture.create_from_image(low_health_image)
		$Sprite2D.set_texture(low_health_texture)
