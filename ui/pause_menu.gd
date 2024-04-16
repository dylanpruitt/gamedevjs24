extends CanvasLayer

signal pressed_resume_button
signal pressed_exit_button

# Called when the node enters the scene tree for the first time.
func _ready():
	$ResumeButton.grab_focus()

func _on_resume_button_pressed():
	pressed_resume_button.emit()

func _on_exit_button_pressed():
	pressed_exit_button.emit()
