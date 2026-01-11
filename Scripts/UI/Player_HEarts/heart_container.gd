extends MarginContainer

@onready var heart_container: HBoxContainer = $HBoxContainer

var heart_scene = preload("res://Scenes/UI/PLayer_Hearts/Heart.tscn")

func intial_hearts(val:  int) -> void:
	for i in range(val):
		var heart = heart_scene.instantiate()
		heart_container.add_child(heart)
		heart.change_alpha(1)
		await get_tree().create_timer(0.4).timeout

func update_hearts(val: int,dir:int):
	
	for i in heart_container.get_children():
		i.queue_free()
	
	if dir < 0:
		for i in val:
			var heart = heart_scene.instantiate()
			heart_container.add_child(heart)
		var lost_heart = heart_scene.instantiate()
		heart_container.add_child(lost_heart)
		lost_heart.change_alpha(0)
	else:
		for i in val -1 :
			var heart = heart_scene.instantiate()
			heart_container.add_child(heart)
		var gained_heart = heart_scene.instantiate()
		heart_container.add_child(gained_heart)
		gained_heart.change_alpha(1.0)
