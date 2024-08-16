extends Node2D

@onready var global = get_node("/root/global")
@onready var result_label: Label = %ResultLabel

func _ready() -> void:
	match global.result:
		0: result_label.text = "It's a Tie!"
		1: result_label.text = "Player 1 Wins!"
		2: result_label.text = "Player 2 Wins!"

func _on_play_again_button_pressed() -> void:
	global.load_scene("two_players")

func _on_main_menu_button_pressed() -> void:
	global.load_scene("main_menu")
