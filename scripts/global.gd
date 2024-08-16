extends Node

### TEST VARIABLES ###
var p1 = "blueberry"
var p2 = "strawberry"

#scenes to load
var two_players = "res://scenes/TwoPlayers.tscn"
var main_menu = "res://scenes/MainMenu.tscn"
var instructions = "res://scenes/Instructions.tscn"
var select_icon = "res://scenes/SelectIcon.tscn"

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

func load_scene(scene : String):
	match scene:
		"two_players": get_tree().change_scene_to_file(two_players)
		"main_menu": get_tree().change_scene_to_file(main_menu)
		"instructions": get_tree().change_scene_to_file(instructions)
		"select_icon": get_tree().change_scene_to_file(select_icon)
