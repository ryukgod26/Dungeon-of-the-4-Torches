extends ProgressBar

@onready var damage_bar: ProgressBar = $DamageBar
@onready var timer: Timer = $Timer

var health := 0 :
	set = _set_health

func _ready() -> void:
	var sb = get_theme_stylebox("fill")
	var unique_sb = sb.duplicate()
	add_theme_stylebox_override("fill",unique_sb)

func update_color():
	var percen = float(health) / max_value
	var sb = get_theme_stylebox("fill")
	
	if percen < .3:
		sb.bg_color = Color("#be0000")
	elif percen < .6:
		sb.bg_color = Color("#f8b300")
	else:
		sb.bg_color = Color("#00a200")

func _set_health(new_health: int):
	var prev_health = health
	health = min(new_health,max_value)
	value = health
	
	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health

func _init_health(intial_health):
	health = intial_health
	max_value = intial_health
	value = intial_health
	damage_bar.max_value = intial_health
	damage_bar.value = intial_health


func _on_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(damage_bar,"value",health,0.2)
	
	await tween.finished
	update_color()
	if health <= 0:
		queue_free()
	
