extends PanelContainer

@onready var property_container: VBoxContainer = $MarginContainer/VBoxContainer

var fps: String

func _ready() -> void:
	visible = false
	Globals.debug = self

func _process(delta: float) -> void:
	if not visible:
		return
	fps = "%.2f" % (1.0/delta)
	add_property("FPS",fps,1)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		visible = not visible

func add_property(name: String,val,order):
	var target = property_container.find_child(name,true,false)
	
	if not target:
		target = Label.new()
		target.name = name
		target.text = target.name + ": " + str(val)
		property_container.add_child(target)
	
	else:
		target.text = target.name + ": " + str(val)
		property_container.move_child(target,order)
