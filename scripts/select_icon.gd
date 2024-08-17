extends Node2D

@onready var global = get_node("/root/global")
@onready var player1_texture = %Player1Texture
@onready var player2_texture = %Player2Texture
@onready var display_sprite: Sprite2D = $CanvasLayer/DisplaySprite
@onready var click_sfx: AudioStreamPlayer2D = $ClickSFX

var p1 = null
var p2 = null
var active_player := 1
var next_scene := false

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
		global.p1 = p1
		global.p2 = p2
		next_scene = true
	click_sfx.play()

func _on_blueberry_button_pressed() -> void:
	click_sfx.play()
	if active_player == 1:
		p1 = "blueberry"
		display_icon()
	else:
		if p1 != "blueberry":
			p2 = "blueberry"
			display_icon()

func _on_pear_button_pressed() -> void:
	click_sfx.play()
	if active_player == 1:
		p1 = "pear"
		display_icon()
	else:
		if p1 != "pear":
			p2 = "pear"
			display_icon()

func _on_cherry_button_pressed() -> void:
	click_sfx.play()
	if active_player == 1:
		p1 = "cherry"
		display_icon()
	else:
		if p1 != "cherry":
			p2 = "cherry"
			display_icon()

func _on_banana_button_pressed() -> void:
	click_sfx.play()
	if active_player == 1:
		p1 = "banana"
		display_icon()
	else:
		if p1 != "banana":
			p2 = "banana"
			display_icon()

func _on_red_apple_button_pressed() -> void:
	click_sfx.play()
	if active_player == 1:
		p1 = "red_apple"
		display_icon()
	else:
		if p1 != "red_apple":
			p2 = "red_apple"
			display_icon()

func _on_pomegranate_button_pressed() -> void:
	click_sfx.play()
	if active_player == 1:
		p1 = "pomegranate"
		display_icon()
	else:
		if p1 != "pomegranate":
			p2 = "pomegranate"
			display_icon()

func _on_strawberry_button_pressed() -> void:
	click_sfx.play()
	if active_player == 1:
		p1 = "strawberry"
		display_icon()
	else:
		if p1 != "strawberry":
			p2 = "strawberry"
			display_icon()

func _on_orange_button_pressed() -> void:
	click_sfx.play()
	if active_player == 1:
		p1 = "orange"
		display_icon()
	else:
		if p1 != "orange":
			p2 = "orange"
			display_icon()

func _on_peach_button_pressed() -> void:
	click_sfx.play()
	if active_player == 1:
		p1 = "peach"
		display_icon()
	else:
		if p1 != "peach":
			p2 = "peach"
			display_icon()

func _on_coconut_button_pressed() -> void:
	click_sfx.play()
	if active_player == 1:
		p1 = "coconut"
		display_icon()
	else:
		if p1 != "coconut":
			p2 = "coconut"
			display_icon()

func _on_kiwi_button_pressed() -> void:
	click_sfx.play()
	if active_player == 1:
		p1 = "kiwi"
		display_icon()
	else:
		if p1 != "kiwi":
			p2 = "kiwi"
			display_icon()

func _on_lemon_button_pressed() -> void:
	click_sfx.play()
	if active_player == 1:
		p1 = "lemon"
		display_icon()
	else:
		if p1 != "lemon":
			p2 = "lemon"
			display_icon()

func _on_green_apple_button_pressed() -> void:
	click_sfx.play()
	if active_player == 1:
		p1 = "green_apple"
		display_icon()
	else:
		if p1 != "green_apple":
			p2 = "green_apple"
			display_icon()

func _on_click_sfx_finished() -> void:
	if next_scene:
		global.load_scene("two_players")
