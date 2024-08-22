extends Control

@onready var global = get_node("/root/global")
@onready var anim = $AnimationPlayer
@onready var ui_buttons = get_tree().get_nodes_in_group("ui_button")

func _process(_delta):
	testEsc()

func _ready():
	anim.play("RESET")

func resume():
	get_tree().paused = false
	anim.play_backwards("blur")
	for button in ui_buttons:
		button.disabled = false
		button.mouse_filter = Control.MOUSE_FILTER_STOP

func pause():
	get_tree().paused = true
	anim.play("blur")
	for button in ui_buttons:
		button.disabled = true
		button.mouse_filter = Control.MOUSE_FILTER_IGNORE

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()

func _on_resume_button_pressed() -> void:
	resume()

func _on_restart_button_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed() -> void:
	resume()
	global.load_scene("main_menu")
