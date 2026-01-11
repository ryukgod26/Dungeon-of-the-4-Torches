extends CharacterBody2D

var player
const SPEED = 30
const DAMAGE := 1
var health := 10:
	set(new_health):
		health = new_health
		health_bar._set_health(health)
var last_dir := "_down"
enum EnemyStates {Idle,Follow,Attack,Hurt,Death}
var current_state:EnemyStates
var attack_range := 20.
var direction
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar

func _ready() -> void:
	animated_sprite.play("idle_down")
	current_state = EnemyStates.Idle
	health_bar._init_health(health)
	player = get_tree().get_first_node_in_group("Player")

func _physics_process(_delta: float) -> void:
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
	print(current_state)
	#print("Current State: " , current_state)

func follow_player() -> void:
	if player:
		direction = global_position.direction_to(player.global_position)
		velocity = direction * SPEED
		last_dir = Globals.get_direction(direction)
		animated_sprite.play("walk" + last_dir)
		if global_position.distance_to(player.global_position) < attack_range:
			current_state = EnemyStates.Attack
		move_and_slide()
		update_shapecast_direction()
	else:
		current_state = EnemyStates.Idle

func take_damage(damage) -> void:
	health -= damage
	if health <= 0:
		current_state = EnemyStates.Death
		animated_sprite.play("idle" + last_dir)
		await get_tree().create_timer(0.5).timeout
		queue_free()


func handle_idle() -> void:
	animated_sprite.play("idle" + last_dir)
	if player:
		current_state = EnemyStates.Follow

func handle_attack() -> void:
	if not $Timers/AttackTimer.is_stopped():
		return
	$Timers/AttackTimer.start()
	velocity = Vector2.ZERO
	last_dir = Globals.get_direction(direction)
	var attack_num = 1 if randi() % 2 == 0 else 2
	animated_sprite.play("attack" + str(attack_num) +last_dir)
	if $ShapeCast2D.is_colliding():
		for i in$ShapeCast2D.get_collision_count():
			var target = $ShapeCast2D.get_collider(i)
			if target.is_in_group("Player"):
				target.take_damage(DAMAGE)
	
	player.take_damage(DAMAGE)
	print("Player Took Damage")
	$Timers/AttackTimer.start()
	if global_position.distance_to(player.global_position) > attack_range:
			current_state = EnemyStates.Follow


func update_shapecast_direction():
	if abs(direction.x) > abs(direction.y):
		$ShapeCast2D.target_position = Vector2(attack_range if direction.x > 0 else -attack_range, 0)
	else:
		$ShapeCast2D.target_position = Vector2(0, attack_range if direction.y > 0 else -attack_range)
