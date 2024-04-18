extends Node2D

@export var health: int = 100
@export var weak_type = "drill"
var max_health = health

signal health_changed(old_value, new_value)
signal entity_died

func heal(dh):
	if dh > 0:
		health_changed.emit(health, health + dh)
		health += dh

func take_damage(dh, damage_type):
	if damage_type == weak_type or damage_type == "env":
		health_changed.emit(health, health - dh)
		health -= dh
		if health <= 0:
			entity_died.emit()
