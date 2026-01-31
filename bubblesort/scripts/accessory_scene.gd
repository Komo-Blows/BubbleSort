class_name AccessoryScene
extends RigidBody2D

@onready var sprite = $sprite
@onready var collision = $collision

@export var accessory : Accessory # filled by charm_bucket on instantiation
@onready var aesthetic = accessory.aesthetic

func _ready():
	assert(accessory != null, "no accessory object assigned to scene!")
	assert(aesthetic != null, "accessory not assigned an aesthetic")
	sprite.texture = accessory.image
	sprite.scale = Vector2(accessory.image_scale, accessory.image_scale)
	name = accessory.name
	collision.shape.radius = accessory.collision_radius

var mouse_over = false
var follow_mouse = false
var over_mask = false #updated by the mask area2d
var stuck = false

func _on_mouse_entered() -> void:
	if !follow_mouse and not stuck:
		mouse_over = true
		sprite.scale *= Vector2(accessory.image_scale, accessory.image_scale)*1.5

func _on_mouse_exited() -> void:
	if !follow_mouse and not stuck:
		mouse_over = false
		sprite.scale = Vector2(accessory.image_scale, accessory.image_scale)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed('click') and mouse_over:
		if follow_mouse:
			set_collision_layer_value(2, true)
			set_collision_mask_value(2, true)
			follow_mouse = false
			# check if attach to mask
			if over_mask:
				stuck = true
		else:
			set_collision_layer_value(2, false)
			set_collision_mask_value(2, false)
			follow_mouse = true

const follow_strength = 10
func _process(_d) -> void:
	#print(mouse_over)
	if follow_mouse:
		if Input.get_axis('Q', 'E'):
			angular_velocity = Input.get_axis('Q', 'E')*2
		var mouse_direction = get_global_mouse_position() - global_position
		linear_velocity = mouse_direction * follow_strength
		if sprite.scale.x < 2 and Input.is_action_pressed("W"):
			sprite.scale *= 1.01
		if sprite.scale.x > 0.5 and Input.is_action_pressed("S"):
			sprite.scale *= 0.99

func attach(parent):
	follow_mouse = false
	freeze = true
	sleeping = true
	lock_rotation = true
	
