extends CharacterBody2D

var player
const SPEED = 50
var health := 2
enum states {Idle,Follow,Attack}
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _process(delta: float) -> void:
	pass

func follow_player(delta):
	if player:
		# 1. Calculate direction to player
		var direction = global_position.direction_to(player.global_position)
		
		# 2. Move
		velocity = direction * SPEED
		move_and_slide()

func take_damage(damage):
	health -= damage
	if health <= 0:
		animated_sprite.play("death_down")
		await animated_sprite.animation_finished
		queue_free()
