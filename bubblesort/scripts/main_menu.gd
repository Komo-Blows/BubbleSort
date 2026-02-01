extends Control


func _on_photo_gallery_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/photo_gallery.tscn")
