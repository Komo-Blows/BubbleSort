extends Node2D

@onready
var child = $character
@onready
var animator = $AnimationPlayer

func place_mask():
	#await Signals.next_character
	new_character()
	pass

func new_character(delay : int = 2):
	animator.play("slide out")
	await animator.animation_finished
	await get_tree().create_timer(delay).timeout
	child.update()
	animator.play("slide in")

func _ready() -> void:
	
	new_character()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		place_mask()
