extends Node2D

@export var icon : Texture2D
var can_go := true

#called by button scripts
func turn(id : int):
	can_go = false
