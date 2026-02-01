extends Node2D

@onready
var child = $character
@onready
var animator = $AnimationPlayer
@onready
var mask_menu = $"mask selector"

var current_mask: MaskScene = null
@export var quota: int = 1
@export var daily_attempts: int = 5
var attempt_count:int = 0
var points := 0
var day: int = 0
var points_dict: Dictionary[CharacterHandler.SatisfactionLevel, int] = {
	CharacterHandler.SatisfactionLevel.CHOPPED: 0,
	CharacterHandler.SatisfactionLevel.UPSET: 1,
	CharacterHandler.SatisfactionLevel.MEH: 2,
	CharacterHandler.SatisfactionLevel.HAPPY: 3
}
var game_over: bool = false

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
	update_points(day, points, quota)

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
		self.handle_spacebar()
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
		
## Calculates the next quota.
func calculate_next_quota() -> int:
	return self.quota + 1

## Given the day, current amount of points, and a quota updates the points label.
func update_points(new_day: int, new_points: int, new_quota: int):
	self.day = new_day
	self.points = new_points
	self.quota = new_quota
	$Points.text = 	"Day: {}, Points/Quota: {}/{}".format([ \
	str(new_day), str(new_points), str(new_quota)], "{}")
	
## Calculates the next daily attempt amount.
func calculate_next_daily_attempts() -> int:
	return self.daily_attempts + 1
	
## Handles the space bar action
func handle_spacebar() -> void:
	await child.take_mask(current_mask).finished #Creates a reaction, and lets it finish.
	# Check if the day is over.
	if self.attempt_count >= self.daily_attempts:
		if self.points >= self.quota:
			self.daily_attemps = calculate_next_daily_attempts() # hidden from user.
			self.update_points(self.day, 0, calculate_next_quota())
		else:
			self.game_over = true
	if !self.game_over:
		print(self.attempt_count)
		print(self.game_over)
		self.attempt_count += 1
		self.points += self.points_dict[child.calculate_reaction(current_mask)]
		new_character()
	else:
		print("Game over?")
		$Points.text = "GAME OVER"
		#TODO: prolly something else happens
