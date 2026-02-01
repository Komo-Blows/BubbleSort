extends Control

@onready
var photo_grid = $photo_grid


var page = 0

var screenshot_folder = "res://screenshots/"
var photo_object = preload("res://scenes/photo_gallery_button.tscn")
func _ready() -> void:
	page = 0
	var files = DirAccess.get_files_at(screenshot_folder)
	for i in files.size():
		if files[i].ends_with(".png"):
			var photo = load(screenshot_folder + files[i + 12 * page])
			var p = photo_object.instantiate()
			p.icon = photo
			p.scale = Vector2(0.25,0.25)
			p.custom_minimum_size = Vector2(480, 360)
			p.expand_icon = true
			p.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			p.size_flags_vertical = Control.SIZE_EXPAND_FILL
			photo_grid.add_child(p)
		#p.scale = Vector2(0.25,0.25)
		
