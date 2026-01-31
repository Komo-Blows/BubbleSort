extends Area2D
#class_name mask

@export var aesthetic: aesthetics_picker
@onready var sprite = $sprite
@onready var collision: CollisionPolygon2D = $collision

#current charm that is selected
var focus_charm

func _ready() -> void:
	Signals.connect("mask_shape_selected", new_mask)

func new_mask(mask_resource) -> void:
	sprite.texture = mask_resource.image
	await get_tree().create_timer(1).timeout
	var sprite_image: Image = sprite.texture.get_image()
	var bits = BitMap.new()
	bits.create_from_image_alpha(mask_resource.image.get_image())
	var tig_bitties := bits.opaque_to_polygons(sprite.get_rect(), 2.0)
	collision.polygon = tig_bitties
	print(collision.polygon)
	

func _on_body_entered(body: Node2D) -> void:
	if body is AccessoryScene:
		focus_charm = body
		focus_charm.over_mask = true

func _on_body_exited(body: Node2D) -> void:
	if body == focus_charm:
		focus_charm.over_mask = false
		focus_charm = null

func _process(_d):
	if focus_charm and focus_charm.stuck:
		focus_charm.reparent(self)
		focus_charm.attach(self)
		# add mask aesthetics to self
		aesthetic.add(focus_charm.aesthetic)
		focus_charm = null
