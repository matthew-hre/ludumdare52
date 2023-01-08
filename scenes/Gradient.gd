extends Node2D

var transparency = 0
var fade_in = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.modulate.a = 0

	# flip sprite horizontally if on the right side of the screen
	if (position.x > 0):
		$Sprite.flip_h = true


func _process(delta):
	var fade_value = 0.6 if fade_in else 0.0
	$Sprite.modulate.a = lerp($Sprite.modulate.a, fade_value, 0.1)


func _on_Area2D_mouse_entered():
	fade_in = true

func _on_Area2D_mouse_exited():
	fade_in = false
