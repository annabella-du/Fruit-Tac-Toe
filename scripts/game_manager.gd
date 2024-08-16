extends Node2D
#keeps track of whose turn it is and if someone's won

#should in theory contain buttons in order
@onready var buttons = get_tree().get_nodes_in_group("button") 
var active_player = 1

var grid = [
	[0, 0, 0],
	[0, 0, 0],
	[0, 0, 0]
]
var can_go := true

#called by button scripts
func turn(id : int):
	var row : int
	var column : int
	match id:
		1:
			row = 0
			column = 0
		2:
			row = 0
			column = 1
		3:
			row = 0
			column = 2
		4:
			row = 1
			column = 0
		5:
			row = 1
			column = 1
		6:
			row = 1
			column = 2
		7:
			row = 2
			column = 0
		8:
			row = 2
			column = 1
		9:
			row = 2
			column = 2
	grid[row][column] = active_player
	if active_player == 1:
		active_player = 2
	elif active_player == 2:
		active_player = 1
