extends CharacterBody2D


const DEFAULT_SPEED = 100.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var last_dir = "_down"
var direction:Vector2 = Vector2.ZERO
@onready var shape_cast: ShapeCast2D = $ShapeCast
var attack_range := 25

func _ready() -> void:
	Globals.player = self

func update_velocity() -> void:
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is RigidBody2D:
			var push_direction = -collision.get_normal()
			collider.apply_central_impulse(push_direction * 1.)
			

#func _physics_process(_delta: float) -> void:
	#movement_logic()

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
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = direction * DEFAULT_SPEED


func update_animation() -> void:
	if direction == Vector2.ZERO:
		animated_sprite.play("idle" + last_dir)
	else:
		last_dir = Globals.get_direction(direction)
		animated_sprite.play("run" + last_dir)
	if direction != Vector2.ZERO:
		update_shapecast_direction()

func update_shapecast_direction():
	if abs(direction.x) > abs(direction.y):
		shape_cast.target_position = Vector2(attack_range if direction.x > 0 else -attack_range, 0)
	else:
		shape_cast.target_position = Vector2(0, attack_range if direction.y > 0 else -attack_range)

func take_damage(amount) -> void:
	#print("Player Took %d Damage" % amount)
	pass
