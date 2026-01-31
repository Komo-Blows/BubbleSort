extends RigidBody2D
var aesthetic_values : Dictionary = {}

@onready var sprite = $sprite
@onready var collision = $collision

@export var accessory : Accessory # filled by charm_bucket on instantiation

func _ready():
	assert(accessory != null, "no accessory object assigned to scene!")
	aesthetic_values = accessory.aesthetics.get_dict()
	sprite.texture = accessory.image
	sprite.scale = Vector2(accessory.image_scale, accessory.image_scale)
	collision.shape.radius = accessory.collision_radius

var mouse_over = false
var follow_mouse = false

func _on_mouse_entered() -> void:
	mouse_over = true
	sprite.scale = accessory.image_scale * 1.5

func _on_mouse_exited() -> void:
	mouse_over = false
	sprite.scale = accessory.image_scale

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed('click') and mouse_over:
		follow_mouse = true
	if event.is_action_released('click'):
		follow_mouse = false

func _process(_d) -> void:
	print(mouse_over)
	if follow_mouse:
		rotation = 0
		self.freeze = true
		global_position = get_global_mouse_position()
		
