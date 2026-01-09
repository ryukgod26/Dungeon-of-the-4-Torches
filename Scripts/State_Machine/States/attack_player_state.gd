class_name AttackPlayerState
extends State

func enter() -> void:
	Globals.player.velocity = Vector2.ZERO
	var anim_name = "attack" + str(randi_range(1, 2)) + Globals.player.last_dir
	Globals.player.animated_sprite.play(anim_name)
	Globals.player.shape_cast.force_shapecast_update()
	if Globals.player.shape_cast.is_colliding():
		for i in Globals.player.shape_cast.get_collision_count():
			var target = Globals.player.shape_cast.get_collider(i)
			if target.has_method("take_damage"):
				target.take_damage(1)
	await Globals.player.animated_sprite.animation_finished
	Globals.player.movement_logic()
	if Globals.player.direction != Vector2.ZERO:
		transition.emit("WalkingPlayerState")
	else:
		transition.emit("IdlePlayerState")

func physics_update(delta: float) -> void:
	await Globals.player.animated_sprite.animation_finished

	if Globals.player.direction != Vector2.ZERO:
		transition.emit("WalkingPlayerState")
	else:
		transition.emit("IdlePlayerState")
