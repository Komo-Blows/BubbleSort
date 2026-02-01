extends Node2D

var picked_up:bool = false
var mouse_over:bool = false
@onready var icon = $colorpicker
func _process(d):
	if picked_up:
		icon.global_position = get_global_mouse_position() + Vector2(27, -27)
		var color := Color(0.5, 1, 0.5, 1) # get color at mouse position :cry:
		icon.modulate = color
		if Input.is_action_just_pressed('click'):
			picked_up = false
			get_parent().color_mask(color)
	else:
		icon.modulate = Color(1, 1, 1, 1)
		icon.position = lerp(icon.position, Vector2.ZERO, 0.1)
		if get_local_mouse_position().length() < 55: # mouse over button
			if Input.is_action_just_pressed('click'):
				picked_up = true
