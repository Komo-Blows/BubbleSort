extends Label

func _process(delta: float) -> void:
	rotation = -get_parent().global_rotation
	global_position = get_global_mouse_position() + Vector2(0, -size.y)
