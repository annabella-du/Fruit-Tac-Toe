extends Node2D

@onready var global = get_node("/root/global")

func _on_instructions_button_pressed() -> void:
	global.load_scene("instructions")

func _on_credits_button_pressed() -> void:
	pass # Replace with function body.

func _on_play_button_pressed() -> void:
	global.load_scene("two_players")
