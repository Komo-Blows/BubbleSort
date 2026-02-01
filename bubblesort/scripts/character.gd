extends Node2D

@onready var sprite = $sprite

@export
var current_character : character

var major_aesthetic : Globals.aesthetics
var minor_aesthetic : Globals.aesthetics
var characters := []

func update_character(char : character):
	sprite.texture = char.image
	
func _ready():
	var char_files = DirAccess.get_files_at("res://characters/")
	for file_name in char_files:
		if file_name.ends_with(".tres"):
			var file = "res://characters/" + file_name
			file = load(file)
			characters.append(file)
	assert(!characters.is_empty(), "no characters to load")
	
	update_character(current_character)

func update():
	print("new character incoming!")
	current_character = characters.pick_random()
	update_character(current_character)
