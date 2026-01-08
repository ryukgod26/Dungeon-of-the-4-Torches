class_name StateMachine
extends Node

@export var intial_state: State
var current_state: State

var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			child.transition.connect(_on_state_transition)
			states[child.name.to_lower()] = child
		else:
			print_debug("The Node: %s is not a State " % child.name)
	current_state = intial_state

func _process(delta: float) -> void:
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)
	Globals.debug.add_property("State",current_state.name,1)
	print("Current State: ", current_state)

func _on_state_transition(new_state_name: String):
	var new_state = states[new_state_name.to_lower()]
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()
