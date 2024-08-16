extends Button

@onready var global = get_node("/root/global")
@onready var gm = get_tree().get_first_node_in_group("game_manager")
@onready var player1_texture = $Player1Texture
@onready var player2_texture = $Player2Texture

@export var id : int
var blank := true

func _ready() -> void:
	player1_texture.visible = false
	player1_texture.texture = load(global.fruits[global.p1])
	player2_texture.visible = false
	player2_texture.texture = load(global.fruits[global.p2])

func _on_pressed():
	if blank:
		if gm.active_player == 1:
			player1_texture.visible = true
		elif gm.active_player == 2:
			player2_texture.visible = true
		if gm.active_player != 0:
			blank = false
			gm.turn(id)
