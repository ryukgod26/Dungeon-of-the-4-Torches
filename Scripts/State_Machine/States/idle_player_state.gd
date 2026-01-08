class_name IdlePlayerState
extends State

func enter() -> void:
	Globals.player.velocity = Vector2.ZERO

func physics_update(delta: float) -> void:
	Globals.player.update_animation()
	if Globals.player.direction != Vector2.ZERO:
		transition.emit("WalkingPlayerState")
	if Input.is_action_just_pressed("attack"):
		transition.emit("AttackPlayerState")
