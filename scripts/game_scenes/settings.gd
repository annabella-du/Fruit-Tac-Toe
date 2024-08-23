extends Node2D

@onready var global = get_node("/root/global")
@onready var audio_texture: TextureRect = $CanvasLayer/VBoxContainer/AudioContainer/AudioButton/AudioTexture
@onready var music_texture: TextureRect = $CanvasLayer/VBoxContainer/MusicContainer/MusicButton/MusicTexture
@onready var sfx_texture: TextureRect = $CanvasLayer/VBoxContainer/SFXContainer/SFXButton/SFXTexture
@onready var click_sfx: AudioStreamPlayer2D = $ClickSFX

var audio_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("SFX")
var main_menu := false

func _ready() -> void:
	audio_texture.visible = not AudioServer.is_bus_mute(audio_bus)
	music_texture.visible = not AudioServer.is_bus_mute(music_bus)
	sfx_texture.visible = not AudioServer.is_bus_mute(sfx_bus)

func _on_audio_button_pressed() -> void:
	AudioServer.set_bus_mute(audio_bus, not AudioServer.is_bus_mute(audio_bus))
	audio_texture.visible = not AudioServer.is_bus_mute(audio_bus)
	click_sfx.play()

func _on_music_button_pressed() -> void:
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))
	music_texture.visible = not AudioServer.is_bus_mute(music_bus)
	click_sfx.play()

func _on_sfx_button_pressed() -> void:
	AudioServer.set_bus_mute(sfx_bus, not AudioServer.is_bus_mute(sfx_bus))
	sfx_texture.visible = not AudioServer.is_bus_mute(sfx_bus)
	click_sfx.play()

func _on_continue_button_pressed() -> void:
	main_menu = true
	click_sfx.play()

func _on_click_sfx_finished() -> void:
	if main_menu: global.load_scene("main_menu")
