extends Node2D


var screen_width = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_width = get_viewport().size.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed():
				print(event.position)
				if event.position.x < screen_width/4:
					var result = get_tree().change_scene_to(load("res://scenes/Main.tscn"))
					result = result

