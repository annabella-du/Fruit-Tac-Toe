extends Node2D

@onready var global = get_node("/root/global")

func _on_continue_button_pressed() -> void:
	global.load_scene("main_menu")
