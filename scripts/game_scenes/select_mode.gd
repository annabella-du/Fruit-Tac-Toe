extends Node2D

@onready var global = get_node("/root/global")
@onready var click_sfx: AudioStreamPlayer2D = $ClickSFX

var next_scene : String

func _on_click_sfx_finished() -> void:
	global.load_scene(next_scene)

func _on_tp_button_pressed() -> void:
	next_scene = "tp_select_icon"
	click_sfx.play()

func _on_easy_button_pressed() -> void:
	next_scene = "easy_select_icon"
	click_sfx.play()

func _on_hard_button_pressed() -> void:
	next_scene = "hard_select_icon"
	click_sfx.play()

func _on_impossible_button_pressed() -> void:
	next_scene = "impossible_select_icon"
	click_sfx.play()
