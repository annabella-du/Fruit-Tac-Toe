extends Node2D

@onready var global = get_node("/root/global")
@onready var click_sfx: AudioStreamPlayer2D = $ClickSFX

var next_scene : String

func _on_click_sfx_finished() -> void:
	global.load_scene(next_scene)

func _on_tp_button_pressed() -> void:
	next_scene = "2select_icon"
	global.current_mode = "two_players"
	click_sfx.play()

func _on_easy_button_pressed() -> void:
	next_scene = "1select_icon"
	global.current_mode = "easy"
	click_sfx.play()

func _on_medium_button_pressed() -> void:
	next_scene = "1select_icon"
	global.current_mode = "medium"
	click_sfx.play()

func _on_hard_button_pressed() -> void:
	next_scene = "1select_icon"
	global.current_mode = "hard"
	click_sfx.play()

func _on_impossible_button_pressed() -> void:
	next_scene = "1select_icon"
	global.current_mode = "impossible"
	click_sfx.play()
