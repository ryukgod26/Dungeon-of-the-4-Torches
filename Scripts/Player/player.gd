extends CharacterBody2D


const SPEED = 100.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	movement_logic()
	move_and_slide()

func movement_logic():
	#if Input.is_action_just_pressed("move_up"):
		#velocity.x = 0
		#velocity.y = SPEED
	#
	#elif Input.is_action_just_pressed("move_down"):
		#velocity.x = 0
		#velocity.y = -SPEED
	#
	#elif Input.is_action_just_pressed("move_right"):
		#velocity.x = SPEED
		#velocity.y = 0
	#
	#elif Input.is_action_just_pressed("move_left"):
		#velocity.x = -SPEED
		#velocity.y = 0
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = direction * SPEED
