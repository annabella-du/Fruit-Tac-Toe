extends Button

@onready var global = get_node("/root/global")
@onready var two_players: Node2D = $"../../.."
@onready var player1_texture = $Player1Texture
@onready var player2_texture = $Player2Texture
@onready var click_sfx: AudioStreamPlayer2D = $"../../../ClickSFX"

@export var id : int
var blank := true

func _ready() -> void:
	player1_texture.visible = false
	player1_texture.texture = load(global.fruits[global.p1])
	player2_texture.visible = false
	player2_texture.texture = load(global.fruits[global.p2])

func _on_pressed():
	click_sfx.play()
	if blank:
		if two_players.active_player == 1:
			player1_texture.visible = true
		elif two_players.active_player == 2:
			player2_texture.visible = true
		if two_players.active_player != 0:
			blank = false
			two_players.turn(id)
