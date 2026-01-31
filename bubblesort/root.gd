extends Node2D

@onready
var child = $character
@onready
var animator = $AnimationPlayer

func new_character():
	animator.play("slide in")
	child.update()

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	new_character()
