extends CanvasLayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused


func _on_resume_pressed() -> void:
	get_tree().paused = not get_tree().paused


func _on_quit_pressed() -> void:
	get_tree().quit(0)
