class_name StackCharacter
extends Node2D

@export var character_name: String = "none"
@export var sprite_texture: Texture2D
@export var type:Mask.MASKTYPE
@export var charm:Mask.CHARMTYPE
@export var type_multiplier: int = 0
@export var charm_multiplier: int = 0
@export var satisfaction_range: int = 0

@onready var sprite: Sprite2D = $CharacterSprite
@onready var mask_slot: Node2D = $MaskSlot
@onready var name_label: Label = $NameLabel

enum SATISFACTIONLEVEL {
	HAPPY,
	MEH,
	UPSET
}

func _ready():
	if sprite_texture:
		sprite.texture = sprite_texture
	name_label.text = character_name

## Creates this character.
static func create(name: String, texture: Texture2D,\
type: Mask.MASKTYPE, charm: Mask.CHARMTYPE, type_multiplier: int, charm_multipler: int,\
satisfaction_range: int) -> StackCharacter:
	var scene = preload("res://scenes/character.tscn")
	var instance = scene.instantiate() as StackCharacter
	instance.character_name = name
	instance.sprite_texture = texture
	instance.type = type
	instance.charm = charm
	instance.type_multiplier = type_multiplier
	instance.charm_multipler = charm_multipler
	instance.satisfaction_range = satisfaction_range
	return instance

## Accepts a mask for this character, and returns the satisfaction level.
func accept_mask(mask: Mask) -> SATISFACTIONLEVEL:
	var total_score: int = 0
	if (mask.get_mask_type() == self.type):
		total_score += mask.get_main_value() * self.type_multiplier
	if (mask.get_charm_type() == self.charm):
		total_score += mask.get_secondary_attribute() * self.charm_multiplier
	if total_score < (0.33 * self.satisfaction_range):
		return SATISFACTIONLEVEL.UPSET
	elif (0.33 * self.satisfaction_range) <= total_score\
	and total_score <= (0.67 * self.satisfaction_range) :
		return SATISFACTIONLEVEL.MEH
	else:
		return SATISFACTIONLEVEL.HAPPY
