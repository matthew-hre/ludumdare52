extends Node

var screen_width = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_width = get_viewport().size.x


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed():

				if event.position.x < 256:
					var result = get_tree().change_scene_to(load("res://scenes/Table.tscn"))
					result = result
				elif event.position.x > (screen_width - 256):
					var result = get_tree().change_scene_to(load("res://scenes/Witnesses.tscn"))
					result = result
					
