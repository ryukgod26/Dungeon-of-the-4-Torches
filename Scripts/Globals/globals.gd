extends Node

var player: CharacterBody2D
var debug


func get_direction(direction) -> String:
	if abs(direction.x) > abs(direction.y):
		return "_right" if direction.x > 0 else "_left"
	else:
		return "_down" if direction.y >  0 else "_up"
