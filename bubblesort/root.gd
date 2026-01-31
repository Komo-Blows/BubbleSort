extends Node2D

@onready
var child = $character

func update_character():
	child.update()
