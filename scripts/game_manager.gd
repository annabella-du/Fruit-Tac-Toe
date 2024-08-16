extends Node2D
#keeps track of whose turn it is and if someone's won

#should in theory contain buttons in order
@onready var buttons = get_tree().get_nodes_in_group("button") 
@onready var display = get_tree().get_first_node_in_group("display")
var active_player = 1

var grid = [
	[0, 0, 0],
	[0, 0, 0],
	[0, 0, 0]
]
var can_go := true

#called by button scripts
func turn(id : int):
	#update grid
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
	
	#check to see if active player won
	if won(active_player):
		print("Player " + str(active_player) + " won!")
		active_player = 0
	
	#check for tie
	if tie():
		active_player = 0
		print("Tie!")
	
	#switch active player
	if active_player == 1:
		active_player = 2
	elif active_player == 2:
		active_player = 1
	display.display_outline(active_player)

#determine if someone won
func won(player : int) -> bool:
	#check each row
	for i in range(3):
		if grid[i][0] == player and grid[i][1] == player and grid[i][2] == player:
			return true
	
	#check each column
	for i in range(3):
		if grid[0][i] == player and grid[1][i] == player and grid[2][i] == player:
			return true
	
	#check diagonals
	if grid[0][0] == player and grid[1][1] == player and grid[2][2] == player:
		return true
	if grid[0][2] == player and grid[1][1] == player and grid[2][0] == player:
		return true
	
	#no win
	return false

func tie() -> bool:
	for row in grid:
		for cell in row:
			if cell == 0:
				return false
	return true
