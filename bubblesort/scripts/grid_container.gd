extends GridContainer

var mask_sprites := []
var button_scene = preload("res://scenes/mask_button.tscn")
func _ready() -> void:
	var mask_files = DirAccess.get_files_at("res://sprites/masks/")
	for file_name in mask_files:
		if file_name.ends_with(".png"):
			var file = "res://sprites/masks/" + file_name
			file = load(file)
			mask_sprites.append(file)
	assert(!mask_sprites.is_empty(), "no masks to load")
	
	for m in mask_sprites:
		var b: Button = button_scene.instantiate()
		b.icon = m
		b.rotation_degrees = 42.4
		self.add_child(b)
