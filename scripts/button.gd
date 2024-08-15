extends Button

@onready var global = get_node("/root/global")
@onready var gm = get_tree().get_first_node_in_group("game_manager")
@onready var player1_texture = $Player1Texture
@onready var player2_texture = $Player2Texture

@export var id : int

func _ready():
	player1_texture.visible = false
	var image1 = Image.load_from_file(global.fruits[global.p1])
	player1_texture.texture = ImageTexture.create_from_image(image1)
	player2_texture.visible = false
	var image2 = Image.load_from_file(global.fruits[global.p2])
	player2_texture.texture = ImageTexture.create_from_image(image2)

func _on_pressed():
	gm.turn(id)
