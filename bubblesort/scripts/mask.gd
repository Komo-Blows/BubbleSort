extends Area2D
class_name MaskScene

@export var aesthetic: aesthetics_picker
@onready var sprite = $sprite
@onready var collision: CollisionPolygon2D = $collision

#current charm that is selected
var focus_charm
var placed := false

func new_mask(mask_resource: Mask) -> void:
	aesthetic = mask_resource.aesthetic
	sprite.texture = mask_resource.image
	var bits = BitMap.new()
	bits.create_from_image_alpha(mask_resource.image.get_image())
	var tig_bitties := bits.opaque_to_polygons(Rect2(Vector2(), bits.get_size()))
	collision.polygon = tig_bitties[0]
	collision.position = -mask_resource.image.get_image().get_size()/2
	collision.disabled = true
	Signals.showhide_instructions.emit(true)

func _on_body_entered(body: Node2D) -> void:
	if placed and body is AccessoryScene:
		focus_charm = body
		focus_charm.over_mask = true

func _on_body_exited(body: Node2D) -> void:
	if placed and body == focus_charm:
		focus_charm.over_mask = false
		focus_charm = null

var char : Node2D
var rotational_velocity: float = 0.0
func _process(dt):
	if placed and focus_charm and focus_charm.stuck:
		focus_charm.reparent(self)
		focus_charm.attach(self)
		# add mask aesthetics to self
		aesthetic.add(focus_charm.aesthetic)
		focus_charm = null
	if not placed:
		global_position = global_position.lerp(get_global_mouse_position(), 0.1)
		scale.x += Input.get_axis('S', 'W') * dt
		if scale.x <= 0.2: scale.x = 0.2
		if scale.x >= 4: scale.x = 4
		scale.y = scale.x
		rotational_velocity += Input.get_axis('Q', 'E')*0.1
		rotation_degrees += rotational_velocity
		rotational_velocity *= 0.9
		if Input.is_action_just_pressed('click'):
			placed = true
			collision.disabled = false
			self.reparent(char,true)
			Signals.showhide_instructions.emit(false)

func color(c:Color):
	sprite.self_modulate = c
	sprite.self_modulate.a = 1
