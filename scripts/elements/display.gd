extends Node2D

@onready var global = get_node("/root/global")
@onready var scene: Node2D = $"../.."
@onready var sprite = $Sprite2D
@onready var player1_texture = $Player1Texture
@onready var player1_outline = $Player1Outline
@onready var player2_texture = $Player2Texture
@onready var player2_outline = $Player2Outline

func _ready() -> void:
	player1_texture.texture = load(global.fruits[global.p1])
	player2_texture.texture = load(global.fruits[global.p2])
	display_outline(scene.active_player)

func display_outline(player : int):
	if player == 0:
		sprite.frame = 0
		player1_outline.visible = false
		player2_outline.visible = false
	elif player == 1:
		sprite.frame = 1
		player1_outline.visible = true
		player2_outline.visible = false
	elif player == 2:
		sprite.frame = 2
		player1_outline.visible = false
		player2_outline.visible = true
