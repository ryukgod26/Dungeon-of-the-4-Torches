class_name WalkingPlayerState
extends State

func enter() -> void:
	Globals.player.update_animation()

func update(delta: float) -> void:
	#var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	#Globals.player.velocity = direction * Globals.player.DEFALT_SPEED
	Globals.player.movement_logic()
	Globals.player.update_velocity()
	Globals.player.update_animation()
	if Globals.player.direction == Vector2.ZERO:
		transition.emit("IdlePlayerState")
	
	if Input.is_action_just_pressed("attack"):
		transition.emit("AttackPlayerState")
