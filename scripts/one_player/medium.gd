extends Node2D
#keeps track of whose turn it is and if someone's won

#should in theory contain buttons in order
@onready var buttons = get_tree().get_nodes_in_group("button") 
@onready var display = get_tree().get_first_node_in_group("display")
@onready var computer_timer: Timer = $ComputerTimer
@onready var game_over_timer: Timer = $GameOverTimer

var active_player = 1

var grid = [
	[0, 0, 0],
	[0, 0, 0],
	[0, 0, 0]
]

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
		global.result = active_player
		active_player = 0
	
	#check for tie
	if tie() and active_player != 0:
		active_player = 0
		global.result = 0
	
	#switch active player
	if active_player == 1:
		active_player = 2
		computer_timer.wait_time = randf_range(1.0, 1.5)
		computer_timer.start()
	elif active_player == 2:
		active_player = 1
	display.display_outline(active_player)

func computer_turn():
	var priority = {1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0}
	
	#mark filled cells
	for i in range(3): #rows
		for j in range(3): #columns (cells)
			if grid[i][j] != 0:
				priority[(i * 3) + j + 1] = -1
	
	#mark potential wins
	#rows
	for i in range(3):
		#left
		if grid[i][1] == grid[i][2] and grid[i][1] != 0 and grid[i][0] == 0:
			priority[(i * 3) + 1] = grid[i][1]
		#middle
		elif grid[i][0] == grid[i][2] and grid[i][0] != 0 and grid[i][1] == 0:
			priority[(i * 3) + 2] = grid[i][0]
		#right
		elif grid[i][0] == grid[i][1] and grid[i][0] != 0 and grid[i][2] == 0:
			priority[(i * 3) + 3] = grid[i][0]
	
	#columns
	for i in range(3):
		#top
		if grid[1][i] == grid[2][i] and grid[1][i] != 0 and grid[0][i] == 0:
			priority[i + 1] = grid[1][i]
		#middle
		elif grid[0][i] == grid[2][i] and grid[0][i] != 0 and grid[1][i] == 0:
			priority[i + 4] = grid[0][i]
		#right
		elif grid[0][i] == grid[1][i] and grid[0][i] != 0 and grid[2][i] == 0:
			priority[i + 7] = grid[0][i]
	
	#diagonals
	if grid[1][1] == grid[2][2] and grid[1][1] != 0 and grid[0][0] == 0:
		priority[1] = grid[1][1]
	elif grid[0][0] == grid[2][2] and grid[0][0] != 0 and grid[1][1] == 0:
		priority[5] = grid[0][0]
	elif grid[0][0] == grid[1][1] and grid[0][0] != 0 and grid[2][2] == 0:
		priority[9] = grid[0][0]
	if grid[1][1] == grid[2][0] and grid[1][1] != 0 and grid[0][2] == 0:
		priority[3] = grid[1][1]
	elif grid[0][2] == grid[2][0] and grid[0][2] != 0 and grid[1][1] == 0:
		priority[5] = grid[0][2]
	elif grid[0][2] == grid[1][1] and grid[0][2] != 0 and grid[2][0] == 0:
		priority[7] = grid[0][2]
	
	var win_spots = []
	var block_spots = []
	var empty_spots = []
	for id in priority:
		if priority[id] == 2:
			win_spots.append(id)
		elif priority[id] == 1:
			block_spots.append(id)
		elif priority[id] == 0:
			empty_spots.append(id)
	
	var id
	var rng = randi_range(1, 10)
	
	if win_spots.size() == 0 and block_spots.size() == 0:
		print(1)
		id = empty_spots.pick_random()
	elif win_spots.size() == 0 and empty_spots.size() == 0:
		print(2)
		id = block_spots.pick_random()
	elif block_spots.size() == 0 and empty_spots.size() == 0:
		print(3)
		id = win_spots.size()
	elif win_spots.size() == 0:
		print(4)
		if rng <= 4: id = block_spots.pick_random()
		else: id = empty_spots.pick_random()
	elif block_spots.size() == 0:
		print(5)
		if rng <= 4: id = win_spots.pick_random()
		else: id = empty_spots.pick_random()
	elif empty_spots.size() == 0:
		print(6)
		if rng <= 5: id = win_spots.pick_random()
		else: id = block_spots.pick_random()
	else:
		print(7)
		if rng <= 2: id = win_spots.pick_random()
		elif rng <= 4: id = block_spots.pick_random()
		else: id = empty_spots.pick_random()
	
	buttons[id - 1].computer()
	turn(id)
	pass

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
	if active_player == 0:
		game_over_timer.start()

func _on_computer_timer_timeout() -> void:
	computer_turn()

func _on_game_over_timer_timeout() -> void:
	global.load_scene("game_over")
