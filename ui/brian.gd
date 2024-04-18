extends Area2D

var brianisms = [
	"i like money",
	"moneymoneymoney"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		print(brianisms.pick_random())
