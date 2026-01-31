extends Node2D

@onready
var child = $character
@onready
var animator = $AnimationPlayer
@onready
var mask_menu = $"mask selector"

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

var charm_folder = 'res://accessories/'
func _ready():
	# initialize Charms
	var i = 0
	var files = DirAccess.get_files_at(charm_folder)
	for file in files:
		i += 1
		var charm_resource = load(charm_folder + file)
		$charm_bucket.add_charm(charm_resource)
		if i >= 10: # ten charms only
			break
	
	#var mask_scene = preload('res://scenes/mask_scene.tscn')
	#var mask_resource = load('res://masks/trad_mask.tres')
	#var mask = mask_scene.instantiate()
	#add_child(mask)
	#mask.new_mask(mask_resource)
	#mask.position += Vector2(1000, 1000)
	#mask.scale = Vector2(2, 2)
	await get_tree().create_timer(1).timeout
	new_character()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		place_mask()
	#$Camera2D.zoom += Vector2(0.001, 0.001)
