extends Node2D


func _on_south_gate_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Scenes/Main_Scene/south_dungeon.tscn")

func _on_north_gate_body_entered(body: Node2D) -> void:
	if Globals.keys_attained == 3:
		$GateAreas/NorthGate/OpenGate.visible = true
		$GateAreas/NorthGate/CloseGate.visible = false
		get_tree().change_scene_to_file("res://Scenes/Main_Scene/north_dungeon.tscn")
	else:
		$GateAreas/NorthGate/OpenGate.visible = false
		$GateAreas/NorthGate/CloseGate.visible = true

func _on_westgate_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Scenes/Main_Scene/west_dungeon.tscn")

func _on_east_gate_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Scenes/Main_Scene/east_dungeon.tscn")
