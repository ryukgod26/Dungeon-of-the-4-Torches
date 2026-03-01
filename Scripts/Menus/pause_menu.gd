extends CanvasLayer

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		if get_tree().paused:
			visible = true
			$AnimationPlayer.play("open")
		else:
			visible = false
			$AnimationPlayer.play_backwards("open")

func _on_resume_pressed() -> void:
	get_tree().paused = not get_tree().paused
	if get_tree().paused:
		visible = true
		$AnimationPlayer.play("open")
	else:
		visible = false
		$AnimationPlayer.play_backwards("open")

func _on_quit_pressed() -> void:
	get_tree().quit(0)
