extends Node

var p1 : String
var p2 : String
var result : int

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

func load_scene(scene : String):
	match scene:
		"two_players": get_tree().change_scene_to_file("res://scenes/tp/TwoPlayers.tscn")
		"main_menu": get_tree().change_scene_to_file("res://scenes/game_scenes/MainMenu.tscn")
		"instructions": get_tree().change_scene_to_file("res://scenes/game_scenes/Instructions.tscn")
		"tp_select_icon": get_tree().change_scene_to_file("res://scenes/tp/TPSelectIcon.tscn")
		"credits": get_tree().change_scene_to_file("res://scenes/game_scenes/Credits.tscn")
		"game_over": get_tree().change_scene_to_file("res://scenes/game_scenes/GameOver.tscn")
		"select_mode" : get_tree().change_scene_to_file("res://scenes/game_scenes/SelectMode.tscn")
		"easy_select_icon": get_tree().change_scene_to_file("res://scenes/easy/EasySelectIcon.tscn")
		"easy": get_tree().change_scene_to_file("res://scenes/easy/Easy.tscn")
