extends Node2D

@onready var global = get_node("/root/global")
@onready var player1_texture = %Player1Texture
@onready var display_sprite: Sprite2D = $CanvasLayer/DisplaySprite
@onready var click_sfx: AudioStreamPlayer2D = $ClickSFX

var p1 = null
var p2 = null
var next_scene := false

func display_icon():
	player1_texture.texture = load(global.fruits[p1])

func choose_computer_icon():
	p2 = global.keys[randi_range(0, 12)]
	if p1 == p2:
		choose_computer_icon()

func _on_continue_button_pressed() -> void:
	if p1 != null:
		choose_computer_icon()
		global.p1 = p1
		global.p2 = p2
		next_scene = true
	click_sfx.play()

func _on_click_sfx_finished() -> void:
	if next_scene:
		global.load_scene(global.current_mode)

func _on_blueberry_button_pressed() -> void:
	click_sfx.play()
	p1 = "blueberry"
	display_icon()

func _on_pear_button_pressed() -> void:
	click_sfx.play()
	p1 = "pear"
	display_icon()

func _on_cherry_button_pressed() -> void:
	click_sfx.play()
	p1 = "cherry"
	display_icon()

func _on_banana_button_pressed() -> void:
	click_sfx.play()
	p1 = "banana"
	display_icon()

func _on_red_apple_button_pressed() -> void:
	click_sfx.play()
	p1 = "red_apple"
	display_icon()

func _on_pomegranate_button_pressed() -> void:
	click_sfx.play()
	p1 = "pomegranate"
	display_icon()

func _on_strawberry_button_pressed() -> void:
	click_sfx.play()
	p1 = "strawberry"
	display_icon()

func _on_orange_button_pressed() -> void:
	click_sfx.play()
	p1 = "orange"
	display_icon()

func _on_peach_button_pressed() -> void:
	click_sfx.play()
	p1 = "peach"
	display_icon()

func _on_coconut_button_pressed() -> void:
	click_sfx.play()
	p1 = "coconut"
	display_icon()

func _on_kiwi_button_pressed() -> void:
	click_sfx.play()
	p1 = "kiwi"
	display_icon()

func _on_lemon_button_pressed() -> void:
	click_sfx.play()
	p1 = "lemon"
	display_icon()

func _on_green_apple_button_pressed() -> void:
	click_sfx.play()
	p1 = "green_apple"
	display_icon()
