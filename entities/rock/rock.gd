extends Node2D

var low_health = false
var already_dead = false

func _on_entity_died():
	if !already_dead:
		already_dead = true
		GlobalVariables.add_found_item(
			[$NameComponent.entity_name, $ValueComponent.money_value]
		)
		print(GlobalVariables.player_found_items)
		$BreakSFX.play()
		$CollisionShape2D.queue_free()
		$Sprite2D.queue_free()
		await $BreakSFX.finished
		queue_free()

func _on_health_changed(old_value, new_value):
	$CPUParticles2D.emitting = true

	if new_value <= $HealthComponent.max_health / 2 and low_health == false:
		low_health = true
		var low_health_texture = load("res://assets/rock_broken.png")
		$Sprite2D.set_texture(low_health_texture)
