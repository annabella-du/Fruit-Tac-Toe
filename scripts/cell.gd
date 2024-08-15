extends Area2D

@export var id : int

func _on_input_event(viewport, event, shape_idx):
	print(0)
	if event == InputEventMouseButton and event.pressed:
		print(id)
