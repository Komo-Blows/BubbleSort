extends Control

@onready
var animator = $animator
@onready
var audio = $AudioStreamPlayer2D

var fly_on_sfx = preload("res://audio/masks_fly_onscreen.wav")
func enable():
	visible = true
	print(visible)
	audio.play()
	for child in grid_container.get_children():
		#print("ratata")
		child.rotation_degrees = 42.4
	animator.play("slide_in")
	for child in grid_container.get_children():
		child.animator.play("RESET")

func swing_masks():
	for child in grid_container.get_children():
		child.animator.play("slide_in")

func disable(o):
	visible = false

func _ready() -> void:
	Signals.connect("mask_shape_selected", disable)

@onready
var grid_container = $GridContainer

func add_mask(mask):
	$GridContainer.add_child(mask)
