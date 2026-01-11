extends Node

var player: CharacterBody2D
var debug

var keys_attained := 0

var south_key_attained = false
var west_key_attained = false
var east_key_attained = false


func get_direction(direction) -> String:
	if abs(direction.x) > abs(direction.y):
		return "_right" if direction.x > 0 else "_left"
	else:
		return "_down" if direction.y >  0 else "_up"
