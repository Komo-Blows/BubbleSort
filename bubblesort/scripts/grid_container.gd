extends GridContainer

var mask_objects := []
var button_scene = preload("res://scenes/menus/mask_button.tscn")
func _ready() -> void:
	var mask_files = DirAccess.get_files_at("res://masks/")
	for file_name in mask_files:
		if file_name.ends_with(".tres"):
			var file = "res://masks/" + file_name
			file = load(file)
			mask_objects.append(file)
	assert(!mask_objects.is_empty(), "no masks to load")
	
	for m in mask_objects:
		var b: Button = button_scene.instantiate()
		b.icon = m.image
		b.mask_object = m
		b.custom_minimum_size = Vector2(250, 250)
		b.expand_icon = true
		b.rotation_degrees = 42.4
		self.add_child(b)
