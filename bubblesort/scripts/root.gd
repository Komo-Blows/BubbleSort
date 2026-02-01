extends Node2D

@onready
var child = $character
@onready
var animator = $AnimationPlayer
@onready
var mask_menu = $"mask selector"

var current_mask: MaskScene = null
var points := 0

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
	Signals.showhide_instructions.connect(showhide_instructions)
	
	var i = 0
	var files = DirAccess.get_files_at(charm_folder)
	for file in files:
		i += 1
		var charm_resource = load(charm_folder + file)
		$charm_bucket.add_charm(charm_resource)
		if i >= 10: # ten charms only
			break
	new_character()

@onready
var current_character = $character
var mask_scene = preload('res://scenes/mask_scene.tscn')
func select_mask(resource): # connected as signal to mask_shape_selected
	var mask = mask_scene.instantiate()
	mask.char = current_character
	add_child(mask)
	current_mask = mask
	mask.new_mask(resource)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space") and current_mask:
		await child.take_mask(current_mask).finished #Creates a reaction, and lets it finish.
		new_character()
	if Input.is_action_just_pressed("screenshot"):
		take_screenshot()
	#$Camera2D.zoom += Vector2(0.001, 0.001)

func showhide_instructions(toggle):
	$instructions.visible = toggle

func take_screenshot() -> void:
	var viewport_texture: ViewportTexture = get_viewport().get_texture()
	var image: Image = viewport_texture.get_image()
	var date_str: String = Time.get_date_string_from_system().replace(".", "_")
	var time_str: String = Time.get_time_string_from_system().replace(":", "_")
	var screenshot_path: String = "res://screenshots/screenshot_" + date_str + "_" + time_str + ".png"
	image.save_png(screenshot_path)
	print("Screenshot saved to: " + screenshot_path)

func color_mask(c: Color): 
	if current_mask: 
		current_mask.color(c)

func update_points(number):
	points = number
	$Points.text = 'Happiness Points: ' + str(points)
