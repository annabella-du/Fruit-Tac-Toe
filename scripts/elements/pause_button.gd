extends TextureButton

@onready var pause_menu = get_tree().get_first_node_in_group("pause_menu")

func _on_pressed() -> void:
	pause_menu.pause()
