extends Node2D

@export var lifetime_seconds = 1.5
@export var range_pixels = 30
@export var damage = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.shape.radius = range_pixels * 2
	var sprite_size = 32
	var scale = range_pixels / sprite_size * 2
	$AnimatedSprite2D.scale = Vector2(scale, scale)
	$AnimatedSprite2D.play()

	await get_tree().create_timer(lifetime_seconds).timeout
	queue_free()

func _process(delta):
	$PointLight2D.energy -= delta

func _on_body_entered(body):
	var health_component = body.find_child("HealthComponent")
	if health_component != null:
		health_component.take_damage(damage, "env")
