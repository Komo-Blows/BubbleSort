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
	name = accessory.name
	collision.shape.radius = accessory.collision_radius

var mouse_over = false
var follow_mouse = false
var stuck = false

func _on_mouse_entered() -> void:
	if !follow_mouse:
		mouse_over = true
		sprite.scale *= Vector2(accessory.image_scale, accessory.image_scale)*1.5

func _on_mouse_exited() -> void:
	if !follow_mouse:
		mouse_over = false
		sprite.scale = Vector2(accessory.image_scale, accessory.image_scale)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed('click') and mouse_over:
		if !stuck:
			follow_mouse = !follow_mouse
			#freeze = follow_mouse
	

		

var follow_strength = 10	
func _process(_d) -> void:
	#print(mouse_over)
	if follow_mouse:
		rotation = 0
		var mouse_direction = get_global_mouse_position() - global_position
		linear_velocity = mouse_direction * follow_strength
	if sprite.scale.x < 2:
		if Input.is_action_pressed("W") and follow_mouse:
			sprite.scale *= 1.01
	if sprite.scale.x > 0.5:
		if Input.is_action_pressed("S") and follow_mouse:
			sprite.scale *= 0.99
