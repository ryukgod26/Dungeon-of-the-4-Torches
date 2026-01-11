extends Node2D

func _ready() -> void:
	if Globals.west_key_attained:
		$Key/Key.queue_free()
	else:
		$Key/Key.visible = false


func _on_exit_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Scenes/Main_Scene/game.tscn")

func _physics_process(delta: float) -> void:
	if Globals.west_key_attained:
		return
	
	if $Entities/Enemies.get_child_count() == 0:
		if $Key/Key:
			$Key/Key.visible = true
