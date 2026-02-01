@tool
extends Resource
class_name Accessory

@export var aesthetic: aesthetics_picker # see aesthetics_picker_resource.gd

@export var name : String
@export var image = Texture2D
@export var image_scale: float = 1.0
@export_range(10, 50) var collision_radius = 20
