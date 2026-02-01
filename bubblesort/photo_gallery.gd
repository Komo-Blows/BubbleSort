extends Control

@onready
var photo_grid = $photo_grid


var page = 0
var photos = []

var screenshot_folder = "res://screenshots/"
var photo_object = preload("res://scenes/menus/photo_gallery_button.tscn")
func _ready() -> void:
	page = 0
	total = get_total_files()
	load_photos()
		#p.scale = Vector2(0.25,0.25)

func load_photos():
	for child in photo_grid.get_children():
		child.queue_free()
	var files = DirAccess.get_files_at(screenshot_folder)
	for i in range(12):
		if (total == i + page * 12):
			return
		var photo = load(screenshot_folder + photos[i + 12 * page])
		var p = photo_object.instantiate()
		p.icon = photo
		p.scale = Vector2(0.25,0.25)
		p.custom_minimum_size = Vector2(480, 280)
		p.expand_icon = true
		p.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		p.size_flags_vertical = Control.SIZE_EXPAND_FILL
		photo_grid.add_child(p)

var total = 0
func next():
	print("next")
	if (page + 1) * 12 < total:
		page += 1
		load_photos()
	if page == 1:
		back_label.text = "Back"

@onready var back_label = $Button2/Label2
func previous():
	if page > 0:
		page -= 1
		load_photos()
	else:
		get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
	if page == 0:
		back_label.text = "Menu"

func get_total_files():
	var t = 0
	var files = DirAccess.get_files_at(screenshot_folder)
	for i in files.size():
		if files[i].ends_with(".png"):
			photos.append(files[i])
			t += 1
	return t



func _on_button_button_down() -> void:
	next()




func _on_button_2_button_down() -> void:
	previous()
