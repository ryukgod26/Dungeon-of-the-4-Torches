extends Node2D

func _ready() -> void:
	if Globals.east_key_attained:
		$Key/Key.queue_free()
	else:
		$Key/Key.visible = false


func _on_exit_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Scenes/Main_Scene/game.tscn")


func _on_target_area_body_entered(body: Node2D) -> void:
	if not Globals.east_key_attained:
		$Key/Key.visible = true
