extends Node2D
#keeps track of whose turn it is and if someone's won

#should in theory contain buttons in order
@onready var buttons = get_tree().get_nodes_in_group("button") 
@onready var display = get_tree().get_first_node_in_group("display")
@onready var computer_timer: Timer = $ComputerTimer
@onready var win_sfx: AudioStreamPlayer2D = $WinSFX
@onready var lose_sfx: AudioStreamPlayer2D = $LoseSFX

var active_player = 1
var game_over_sfx := true
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
		computer_timer.wait_time = randf_range(0.75, 1)
		computer_timer.start()
	elif active_player == 2:
		active_player = 1
	display.display_outline(active_player)

func computer_turn():
	var priority1 = {1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0}
	var priority2 = {1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0}
	
	#mark potential wins
	#rows
	for i in range(3):
		#left
		if grid[i][1] == grid[i][2] and grid[i][1] != 0 and grid[i][0] == 0:
			if grid[i][1] == 1: priority1[(i * 3) + 1] = 1
			else: priority2[(i * 3) + 1] = 1
		#middle
		if grid[i][0] == grid[i][2] and grid[i][0] != 0 and grid[i][1] == 0:
			if grid[i][0] == 1: priority1[(i * 3) + 2] = 1
			else: priority2[(i * 3) + 2] = 1
		#right
		if grid[i][0] == grid[i][1] and grid[i][0] != 0 and grid[i][2] == 0:
			if grid[i][0] == 1: priority1[(i * 3) + 3] = 1
			else: priority2[(i * 3) + 3] = 1
	
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
		else: priority2[5] = 1
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
	for id in range(1, 10):
		if priority1[id] == 1: block_spots.append(id)
		if priority2[id] == 1: win_spots.append(id)
		if priority1[id] == 0 and priority2[id] == 0 and buttons[id - 1].blank: empty_spots.append(id)
	
	var id
	var rng = randi_range(1, 10)
	
	if win_spots.size() == 0 and block_spots.size() == 0:
		id = empty_spots.pick_random()
	elif win_spots.size() == 0 and empty_spots.size() == 0:
		id = block_spots.pick_random()
	elif block_spots.size() == 0 and empty_spots.size() == 0:
		id = win_spots.size()
	elif win_spots.size() == 0:
		if rng <= 8: id = block_spots.pick_random()
		else: id = empty_spots.pick_random()
	elif block_spots.size() == 0:
		if rng <= 8: id = win_spots.pick_random()
		else: id = empty_spots.pick_random()
	elif empty_spots.size() == 0:
		if rng <= 7: id = win_spots.pick_random()
		else: id = block_spots.pick_random()
	else:
		if rng <= 6: id = win_spots.pick_random()
		elif rng <= 8: id = block_spots.pick_random()
		else: id = empty_spots.pick_random()
	
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
