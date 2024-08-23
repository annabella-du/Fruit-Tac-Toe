extends TextureButton

@onready var pause_menu = get_tree().get_first_node_in_group("pause_menu")
@onready var click_sfx: AudioStreamPlayer2D = $ClickSFX

func _on_pressed() -> void:
	click_sfx.play()

func _on_click_sfx_finished() -> void:
	pause_menu.pause()
