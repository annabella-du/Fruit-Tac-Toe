extends Node

var p1 : String = "blueberry"
var p2 : String = "strawberry"
var result : int
var current_mode : String

var fruits = {
	"blueberry" : "res://assets/fruits/01.png",
	"pear" : "res://assets/fruits/02.png",
	"cherry" : "res://assets/fruits/03.png",
	"banana" : "res://assets/fruits/04.png",
	"red_apple" : "res://assets/fruits/05.png",
	"pomegranate" : "res://assets/fruits/06.png",
	"strawberry" : "res://assets/fruits/07.png",
	"orange" : "res://assets/fruits/08.png",
	"peach" : "res://assets/fruits/09.png",
	"coconut" : "res://assets/fruits/10.png",
	"kiwi" : "res://assets/fruits/11.png",
	"lemon" : "res://assets/fruits/12.png",
	"green_apple" : "res://assets/fruits/13.png",
}
@onready var keys = fruits.keys()

func _physics_process(_delta: float) -> void:
	if get_tree().paused:
		print("paused")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func load_scene(scene : String):
	match scene:
		"main_menu": get_tree().change_scene_to_file("res://scenes/game_scenes/MainMenu.tscn")
		"credits": get_tree().change_scene_to_file("res://scenes/game_scenes/Credits.tscn")
		"instructions": get_tree().change_scene_to_file("res://scenes/game_scenes/Instructions.tscn")
		"select_mode": get_tree().change_scene_to_file("res://scenes/game_scenes/SelectMode.tscn")
		"game_over": get_tree().change_scene_to_file("res://scenes/game_scenes/GameOver.tscn")
		"1select_icon" : get_tree().change_scene_to_file("res://scenes/one_player/1SelectIcon.tscn")
		"2select_icon": get_tree().change_scene_to_file("res://scenes/two_players/2SelectIcon.tscn")
		"two_players": get_tree().change_scene_to_file("res://scenes/two_players/2P.tscn")
		"easy": get_tree().change_scene_to_file("res://scenes/one_player/Easy.tscn")
		"medium": get_tree().change_scene_to_file("res://scenes/one_player/Medium.tscn")
		"hard": get_tree().change_scene_to_file("res://scenes/one_player/Hard.tscn")
		"impossible": get_tree().change_scene_to_file("res://scenes/one_player/Impossible.tscn")
