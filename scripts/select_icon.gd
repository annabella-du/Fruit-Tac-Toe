extends Node2D

@onready var global = get_node("/root/global")
@onready var player1_texture = %Player1Texture
@onready var player2_texture = %Player2Texture
@onready var display_sprite: Sprite2D = $CanvasLayer/DisplaySprite

var p1 : String
var p2 : String
var active_player := 1

func _ready() -> void:
	display_sprite.frame = 1

func display_icon():
	if active_player == 1:
		player1_texture.texture = load(global.fruits[p1])
	else:
		player2_texture.texture = load(global.fruits[p2])

func _on_continue_button_pressed() -> void:
	if active_player == 1 and p1 != null:
		active_player = 2
		display_sprite.frame = 2
	elif active_player == 2 and p2 != null:
		global.load_scene("two_players")

func _on_blueberry_button_pressed() -> void:
	if active_player == 1:
		p1 = "blueberry"
		display_icon()
	else:
		if p1 != "blueberry":
			p2 = "blueberry"
			display_icon()
