extends Node2D
#keeps track of whose turn it is and if someone's won

#should in theory contain buttons in order
@onready var buttons = get_tree().get_nodes_in_group("button") 
@onready var display = get_tree().get_first_node_in_group("display")
@onready var computer_timer: Timer = $ComputerTimer
@onready var win_sfx: AudioStreamPlayer2D = $WinSFX
@onready var lose_sfx: AudioStreamPlayer2D = $LoseSFX

var active_player = 2
var game_over_sfx := true
var auto := false

var grid = [
	[0, 0, 0],
	[0, 0, 0],
	[0, 0, 0]
]
var cases = []
var moves1 = []
var moves2 = []
var center = [5]
var corners = [1, 3, 7, 9]
var sides = [2, 4, 6, 8]
var opposite_corners = {1:9, 3:7, 7:3, 9:1}
var adjacent_sides = {
	1: [2, 4],
	3: [2, 6],
	7: [4, 8],
	9: [6, 8]
}
var spaced_corners = {
	1: [3, 7],
	3: [1, 9],
	7: [1, 9],
	9: [3, 7]
}

func _ready() -> void:
	computer_timer.wait_time = randf_range(0.25, 0.5)
	computer_timer.start()

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
	
	#update last move variable
	if active_player == 1: moves1.append(id)
	else: moves2.append(id)
	
	#check to see if active player won
	if won(active_player):
		global.result = active_player
		active_player = 0
	
	#check for tie
	if tie() and active_player != 0:
		active_player = 0
		global.result = 0
	
	#switch active player
	if active_player == 1:
		active_player = 2
		computer_timer.wait_time = randf_range(0.75, 1)
		computer_timer.start()
	elif active_player == 2:
		active_player = 1
	display.display_outline(active_player)

func computer_turn():
	var id : int
	var priority1 = {1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0}
	var priority2 = {1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0}
	#rows
	for i in range(3):
		#left
		if grid[i][1] == grid[i][2] and grid[i][1] != 0 and grid[i][0] == 0:
			if grid[i][1] == 1: priority1[(i * 3) + 1] = 1
			else: priority2[(i * 3) + 1] = 1
		#middle
		if grid[i][0] == grid[i][2] and grid[i][0] != 0 and grid[i][1] == 0:
			if grid[i][0] == 1: priority1[(i * 3) + 2] = 1
			else: priority2[(i * 3) + 1] = 1
		#right
		if grid[i][0] == grid[i][1] and grid[i][0] != 0 and grid[i][2] == 0:
			if grid[i][0] == 1: priority1[(i * 3) + 3] = 1
			else: priority2[(i * 3) + 1] = 1
	
	#columns
	for i in range(3):
		#top
		if grid[1][i] == grid[2][i] and grid[1][i] != 0 and grid[0][i] == 0:
			if grid[1][i] == 1: priority1[i + 1] = 1
			else: priority2[i + 1] = 1
		#middle
		if grid[0][i] == grid[2][i] and grid[0][i] != 0 and grid[1][i] == 0:
			if grid[0][i] == 1: priority1[i + 4] = 1
			else: priority2[i + 4] = 1
		#right
		if grid[0][i] == grid[1][i] and grid[0][i] != 0 and grid[2][i] == 0:
			if grid[0][i] == 1: priority1[i + 7] = 1
			else: priority2[i + 7] = 1
	
	#diagonals
	if grid[1][1] == grid[2][2] and grid[1][1] != 0 and grid[0][0] == 0:
		if grid[1][1] == 1: priority1[1] = 1
		else: priority2[1] = 1
	if grid[0][0] == grid[2][2] and grid[0][0] != 0 and grid[1][1] == 0:
		if grid[0][0] == 1: priority1[5] = 1
		else: priority2[0] = 1
	if grid[0][0] == grid[1][1] and grid[0][0] != 0 and grid[2][2] == 0:
		if grid[0][0] == 1: priority1[9] = 1
		else: priority2[9] = 1
	if grid[1][1] == grid[2][0] and grid[1][1] != 0 and grid[0][2] == 0:
		if grid[1][1] == 1: priority1[3] = 1
		else: priority2[3] = 1
	if grid[0][2] == grid[2][0] and grid[0][2] != 0 and grid[1][1] == 0:
		if grid[0][2] == 1: priority1[5] = 1
		else: priority2[5] = 1
	if grid[0][2] == grid[1][1] and grid[0][2] != 0 and grid[2][0] == 0:
		if grid[0][2] == 1: priority1[7] = 1
		else: priority2[7] = 1
	
	var win_spots = []
	var block_spots = []
	var empty_spots = []
	for i in range(1, 10):
		if priority1[i] == 1: block_spots.append(i)
		if priority2[i] == 1: win_spots.append(i)
		if priority1[i] == 0 and priority2[i] == 0 and buttons[i - 1].blank: empty_spots.append(i)
	
	#win
	if win_spots.size() != 0:
		id = win_spots[0]
		buttons[id - 1].computer()
		turn(id)
		print("id: " + str(id) + " win_spots: " + str(win_spots))
		return
	
	#auto
	if auto:
		id = block_spots[0]
		buttons[id - 1].computer()
		turn(id)
		print("id: " + str(id) + " block_spots: " + str(block_spots))
		return
	
	print("cases: " + str(cases) + " moves1: " + str(moves1) + " moves2: " + str(moves2))
	match cases.size():
		0: #first move
			cases.append(0)
			id = corners.pick_random()
		1: #second move
			if moves1.back() in center: #center
				cases.append(0)
				id = opposite_corners[moves2.back()]
				auto = true
			elif moves1.back() in corners: #corner
				#determine opposite corner
				var opp
				id = opposite_corners[moves2.back()]
				if moves1.back() == opp: #opposite
					cases.append(1)
					#choose empty corner
					var empty = corners
					corners.erase(moves1.back())
					corners.erase(moves2.back())
					id = empty.pick_random()
				else: #spaced
					cases.append(2)
					#place in opposite corner
					id = opposite_corners[moves2.back()]
			elif moves1.back() in sides: #side
				#place in corner not adjacent to player's previous move
				for i in range(2):
					if moves1.back() not in spaced_corners[moves2.back()][i]:
						id = spaced_corners[moves2.back()][i]
				if moves1.back() not in adjacent_sides[moves2.back()]: #not adjacent
					cases.append(3)
					auto = true
				else: cases.append(4)
	
	buttons[id - 1].computer()
	turn(id)


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

func _on_click_sfx_finished() -> void:
	if active_player == 0 and game_over_sfx:
		game_over_sfx = false
		if global.result == 1:
			win_sfx.play()
		else:
			lose_sfx.play()

func _on_computer_timer_timeout() -> void:
	computer_turn()

func _on_win_sfx_finished() -> void:
	global.load_scene("game_over")

func _on_lose_sfx_finished() -> void:
	global.load_scene("game_over")
