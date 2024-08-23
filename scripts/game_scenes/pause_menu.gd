extends CanvasLayer

@onready var global = get_node("/root/global")
@onready var anim = $AnimationPlayer
@onready var ui_buttons = get_tree().get_nodes_in_group("ui_button")
@onready var click_sfx: AudioStreamPlayer2D = $ClickSFX

var button : String

func _ready():
	anim.play("RESET")
	layer = 0

func resume():
	get_tree().paused = false
	anim.play_backwards("blur")

func pause():
	get_tree().paused = true
	layer = 2
	anim.play("blur")

func _on_resume_button_pressed() -> void:
	if get_tree().paused:
		button = "resume"
		click_sfx.play()

func _on_restart_button_pressed() -> void:
	if get_tree().paused:
		button = "restart"
		click_sfx.play()

func _on_main_menu_button_pressed() -> void:
	if get_tree().paused:
		button = "main_menu"
		click_sfx.play()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "blur" and !get_tree().paused:
		layer = 0
		match button:
			"restart": get_tree().reload_current_scene()
			"main_menu": global.load_scene("main_menu")

func _on_click_sfx_finished() -> void:
	resume()
