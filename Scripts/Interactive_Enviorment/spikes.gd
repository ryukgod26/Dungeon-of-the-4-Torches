extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var timer: Timer = $Timer

var player
@export var delay_time = 2

var is_active := false

func _ready() -> void:
	$Timer.wait_time = delay_time

func _on_timer_timeout() -> void:
	is_active = not is_active
	
	if is_active:
		animated_sprite.play("attack")
		if player:
			print("Spike Damaged Player")
			player.take_damage(1)
	else:
		animated_sprite.play("none")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body


func _on_body_exited(body: Node2D) -> void:
	player = null
