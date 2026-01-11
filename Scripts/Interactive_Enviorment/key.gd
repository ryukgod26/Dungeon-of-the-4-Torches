extends Area2D

@export var dir = ""

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if dir.to_lower() == "east":
			Globals.east_key_attained = true
		elif dir.to_lower() == "west":
			Globals.west_key_attained = true
		elif dir.to_lower() == "south":
			Globals.south_key_attained = true
		Globals.keys_attained += 1
		queue_free()
