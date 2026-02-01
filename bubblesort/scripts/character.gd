extends Node2D

@onready var sprite = $sprite

@export
var current_character : character

var major_aesthetic : Globals.aesthetics
var minor_aesthetic : Globals.aesthetics
var characters : Array[character] = []
var recent_characters : Array[character] = []

func update_character(char : character):
	sprite.texture = char.image
	for child in get_children():
		if child is MaskScene:
			child.queue_free()

func _ready():
	var char_files = DirAccess.get_files_at("res://characters/")
	for file_name in char_files:
		if file_name.ends_with(".tres"):
			var file = "res://characters/" + file_name
			file = load(file)
			characters.append(file)
	assert(!characters.is_empty(), "no characters to load")
	
	update_character(current_character)

@onready
var audio = $AudioStreamPlayer2D
func update():
	while true:
		current_character = characters.pick_random()
		if !recent_characters.has(current_character):
			break
	print(recent_characters)
	recent_characters.append(current_character)
	update_character(current_character)
	
	await get_tree().create_timer(1).timeout
	if current_character.sfx:
		audio.stream = current_character.sfx
		audio.play()
