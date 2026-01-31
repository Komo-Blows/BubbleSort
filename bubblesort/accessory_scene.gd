extends Node2D

var aesthetic_values : Dictionary = {}

@onready var sprite = $sprite

@export var accessory : Accessory

func _ready():
	assert(accessory != null, "no accessory object assigned to scene!")
	for ID in Globals.aesthetics:
		aesthetic_values[ID] = 0
	update()
	for ID in Globals.aesthetics.values():
		print(aesthetic_values[ID])

func update():
	aesthetic_values[Globals.aesthetics.techy] = accessory.techy
	aesthetic_values[Globals.aesthetics.fishy] = accessory.fishy
	aesthetic_values[Globals.aesthetics.cutesy] = accessory.cutesy
	aesthetic_values[Globals.aesthetics.preppy] = accessory.preppy
	aesthetic_values[Globals.aesthetics.ugly] = accessory.ugly
	aesthetic_values[Globals.aesthetics.demonic] = accessory.demonic
	aesthetic_values[Globals.aesthetics.cowboy] = accessory.cowboy
	aesthetic_values[Globals.aesthetics.irish] = accessory.irish
	aesthetic_values[Globals.aesthetics.badly_drawn] = accessory.badly_drawn
	
	sprite.texture = accessory.image
