extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_start_button_pressed():
	print("starting game...")
	get_tree().change_scene_to_file("res://ui/tutorial_screen.tscn")


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://ui/credits_screen.tscn")


func _on_exit_button_pressed():
	print("exiting game...")
	get_tree().quit()
