extends Node2D

@onready var sprite = $sprite

@export
var current_character : character

var major_aesthetic : Globals.aesthetic
var minor_aesthetic : Globals.aesthetic

func update_character(char : character):
	sprite.texture = char.image
	

func _ready():
	update_character(current_character)

func update():
	update_character(current_character)
