extends CharacterBody2D

@export var max_health       : int   = 500
@export var move_speed       : float = 60.0
@export var chase_range      : float = 300.0
@export var attack1_range    : float = 80.0
@export var attack2_range    : float = 150.0
@export var attack1_damage   : int   = 15
@export var attack2_damage   : int   = 30
@export var knockback_force  : float = 200.0
@export var invincibility_time: float = 0.6

enum BossState { IDLE, WALK, ATTACK1, ATTACK2, HURT, DEAD }
var state : BossState = BossState.IDLE

var current_health : int
var facing         : String = "down"
var is_invincible  : bool   = false
var player_ref     : Node2D = null


@onready var anim        : AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox      : Area2D           = $HitBox
@onready var shape_cast  : ShapeCast2D      = $ShapeCast2D
@onready var attack_timer: Timer            = $Timers/AttackTimer
@onready var invinc_timer: Timer            = $Timers/InvicTimer
@onready var health_bar  : ProgressBar      = $CanvasLayer/HealthBar
@onready var label       : Label            = $CanvasLayer/Label


func _ready() -> void:
	current_health       = max_health
	health_bar.max_value = max_health
	health_bar.value     = max_health
	label.text           = "BOSS"

	hitbox.body_entered.connect(_on_hitbox_body_entered)

	anim.animation_finished.connect(_on_animation_finished)

	attack_timer.wait_time = 1.5
	invinc_timer.wait_time = invincibility_time
	attack_timer.one_shot  = true
	invinc_timer.one_shot  = true

	invinc_timer.timeout.connect(_on_invinc_timer_timeout)

	_find_player()

	_enter_boss_state(BossState.IDLE)


func _physics_process(delta: float) -> void:
	if state == BossState.DEAD:
		return

	if player_ref == null:
		_find_player()

	match state:
		BossState.IDLE:
			_tick_idle()
		BossState.WALK:
			_tick_walk(delta)
		BossState.ATTACK1, BossState.ATTACK2:
			velocity = Vector2.ZERO
			move_and_slide()

func _tick_idle() -> void:
	velocity = Vector2.ZERO
	if player_ref == null:
		return
	var dist := global_position.distance_to(player_ref.global_position)
	if dist <= chase_range:
		_enter_boss_state(BossState.WALK)

func _tick_walk(delta: float) -> void:
	if player_ref == null:
		_enter_boss_state(BossState.IDLE)
		return

	var dist := global_position.distance_to(player_ref.global_position)

	if dist > chase_range * 1.2:
		_enter_boss_state(BossState.IDLE)
		return

	if dist <= attack1_range and attack_timer.is_stopped():
		_enter_boss_state(BossState.ATTACK1)
		return
	elif dist <= attack2_range and attack_timer.is_stopped():
		_enter_boss_state(BossState.ATTACK2)
		return

	# Move towards player
	var dir := (player_ref.global_position - global_position).normalized()
	velocity  = dir * move_speed
	_update_facing(dir)
	move_and_slide()
	_play_anim("walk_" + facing)

func _enter_boss_state(new_state: BossState) -> void:
	state = new_state
	match state:
		BossState.IDLE:
			velocity = Vector2.ZERO
			_play_anim("idle_" + facing)
		BossState.WALK:
			_play_anim("walk_" + facing)
		BossState.ATTACK1:
			_play_anim("attack1_" + facing)
			attack_timer.start()
		BossState.ATTACK2:
			_play_anim("attack2_" + facing)
			attack_timer.start()
		BossState.HURT:
			_play_anim("idle_" + facing)  
			_flash_hurt()
		BossState.DEAD:
			velocity = Vector2.ZERO
			_play_anim("idle_" + facing)
			set_physics_process(false)
			hitbox.monitoring = false
			await get_tree().create_timer(1.5).timeout
			queue_free()


func _on_animation_finished() -> void:
	match state:
		BossState.ATTACK1, BossState.ATTACK2:
			if player_ref and global_position.distance_to(player_ref.global_position) <= chase_range:
				_enter_boss_state(BossState.WALK)
			else:
				_enter_boss_state(BossState.IDLE)
		BossState.HURT:
			if player_ref and global_position.distance_to(player_ref.global_position) <= chase_range:
				_enter_boss_state(BossState.WALK)
			else:
				_enter_boss_state(BossState.IDLE)

func take_damage(amount: int, knockback_dir: Vector2 = Vector2.ZERO) -> void:
	if is_invincible or state == BossState.DEAD:
		return

	current_health -= amount
	health_bar.value = current_health

	if knockback_dir != Vector2.ZERO:
		velocity = knockback_dir.normalized() * knockback_force

	if current_health <= 0:
		_enter_boss_state(BossState.DEAD)
		return

	is_invincible = true
	invinc_timer.start()
	_enter_boss_state(BossState.HURT)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if not (state == BossState.ATTACK1 or state == BossState.ATTACK2):
		return
	if not body.is_in_group("Player"):
		return

	var dmg := attack1_damage if state == BossState.ATTACK1 else attack2_damage
	var kb_dir := (body.global_position - global_position).normalized()

	if body.has_method("take_damage"):
		body.take_damage(dmg, kb_dir)


func _on_invinc_timer_timeout() -> void:
	is_invincible = false
	anim.modulate = Color.WHITE


func _update_facing(dir: Vector2) -> void:
	if abs(dir.x) > abs(dir.y):
		facing = "right" if dir.x > 0 else "left"
	else:
		facing = "down" if dir.y > 0 else "up"

func _play_anim(anim_name: String) -> void:
	if anim.animation != anim_name:
		anim.play(anim_name)

func _flash_hurt() -> void:
	var tween := create_tween()
	tween.tween_property(anim, "modulate", Color(1, 0.3, 0.3), 0.05)
	tween.tween_property(anim, "modulate", Color.WHITE,        0.05).set_delay(0.1)

func _find_player() -> void:
	var players := get_tree().get_nodes_in_group("Player")
	if players.size() > 0:
		player_ref = players[0]
