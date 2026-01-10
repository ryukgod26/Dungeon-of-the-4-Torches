extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer

var is_active := false

func _on_timer_timeout() -> void:
	is_active = not is_active
	
	if is_active:
		animated_sprite.play("attack")
		var bodies = get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("Player"):
				body.take_damage(1)
	else:
		animated_sprite.play("none")
		


func _on_body_entered(body: Node2D) -> void:
	if is_active and body.is_in_group("Player"):
		print("Player walked into active spikes!")
