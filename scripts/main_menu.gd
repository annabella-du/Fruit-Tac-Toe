extends Node2D

@onready var global = get_node("/root/global")
@onready var click_sfx: AudioStreamPlayer2D = $ClickSFX

var next_scene : String

func _on_instructions_button_pressed() -> void:
	click_sfx.play()
	
	next_scene = "instructions"

func _on_credits_button_pressed() -> void:
	click_sfx.play()
	next_scene = "credits"

func _on_play_button_pressed() -> void:
	click_sfx.play()
	next_scene = "select_icon"

func _on_click_sfx_finished() -> void:
	global.load_scene(next_scene)
