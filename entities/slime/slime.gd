extends RigidBody2D

var attacking = false
var damage = 10

func _process(_delta):
	if not attacking:
		return

	var colliding_bodies = $Hurtbox.get_overlapping_bodies().filter(func(b): return b.name == "Player")

	for body in colliding_bodies:
		if body.name == "Player":
			var health_component = body.get_node("HealthComponent")
			health_component.take_damage(damage, GlobalVariables.DamageTypes.ENEMY)
			attacking = false

func _on_health_changed(old_value, new_value):
	if new_value < old_value:
		$HurtSFX.play()
		hurt_modulate_effects()

func hurt_modulate_effects():
	var normal_mod = Color.WHITE

	$AnimatedSprite2D.modulate = Color.RED
	await get_tree().create_timer(0.05).timeout
	$AnimatedSprite2D.modulate = Color(1, 0.5, 0.5, 1)
	await get_tree().create_timer(0.05).timeout
	$AnimatedSprite2D.modulate = Color(1, 0.75, 0.75, 1)
	await get_tree().create_timer(0.05).timeout
	$AnimatedSprite2D.modulate = normal_mod


func _on_entity_died():
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(0.85).timeout
	queue_free()


func _on_timer_timeout():
	var player_position = get_parent().get_parent().get_node("Player").position
	var direction = position.direction_to(player_position)
	var angle = position.angle_to_point(player_position)
	$Hurtbox.rotation = angle
	apply_force(direction * 15000)
	attacking = true
	$Timer.start(2.0)
	await get_tree().create_timer(1.0).timeout
	attacking = false
