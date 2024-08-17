extends Node2D

@onready var global = get_node("/root/global")
@onready var click_sfx: AudioStreamPlayer2D = $ClickSFX

func _on_continue_button_pressed() -> void:
	click_sfx.play()

func _on_click_sfx_finished() -> void:
	global.load_scene("main_menu")
