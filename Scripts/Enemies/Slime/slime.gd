extends CharacterBody2D

var player
const SPEED = 30
var health := 2
var last_dir := "_down"
enum EnemyStates {Idle,Follow,Attack,Hurt,Death}
var current_state:EnemyStates
var attack_radius := 14.
var direction
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.play("idle_down")
	current_state = EnemyStates.Idle

func _physics_process(delta: float) -> void:
	match current_state:
		EnemyStates.Idle:
			handle_idle()
		EnemyStates.Follow:
			follow_player()
		EnemyStates.Attack:
			handle_attack()
		EnemyStates.Death:
			pass
		EnemyStates.Hurt:
			velocity = Vector2.ZERO
	#print("Current State: " , current_state)

func follow_player() -> void:
	if player:
		direction = global_position.direction_to(player.global_position)
		velocity = direction * SPEED
		last_dir = Globals.get_direction(direction)
		animated_sprite.play("run" + last_dir)
		if global_position.distance_to(player.global_position) < attack_radius:
			current_state = EnemyStates.Attack
		move_and_slide()
	else:
		current_state = EnemyStates.Idle

func take_damage(damage) -> void:
	health -= damage
	print("Slime Took Damage and has health %d" % health)
	if health <= 0:
		print("Slime Died")
		current_state = EnemyStates.Death
		animated_sprite.play("death" + last_dir)
		await animated_sprite.animation_finished
		queue_free()
	else:
		current_state = EnemyStates.Hurt
		animated_sprite.play("hurt" + last_dir)
		await animated_sprite.animation_finished
		current_state = EnemyStates.Follow

func handle_idle() -> void:
	animated_sprite.play("idle" + last_dir)
	if player:
		current_state = EnemyStates.Follow

func handle_attack() -> void:
	#if not $Timers/AttackTimer.is_stopped():
		#animated_sprite.play("idle" + last_dir)
	velocity = Vector2.ZERO
	last_dir = Globals.get_direction(direction)
	animated_sprite.play("attack" + last_dir)
	player.take_damage(1)
	$Timers/AttackTimer.start()
	if not player:
		current_state = EnemyStates.Idle
	if global_position.distance_to(player.global_position) > attack_radius:
		current_state = EnemyStates.Follow

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null
