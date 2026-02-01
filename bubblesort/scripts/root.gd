extends Node2D

@onready
var child = $character
@onready
var animator = $AnimationPlayer
@onready
var mask_menu = $"mask selector"

var current_mask: MaskScene = null

func new_character(delay : int = 2):
	animator.play("slide out")
	await animator.animation_finished
	await get_tree().create_timer(delay).timeout
	child.update()
	animator.play("slide in")

var charm_folder = 'res://accessories/'
func _ready():
	# initialize Charms
	Signals.mask_shape_selected.connect(select_mask)
	
	var i = 0
	var files = DirAccess.get_files_at(charm_folder)
	for file in files:
		i += 1
		var charm_resource = load(charm_folder + file)
		$charm_bucket.add_charm(charm_resource)
		if i >= 10: # ten charms only
			break
	
	#await get_tree().create_timer(1).timeout
	new_character()

var mask_scene = preload('res://scenes/mask_scene.tscn')
func select_mask(resource): # connected as signal to mask_shape_selected
	var mask = mask_scene.instantiate()
	add_child(mask)
	current_mask = mask
	mask.new_mask(resource)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		new_character()
	#$Camera2D.zoom += Vector2(0.001, 0.001)
